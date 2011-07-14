Subject: Re: As we move to systemd, we are loosing some functionality from
 init scripts.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <201107142323.42062.russell@coker.com.au>
References: <4E1CB8A5.2010707@redhat.com> <4E1DD9A7.80007@redhat.com>
	 <1310647915.28361.2.camel@moss-pluto>
	 <201107142323.42062.russell@coker.com.au>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 14 Jul 2011 09:41:56 -0400
Message-ID: <1310650916.28361.12.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2011-07-14 at 23:23 +1000, Russell Coker wrote:
> On Thu, 14 Jul 2011, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > Don't reuse the kernel classes/permissions please.  I know we've done
> > that in e.g. crond in the past, but it conflates their purpose;
> 
> The crond operation is to ask the kernel what could happen if the crontab 
> spool file was treated as an executable, and then apply the resulting context 
> for executing the commands that it contains.

Yes, IIRC, that was my idea.

> While this is not obvious to a SE Linux newbie, it makes sense and it closely 
> matches the ancient crond code for checking UIDs for the Unix permission 
> parts.
> 
> While making the operation more obvious to newbies does offer some benefits 
> (including security benefits by avoiding mistakes), I can't think of a good 
> way of achieving such a goal.
> 
> If we were to start from the Vixie-cron base and write entirely new SE Linux 
> patches and policy without any legacy today how do you think we would do it 
> better?

In retrospect, I think it would have been cleaner to have defined a
unique class/perm for this purpose.  Both in order to cleanly delineate
the kernel classes/permissions from userspace ones and to make clear the
semantic difference between an execve of a file and running a cron job
from a configuration file.

> systemd has to use labels on files for all variants of the proposed design so 
> classes aren't an option.

It is fine for systemd to use a file label as the object security
context if that is the granularity at which we want to control the
operations, but systemd can still define and use its own classes and
permissions for the permission checks on its operations.  In a similar
manner, dbusd is using the security context of the destination process
as the object security context for its check, yet it defines its own
class and permissions for those checks.  And of course all of the
userspace object managers are using the process context as the
subject/source context.

> Once we get role support in the filesystem code (how long will that take?) we 
> could use role labels to determine which roles can execute the daemon start 
> scripts.  But it would still surely end up with systemd just doing a check of 
> whether the context of systemctl permits executing the /etc/init.d script in 
> question.
> 

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
