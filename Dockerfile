FROM amazon/aws-sam-cli-build-image-ruby2.7

WORKDIR /build

ARG POSTGRESQL_VERSION

ENV PATH=/opt/bin:$PATH
ENV LD_LIBRARY_PATH=/opt/lib:/opt/lib64:$LD_LIBRARY_PATH
ENV POSTGRESQL_VERSION=$POSTGRESQL_VERSION

# RUN echo '== patchelf =='
# RUN git clone https://github.com/NixOS/patchelf.git && \
#     cd ./patchelf && \
#     git checkout 0.11 && \
#     ./bootstrap.sh && \
#     ./configure --prefix=/opt && \
#     make && \
#     make install

RUN echo '== Install Postgresql Library =='
RUN mkdir lib
RUN yum update -y
RUN yum install -y amazon-linux-extras
RUN amazon-linux-extras enable postgresql10
RUN yum install -y postgresql-devel
RUN cp /usr/lib64/libpq.so* lib/

RUN echo '== Install PG Gem =='
RUN gem install pg -- --with-pg-lib=lib/libpq.so

# RUN echo '== Install Mysql2 Gem =='
# RUN rm -rf /usr/local/mysql/lib/libmysqlclient.so* && \
#     gem install pg \
#       -v $POSTGRESQL_VERSION \
#       -- --with-pg-lib=lib/libpq.so

# RUN echo '== MySQL Connector =='
# RUN yum install -y cmake
# RUN curl -L https://downloads.mysql.com/archives/get/p/19/file/mysql-connector-c-6.1.11-src.tar.gz > mysql-connector-c-6.1.11-src.tar.gz && \
#     tar -xf mysql-connector-c-6.1.11-src.tar.gz && \
#     cd mysql-connector-c-6.1.11-src && \
#     cmake . -DCMAKE_BUILD_TYPE=Release && \
#     make && \
#     make install

# RUN echo '== Install Mysql2 Gem =='
# RUN rm -rf /usr/local/mysql/lib/libmysqlclient.so* && \
#     gem install mysql2 \
#       -v $POSTGRESQL_VERSION \
#       -- --with-mysql-dir=/usr/local/mysql

# RUN echo '== Patch MySQL2 Gem =='
# RUN patchelf --add-needed librt.so.1 \
#       "/var/lang/lib/ruby/gems/2.5.0/gems/mysql2-${POSTGRESQL_VERSION}/lib/mysql2/mysql2.so" && \
#     patchelf --add-needed libstdc++.so.6 \
#       "/var/lang/lib/ruby/gems/2.5.0/gems/mysql2-${POSTGRESQL_VERSION}/lib/mysql2/mysql2.so"

RUN echo '== Share Files =='
RUN mkdir -p /build/share && \
    cp -r "/var/lang/lib/ruby/gems/2.7.0/gems/pg-${POSTGRESQL_VERSION}"/* /build/share && \
    rm -rf /build/share/ext \
           /build/share/README.md \
           /build/share/support
