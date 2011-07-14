From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@tycho.nsa.gov>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: As we move to systemd, we are loosing some functionality from init scripts.
Date: Thu, 14 Jul 2011 23:23:41 +1000
References: <4E1CB8A5.2010707@redhat.com> <4E1DD9A7.80007@redhat.com> <1310647915.28361.2.camel@moss-pluto>
In-Reply-To: <1310647915.28361.2.camel@moss-pluto>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201107142323.42062.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 14 Jul 2011, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> Don't reuse the kernel classes/permissions please.  I know we've done
> that in e.g. crond in the past, but it conflates their purpose;

The crond operation is to ask the kernel what could happen if the crontab 
spool file was treated as an executable, and then apply the resulting context 
for executing the commands that it contains.

While this is not obvious to a SE Linux newbie, it makes sense and it closely 
matches the ancient crond code for checking UIDs for the Unix permission 
parts.

While making the operation more obvious to newbies does offer some benefits 
(including security benefits by avoiding mistakes), I can't think of a good 
way of achieving such a goal.

If we were to start from the Vixie-cron base and write entirely new SE Linux 
patches and policy without any legacy today how do you think we would do it 
better?

> define
> new classes/perms for this purpose instead.  Also be sure to use the
> newer interfaces for userspace object managers ala XSELinux so that you
> use dynamic class/perm mapping.  We still need the older userspace
> object managers to be updated in that regard.

systemd has to use labels on files for all variants of the proposed design so 
classes aren't an option.

Once we get role support in the filesystem code (how long will that take?) we 
could use role labels to determine which roles can execute the daemon start 
scripts.  But it would still surely end up with systemd just doing a check of 
whether the context of systemctl permits executing the /etc/init.d script in 
question.

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
