Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA4IMnXZ025478
	for <selinux@tycho.nsa.gov>; Thu, 4 Nov 2004 13:22:49 -0500 (EST)
Received: from oe-im2.bizmailsrvcs.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA4IMicx010063
	for <selinux@tycho.nsa.gov>; Thu, 4 Nov 2004 18:22:45 GMT
Subject: Re: Updated SELinux Release
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Colin Walters <walters@verbum.org>,
   Manoj Srivastava <manoj.srivastava@stdc.com>,
   SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1099575525.3174.7.camel@moss-spartans.epoch.ncsc.mil>
References: <1099496380.1213.111.camel@moss-spartans.epoch.ncsc.mil>
	 <87vfcmqvi5.fsf@glaurung.internal.golden-gryphon.com>
	 <1099539462.5018.2.camel@nexus.verbum.private>
	 <1099575525.3174.7.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 04 Nov 2004 13:25:51 -0500
Message-Id: <1099592751.5414.22.camel@selinux>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-11-04 at 08:38 -0500, Stephen Smalley wrote:
> On Wed, 2004-11-03 at 22:37, Colin Walters wrote:
> > I don't think anyone has actually been using these functions up until
> > now.  Neither Debian or Fedora enabled MLS, and I don't think Gentoo did
> > either.  So it's probably safe to continue using the existing soname;
> > but we should certainly be careful about this in the future.
> 
> As a reminder, when I created libsepol from the checkpolicy core logic,
> I had to export just about everything for use by checkpolicy via the
> static library, but narrowly limited the API exported by the shared
> library.  So we are free to rework the static library API at will, as
> long as it doesn't affect the shared library API/ABI.

Well in this case, I believe these changes were because of the MLS
compile failures I had.  When the code was originally moved over to
libsepol from checkpolicy, the MLS functions weren't switched over from
the global policydb to the policydb pointer in the function call.  So
really, this fixes the broken API.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
