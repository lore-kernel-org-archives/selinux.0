Date: Sat, 9 Jun 2007 09:14:17 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Brian Smith <brian@briansmith.org>
cc: SELinux@tycho.nsa.gov
Subject: Re: SELinux STRICT policy on CentOS 5
In-Reply-To: <000101c7aa6a$4bfe49c0$5e01a8c0@Junk>
Message-ID: <Line.LNX.4.64.0706090912400.21830@d.namei>
References: <000101c7aa6a$4bfe49c0$5e01a8c0@Junk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 9 Jun 2007, Brian Smith wrote:

> Hello all,
>  
> What is the installation procedure for enabling the STRICT policy in CentOS 5 and/or RHEL 5? Everything I read seemed to indicate it was:
>  
> 	yum install selinux-policy-strict
> 	[ set SELINUXTYPE=strict in /etc/selinux/config ]
> 	touch /.autorelabel
> 	reboot
> 
> However, whenever I do this I get a kernel panic on boot:
> 
> 	http://bugs.centos.org/view.php?id=2002
> 
> Note that I am not the original bug reporter.
> 
> The targeted policy seems to work without any problems. I tried switching to the strict policy before doing a "yum update -y && reboot" and then after reinstalling I tried AFTER doing a "yum update -u && reboot." I tried the above procedure, but then booting with "enforcing=0." This avoided the kernel panic but I could not log in as root via the console, only via SSH. And, logging in as root via SSH resulted in many permission denied errors; root couldn't read its own bash profile, for example.
> 
> I running CentOS in VMWare Server 1.0.3.

I'm running MLS, which is similar, and to switch from targeted policy, had 
to reboot and perform the fs relabeling in permissive mode (which you can 
do in single user mode afaik), then reboot in enforcing mode.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
