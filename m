Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8HAEfLa024066
	for <selinux@tycho.nsa.gov>; Wed, 17 Sep 2003 06:14:41 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h8HAEdmw000382
	for <selinux@tycho.nsa.gov>; Wed, 17 Sep 2003 10:14:39 GMT
Received: from sat.sws.net.au (sat.sws.net.au [202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h8HAEa9d000371 for <selinux@tycho.nsa.gov>; Wed, 17 Sep 2003 10:14:37 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Dale Amon <amon@vnl.com>, Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: Boot time avc messages
Date: Wed, 17 Sep 2003 20:14:22 +1000
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
References: <20030915214153.GE8988@vnl.com> <20030916145353.GM8988@vnl.com>
In-Reply-To: <20030916145353.GM8988@vnl.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200309172014.22502.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 17 Sep 2003 00:53, Dale Amon wrote:
> avc:  denied  { write } for  pid=303 exe=/usr/sbin/setfiles path=/dev/tty1
> dev=sda2 ino=946919 scontext=root:sysadm_r:setfiles_t
> tcontext=system_u:object_r:tty_device_t tclass=chr_file

I guess that setfiles relabeled /dev which includes your terminal device.  
Your shell can still write to it because it runs as sysadm_t, but setfiles_t 
can't.  I'll give setfiles such access.  Normally it won't make any 
difference, but in some situations it can make relabeling work correctly.

> # DEVFSD was disincluded from this test kernel but daemon is here
> avc:  denied  { sys_tty_config } for  pid=319 exe=/bin/bash capability=26
> scontext=system_u:system_r:devfsd_t tcontext=system_u:system_r:devfsd_t
> tclass=capability

Strange.  What script is this?  Is it /sbin/devfsd_make_links?

> avc:  denied  { sys_tty_config } for  pid=328 exe=/sbin/hwclock
> capability=26 scontext=system_u:system_r:hwclock_t
> tcontext=system_u:system_r:hwclock_t tclass=capability

I can't understand why hwclock would want to do that.  Bug in hwclock?

> # There does not seem to be any bootlogd policy
> avc:  denied  { read write } for  pid=48 exe=/sbin/bootlogd dev=sda2
> ino=946402 scontext=system_u:system_r:initrc_t
> tcontext=system_u:object_r:device_t tclass=chr_file

True, such policy needs to be written.

> avc:  denied  { ioctl } for  pid=48 exe=/sbin/bootlogd path=/dev/ptyp0
> dev=sda2 ino=946402 scontext=system_u:system_r:initrc_t
> tcontext=system_u:object_r:device_t tclass=chr_file

Don't use them, use unix98 pty's.  I don't think that SE Linux will ever 
support old pty's.

I do:
rm -f /dev/[tp]ty[abcdepqrstuvwxyz][0-9a-f]

See: http://www.coker.com.au/selinux/tweaks.html

> avc:  denied  { mounton } for  pid=113 exe=/bin/mount path=/dev/pts dev=
> ino=1 scontext=system_u:system_r:mount_t
> tcontext=system_u:object_r:devpts_t tclass=dir

Having the /dev/pts directory may be a bad thing, but I'll add an allow rule 
for that to my policy (for the moment at least).

> # I'm using syslog-ng instead with minor policy changes. Perhaps
> # Russ's latest have these items fixed?
> avc:  denied  { read } for  pid=220 exe=/sbin/syslog-ng path=pipe:[1143]
> dev= ino=1143 scontext=system_u:system_r:syslogd_t
> tcontext=system_u:system_r:syslogd_t tclass=fifo_file

I'll add that to my policy, it does no harm, and a future version of the 
regular syslogd may want to do the same.

> avc:  denied  { syslog_mod } for  pid=221 exe=/sbin/syslog-ng
> scontext=system_u:system_r:syslogd_t tcontext=system_u:system_r:kernel_t
> tclass=system

I'll add that to my policy too.

> avc:  denied  { name_bind } for  pid=221 exe=/sbin/syslog-ng port=999
> scontext=system_u:system_r:syslogd_t tcontext=system_u:object_r:port_t
> tclass=tcp_socket

What is port 999 for?

> avc:  denied  { fsetid } for  pid=221 exe=/sbin/syslog-ng capability=4
> scontext=system_u:system_r:syslogd_t tcontext=system_u:system_r:syslogd_t
> tclass=capability

Which of the following does syslog-ng do and why?

/* Overrides the following restrictions that the effective user ID
   shall match the file owner ID when setting the S_ISUID and S_ISGID
   bits on that file; that the effective group ID (or one of the
   supplementary group IDs) shall match the file owner ID when setting
   the S_ISGID bit on that file; that the S_ISUID and S_ISGID bits are
   cleared on successful return from chown(2) (not implemented). */

> avc:  denied  { setattr } for  pid=221 exe=/sbin/syslog-ng dev=sda2
> ino=946940 scontext=system_u:system_r:syslogd_t
> tcontext=system_u:object_r:tty_device_t tclass=chr_file

Looks like you have configured it to log stuff to a special virtual console.  
I do the same, but it's not a default config so not something we want in 
policy.

> avc:  denied  { search } for  pid=230 exe=/usr/sbin/inetd dev=sda2
> ino=903169 scontext=system_u:system_r:inetd_t
> tcontext=system_u:object_r:var_lib_t tclass=dir

What was it looking for under /var/lib?  Put in the following:
allow inetd_t var_lib_t:dir search;
auditallow inetd_t var_lib_t:dir search;

Then we'll get more info about what's happening.

> avc:  denied  { name_bind } for  pid=230 exe=/usr/sbin/inetd port=25
> scontext=system_u:system_r:inetd_t tcontext=system_u:object_r:smtp_port_t
> tclass=tcp_socket

What mail server are you using?  Is that a default config or some unusual 
custom config?

> avc:  denied  { unlink } for  pid=258 exe=/bin/rm dev=sda2 ino=929844
> scontext=system_u:system_r:initrc_t tcontext=system_u:object_r:var_log_t
> tclass=file

bootlogd?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
