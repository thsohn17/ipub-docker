# base image를 작성
FROM ubuntu:18.04

# apache2 package를 설치
RUN apt-get update && apt-get -y install apache2

# web 기본 페이지를 생성
RUN echo 'Docker container Application.' > /var/www/html/index.html

#필요한 작업 경로를 생성 
RUN mkdir /webapp

WORKDIR /webapp

# 아파치에 필요한 환경변수 
RUN echo '. /etc/apache2/envvars' > /webapp/run_http.sh && echo 'mkdir -p /var/run/apache2' >> /webapp/run_http.sh && echo 'mkdir -p /var/lock/apache2' >> /webapp/run_http.sh && echo '/usr/sbin/apache2 -D FOREGROUND' >> /webapp/run_http.sh && chmod 744 /webapp/run_http.sh

#이미지가 컨테이너로 실행될 떄 아파치 서비스를 자동으로 실행되게 한다. 
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
#80번 포트
EXPOSE 80

CMD /webapp/run_http.sh
