Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6OK0SHa003447
	for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2003 16:00:28 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h6OK0RDW008168
	for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2003 20:00:27 GMT
Received: from prometheus.epoch.ncsc.mil (prometheus.epoch.ncsc.mil [144.51.25.40])
        by jazzband.ncsc.mil  with ESMTP id h6OK0QeN008163 for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2003 20:00:26 GMT
Received: from prometheus.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by prometheus.epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6OK0QxH014711
	for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2003 16:00:26 -0400
Received: (from jwcart2@localhost)
	by prometheus.epoch.ncsc.mil (8.12.8/8.12.8/Submit) id h6OK0QMq014709
	for selinux@tycho.nsa.gov; Thu, 24 Jul 2003 16:00:26 -0400
Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6OJvDHa003428
	for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2003 15:57:14 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h6OJu6FB028010
	for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2003 19:56:06 GMT
Received: from citation.av8.net ([130.105.12.4])
	by jazzswing.ncsc.mil  with ESMTP id h6OJu6GD028007
	for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2003 19:56:06 GMT
Date: Thu, 24 Jul 2003 15:51:27 -0400 (EDT)
From: Dean Anderson <dean@av8.com>
To: Michael Luu <mluu@cougaarsoftware.com>
cc: "'Russell Coker'" <russell@coker.com.au>, <selinux@tycho.nsa.gov>
Subject: RE: can't log into machine w/ ssh
In-Reply-To: <000901c35213$a6ce2590$ef0111ac@mluudt>
Message-ID: <Pine.LNX.4.44.0307241531570.23576-100000@vista.av8.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Actaully, you can only use run_init to run the rc scripts, and things run
directly by init. Only the RC scripts can start daemons. I also tried to
use run_init to directly start daemons, but it misses the transition from
init_t to initrc_t to sshd_t followed by init running the scripts:

domain_auto_trans(init_t, initrc_exec_t, initrc_t)
domain_auto_trans(initrc_t, sshd_exec_t, sshd_t)

The correct way to restart daemons is to use run_init to run the
/etc/rc.d/init.d/<svc> restart script.  This is problematic for things
that are started out of rc.local. Possibly, separate rules could be made
for rc.local programs along the lines of  doamin_auto_trans(init_t,
sshd_exec_t, sshd_t)  or perhaps a run_initrc program.

Though, probably, its better to create a separate rc script for its admin
benefits...

		--Dean

On Thu, 24 Jul 2003, Michael Luu wrote:

> thanks for your help!
>
> mike
>
> -----Original Message-----
> From: Russell Coker [mailto:russell@coker.com.au]
> Sent: Thursday, July 24, 2003 11:11 AM
> To: Michael Luu; selinux@tycho.nsa.gov
> Subject: Re: can't log into machine w/ ssh
>
>
> On Thu, 24 Jul 2003 13:54, Michael Luu wrote:
> > when all else fails, rebooting the machine will make things work. :)
> > anyways, would you happen to know which services needs to be restarted
>
> > when i do add users and perform policy updates?
>
> Nothing needs to be restarted.
>
> I guess that you had sshd running in the wrong domain, and that when you
>
> rebooted it was started in the right domain.
>
> You have to use run_init to start daemons...
>
> --
> http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux
> packages
> http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
> http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
> http://www.coker.com.au/~russell/  My home page
>
>
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
