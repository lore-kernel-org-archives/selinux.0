Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i82C4PrT028128
	for <selinux@tycho.nsa.gov>; Thu, 2 Sep 2004 08:04:25 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i82C4Ov0003761
	for <selinux@tycho.nsa.gov>; Thu, 2 Sep 2004 12:04:25 GMT
Subject: Re: what to do with matchpathcon on S_IFCHR, S_IFBLK, hard links
	and fifos
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20040901174909.GF4400@lkcl.net>
References: <20040901174909.GF4400@lkcl.net>
Content-Type: text/plain
Message-Id: <1094126565.17265.9.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 02 Sep 2004 08:02:45 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-09-01 at 13:49, Luke Kenneth Casson Leighton wrote:
> when using matchpathcon(), is there anything special that should
> be done for the above filetypes, or should the mode_t argument
> just be passed through and let libselinux worry about it?

Pass the mode; matchpathcon will take (mode & S_IFMT) and compare it
with the file type specified in file_contexts (-b, -c, -d, -p, -l, -s,
--, or nothing to match any file type).

Multiple hard links are a separate issue; setfiles keeps track of
inode->specification mappings as it traverses a filesystem and detects
conflicts, but matchpathcon can't do that obviously.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
