Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA25399
	for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 15:43:29 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id UAA13028
	for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 20:42:24 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id UAA13024 for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 20:42:24 GMT
Date: Wed, 20 Mar 2002 15:42:39 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: "Leslie J. French" <ljf@semandex.net>
cc: <selinux@tycho.nsa.gov>
Subject: RE: SMP mode?
In-Reply-To: <BFEMIIHKHLALNELLMPOMCEMFCAAA.ljf@semandex.net>
Message-ID: <Pine.GSO.4.33.0203201538540.11981-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 20 Mar 2002, Leslie J. French wrote:

> I have =y on the following options (via modules/lsm-patch)
>
>  _PACKET _NETLINK _RTNETLINK _NETFILTER _UNIX _INET
>  security: _CAPABILITIES _IP _SELINUX _SELINUX_DEVELOP
>
> the errors are occuring on a UDP socket, at random positions in a dataflow.

Is it failing on a sendto/sendmsg call or some other call?

Also, see whether the same error occurs with a kernel built without
CONFIG_SECURITY_IP.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
