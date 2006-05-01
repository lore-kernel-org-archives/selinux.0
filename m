From: =?utf-8?q?T=C3=B6r=C3=B6k_Edwin?= <edwin@gurde.com>
To: selinux@tycho.nsa.gov
Subject: [3/4] Labeling only policy for fireflier (example module)
Date: Mon, 1 May 2006 19:38:02 +0300
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        fireflier-devel@lists.sourceforge.net
References: <200604021240.21290.edwin@gurde.com> <200605011917.54954.edwin@gurde.com> <200605011934.00791.edwin@gurde.com>
In-Reply-To: <200605011934.00791.edwin@gurde.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200605011938.02642.edwin@gurde.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an example module that fireflier would generate for a certain program.

myapp1_t's sockets can only be accesses by myapp2, but not by other unconfined 
processes, and not by myapp3.
myapp2, and myapp3's sockets can't be accesses except by themselves.
fireflier_unconfined_t's sockets can be accessed by anybody.


I included the policy files, and a test program below.
Let's suppose these programs aren't run as root. Can they bypass selinux 
security context labels?(can they change them?)



test_module.te:
--------------
policy_module(test_module,0.1)
fireflier_gen_unconfined_type(myapp1)
fireflier_gen_unconfined_type(myapp2)
fireflier_gen_unconfined_type(myapp3)

allow_access_to_socket(myapp1,myapp2)

------
test_module.fc
-----
/home/edwin/p2          --      
gen_context(system_u:object_r:myapp2_exec_t,s0)
/home/edwin/p3          --      gen_context(system_u:object_r:myapp3_exec_t,s0
/home/edwin/p1          --      
gen_context(system_u:object_r:myapp1_exec_t,s0)
/home/edwin/p4          --      
gen_context(system_u:object_r:myapp1_exec_t,s0)



--------------p1.c
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <unistd.h>
void die(const char* msg)
{
   perror(msg);
   exit(1);
}

void showattr(int fd)
{
   const char security_name[] = "security.selinux";
   ssize_t len = fgetxattr(fd,security_name,NULL,0);
   if (len==-1)
     return;
   

   size_t i;

   char* list = malloc(len+1);
   if((len = fgetxattr(fd,security_name,list,len))==-1)
     die("error getting xattr");
   list[len]=0;
   for(i=0;i<len;i++)
     if(!list[i]) list[i]='\n';   
   printf("\nsecurity context of %d  is: %s",fd,list);
   free(list);

}
   

int main(int argc,char* argv[])
{
   if(argc<3) 
     {
	printf("usage: %s <childname> <port>\n",argv[0]);
	return 1;
     }
   
   int fd = socket(PF_INET,SOCK_STREAM,IPPROTO_TCP);
   if(fd<0)
     die("socket() failed");
   struct sockaddr_in servaddr;
   servaddr.sin_family = AF_INET;
   servaddr.sin_addr.s_addr = htonl(INADDR_ANY);
   servaddr.sin_port = htons(atoi(argv[2]));
   if(bind(fd,(struct sockaddr*)&servaddr,sizeof(servaddr))<0)
     die("bind() failed");
   if(listen(fd,3)<0)
     die("listen() failed");
   int newfd2 =  accept(fd,NULL,NULL);
   if(newfd2<0)
     die("accept() failed");

   showattr(fd);
   showattr(newfd2);
   system(argv[1]);
   if(fork()==0) 
     {   
	execl(argv[1],argv[1],(char*)NULL);
     }
   
   close(newfd2);
   close(fd);
   return 0;
}

-------------p2.c
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/socket.h>
#include <unistd.h>
#include <attr/xattr.h>
#include <string.h>
#include <netinet/in.h>

void die(const char* msg)
{
   perror(msg);
   exit(1);
}

char* linkname(int fd)
{
   char fmt[] = "/proc/self/fd/%d";
   const int namebufsiz = strlen(fmt)+16;
   char* namebuf = malloc(namebufsiz);
   char* buf = NULL;
   
   snprintf(namebuf,namebufsiz,fmt,fd);
   int res = 0,bufsiz=0;
   do{
      bufsiz += 16;
      buf  = realloc(buf,bufsiz);
      res = readlink(namebuf,buf,bufsiz);
      if (res == -1)
	die("readlink error");
   } while (res==bufsiz);
   free(namebuf);
   return buf;  
}


void showattr(int fd)
{
   const char security_name[] = "security.selinux";
   ssize_t len = fgetxattr(fd,security_name,NULL,0);
   if (len==-1)
     return;
   
   char* name = linkname(fd);
   size_t i;

   char* list = malloc(len+1);
   if((len = fgetxattr(fd,security_name,list,len))==-1)
     die("error getting xattr");
   list[len]=0;
   for(i=0;i<len;i++)
     if(!list[i]) list[i]='\n';   
   printf("\nsecurity context of %d (%s) is: %s",fd,name,list);
   free(name);
   free(list);

   struct stat sbuf;
   if(fstat(fd,&sbuf)==-1)
     perror("stat error");
   else 
     {
	if(!S_ISSOCK(sbuf.st_mode)) 
	  {
	     printf("not a socket");
	     if(fd<3)
	       return;
	  }	
     }
   
   //read from it
   char x[16];
   socklen_t socklen = 16;
   struct sockaddr* sa=malloc(socklen);
   struct msghdr msg;
   if(read(fd,x,sizeof(x))==-1)
     perror("read failed");
   else
     printf("%s\n",x);
   if(recv(fd,&x,1,MSG_DONTWAIT)==-1)
     perror("recv failed");
   if(recvfrom(fd,&x,1,MSG_DONTWAIT,sa,&socklen)==-1)
     perror("recvfrom failed");
   if(recvmsg(fd,&msg,MSG_DONTWAIT)==-1)
     perror("recvmsg failed");
   if(listen(fd,3)<0)
     perror("listen failed");
   if(accept(fd,NULL,NULL))
     perror("accept failed");
   struct sockaddr_in servaddr;
   servaddr.sin_family = AF_INET;
   servaddr.sin_addr.s_addr = htonl(INADDR_ANY);
   servaddr.sin_port = htons(5611);
   if(connect(fd,(struct sockaddr*)&servaddr,sizeof(servaddr))<0)
     perror("connect failed");
   if(bind(fd,(struct sockaddr*)&servaddr,sizeof(servaddr))<0)
     perror("bind failed");
}


int main()
{
   int fds,fd;
   if((fds = getdtablesize()) == -1) fds=255;
   for(fd=0;fd<fds;fd++)
     showattr(fd);
   system("ps -Z");
}

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
