Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA00853
	for <selinux@tycho.nsa.gov>; Mon, 29 Apr 2002 12:53:07 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id QAA11708
	for <selinux@tycho.nsa.gov>; Mon, 29 Apr 2002 16:51:56 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id QAA11704 for <selinux@tycho.nsa.gov>; Mon, 29 Apr 2002 16:51:55 GMT
Date: Mon, 29 Apr 2002 12:52:19 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: "Westerman, Mark" <Mark.Westerman@csoconline.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: insmod
In-Reply-To: <20020429162425.4B40D3EA8@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0204291246180.19520-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 29 Apr 2002, Russell Coker wrote:

> A snippet from my assert.te file:
> neverallow ~{ initrc_t admin insmod_t } sysctl_t:file { write append };
> neverallow ~{ initrc_t admin } sysctl_fs_t:file { write append };
> neverallow ~{ initrc_t admin kmod_t insmod_t } sysctl_kernel_t:file { write
> append };

The above line for sysctl_kernel_t is the same as the corresponding line
in the 2002031409 NSA SELinux release.  That change was merged in
accordance with the earlier discussion on the list.  However, the sysctl_t
line in the example policy does not include insmod_t, since I wasn't aware
that it was necessary (and I'm not sure why it is necessary for tainted).
With regard to ipsec, we should probably define a new type for the
IPSEC-related entries and assign it to those entries.

If we want to reduce the need to edit assert.te, we could define type
attributes for domains that should be authorized to write to the sysctl
types and merely use the type attribute in the assertion, as is currently
done for privmem/memory_device_t.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
