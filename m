Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA05905
	for <selinux@tycho.nsa.gov>; Fri, 28 Jun 2002 12:03:27 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id QAA16139
	for <selinux@tycho.nsa.gov>; Fri, 28 Jun 2002 16:02:59 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id QAA16135
	for <selinux@tycho.nsa.gov>; Fri, 28 Jun 2002 16:02:59 GMT
Date: Fri, 28 Jun 2002 12:02:38 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: Ryan Bergauer <privateryan@mindspring.com>, <selinux@tycho.nsa.gov>
Subject: Re: Configuration issues on a new installation
In-Reply-To: <20020628151544.CAB317DA7@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0206281200580.17745-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 28 Jun 2002, Russell Coker wrote:

> These three are covered by daemon_domain() in my latest global_macros.te
> file, Steve, are you putting them in your tree?
> allow smbd_t console_device_t:chr_file { read write };
> allow smbd_t null_device_t:chr_file { read write ioctl };
> allow smbd_t init_t:fd { use };

Yes, these rules are included in daemon_domain in our internal CVS tree,
but I don't think that they were in the last public release.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
