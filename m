Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA01695
	for <selinux@tycho.nsa.gov>; Mon, 29 Apr 2002 13:53:21 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id RAA15946
	for <selinux@tycho.nsa.gov>; Mon, 29 Apr 2002 17:51:31 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id RAA15942
	for <selinux@tycho.nsa.gov>; Mon, 29 Apr 2002 17:51:31 GMT
Date: Mon, 29 Apr 2002 13:53:06 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: "Westerman, Mark" <Mark.Westerman@csoconline.com>
cc: Russell Coker <russell@coker.com.au>, SE Linux <selinux@tycho.nsa.gov>
Subject: RE: insmod
In-Reply-To: <72222DC86846D411ABD300A0C9EB08A101524374@csoc-mail-box.csoconline.com>
Message-ID: <Pine.GSO.4.33.0204291345560.19520-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 29 Apr 2002, Westerman, Mark wrote:

> I was wondering if we could define different type for diffent type of
> sysctl.
>
> example:
> 	net.ipv4.ip_forward
> 	net.ipv4.conf.default.rp_filter
>
> I know there are many differnt type os sysctl. I would like to
> be only grant ipsec the above permission, but nothing else.

It is possible to define different types for different sysctl variables,
although it currently requires code changes to the SELinux module to apply
these new types to the sysctl variable consistently across both interfaces
(the sysctl system call and the /proc/sys entries).  We should be able to
move these definitions entirely from the module into the policy
configuration, but I'm not sure when we'll get to it.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
