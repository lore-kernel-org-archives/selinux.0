Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hBJ79DRb010779
	for <selinux@tycho.nsa.gov>; Fri, 19 Dec 2003 02:09:13 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hBJ78Njx021443
	for <selinux@tycho.nsa.gov>; Fri, 19 Dec 2003 07:08:23 GMT
Received: from continuum.cm.nu (continuum.cm.nu [216.113.193.225])
	by jazzswing.ncsc.mil  with ESMTP id hBJ78NSR021440
	for <selinux@tycho.nsa.gov>; Fri, 19 Dec 2003 07:08:23 GMT
Received: from shane by continuum.cm.nu with local (Exim 4.30)
	id 1AXEl0-0000Hf-Ep
	for selinux@tycho.nsa.gov; Thu, 18 Dec 2003 23:09:06 -0800
Date: Thu, 18 Dec 2003 23:09:05 -0800
To: selinux@tycho.nsa.gov
Cc: Russell Coker <russell@coker.com.au>
Subject: Re: Domain Transitions (or the Exim4 policy)
Message-ID: <20031219070905.GA32075@cm.nu>
References: <20031219024548.GA24510@cm.nu>
	<200312191647.45107.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200312191647.45107.russell@coker.com.au>
From: Shane Wegner <shane-keyword-selinux.9d5a25@cm.nu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Dec 19, 2003 at 04:47:45PM +1100, Russell Coker wrote:
> Why did you change it to exim4_t?  It seems to me that as exim and sendmail 
> operate in the same manner it would be better to have a single policy to use 
> for them both.  This will make it easier to maintain the policy.

Point taken.  Exim does seem to use a slightly different
capability set and needs some modified permissions but
they're trivial changes.

> > permissions it needs.  Further, when a user sends mail, say
> > echo Hello world |mail
> > exim4 gets spawned but this time in the user_t domain,
> > again without the necessary permissions to write to its
> > spool.
> 
> In the sendmail policy it would transition to user_mail_t domain.

After adapting sendmail.te and putting that in per your
suggestion, it does indeed transition to user_mail_t though
I can't figure out how.  The problem I'm seeing now though
is from user_mail_t, exim doesn't have permission to wread
its config files.  Do I need to give user_mail_t or
user_mail_domain all the privileges given to sendmail_t in
the sendmail policy?  Also, is user_mail_t an alias for
some other domain.  I'm seeing user_mail_domain in policies
but don't see user_mail_t anywhere save a minor mention
in attrib.te.

Thanks for the suggestions, they were of great help.

Shane

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
