Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6Q3o5rT022361
	for <selinux@tycho.nsa.gov>; Sun, 25 Jul 2004 23:50:05 -0400 (EDT)
Received: from monk.area614.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6Q3naVH023926
	for <selinux@tycho.nsa.gov>; Mon, 26 Jul 2004 03:49:36 GMT
Subject: Re: [patch] openvpn policy
From: Colin Walters <walters@verbum.org>
To: selinux@tycho.nsa.gov
Cc: russell@coker.com.au
In-Reply-To: <1090799087.13627.14.camel@nexus.verbum.private>
References: <1090799087.13627.14.camel@nexus.verbum.private>
Content-Type: text/plain
Date: Sun, 25 Jul 2004 23:50:04 -0400
Message-Id: <1090813804.15346.17.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2004-07-25 at 19:50 -0400, Colin Walters wrote:

openvpn.fc:
> /etc/openvpn/(/*)       --      system_u:object_r:openvpn_etc_t

Ooops, obviously that should be:

/etc/openvpn(/.*)?       --      system_u:object_r:openvpn_etc_t




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
