Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: K VAMSHI KRISHNA <Vamshi.Krishna@cmcltd.com>, <SELinux@tycho.nsa.gov>
Subject: Re: SELinux and Tomcat web server
Date: Tue, 12 Nov 2002 19:41:07 +0100
References: <1138.172.16.16.31.1037107565.squirrel@webmail>
In-Reply-To: <1138.172.16.16.31.1037107565.squirrel@webmail>
MIME-Version: 1.0
Message-Id: <200211121941.07340.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 12 Nov 2002 14:26, K VAMSHI KRISHNA wrote:
> I am a newbie just getting my hands dirty with SELinux. We are presently
> planing to host a Jakarta Tomcat web server that hosts some JSPs on a
> SELinux system. So as evident, this requires configuring the server
> which is started using the command
> /usr/local/jakarta/tomcat.sh start
> The process listens at some port and respond by serving JSPs. This to my
> knowledge involves unzipping/extracting class files from some jar files
> in the lib and work folders under the jakarta folder. It also needs
> configuring the acess to the Java subsystem by Tomcat process.
> Before starting on this, I thought of inquiring if any of you have
> already gone through it. I would be grateful for any help in this
> context. Any pointers in configuring the Java subsystem will also be
> quite useful. Thanks in advance,

Sounds like you need to write a new policy for JSP servers.

It will need to have a type for the executable defined by EG 
daemon_domain(jserver), then you need to have a start script in /etc/init.d/ 
for it which runs the executable (and transitions from initrc_t to 
jserver_t).  Then you need a rule something like
create_dir_file(jserver_t, jserver_tmp_t) to handle the files it extracts from 
archives.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
