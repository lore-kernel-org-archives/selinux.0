Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA07902
	for <selinux@tycho.nsa.gov>; Wed, 10 Jul 2002 12:38:42 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id QAA27049
	for <selinux@tycho.nsa.gov>; Wed, 10 Jul 2002 16:38:07 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id QAA27039
	for <selinux@tycho.nsa.gov>; Wed, 10 Jul 2002 16:38:06 GMT
Date: Wed, 10 Jul 2002 12:38:23 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Debian User <rogelio@evoworks.evoserve.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: [PATCH] atuomatic type transitions for pts in devfs
In-Reply-To: <3D2C4F46.1040408@evoworks.evoserve.com>
Message-ID: <Pine.GSO.4.33.0207101224280.26546-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 10 Jul 2002, Debian User wrote:

> This patch only works properly with a devfsd less system. Devfsd needs
> to be patched for this to work on systems using it.

Just to further clarify, when devfsd is used, the allocating task SID is
the SID of devfsd rather than the SID of the requesting process, so the
kernel cannot automatically determine an appropriate type transition
for the requesting process.  To support such functionality while using
devfsd, you would need to patch devfsd to permit passing the SID of the
requesting process to an action (much like the current support for passing
the uid).  A devfsd module for nodes within pts could then call
security_transition_sid based on the requesting process SID and the base
devpts SID to obtain a transition SID for the pty.

As a separate issue (previously mentioned on the list), fully supporting
labeling by devfsd would also require patches to the kernel devfs code to
preserve and restore SIDs on devfs entries labeled by devfsd, as the
entries may be evicted from the dcache.

Hence, at present, devfs labeling support is only reliable without devfsd
through the use of genfs_contexts and this patch.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com






--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
