Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA16872
	for <selinux@tycho.nsa.gov>; Wed, 1 May 2002 15:02:05 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id TAA26092
	for <selinux@tycho.nsa.gov>; Wed, 1 May 2002 19:00:53 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id TAA26088 for <selinux@tycho.nsa.gov>; Wed, 1 May 2002 19:00:53 GMT
Date: Wed, 1 May 2002 15:01:35 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Tho <nguyentt@spawar.navy.mil>
cc: <selinux@tycho.nsa.gov>
Subject: Re: Question about installing LSM-2.4
In-Reply-To: <LJEBLEMCKEAGNFDLIBBBIEBBCBAA.nguyentt@spawar.navy.mil>
Message-ID: <Pine.GSO.4.33.0205011449140.1601-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 1 May 2002, Tho wrote:

>    Hi, my name is Tho Nguyen.  I have just downloaded the LSM-2.4.  I am

I assume that you downloaded the entire lsm-2.4-selinux-2002031409 release
from http://www.nsa.gov/selinux/download2.html.  A number of bug fix
patches have been posted to the list since that release was made back in
March, and a new release is expected very soon.  Hence, you may want to
wait for the new release.

> planning to install it on Redhat Linux 7.1.  My question is do I need
> to log in as the root when installing it or I can just be a regular user.

You'll need to su prior to installing SELinux in order to have sufficient
permissions to install the SELinux software and configuration files.
See selinux/README for the installation instructions.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
