Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA01807
	for <selinux@tycho.nsa.gov>; Tue, 1 Oct 2002 07:47:01 -0400 (EDT)
Date: Tue, 1 Oct 2002 07:46:43 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Tom <tom@lemuria.org>
cc: <selinux@tycho.nsa.gov>
Subject: Re: policy version
In-Reply-To: <20021001131535.A21503@lemuria.org>
Message-ID: <Pine.GSO.4.33.0210010742590.1579-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 1 Oct 2002, Tom wrote:

> I have a totally unusable SELinux system right now, because of policy
> version conflicts. For reasons I don't understand, checkpolicy creates
> a binary representation version 12, which load_policy refuses to load
> because it's version 11.

This implies that you are still running a kernel with policy version 11,
but your checkpolicy program has been rebuilt for policy version 12.
Maybe you need to boot your new kernel (hopefully, you did obtain a new
kernel, right?)?

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
