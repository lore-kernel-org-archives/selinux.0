Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA4DcRXZ022718
	for <selinux@tycho.nsa.gov>; Thu, 4 Nov 2004 08:38:27 -0500 (EST)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA4DcR8i020518
	for <selinux@tycho.nsa.gov>; Thu, 4 Nov 2004 13:38:28 GMT
Subject: Re: Updated SELinux Release
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Manoj Srivastava <manoj.srivastava@stdc.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <87vfcmqvi5.fsf@glaurung.internal.golden-gryphon.com>
References: <1099496380.1213.111.camel@moss-spartans.epoch.ncsc.mil>
	 <87vfcmqvi5.fsf@glaurung.internal.golden-gryphon.com>
Content-Type: text/plain
Message-Id: <1099575225.3174.1.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 04 Nov 2004 08:33:45 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-11-03 at 19:59, Manoj Srivastava wrote:
> 	I have been looking at the changes in libsepol, and I see
>  these changes to the API:
<snip>
> 	Unfortunately, this has not been accompanied with an soname
>  change, this can't be a good thing.  I would suggest bumping up the
>  soname to match the version (libsepol.so.1.2), to minimize confusion.

libsepol only exports a very limited API via the shared library.  The
majority of its API is only exported via the static library, and is only
for programs that are tightly coupled to it (like checkpolicy, from
which it was originally created).

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
