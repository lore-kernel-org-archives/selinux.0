Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h5ONLT3E026350
	for <selinux@tycho.nsa.gov>; Tue, 24 Jun 2003 19:21:29 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h5ONLS5e009136
	for <selinux@tycho.nsa.gov>; Tue, 24 Jun 2003 23:21:28 GMT
Received: from citation.av8.net ([130.105.12.4])
        by jazzband.ncsc.mil  with ESMTP id h5ONLS92009133 for <selinux@tycho.nsa.gov>; Tue, 24 Jun 2003 23:21:28 GMT
Date: Tue, 24 Jun 2003 19:18:13 -0400 (EDT)
From: Dean Anderson <dean@av8.com>
To: Russell Coker <russell@coker.com.au>
cc: selinux@tycho.nsa.gov
Subject: Re: proftpd
In-Reply-To: <200306250840.43592.russell@coker.com.au>
Message-ID: <Pine.LNX.4.44.0306241911350.11879-100000@vista.av8.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I was trying to fire up binaries (that I planned to put in rc.local)
directly using run_init.  I figured out why this doesn't work just now.
The run_init can make transition the rc scripts to the initrc_t domain,
and then things they start can be transitioned from initrc_t to their
domain. The documentation says this, but I wasn't reading the
documentation closely enough.

		--Dean

On Wed, 25 Jun 2003, Russell Coker wrote:

> On Wed, 25 Jun 2003 05:15, Dean Anderson wrote:
> > I'm having some trouble with the proftpd program, specifically, it won't
> > seem to transition from the initrc domain to the ftpd_t domain
>
> The daemon_domain() macro should take care of this.
>
> > I relabeled the files (after changing the path to the proftpd binary to
> > /usr/local/sbin/proftpd in file_contexts/programs/ftpd.fc
> >
> > ls --context /usr/local/sbin/proftpd
> > shows system_u:object_r:ftpd_exec_t
> >
> > grep ftpd_exec_t policy.conf shows a type transition line:
> > type_transition initrc_t ftpd_exec_t:process ftpd_t
> >
> > Yet, no effect. Rebooting also has no effect.
>
> It seems that you've done all the right checks.  I'm not sure what's going
> wrong here.
>
> > Interestingly, the radius.te file has this:
> >
> > domain_auto_trans(system_crond_t, radiusd_exec_t, radiusd_t)
> >
> > However, radius is not started by cron. What is up with this?
>
> This is so that cron jobs for maintaining RADIUS run in the same domain.  It
> may be worth putting the cron job into a different domain, maybe
> radius_crond_t.
>
> --
> http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
> http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
> http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
> http://www.coker.com.au/~russell/  My home page
>
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
