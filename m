Message-ID: <3D43AE5E.8020506@web.de>
Date: Sun, 28 Jul 2002 10:42:06 +0200
From: =?ISO-8859-1?Q?Mark_M=FCller?= <trusted@web.de>
MIME-Version: 1.0
To: SELinux Mailing List <SELinux@tycho.nsa.gov>
Subject: Re: How to make sftp work?
References: <3D42C94D.8000100@web.de> <20020727164605.9240D265@lyta.coker.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:
> I suggest that the /usr/lib/ssh directory have type lib_t (which it has in 
> the default policy file context files).  sshd_t already has search and 
> getattr access to lib_t directories.
I changed that due to another AVC denied message and placed sftp in 
sshd_t through a domain transition. Now I switched back to lib_t again.

> It seems that the default domain for the root account on your system is 
> user_t which does not have access to the root home directory.  Not much you 
> can do about this.
I can change with newrole, however this doesn't help me further as you 
said before. sshd spawns bash/sftp not in the proper context concerning 
my situation.


> I believe that ssh runs the user's shell and uses that for all further 
> operations.  The SE Linux policy for ssh is based around domain transitions 
> when running the shell...
> 
> I'm not sure why anyone wants sftp, between regular ftp, scp, and sendfile I 
> think that all requirements are covered...
It is just for convenience. We got used to spawn the sftp-server 
automatically from sshd and don't run ftp. I thought I could extend the 
policy so that the sftp-server subsystem is placed in the proper domain 
when started from sshd. Otherwise we will use ftp instead.


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
