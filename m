Return-Path: <SRS0=sd8A=UG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B2C0C2BCA1
	for <selinux@archiver.kernel.org>; Fri,  7 Jun 2019 13:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF8AE208E3
	for <selinux@archiver.kernel.org>; Fri,  7 Jun 2019 13:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nonadev.net header.i=@nonadev.net header.b="0YB+dJPl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbfFGNJ4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 7 Jun 2019 09:09:56 -0400
Received: from edna.lautre.net ([80.67.160.88]:42518 "EHLO edna.lautre.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727566AbfFGNJ4 (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 7 Jun 2019 09:09:56 -0400
X-Greylist: delayed 363 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Jun 2019 09:09:54 EDT
Received: from d-jobol.iot.bzh (por56-1-78-229-206-229.fbx.proxad.net [78.229.206.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by edna.lautre.net (Postfix) with ESMTPSA id F2F6C102A0D;
        Fri,  7 Jun 2019 15:03:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=nonadev.net;
        s=alternc; t=1559912628;
        bh=GdebRi4P2ZP3wq8vWoou05N7ahplbq5AFRqxRpfusA8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=0YB+dJPlb7kQq7mf5jm3vp3XWSmriwK8oJALewuKbDnk8fPh3vgaiohnQtqF+VDHk
         I9KGzYnW4f+UNChR85fKDARf+qhBAFezx5C2hrPUCTu9Whh3aUvIgrQpYeS7ePxl2i
         OPG2Z0ZpGcdGnfGC8uqMx+FfRXwaG1cyCDtAsWDk=
Date:   Fri, 7 Jun 2019 15:03:45 +0200
From:   =?UTF-8?B?Sm9zw6k=?= Bollo <jobol@nonadev.net>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>, casey.schaufler@intel.com,
        jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com
Subject: Re: [PATCH 00/58] LSM: Module stacking for AppArmor
Message-ID: <20190607150345.295c87c8@d-jobol.iot.bzh>
In-Reply-To: <66a87b0b-b6f4-74ff-2e51-afc8e2d30de1@schaufler-ca.com>
References: <20190602165101.25079-1-casey@schaufler-ca.com>
        <f71388e9-a4c5-8935-137b-8eb50be7f833@tycho.nsa.gov>
        <66a87b0b-b6f4-74ff-2e51-afc8e2d30de1@schaufler-ca.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, 4 Jun 2019 09:14:42 -0700
Casey Schaufler <casey@schaufler-ca.com> wrote:

> On 6/4/2019 5:29 AM, Stephen Smalley wrote:
> > On 6/2/19 12:50 PM, Casey Schaufler wrote: =20
> >> This patchset provides the changes required for
> >> the AppArmor security module to stack safely with any other. =20
> >
> > Please explain the motivation =20
>=20
> I'll add some explanation for the next revision.
> It won't be anything that I haven't posted many times
> before, but you're right that it belongs in the log.
>=20
> > - why do we want to allow AppArmor to stack with other modules, =20
>=20
> First, is there a reason not to? Sure, you can confuse
> administrators by implementing complex security policies,
> but there are lots of ways to do that already.
>=20
> AppArmor provides a different security model than SELinux,
> TOMOYO or Smack. Smack is better at system component
> separation, while AppArmor is better at application isolation.
> It's a win to use each to its strength rather than trying to
> stretch either to the edge of what it can do.
>=20
> > who would use it, =20

Hi all,

I would like to expose a potential use of interest for me: being able
to have containers running Smack on Ubuntu or Fedora platforms.

But it could also be interesting for running a container having fedora
on ubuntu or suse or the opposite.

How it will work? Will it work? Ask Casey.

just my 2 pennies
Jos=C3=A9 Bollo

> Can't name names, but there have been multiple requests.
>=20
> > how would it be used, =20
>=20
> As mentioned above, Smack for system separation, AppArmor for
> application isolation.
>=20
> > what does it provide that isn't already possible in the absence of
> > it. =20
>=20
> It's not necessary that something be impossible to do any
> other way. The question should be whether this provides for
> a better way to achieve the goals, and this does that.
> If I tried the come up with something that's impossible I
> would expect the usual "you can do that with SELinux policy"
> argument. We know we can do things. We want to have the tools
> to do them better.
>=20
> > Also, Ubuntu fully upstreamed all of their changes to AppArmor,
> > would this still suffice to enable stacking of AppArmor or do they
> > rely on hooks that are not handled here? =20
>=20
> Some amount of merging will likely be required. But that's
> always going to be true with parallel development tracks.
> That's why we have git!
>=20
> > Please explain the cost of the change - what do we pay in terms of
> > memory, runtime, or other overheads in order to support this
> > change? =20
>=20
> Do you have particular benchmarks you want to see?
> When I've supplied numbers in the past they have not
> been remarked on.
>=20
> > =20
> >>
> >> A new process attribute identifies which security module
> >> information should be reported by SO_PEERSEC and the
> >> /proc/.../attr/current interface. This is provided by
> >> /proc/.../attr/display. Writing the name of the security
> >> module desired to this interface will set which LSM hooks
> >> will be called for this information. The first security
> >> module providing the hooks will be used by default. =20
> >
> > Doesn't this effectively undo making the hooks read-only after
> > init, at least for the subset involved?=C2=A0 What are the security
> > implications thereof? =20
>=20
> Any mechanism, be it a separate set of hooks, a name used to
> do list look ups, or an sophisticated hash scheme will have that
> impact for the processes that use it. This scheme has the best
> performance profile of the mechanisms I experimented with and
> avoids all sorts of special cases.
>=20
> > =20
> >> The use of integer based security tokens (secids) is
> >> generally (but not completely) replaced by a structure
> >> lsm_export. The lsm_export structure can contain information
> >> for each of the security modules that export information
> >> outside the LSM layer.
> >>
> >> The LSM interfaces that provide "secctx" text strings
> >> have been changed to use a structure "lsm_context"
> >> instead of a pointer/length pair. In some cases the
> >> interfaces used a "char *" pointer and in others a
> >> "void *". This was necessary to ensure that the correct
> >> release mechanism for the text is used. It also makes
> >> many of the interfaces cleaner.
> >>
> >> https://github.com/cschaufler/lsm-stacking.git#stack-5.2-v1-apparmor
> >>
> >> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> >> ---
> >> =C2=A0 drivers/android/binder.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 25 ++-
> >> =C2=A0 fs/kernfs/dir.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 6 +-
> >> =C2=A0 fs/kernfs/inode.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 31 ++-
> >> =C2=A0 fs/kernfs/kernfs-internal.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +-
> >> =C2=A0 fs/nfs/inode.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 13 +-
> >> =C2=A0 fs/nfs/internal.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 8 +-
> >> =C2=A0 fs/nfs/nfs4proc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 17 +-
> >> =C2=A0 fs/nfs/nfs4xdr.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 16 +-
> >> =C2=A0 fs/nfsd/nfs4proc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0 8 +-
> >> =C2=A0 fs/nfsd/nfs4xdr.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 14 +-
> >> =C2=A0 fs/nfsd/vfs.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 7 +-
> >> =C2=A0 fs/proc/base.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> >> =C2=A0 include/linux/cred.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 3 +-
> >> =C2=A0 include/linux/lsm_hooks.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 91 +++++----
> >> =C2=A0 include/linux/nfs4.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 8 +-
> >> =C2=A0 include/linux/security.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 133 +++++++++----
> >> =C2=A0 include/net/af_unix.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0 2 +-
> >> =C2=A0 include/net/netlabel.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 10 =
+-
> >> =C2=A0 include/net/scm.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 14 +-
> >> =C2=A0 kernel/audit.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 43 ++--
> >> =C2=A0 kernel/audit.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 9 +-
> >> =C2=A0 kernel/auditfilter.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 6 +-
> >> =C2=A0 kernel/auditsc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 77 ++++----
> >> =C2=A0 kernel/cred.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 15 +-
> >> =C2=A0 net/ipv4/cipso_ipv4.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 =
13 +-
> >> =C2=A0 net/ipv4/ip_sockglue.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 12 =
+-
> >> =C2=A0 net/netfilter/nf_conntrack_netlink.c=C2=A0=C2=A0=C2=A0 |=C2=A0 =
29 ++-
> >> =C2=A0 net/netfilter/nf_conntrack_standalone.c |=C2=A0 16 +-
> >> =C2=A0 net/netfilter/nfnetlink_queue.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 38 ++--
> >> =C2=A0 net/netfilter/nft_meta.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 13 +-
> >> =C2=A0 net/netfilter/xt_SECMARK.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 14 +-
> >> =C2=A0 net/netlabel/netlabel_kapi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 5 +-
> >> =C2=A0 net/netlabel/netlabel_unlabeled.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 101 +++++-----
> >> =C2=A0 net/netlabel/netlabel_unlabeled.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0 2 +-
> >> =C2=A0 net/netlabel/netlabel_user.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 13 +-
> >> =C2=A0 net/netlabel/netlabel_user.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
> >> =C2=A0 net/unix/af_unix.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0 6 +-
> >> =C2=A0 security/apparmor/audit.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 4 +-
> >> =C2=A0 security/apparmor/include/audit.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0 2 +-
> >> =C2=A0 security/apparmor/include/net.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 6 +-
> >> =C2=A0 security/apparmor/include/secid.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0 9 +-
> >> =C2=A0 security/apparmor/lsm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 64 +++---
> >> =C2=A0 security/apparmor/secid.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 42 ++--
> >> =C2=A0 security/integrity/ima/ima.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 14 +-
> >> =C2=A0 security/integrity/ima/ima_api.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 9 +-
> >> =C2=A0 security/integrity/ima/ima_appraise.c=C2=A0=C2=A0 |=C2=A0=C2=A0=
 6 +-
> >> =C2=A0 security/integrity/ima/ima_main.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 34 ++--
> >> =C2=A0 security/integrity/ima/ima_policy.c=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 19 +-
> >> =C2=A0 security/security.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 338
> >> +++++++++++++++++++++++++++-----
> >> security/selinux/hooks.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 259
> >> ++++++++++++------------ security/selinux/include/audit.h
> >> |=C2=A0=C2=A0 5 +- security/selinux/include/objsec.h=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 42 +++-
> >> security/selinux/netlabel.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 25 +--
> >> security/selinux/ss/services.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 18 +-
> >> security/smack/smack.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 18 ++
> >> security/smack/smack_lsm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 238
> >> +++++++++++----------- security/smack/smack_netfilter.c=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> >> 8 +- security/smack/smackfs.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 12 +- 58 files
> >> changed, 1217 insertions(+), 779 deletions(-)=20
> > =20

