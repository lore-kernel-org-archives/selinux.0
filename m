Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5AMCMrT002167
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 18:12:22 -0400 (EDT)
Received: from smtp800.mail.ukl.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i5AMCJaH026406
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 18:12:19 -0400 (EDT)
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.155.76.36 with poptime)
  by smtp800.mail.ukl.yahoo.com with SMTP; 10 Jun 2004 22:12:20 -0000
Date: Thu, 10 Jun 2004 22:09:40 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Ed Street <edstreet@street-tek.com>, "'SE-Linux'" <selinux@tycho.nsa.gov>
Subject: Re: [debian] postfix chroot setup from /etc/init.d/postfix isn't working.
Message-ID: <20040610220940.GT2861@lkcl.net>
References: <20040610193218.8DD243A4066@abyss.simplyaquatics.com> <1086897134.4397.125.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1086897134.4397.125.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Jun 10, 2004 at 03:52:14PM -0400, Stephen Smalley wrote:
> On Thu, 2004-06-10 at 15:32, Ed Street wrote:
> > Well like they say chroot is the poor mans security setup :) Disabling the
> > chroot jail would be the best solution overall.
> 
> Defense in depth is a good idea, so using chroot (or other measures) in
> combination with SELinux is quite sensible...
 
 then, ideally, the stuff that creates the chroot jail needs to be moved into
 a separate "helper" script that can be run in its own context

 and the postfix.te script needs to have these added:

	 allow postfix_cleanup_t postfix_cleanup_t:capability { sys_chroot };
	 allow postfix_master_t postfix_master_t:capability { sys_chroot };
	 allow postfix_pickup_t postfix_pickup_t:capability { sys_chroot };
	 allow postfix_qmgr_t postfix_qmgr_t:capability { sys_chroot };

 and possibly more?  i am only running a local-delivery-only postfix.


 or, i am sure that there are people on this list who can think of a
 safe way to do this.

 l.

-- 
-- 
Information I post is with honesty, integrity, and the expectation that
you will take full responsibility for acting on the information contained,
and that, should you find it to be flawed or even mildly useful, you
will act with both honesty and integrity in return - and tell me.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
