Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i82DeIrT029031
	for <selinux@tycho.nsa.gov>; Thu, 2 Sep 2004 09:40:18 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i82DeGv0008974
	for <selinux@tycho.nsa.gov>; Thu, 2 Sep 2004 13:40:17 GMT
Subject: Re: what to do with matchpathcon on S_IFCHR, S_IFBLK, hard links
	and fifos
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20040902134454.GC5745@lkcl.net>
References: <20040901174909.GF4400@lkcl.net>
	 <1094126565.17265.9.camel@moss-spartans.epoch.ncsc.mil>
	 <20040902134454.GC5745@lkcl.net>
Content-Type: text/plain
Message-Id: <1094132316.17265.53.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 02 Sep 2004 09:38:36 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-09-02 at 09:44, Luke Kenneth Casson Leighton wrote:
>  okay, second question, if i may.
> 
>  if i have set up file contexts on some files in a temporary
>  directory (of course, using matchpathcon to set the context
>  of where the file is _going_ to be not where it _is_), then
>  will the "/bin/mv" command preserve those file contexts
>  even across filesystem boundaries - without any extra arguments?

With a SELinux-patched coreutils, yes; mv attempts to preserve the
security context on the file even when moving across filesystem
boundaries.  But it cannot always succeed, e.g. the filesystem may not
support xattrs or the policy may deny access due to file create
permission or filesystem associate permission.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
