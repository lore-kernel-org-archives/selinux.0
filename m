Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0NFt8Rb014878
	for <selinux@tycho.nsa.gov>; Fri, 23 Jan 2004 10:55:08 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i0NFt7Ca015501
	for <selinux@tycho.nsa.gov>; Fri, 23 Jan 2004 15:55:07 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id i0NFt6VC015498 for <selinux@tycho.nsa.gov>; Fri, 23 Jan 2004 15:55:06 GMT
Subject: RE: transition failure
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: "James R. Kratzer" <JamesK@xetron.com>
Cc: "SE Linux Mail List (E-mail)" <selinux@tycho.nsa.gov>
In-Reply-To: <69B1CAEF4FC66F4D9A07B903E0265D3F0B4A8A@s3cin>
References: <69B1CAEF4FC66F4D9A07B903E0265D3F0B4A8A@s3cin>
Content-Type: text/plain
Message-Id: <1074873305.4931.84.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 23 Jan 2004 10:55:05 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-01-23 at 10:46, Kratzer, James R. wrote:
> Thanks Stephen.  The script's context was indeed the problem. Using chcon
> fixed the problem.  The context for the swatchd script was correct after a
> "make relabel", but I later edited the file with vi, and vi corrupted the
> context.  The chcon command corrected the context.  Is there a patched
> version of vi available that will preserve contexts of files?

Dan has a patched vim available under
ftp://people.redhat.com/dwalsh/SELinux.  Also in rawhide, I think.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
