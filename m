Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m15DC1kM000306
	for <selinux@tycho.nsa.gov>; Tue, 5 Feb 2008 08:12:01 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m15DC184019173
	for <selinux@tycho.nsa.gov>; Tue, 5 Feb 2008 13:12:01 GMT
Subject: Re: How to contribute: policy?
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Eoin Ryan <ryaneoin@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <207608340802041208y44962ac0u98a3b0753f74b7ec@mail.gmail.com>
References: <207608340802041208y44962ac0u98a3b0753f74b7ec@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 05 Feb 2008 08:10:06 -0500
Message-Id: <1202217006.7533.46.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2008-02-04 at 20:08 +0000, Eoin Ryan wrote:
> I'm on a mission to run a personal server using the strict policy,
> mainly as a learning exercise.  I've just come across what seems to be
> an error in the policy, so I thought a good way to contribute might be
> to submit bug reports as I work to configure the system for
> mail/web/etc.  Is this the correct place/way to submit such problems?
> 
> The following was generated after the root user (logged in as
> sysadm_r) executed the newaliases command on RHEL5, 2.6.18-53.1.6.el5
> kernel and strict policy version 21.

You can post it here, but since its RHEL you probably should post it to
Red Hat bugzilla so it can go through the right processes to be included
in the next RHEL update.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
