Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tAN88RhU004016
 for <selinux@tycho.nsa.gov>; Mon, 23 Nov 2015 03:08:27 -0500
Received: by wmec201 with SMTP id c201so147919967wme.0
 for <selinux@tycho.nsa.gov>; Mon, 23 Nov 2015 00:08:09 -0800 (PST)
Date: Mon, 23 Nov 2015 09:08:07 +0100
From: Dominick Grift <dac.override@gmail.com>
To: Laurent Bigonville <bigon@debian.org>
Cc: selinux@tycho.nsa.gov
Subject: Re: (Userspace) AVC denial generated even if allowed by the policy?
Message-ID: <20151123080806.GA5869@x250>
References: <5652636F.2060609@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
In-Reply-To: <5652636F.2060609@debian.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On Mon, Nov 23, 2015 at 01:53:03AM +0100, Laurent Bigonville wrote:
> Hi,
> 
> I'm still looking at adding SELinux support in the "at" daemon and I now
> have the following patch[0].
> 
> With this patch, at seems to behave like the cron daemon, as explained in
> the commit log:
> 
>     - When cron_userdomain_transition is set to off, a process for an
>       unconfined user will transition to unconfined_cronjob_t. For confined
>       user, the job is run as cronjob_t.
> 
>     - When cron_userdomain_transition is set to on, the processes are run
>       under the user default context.
> 
> But every time an AVC denial is generated (with cron_userdomain_transition
> set to off and the user running as staff_u, in permissive with unmodified
> refpolicy):
> 
> avc:  denied  { entrypoint } for scontext=staff_u:staff_r:cronjob_t:s0
> tcontext=staff_u:object_r:user_cron_spool_t:s0 tclass=file
> 
> The job runs as (id -Z): staff_u:staff_r:cronjob_t:s0
> 
> But audit2{allow,why} are saying that this is already allowed in the policy
> 
> Setting the cron_userdomain_transition boolean to on, I have the following
> avc:
> 
> avc:  denied  { entrypoint } for scontext=staff_u:sysadm_r:sysadm_t:s0
> tcontext=staff_u:object_r:user_cron_spool_t:s0 tclass=file

I think this is weird as well since user_cron_spool_t is not actually
executed as far as i know (and thus is not actually an entrypoint). The entrypoint permission is merely allowed so
that crond_t/atd_t can calculate access to the target domains.

So i do not see why these entrypoint events are hit in the first place

> 
> The job runs as (id -Z): staff_u:sysadm_r:sysadm_t:s0
> 
> So as said it seems to work, but I'm not sure why this AVC denial is
> generated.
> 
> sesearch shows:
> 
> $ sesearch -ATSC  -t user_cron_spool_t -c file -p entrypoint
> Found 6 semantic av rules:
>    allow files_unconfined_type file_type : file { ioctl read write create
> getattr setattr lock relabelfrom relabelto append unlink link rename execute
> swapon quotaon mounton execute_no_trans entrypoint open audit_access } ;
> DT allow unconfined_t user_cron_spool_t : file entrypoint ; [
> cron_userdomain_transition ]
> DT allow user_t user_cron_spool_t : file entrypoint ; [
> cron_userdomain_transition ]
> EF allow cronjob_t user_cron_spool_t : file entrypoint ; [
> cron_userdomain_transition ]
> DT allow staff_t user_cron_spool_t : file entrypoint ; [
> cron_userdomain_transition ]
> DT allow sysadm_t user_cron_spool_t : file entrypoint ; [
> cron_userdomain_transition ]
> 
> Did I overlooked something?
> 
> Cheers,
> 
> Laurent Bigonville
> 
> [0] https://anonscm.debian.org/cgit/users/bigon/at.git/commit/?h=selinux&id=0112f006b74a36f7200e315575fd25d78e11b170
> 
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.

- -- 
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
https://sks-keyservers.net/pks/lookup?op=get&search=0x314883A202DFF788
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJWUsliAAoJENAR6kfG5xmceAcL/jHlL/Ru8AeJ0kciGQoBfNHQ
KszDv3fv5x3l1qlN9311Do8mnjVedZS+7fucA+AaXT1R/EpSdVlZZsf5fXaIhPc3
k28niDSGIWrLypLsjlEbkZ/KgIZNuMOnmIVmfuhakVlyZmdq/VFmd6wQb1xuIoet
ZrPclGtiXbKljkKbXTlMWEioMf1mM1CRUWuekZu2ViGWbBRCAOvl+qbWQzRgW5Xy
QWk4U29wXLHlhr3UYIdiZcR7avprY3e6xhb+KmL6Q7smfuIsV8iLT3qIy1r/9nLb
cotbilVVnBdJYZxuTqZxe7nZpCl2tY9ScYtgarljqBWanOG1Qt8jPLgIVdyXDYZs
64vfPoBuAj/XaKxoiffm3U4xuMSfQOJKkEA0VGWjvz2P2f9qWXw5Qwrfb6IxQKkP
TjAB+E1kauzvrVzXaw1vbgYOfrggcl4dGoSaA347C4KxAa/BXh76Cj23DfWeF82P
799SMSSzLZQGQKCOhArW7I0ZwFSRAXQtaX2LqH11Yw==
=g861
-----END PGP SIGNATURE-----
