Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA13312
	for <selinux@tycho.nsa.gov>; Mon, 8 Oct 2001 13:41:47 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id RAA04456
	for <selinux@tycho.nsa.gov>; Mon, 8 Oct 2001 17:40:01 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100] (may be forged))
	by jazzswing.ncsc.mil  with ESMTP id RAA04452
	for <selinux@tycho.nsa.gov>; Mon, 8 Oct 2001 17:40:00 GMT
Date: Mon, 8 Oct 2001 13:41:41 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: James Bishop <james.bishop@jrc.it>
cc: <selinux@tycho.nsa.gov>
Subject: Re: Compiling for SuSE 7.2
In-Reply-To: <3BC1D4C4.4070500@jrc.it>
Message-ID: <Pine.GSO.4.33.0110081340390.9507-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 8 Oct 2001, James Bishop wrote:

> Thanks for your suggestion. On SuSE 7.2, the /bin/login program comes
> from the RPM "shadow.rpm". MCONFIG in the SuSE 7.2 util-linux.spm
> defines HAVE_SHADOW="yes", whereas the SELinux util-linux MCONFIG
> defines HAVE_SHADOW="no".

Ok.  So you need to port the SELinux login patch to the login program in
the shadow SRPM provided with SuSE 7.2.  That will likely require more
work.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
