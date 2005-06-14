Subject: Re: general selinux questions
From: antoine <antoine@nagafix.co.uk>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1118433283.3774.218.camel@moss-spartans.epoch.ncsc.mil>
References: <1118281858.9481.4.camel@localhost>
	 <1118341614.30110.122.camel@moss-spartans.epoch.ncsc.mil>
	 <1118433604.10190.353.camel@localhost>
	 <1118433283.3774.218.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 14 Jun 2005 18:24:36 +0100
Message-Id: <1118769876.10262.52.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > ping [whatever] >& tempfile
(...) 
> Likely needed to redirect stdin too.
DOH. I'll try that.


[Note]:
Just about anything (ie: ssh login) seems to require:
'allow sysadm_t devpts_t:chr_file getattr;'
(I've put it in admin.te for now)


I've only got 2 problems left I *really* cannot figure out:
1)
audit(1118762231.596:0): avc:  denied  { transition } for  pid=28871
exe=/usr/lib/postfix/master path=/usr/lib/postfix/pipe dev=md3
ino=670776 scontext=system_u:system_r:postfix_master_t
tcontext=system_u:object_r:postfix_pipe_t tclass=process
So I've added this to postfix.te (from audit2allow):
allow postfix_master_t postfix_pipe_t:process transition;
But it has no effect and the same audit message keeps coming up!
I have absolutely no idea where to go from here...

Here are some related rules:
domain_auto_trans(postfix_master_t, postfix_pipe_exec_t, postfix_pipe_t)
I tried adding these:
role_transition system_r postfix_pipe_exec_t object_r;
allow postfix_master_t postfix_pipe_t:process transition;
role object_r types postfix_pipe_t;

-rwxr-xr-x  root     root
system_u:object_r:postfix_master_exec_t /usr/lib/postfix/master
-rwxr-xr-x  root     root
system_u:object_r:postfix_pipe_exec_t /usr/lib/postfix/pipe

2)
All similar to the one above (any code that calls sendmail):
audit(1118761207.922:0): avc:  denied  { transition } for  pid=28648
exe=/bin/bash path=/usr/sbin/sendmail dev=md3 ino=783481
scontext=system_u:system_r:myscript_exec_t
tcontext=system_u:object_r:sysadm_mail_t tclass=process

I tried the same rules as above with no effect...


> > I use Gentoo, it does the same thing:
> > # grep tmpfs_t policy.conf
> > type tmpfs_t, file_type, sysadmfile, fs_type;
> > allow { tmpfs_t tmp_t } tmpfs_t:filesystem associate;
> > (..)
> 
> Yes, but does it restorecon /tmp or use a context mount to get it into
> tmp_t rather than tmpfs_t?
When/where? You've lost me...

> Are you sure you are in permissive mode (getenforce)?  If so, then
> SELinux shouldn't be in your way at all.  /chroot is a local fs?
Yes /chroot is just a sub-directory of /
# getenforce
Permissive

> Fedora migrated to /etc/selinux and reorganized the layout in FC3, but
> libselinux knows to fall back to the old locations
> under /etc/security/selinux if it cannot find /etc/selinux, so that
> shouldn't be a problem.
Gentoo has /etc/security/selinux but no 'config' file in there.

Is there an equivalent to run_init for cron scripts? (one of my cron
scripts is misbehaving and I want to trace it in exactly the same env)


Thanks
Antoine


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
