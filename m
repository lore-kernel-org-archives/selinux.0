Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iATEkdIi011025
	for <selinux@tycho.nsa.gov>; Mon, 29 Nov 2004 09:46:39 -0500 (EST)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iATEj7Yd018788
	for <selinux@tycho.nsa.gov>; Mon, 29 Nov 2004 14:45:07 GMT
Subject: Re: patch: misc policy additions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Cc: Jim Carter <jwcart2@epoch.ncsc.mil>, Colin Walters <walters@verbum.org>,
   SELinux ML <selinux@tycho.nsa.gov>
In-Reply-To: <20041127225844.GA2509@jmh.mhn.de>
References: <20041109210447.GC2543@jmh.mhn.de>
	 <1100046550.26388.8.camel@nexus.verbum.private>
	 <20041110102439.GA2541@jmh.mhn.de>
	 <1100893088.31793.14.camel@moss-lions.epoch.ncsc.mil>
	 <20041127225844.GA2509@jmh.mhn.de>
Content-Type: text/plain
Message-Id: <1101739328.13948.47.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 29 Nov 2004 09:42:09 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2004-11-27 at 17:58, Thomas Bleher wrote:
> I do not remember the exact circumstances when I needed it. However, I
> don't think it's just relabeling between the $1_tty_device_t types. What
> if a device file loses its context? restorecon can relabel all other
> files so it just seemed logical to allow it.

IIRC, permission for relabeling those types was omitted from setfiles_t
to avoid having a 'make relabel' unwittingly reset the label on your own
tty (or any other active sessions).  But I see your point about an
explicit restorecon.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
