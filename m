Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id VAA26473
	for <selinux@tycho.nsa.gov>; Fri, 20 Sep 2002 21:48:42 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id BAA19786
	for <selinux@tycho.nsa.gov>; Sat, 21 Sep 2002 01:46:56 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id BAA19782 for <selinux@tycho.nsa.gov>; Sat, 21 Sep 2002 01:46:56 GMT
Date: Fri, 20 Sep 2002 21:48:10 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: freeswan IP sec patch
In-Reply-To: <20020828131939.44F698FDA@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0209202147510.2978-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 28 Aug 2002, Russell Coker wrote:

> The attached patch makes ipsec with freeswan work for me.  I had to change it
> to only have a single var_run_t because both programs want to use each
> other's files under /var/run.  It doesn't work unless it can search for
> kernel modules.  The installation process for Debian requires accessing
> /root/.rnd, I'm not sure what other distributions do in this regard (maybe it
> should have "ifdef(`dpkg.te'," around it.

Thanks, merged.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
