Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6G2YJrT026753
	for <selinux@tycho.nsa.gov>; Thu, 15 Jul 2004 22:34:20 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6G2XrEp018037
	for <selinux@tycho.nsa.gov>; Fri, 16 Jul 2004 02:33:55 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Erich Schubert <erich@debian.org>
Subject: Re: SELinux Policy patches
Date: Fri, 16 Jul 2004 12:34:03 +1000
Cc: selinux@tycho.nsa.gov, bam@snoopy.apana.org.au
References: <20040716002210.GA1081@wintermute.xmldesign.de>
In-Reply-To: <20040716002210.GA1081@wintermute.xmldesign.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200407161234.03434.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 16 Jul 2004 10:22, Erich Schubert <erich@debian.org> wrote:
> # can be a link, too - maybe dontaudit, since this is the "build" link
> # in my case, which it does not need to read...
> allow initrc_t modules_object_t:lnk_file read;

I think that dontaudit is the correct thing to do.

> # spamd going for a link in the perl dirs (5.8 -> 5.8.1 or so)
> allow spamd_t usr_t:lnk_file read;

OK, I've put it in my tree.

> # not sure if this is still needed with the recent path changes:
> allow load_policy_t policy_src_t:lnk_file read;

Should not be needed.

> # I also added (don't remember what that was needed for):
> can_exec(logrotate_t, logrotate_exec_t)

Can you find out what it is needed for?

> # Newer versions of pppd can update the utmp file:
> allow pppd_t initrc_var_run_t:file rw_file_perms;

Is it really updating the utmp file or just inappropriately opening the file 
read/write for a read operation?  Please tell me where this is documented.

> Then a small change for the file_contexts/program/named.fc
> -/etc/bind/rndc\.key    --  system_u:object_r:rndc_conf_t
> +/etc/bind/rndc.*   --  system_u:object_r:rndc_conf_t
> (debian default installation included rndc.conf i think)

What version of the package is this?

> I have a couple of access violation with applications of
>   foo var_lib_t:dir search;
>   foo var_lib_t:lnk_file read;
> for example syslogd, inetd, postfix_masteri, staff_ssh_t.
> Should i allow these or use dontaudit, and should i submit patches for
> such? Is there a known reason for such behaviour?

What are they trying to access under /var/lib?

> /bin/mountpoint gets access violations for "tmpfs_t", "devpts_t".
> Should i add these to fsadm_t or make a new mountpoint_t?

Add them to fsadm_t.

> Any idea what this is "good" for, what is modprobe trying to do:
> denied  { write } for  pid=281 exe=/sbin/modprobe name=8390.ko
> scontext=system_u:system_r:insmod_t
> tcontext=system_u:object_r:modules_object_t tclass=file

That's a bug in modprobe, there is already a Debian bug report about it.

> "amavis.te" is causing two violations (consider dontaudit)
> # allow amavis to search clamd socket in /var/run/clamav
> allow amavisd_t clamd_var_run_t:dir search;
> # cron job trying to search /var/lib/amavis
> allow crond_t amavisd_lib_t:dir search;

Brian, what do you think?

> "spamd.te" similar:
> -allow spamd_t { etc_t etc_runtime_t }:file { getattr read };
> +allow spamd_t { etc_t etc_runtime_t }:file { getattr read ioctl };
> -allow spamd_t usr_t:file { getattr ioctl read };
> +allow spamd_t usr_t:{ lnk_file file } { getattr ioctl read };

OK, added to my tree.

> "clamav.te" needs log file support here:
> +# for log files
> +log_domain(clamd)
> +rw_dir_file(clamd_t, clamd_log_t)

logdir_domain(clamd) does this.  Added to my tree.

> "clamav.fc" needs the following:
> +/var/log/clamav(/.*)? --       system_u:object_r:clamd_log_t
> +/var/run/clamav(/.*)?          system_u:object_r:clamd_var_run_t

Added to my tree.

> Should i keep such rules in my local.te file, or should i also publish
> them somehow? Some things like the dhcpd-failover or named-log thing
> could be of general interest.

The dhcpd-failover thing sounds useful.

Also for the attached files please send another message describing the changes 
with diffs.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
