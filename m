Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Mark =?iso-8859-1?q?M=FCller?= <trusted@web.de>,
        SELinux Mailing List <SELinux@tycho.nsa.gov>
Subject: Re: How to make sftp work?
Date: Sat, 27 Jul 2002 18:46:05 +0200
References: <3D42C94D.8000100@web.de>
In-Reply-To: <3D42C94D.8000100@web.de>
MIME-Version: 1.0
Message-Id: <20020727164605.9240D265@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 27 Jul 2002 18:24, Mark Müller wrote:
> Hello,
> when I want to use sftp (with a Windows-SSH client) several AVC denied
> messages come:
>
> --------
> avc:  denied  { search } for  pid=3303 exe=/usr/sbin/sshd
> path=/usr/lib/ssh dev=08:09 ino=61510 scontext=system_u:system_r:sshd_t
> tcontext=system_u:object_r:sshd_exec_t tclass=dir

I suggest that the /usr/lib/ssh directory have type lib_t (which it has in 
the default policy file context files).  sshd_t already has search and 
getattr access to lib_t directories.

> avc:  denied  { search } for  pid=3452 exe=/bin/bash path=/usr/lib/ssh
> dev=08:09 ino=61510 scontext=root:user_r:user_t
> tcontext=system_u:object_r:sshd_exec_t tclass=dir

user_t has access to lib_t too...

> avc:  denied  { getattr } for  pid=3452 exe=/usr/lib/ssh/sftp-server
> path=/root/.bash_history dev=08:09 ino=208 scontext=root:user_r:user_t
> tcontext=system_u:object_r:sysadm_home_t tclass=lnk_file
>
> avc:  denied  { read } for  pid=3452 exe=/usr/lib/ssh/sftp-server
> path=/root/.bash_history dev=08:09 ino=208 scontext=root:user_r:user_t
> tcontext=system_u:object_r:sysadm_home_t tclass=lnk_file

It seems that the default domain for the root account on your system is 
user_t which does not have access to the root home directory.  Not much you 
can do about this.

> but why is bash involved in the second AVC denied message, and how can I
>   use sftp? Am I wrong or does bash in user_t start sftp-server and thus
> sftp-server is placed in the user_t domain?

I believe that ssh runs the user's shell and uses that for all further 
operations.  The SE Linux policy for ssh is based around domain transitions 
when running the shell...

I'm not sure why anyone wants sftp, between regular ftp, scp, and sendfile I 
think that all requirements are covered...

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
