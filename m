Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6TEBVrT019067
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 10:11:32 -0400 (EDT)
Received: from smtp814.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i6TEB0bB021436
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 14:11:00 GMT
Date: Thu, 29 Jul 2004 15:22:36 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Joshua Brindle <method@gentoo.org>, SE-Linux <selinux@tycho.nsa.gov>,
   James Morris <jmorris@redhat.com>
Subject: Re: temporary hack to use udev in selinux
Message-ID: <20040729142236.GH8858@lkcl.net>
References: <20040728232043.GF18711@lkcl.net> <410844F9.3010203@gentoo.org> <20040729013510.GC4335@lkcl.net> <20040729020431.GA10044@lkcl.net> <1091105268.21971.22.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1091105268.21971.22.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Jul 29, 2004 at 08:47:48AM -0400, Stephen Smalley wrote:

> On Wed, 2004-07-28 at 22:04, Luke Kenneth Casson Leighton wrote:
> > okay, i've added in some stuff for tmpfs, just like chris did,
> > joshua.

 ... by the way is anyone at all worried that shmfs doesn't have
 an exit_tmpfs function?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
