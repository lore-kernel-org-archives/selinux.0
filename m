Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1TGZErW024669
	for <selinux@tycho.nsa.gov>; Fri, 29 Feb 2008 11:35:14 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m1TGZ7wc011819
	for <selinux@tycho.nsa.gov>; Fri, 29 Feb 2008 16:35:07 GMT
Subject: Re: [DSE-Dev] refpolicy: patch for ldconfig from glibc 2.7,	new
	patch
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Martin Orr <martin@martinorr.name>
Cc: =?ISO-8859-1?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>,
        selinux@tycho.nsa.gov, selinux-devel@lists.alioth.debian.org
In-Reply-To: <47C824BE.5040001@martinorr.name>
References: <20080222152703.GA4163@bobek.pm.i.cz>
	 <1203703539.32061.22.camel@gorn> <20080229072116.GA13364@bobek.pm.i.cz>
	 <1204292761.32061.230.camel@gorn>  <47C824BE.5040001@martinorr.name>
Content-Type: text/plain; charset=ISO-8859-1
Date: Fri, 29 Feb 2008 11:32:29 -0500
Message-Id: <1204302749.32061.241.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2008-02-29 at 15:29 +0000, Martin Orr wrote:
> On 29/02/08 13:46, Christopher J. PeBenito wrote:
> > On Fri, 2008-02-29 at 08:21 +0100, Václav Ovsík wrote:
> >> When se_aptitude or se_apt is ran on Debian (apt or aptitude execution wrapped
> >> with run_init), then the ldconfig called from a postinst and/or a postrm
> >> scripts of shared libs brings following denials:
> >>
> >> Feb 28 12:24:59 sid kernel: audit(1204197899.429:13): avc:  denied  { read write } for  pid=3209 comm="ldconfig" name="2" dev=devpts ino=4 scontext=system_u:system_r:ldconfig_t:s0 tcontext=system_u:object_r:devpts_t:s0 tclass=chr_file
> >> Feb 28 12:24:59 sid kernel: audit(1204197899.429:14): avc:  denied  { use } for  pid=3209 comm="ldconfig" name="2" dev=devpts ino=4 scontext=system_u:system_r:ldconfig_t:s0 tcontext=system_u:system_r:apt_t:s0 tclass=fd
> >> Feb 28 12:24:59 sid kernel: audit(1204197899.429:15): avc:  denied  { write } for  pid=3209 comm="ldconfig" name="[23124]" dev=pipefs ino=23124 scontext=system_u:system_r:ldconfig_t:s0 tcontext=system_u:system_r:apt_t:s0 tclass=fifo_file
> >>
> >> The attached patch (wich replaces my previos patch) suppresses these messages.
> >> Maybe this could be solved also by adding unconfined_domain(ldconfig_t) like
> >> Fedora or Ubuntu solves this. (This could be added to.)
> > 
> > The apt rules are fine, but there shouldn't be any more generic pty
> > usage anymore.  Are you using an older policy that doesn't have strict
> > and targeted merged (and unconfined_r)?
> 
> It's because apt creates a pty of its own to run dpkg on, so it can log the
> output.  (This is fairly recent - it has been in apt trunk since October.)

Makes sense.

> The attached patch is what I am using to deal with this.  (I'm not sure if
> it should be apt_dontaudit_use_fds(ldconfig_t) or apt_use_fds(ldconfig_t)
> but dontaudit is what the Debian policy package uses.)

You probably want to allow it otherwise ldconfig won't inherit the fds
that point to the apt pty.  By denying the inheritance on an enforcing
system, fd 0,1,2 will be closed and reopened to /dev/null, so you lose
any ldconfig output.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
