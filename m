Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6TDkgrT018660
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 09:46:42 -0400 (EDT)
Received: from smtp807.mail.ukl.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i6TDkeCb005258
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 13:46:40 GMT
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.152.10.162 with poptime)
  by smtp807.mail.ukl.yahoo.com with SMTP; 29 Jul 2004 13:46:40 -0000
Date: Thu, 29 Jul 2004 14:57:45 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: temporary hack to use udev in selinux
Message-ID: <20040729135745.GB8858@lkcl.net>
References: <20040728232043.GF18711@lkcl.net> <1091104600.21971.8.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1091104600.21971.8.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Jul 29, 2004 at 08:36:41AM -0400, Stephen Smalley wrote:
> On Wed, 2004-07-28 at 19:20, Luke Kenneth Casson Leighton wrote:
> > fighting with it for a day, and after seeing some clues in the
> > file contexts (/(u)dev/....) i decided to try editing
> > /etc/udev/udev.conf to set it to use /udev instead of /dev.
> 
> I don't know which policy version you are using, but in the current
> policy, the regexes are of the form "/u?dev", so it works with either a
> /dev or /udev.  Requires using a xattr-supporting filesystem for udev,
> naturally.
 
 as i mention in my previous post, /.dev is the location that the
 debian maintainer has chosen to re-mount the "old" /dev which will
 have been hidden by udev.

 consequently, because /.dev is not listed in file_contexts/types.fc,
 all permissions get destroyed to system_u:object_r:default_t.

 on next boot, /sbin/init is denied access to /dev/hda2, my root
 partition!!!

 adding in /.?u?dev into the regex fixes the problem [ItWorksForMe(tm)]

 hey, maybe it should be /\.u?dev/.
 
 i didn't say i was any _good_ at writing regexes.
 
 [25 years of doing computer programming and i still avoid
 them as much as i can.]

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
