Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id WAA26649
	for <selinux@tycho.nsa.gov>; Fri, 20 Sep 2002 22:39:38 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id CAA21640
	for <selinux@tycho.nsa.gov>; Sat, 21 Sep 2002 02:37:52 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id CAA21636 for <selinux@tycho.nsa.gov>; Sat, 21 Sep 2002 02:37:52 GMT
Date: Fri, 20 Sep 2002 22:39:13 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: policy patches
In-Reply-To: <200209100059.15066.russell@coker.com.au>
Message-ID: <Pine.GSO.4.33.0209202233060.2978-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 10 Sep 2002, Russell Coker wrote:

> initrd.diff is part of the policy needed to get an initrd working properly, it
> doesn't have everything because it's difficult to separate it all.  But it's
> a good improvement and it has most of what you need.

Merged, except that I retained the policy target (but it is no longer the
default) and I omitted the gzip intermediate stage, as it conflicts with
the Tresys' work, which is trying to establish an assured pipeline for
policy updates.  The preferred solution is to modify checkpolicy to
directly support compressing the binary policy.

> misc.diff is many things that are patches for things that are in my area (IE
> dpkg.te), trivial, or patches for things that are not fully working anyway
> (postgresql and fcron) so which can't be broken.

Mostly merged, with a few changes rejected due to concerns about their
implications.

> amanda.diff is a patch for amanda to properly support the types for home dirs
> with multiple user roles.

Merged.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
