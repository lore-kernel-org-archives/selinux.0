From: K VAMSHI KRISHNA <Vamshi.Krishna@cmcltd.com>
Message-ID: <1089.172.16.16.31.1037101869.squirrel@webmail>
Date: Tue, 12 Nov 2002 17:21:09 +0530 (IST)
Subject: SELinux and Tomcat web server
To: <SELinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello friends,
I am a newbie just getting my hands dirty with SELinux. We are presently
planing to host a Jakarta Tomcat web server that hosts some JSPs on a
SELinux system. So as evident, this requires configuring the server which
is started using the command
/usr/local/jakarta/tomcat.sh start
The process listens at some port and respond by serving JSPs. This to my
knowledge involves unzipping/extracting class files from some jar files in
the lib and work folders under the jakarta folder. It also needs
configuring the acess to the Java subsystem by Tomcat process.
Before starting on this, I thought of inquiring if any of you have already
gone through it. I would be grateful for any help in this context. Any
pointers in configuring the Java subsystem will also be quite useful.
Thanks in advance,
Vamshi.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
