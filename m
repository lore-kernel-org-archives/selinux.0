Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA02412
	for <selinux@tycho.nsa.gov>; Thu, 28 Mar 2002 08:51:16 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id NAA26989
	for <selinux@tycho.nsa.gov>; Thu, 28 Mar 2002 13:50:10 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id NAA26985 for <selinux@tycho.nsa.gov>; Thu, 28 Mar 2002 13:50:10 GMT
Date: Thu, 28 Mar 2002 08:50:26 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>, <bdale@gag.com>
Subject: Re: SE support in tar 1.3.25?
In-Reply-To: <20020327224702.1317F420EE@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0203280839200.22457-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 27 Mar 2002, Russell Coker wrote:

> I've just made a quick attempt at getting tar 1.3.25 working with SE support.
> The code has changed enough since the 1.3.19 version that the SE patch is
> against that not only do patches not apply in a working fashion, but I can't
> figure out what the code is actually doing.
>
> If the NSA person who originally wrote the tar support could port it to the
> latest version of tar then that would be great.

A person at MITRE originally implemented the SELinux tar modifications
relative to the upstream tar-1.12 sources.  A SELinux user (Shaun Savage)
later made the initial effort to update those modifications to
tar-1.13.19-6 SRPM for RH7.2, and the original implementor from MITRE
then reviewed and revised that updated patch.  However, the original
implementor isn't actively involved in the project at the moment, so I'm
not sure that he can work on updating it again.

The abstract concept for the tar modifications is simply to allow users to
preserve the security contexts of files when they are archived, view the
security contexts of files in an archive listing, and extract files from
an archive with their original security contexts (if permitted by the
security policy).  As I recall, the implementation approach was to add
a special file to the archive that contained the security context for
each file, similar to the existing GNU tar support for long links.
Unfortunately, a quick examination of the code indicates that the tar
modifications assume a fixed maximum size for security contexts, so this
assumption should be eliminated prior to merging this support into
upstream sources.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com






--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
