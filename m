Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA21041
	for <selinux@tycho.nsa.gov>; Wed, 5 Jun 2002 08:32:50 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA03763
	for <selinux@tycho.nsa.gov>; Wed, 5 Jun 2002 12:32:39 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id MAA03759
	for <selinux@tycho.nsa.gov>; Wed, 5 Jun 2002 12:32:37 GMT
Date: Wed, 5 Jun 2002 08:32:23 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: <linux-security-module@wirex.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: new LSM release
In-Reply-To: <20020605043254.5FEE21547@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0206050826100.27221-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 5 Jun 2002, Russell Coker wrote:

> I've just checked and it appears that the new 2.5.19 LSM release is slightly
> behind the latest 2.5.19 NSA SE release.
>
> Just letting everyone know because the LSM release has a more recent time
> stamp...

Yes, I think that the 2.5.9 LSM snapshot patch was made before I pushed
the MLS enhancements.  Also, the 2.4.18 LSM snapshot patch appears to
still be the 2002_04_28 snapshot, whereas the latest 2.4.18 SELinux
release includes a number of subsequent updates to the SELinux module
(that are also available in the BitKeeper tree).

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
