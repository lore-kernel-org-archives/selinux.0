Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA4DgsXZ022770
	for <selinux@tycho.nsa.gov>; Thu, 4 Nov 2004 08:42:54 -0500 (EST)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA4DfWCH016458
	for <selinux@tycho.nsa.gov>; Thu, 4 Nov 2004 13:41:32 GMT
Subject: Re: Updated SELinux Release
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Colin Walters <walters@verbum.org>
Cc: Manoj Srivastava <manoj.srivastava@stdc.com>, selinux@tycho.nsa.gov
In-Reply-To: <1099539462.5018.2.camel@nexus.verbum.private>
References: <1099496380.1213.111.camel@moss-spartans.epoch.ncsc.mil>
	 <87vfcmqvi5.fsf@glaurung.internal.golden-gryphon.com>
	 <1099539462.5018.2.camel@nexus.verbum.private>
Content-Type: text/plain
Message-Id: <1099575525.3174.7.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 04 Nov 2004 08:38:45 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-11-03 at 22:37, Colin Walters wrote:
> I don't think anyone has actually been using these functions up until
> now.  Neither Debian or Fedora enabled MLS, and I don't think Gentoo did
> either.  So it's probably safe to continue using the existing soname;
> but we should certainly be careful about this in the future.

As a reminder, when I created libsepol from the checkpolicy core logic,
I had to export just about everything for use by checkpolicy via the
static library, but narrowly limited the API exported by the shared
library.  So we are free to rework the static library API at will, as
long as it doesn't affect the shared library API/ABI.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
