Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9PIHuXZ005963
	for <selinux@tycho.nsa.gov>; Mon, 25 Oct 2004 14:17:56 -0400 (EDT)
Received: from moss-huskies.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9PIGRvs019076
	for <selinux@tycho.nsa.gov>; Mon, 25 Oct 2004 18:16:27 GMT
Received: from moss-huskies.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-huskies.epoch.ncsc.mil (8.12.11/8.12.11) with ESMTP id i9PIJE0B014276
	for <selinux@tycho.nsa.gov>; Mon, 25 Oct 2004 14:19:14 -0400
Received: (from hdholm@localhost)
	by moss-huskies.epoch.ncsc.mil (8.12.11/8.12.11/Submit) id i9PIJEkY014275
	for selinux@tycho.nsa.gov; Mon, 25 Oct 2004 14:19:14 -0400
Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9PFMcXZ004114
	for <selinux@tycho.nsa.gov>; Mon, 25 Oct 2004 11:22:38 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9PFLGvs013982
	for <selinux@tycho.nsa.gov>; Mon, 25 Oct 2004 15:21:21 GMT
Subject: Re: [patches] SE-DBUS policy revamp [1/2]
From: Havoc Pennington <hp@redhat.com>
To: Colin Walters <walters@verbum.org>
Cc: selinux@tycho.nsa.gov, dbus@freedesktop.org, dwalsh@redhat.com
In-Reply-To: <1098569359.8447.47.camel@x-infinity.verbum.private>
References: <1098569359.8447.47.camel@x-infinity.verbum.private>
Content-Type: text/plain
Date: Mon, 25 Oct 2004 11:23:32 -0400
Message-Id: <1098717812.31744.2.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2004-10-23 at 18:09 -0400, Colin Walters wrote:
> +/* Store the context of the bus for computing relabels. */
> +char *bus_context = NULL;

This should be "static"

I can't say I understand the patch otherwise, but if you guys think it's
right go for it.

Havoc


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
