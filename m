Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA18777
	for <selinux@tycho.nsa.gov>; Wed, 28 Aug 2002 16:12:03 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id UAA15597
	for <selinux@tycho.nsa.gov>; Wed, 28 Aug 2002 20:10:23 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id UAA15593 for <selinux@tycho.nsa.gov>; Wed, 28 Aug 2002 20:10:22 GMT
Date: Wed, 28 Aug 2002 16:11:40 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: "M. H." <metalhead00@hotmail.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: building libsecure.a advice
In-Reply-To: <F517f8CATwsi6PJyLHI0000cfaa@hotmail.com>
Message-ID: <Pine.GSO.4.33.0208281610290.25057-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 28 Aug 2002, M. H. wrote:

> Has anyone tried to build JUST libsecure.a. Since SELinux applications need
> to be linked against it, I want to separate all necessary headers and
> libraries (seems like libsecure.a is the only one) so I can integrate them
> in my build environment (rather than relying on the default include or lib
> directories of the system.)
> A problem I've run into is finding a simple way of rebuilding the library
> without installing the whole kernel. I tried to run 'make' in the
> selinux/libsecure directory but that fails since selinux/libsecure/include
> misses some necessary files (some of those are in
> lsm-2.4/security/selinux/include.) Has anyone had any luck building ONLY
> libsecure.a?

As explained in selinux/README, you need to run 'make install' in
selinux/module to install the support files from the SELinux module used
to build the remaining components.  This doesn't require building the
kernel itself.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
