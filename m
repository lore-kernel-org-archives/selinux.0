Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0NIiMFX023078
	for <selinux@tycho.nsa.gov>; Sun, 23 Jan 2005 13:44:22 -0500 (EST)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0NIgIlA019285
	for <selinux@tycho.nsa.gov>; Sun, 23 Jan 2005 18:42:19 GMT
Date: Sun, 23 Jan 2005 13:44:17 -0500 (EST)
From: James Morris <jmorris@redhat.com>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Re: [patch] enhanced MLS support
In-Reply-To: <41EC4682.8050807@trustedcs.com>
Message-ID: <Xine.LNX.4.44.0501231333020.18710-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 17 Jan 2005, Darrel Goeddel wrote:

> Replaced the existing MLS logic with a flexible system based on the current
> constraints language.

Do you plan to add support for integrity labels?

What about releasibility labels?

> The compile time options for MLS support have been replaced with runtime
> options/detection.

This looks good from the kernel side, and I don't imagine there will be
any real performance issues with all of the runtime checks, given the base
impact of SELinux.


One technical nit (in both kernel and user code):

+int mls_setup_user_levels(struct context *fromcon, struct user_datum *user,
+                          struct context *usercon)
+{
+       struct mls_level *fromcon_sen = &(fromcon->range.level[0]);
+       struct mls_level *fromcon_clr = &(fromcon->range.level[1]);
+       struct mls_level *user_low = &(user->range.level[0]);
+       struct mls_level *user_clr = &(user->range.level[1]);
+       struct mls_level *user_def = &(user->dfltlevel);
+       struct mls_level *usercon_sen = &(usercon->range.level[0]);
+       struct mls_level *usercon_clr = &(usercon->range.level[1]);
+
+       if (selinux_mls_enabled) {

The mls_level definitions & assignments should be in the conditional
section.


- James
-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
