Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA17242
	for <selinux@tycho.nsa.gov>; Tue, 20 Aug 2002 10:15:10 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA16810
	for <selinux@tycho.nsa.gov>; Tue, 20 Aug 2002 14:14:06 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id OAA16806
	for <selinux@tycho.nsa.gov>; Tue, 20 Aug 2002 14:14:06 GMT
Date: Tue, 20 Aug 2002 10:14:36 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: A F A 1 W I <DoD@penn.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: Latest release
In-Reply-To: <003401c2484f$39f0e4e0$7e935b40@usaf>
Message-ID: <Pine.GSO.4.33.0208201009530.24294-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 20 Aug 2002, A F A 1 W I wrote:

> Could anyone please tell me if this is the latest release?
>
> selinux-2.4.18-2002031409.i386.rpm

No, that isn't the latest release.  It is actually several releases behind
the latest release.

The latest release is 2002070313 and can be obtained from the NSA SELinux
web site http://www.nsa.gov/selinux.  If you want the latest release +
patches posted since the release, you can check out the CVS tree from the
sourceforge site using the following:

cvs -d:pserver:anonymous@cvs.selinux.sourceforge.net:/cvsroot/selinux \
-z3 co nsa/lsm-2.4/security/selinux

I expect that a new release will be forthcoming soon based on 2.4.19.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
