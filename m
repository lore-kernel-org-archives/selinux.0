Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1TED1QW031379
	for <selinux@tycho.nsa.gov>; Fri, 29 Feb 2008 09:13:01 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m1TECxQO025778
	for <selinux@tycho.nsa.gov>; Fri, 29 Feb 2008 14:12:59 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: refpolicy: patch for ldconfig from glibc 2.7, new patch
Date: Fri, 29 Feb 2008 08:46:01 -0500
Message-ID: <1204292761.32061.230.camel@gorn>
In-Reply-To: <20080229072116.GA13364@bobek.pm.i.cz>
References: <20080222152703.GA4163@bobek.pm.i.cz> <1203703539.32061.22.camel@gorn>  <20080229072116.GA13364@bobek.pm.i.cz>
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: =?iso-8859-1?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>
Cc: <selinux@tycho.nsa.gov>, <selinux-devel@lists.alioth.debian.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2008-02-29 at 08:21 +0100, Václav Ovsík wrote:
> Hi,
> this is a completion of previos patch...
[...]
> When se_aptitude or se_apt is ran on Debian (apt or aptitude execution wrapped
> with run_init), then the ldconfig called from a postinst and/or a postrm
> scripts of shared libs brings following denials:
> 
> Feb 28 12:24:59 sid kernel: audit(1204197899.429:13): avc:  denied  { read write } for  pid=3209 comm="ldconfig" name="2" dev=devpts ino=4 scontext=system_u:system_r:ldconfig_t:s0 tcontext=system_u:object_r:devpts_t:s0 tclass=chr_file
> Feb 28 12:24:59 sid kernel: audit(1204197899.429:14): avc:  denied  { use } for  pid=3209 comm="ldconfig" name="2" dev=devpts ino=4 scontext=system_u:system_r:ldconfig_t:s0 tcontext=system_u:system_r:apt_t:s0 tclass=fd
> Feb 28 12:24:59 sid kernel: audit(1204197899.429:15): avc:  denied  { write } for  pid=3209 comm="ldconfig" name="[23124]" dev=pipefs ino=23124 scontext=system_u:system_r:ldconfig_t:s0 tcontext=system_u:system_r:apt_t:s0 tclass=fifo_file
> 
> The attached patch (wich replaces my previos patch) suppresses these messages.
> Maybe this could be solved also by adding unconfined_domain(ldconfig_t) like
> Fedora or Ubuntu solves this. (This could be added to.)

The apt rules are fine, but there shouldn't be any more generic pty
usage anymore.  Are you using an older policy that doesn't have strict
and targeted merged (and unconfined_r)?

> @@ -103,3 +108,10 @@
>         # blow up.
>         rpm_manage_script_tmp_files(ldconfig_t)
>  ')
> +
> +optional_policy(`
> +       # ldconfig run from postinstall, postrm scripts on Debian...
> +       apt_rw_pipes(ldconfig_t)
> +       apt_use_fds(ldconfig_t)
> +       term_use_generic_ptys(ldconfig_t)
> +')
> 

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
