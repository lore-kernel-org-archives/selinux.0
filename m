Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hBJI3URb013261
	for <selinux@tycho.nsa.gov>; Fri, 19 Dec 2003 13:03:30 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hBJI3Tpn000347
	for <selinux@tycho.nsa.gov>; Fri, 19 Dec 2003 18:03:29 GMT
Received: from continuum.cm.nu (continuum.cm.nu [216.113.193.225])
        by jazzband.ncsc.mil  with ESMTP id hBJI3Sab000344 for <selinux@tycho.nsa.gov>; Fri, 19 Dec 2003 18:03:28 GMT
Received: from shane by continuum.cm.nu with local (Exim 4.30)
	id 1AXOyF-0006DU-Ka
	for selinux@tycho.nsa.gov; Fri, 19 Dec 2003 10:03:27 -0800
Date: Fri, 19 Dec 2003 10:03:26 -0800
To: selinux@tycho.nsa.gov
Cc: Russell Coker <russell@coker.com.au>
Subject: Re: Domain Transitions (or the Exim4 policy)
Message-ID: <20031219180326.GA23288@cm.nu>
References: <20031219024548.GA24510@cm.nu>
	<200312191647.45107.russell@coker.com.au>
	<20031219070905.GA32075@cm.nu>
	<200312191859.56996.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200312191859.56996.russell@coker.com.au>
From: Shane Wegner <shane-keyword-selinux.9d5a25@cm.nu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Dec 19, 2003 at 06:59:56PM +1100, Russell Coker wrote:
> On Fri, 19 Dec 2003 18:09, Shane Wegner <shane-dated-1074409746.778e04@cm.nu> 
> wrote:
> > On Fri, Dec 19, 2003 at 04:47:45PM +1100, Russell Coker wrote:
> > > Why did you change it to exim4_t?  It seems to me that as exim and
> > > sendmail operate in the same manner it would be better to have a single
> > > policy to use for them both.  This will make it easier to maintain the
> > > policy.
> >
> > Point taken.  Exim does seem to use a slightly different
> > capability set and needs some modified permissions but
> > they're trivial changes.
> 
> Send me a list.
> 
> I think that possibly the solution to this is to have sendmail.te and exim.te 
> both instantiate a common macro for 99% of the policy.

Ok, differences I can spot are:
Exim needs only read access to sendmail_conf_t it its case
/etc/exim4 and /var/lib/exim4
Init scripts need write access to /var/lib/exim4 as the
main config file automatically gets generated from
fragments on startup/reload.
Needs read access to /dev/urandom
Needs append-only access to sendmail_log_t  In exim's case,
it's a directory (/var/log/exim4).
Needs complete access to sendmail_mqueue_t including
mkdir/rmdir/file locking etc.  That's exim's playground.
Needs read access to /home or /home/(^/+)/.procmailrc.  The
procmail filter checks for the existance of a user's
.procmailrc file which is how it decides whether to use
procmail as the delivery agent or if not found, it delivers
to the mail spool directly.  I suppose it'd also need
$HOME/.forward etc.

Capabilities Exim uses which the sendmail.te doesn't
currently allow: dac_override fowner sys_resource.

Sendmail allows sys_nice and sys_tty_config which Exim does
not appear to use.  Exim also needs a line similar to:
allow sendmail_t self:process setpgid;

Best,
Shane

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
