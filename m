Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA17266
	for <selinux@tycho.nsa.gov>; Tue, 20 Aug 2002 10:17:11 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA01697
	for <selinux@tycho.nsa.gov>; Tue, 20 Aug 2002 14:15:33 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id OAA01693 for <selinux@tycho.nsa.gov>; Tue, 20 Aug 2002 14:15:32 GMT
Date: Tue, 20 Aug 2002 10:16:54 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: A F A 1 W I <DoD@penn.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: Latest release
In-Reply-To: <Pine.GSO.4.33.0208201009530.24294-100000@raven>
Message-ID: <Pine.GSO.4.33.0208201016020.24294-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 20 Aug 2002, Stephen Smalley wrote:

> web site http://www.nsa.gov/selinux.  If you want the latest release +
> patches posted since the release, you can check out the CVS tree from the
> sourceforge site using the following:
>
> cvs -d:pserver:anonymous@cvs.selinux.sourceforge.net:/cvsroot/selinux \
> -z3 co nsa/lsm-2.4/security/selinux

Oops.  Cut-and-paste error.  The above should be:

cvs -d:pserver:anonymous@cvs.selinux.sourceforge.net:/cvsroot/selinux \
-z3 co nsa

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
