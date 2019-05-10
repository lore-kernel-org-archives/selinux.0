Return-Path: <SRS0=uP1p=TK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04968C04A6B
	for <selinux@archiver.kernel.org>; Fri, 10 May 2019 14:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0F5D21479
	for <selinux@archiver.kernel.org>; Fri, 10 May 2019 14:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2OsZqsr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbfEJOkp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 May 2019 10:40:45 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34156 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727144AbfEJOkp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 10 May 2019 10:40:45 -0400
Received: by mail-ed1-f67.google.com with SMTP id p27so5495927eda.1
        for <selinux@vger.kernel.org>; Fri, 10 May 2019 07:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WkY8IhwJ7ET94tM+j+I7Lamb564SUsLBiVxAr5cTOoU=;
        b=Y2OsZqsrZOg+TGxlsZWSIl5X4ctQHL1j7szi7ED+vlJSOTQTxzOLSDN/njP2+A14nA
         0rrrcKp+5jon3taLfbrusPCxqTFuY1iQVRIL3B4EYtPtBxuR1oMQ2fzXtG/kdTThbBC4
         HcDSz5IyYLlAfE93QIpVdQhyKurAmQ2pe+xscqal2x3+69C6pr/izEggAeHk8SSwKb3+
         TZuC1HbR66g0Z7UrRQXL2UUxe5mqhO+y4pUH0QdBSR8b5H+ce+Qh2BC5rASiF87EPVnf
         9v7JSD2+Ur4M44NJymabsXCw7MmnyXa5Wz7ybVlezELGNkOypyxduCLhYu5/qyK8zTHO
         xEsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=WkY8IhwJ7ET94tM+j+I7Lamb564SUsLBiVxAr5cTOoU=;
        b=I/HKs3XRfBuQVwMri9TRmJemWEghNAUuyR9WR5fenKrxUjY3wDCArnho8p07yIJyMb
         6GDaB2y2IH4eQ3MSmsbYqTYjgAgrJCptxkJvhDJ9Wq9kaDMiViwmOabCw3Z0R2fbslbB
         JftwxXCk9soE0VVOV17onTe/DEElWT6tFbUtAgzZNPKefS4PRDXvDeHNGndMo3b2lfs/
         1DHbpWR5LO4FW4GxJpyP2XhOgNWLRYfdjzJslMJTRRIpM9NZ8n0XbPwDV/drj1HCO6bN
         EwFGEnhXzcvVXi/iPAIWMjPWdkS942KhE/YYwaCcH8GGZ+/HG5H3cvqwfW4MaPt85X+O
         MJxg==
X-Gm-Message-State: APjAAAW5GOwD6U14wEtxCKqM7OvhLJTSgEy/HqCkMuMXWwWBGomHnhrG
        bXLvsh/i+vmLypGeqfqyBBv6HDzqRSw=
X-Google-Smtp-Source: APXvYqyoWC3ztAJ/psUJmFJKXDo071xESVE8epQSOBibQECeR9eKyrvBPDYgN7Os3WDgzSRqqQvIlg==
X-Received: by 2002:a17:906:2542:: with SMTP id j2mr8900497ejb.217.1557499242885;
        Fri, 10 May 2019 07:40:42 -0700 (PDT)
Received: from brutus.lan (brutus.defensec.nl. [2001:985:d55d::438])
        by smtp.gmail.com with ESMTPSA id k37sm1521484edb.11.2019.05.10.07.40.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 May 2019 07:40:41 -0700 (PDT)
Date:   Fri, 10 May 2019 16:40:40 +0200
From:   Dominick Grift <dac.override@gmail.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Jeffrey Vander Stoep <jeffv@google.com>, selinux@vger.kernel.org,
        Joel Galenson <jgalenson@google.com>,
        Petr Lautrbach <plautrba@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: Re: Mislabeled /proc/<pid>/ns/mnt files?
Message-ID: <20190510144040.GF5967@brutus.lan>
Mail-Followup-To: Stephen Smalley <sds@tycho.nsa.gov>,
        Jeffrey Vander Stoep <jeffv@google.com>, selinux@vger.kernel.org,
        Joel Galenson <jgalenson@google.com>,
        Petr Lautrbach <plautrba@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
References: <CABXk95D-4v2aT=sZk9NoeGJBGTy=7NTQ8+yKv5E4RvaODJgWLA@mail.gmail.com>
 <fdcf1946-2151-4502-9755-3a10d0646399@tycho.nsa.gov>
 <CABXk95Au_UVdghpHGuu39mHJkSYA2=7YS__vtx8sxGEH4CuSgg@mail.gmail.com>
 <20190510071208.GA14283@brutus.lan>
 <31b10fd2-bb1b-1a01-9bc3-f876404449a5@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DO5DiztRLs659m5i"
Content-Disposition: inline
In-Reply-To: <31b10fd2-bb1b-1a01-9bc3-f876404449a5@tycho.nsa.gov>
User-Agent: Every email client sucks, this one just sucks less.
X-PGP-Key: https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--DO5DiztRLs659m5i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2019 at 10:28:50AM -0400, Stephen Smalley wrote:
> On 5/10/19 3:12 AM, Dominick Grift wrote:
> > On Thu, May 09, 2019 at 02:47:30PM -0700, Jeffrey Vander Stoep wrote:
> > > From: Stephen Smalley <sds@tycho.nsa.gov>
> > > Date: Thu, May 9, 2019 at 2:17 PM
> > > To: Jeffrey Vander Stoep, <selinux@vger.kernel.org>, Joel Galenson,
> > > Petr Lautrbach
> > >=20
> > > > On 5/9/19 3:56 PM, Jeffrey Vander Stoep wrote:
> > > > > I expected files here would have the process's context, but they
> > > > > don't. The files are actually all symlinks so it's entirely possi=
ble
> > > > > that the they shouldn't have the process's context. If that's the
> > > > > case, how can I provide different labels for them? Neither "proc"=
 nor
> > > > > "unlabeled" are appropriate.
> > > > >=20
> > > > > On a device with a 3.18 kernel they have the "proc" context:
> > > > > sailfish:/ # ls -LZ1 /proc/1/ns
> > > > > u:object_r:proc:s0 mnt
> > > > > u:object_r:proc:s0 net
> > > > >=20
> > > > > On a device with the 4.9 kernel the have the "unlabeled" context:
> > > > > blueline:/ # ls -LZ1 /proc/1/ns
> > > > > u:object_r:unlabeled:s0 cgroup
> > > > > u:object_r:unlabeled:s0 mnt
> > > > > u:object_r:unlabeled:s0 net
> > > >=20
> > > > First, ls -L dereferences symlinks so you are going to get the cont=
ext
> > > > of the object referenced by the symlink, not the context of the sym=
link
> > > > itself.
> > >=20
> > > I'm seeing a denial on the object not the symlink, so -L is what I wa=
nt.
> > >=20
> > > >=20
> > > > Second, the task context is only assigned to proc inodes created via
> > > > proc_pid_make_inode(), which has never been the case of /proc/pid/ns
> > > > inodes - those have their own implementations and operations.
> > > >=20
> > > > Third, /proc/pid/ns migrated from proc to its own pseudo filesystem,
> > > > nsfs, which requires a corresponding fs_use or genfscon rule in pol=
icy
> > > > or they will be unlabeled.  refpolicy has a genfscon rule. Confusin=
gly
> > > > there appears to be both in Fedora policy, a fs_use_task and a genf=
scon
> > > > rule, and it appears that fs_use_task is being applied here.  I don=
't
> > > > know why or what exactly that means.  It won't be the task context =
for
> > > > the task associated with that /proc/pid directory but instead would=
 be
> > > > whichever task context instantiates the inode.
> > > >=20
> > >=20
> > > So, how do I label these files in genfs_contexts?
> > >=20
> > > "mount | grep nsfs" returns nothing.
> >=20
> > # seinfo --genfs | grep nsfs
> >     genfscon nsfs /  sys.id:sys.role:fs.nsfs.fs:s0
> >=20
> > Yes, i think this is a step backwards. In the past we got a nice list o=
f objects that have no context associated when policy is loaded.
> > That list was removed. So sometimes its hard to determine whether somet=
hing needs a genfscon if its not listen with `mount.
>=20
> So, to be specific, commit 2088d60e3b2f53d0c9590a0202eeff85b288b1eb
> ("selinux: quiet the filesystem labeling behavior message") removed the
> logging of which filesystem labeling behavior was selected for each
> filesystem, and then the last remnant was dropped by commit
> 270e8573145a26de924e2dc644596332d400445b ("selinux: Remove redundant check
> for unknown labeling behavior").  The second commit makes sense given the
> prior one, but perhaps we do need/want to retain some kind of log message
> when mounting a filesystem that is not configured for labeling (i.e.
> SECURITY_FS_USE_NONE)?  We could add back a log message just for that case
> without reverting the other changes.

I would appreciate that, yes.

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--DO5DiztRLs659m5i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlzVjWMACgkQJXSOVTf5
R2nF8wwAh/Q/93mlgwA8T0gR2F/JF2KoEyEyEvxNCtu/H2mfgmwuWa/OUaer837z
83aSBql3QK75ChO5rXM1HXUcEMr5isNiMCFllYE66ZUW7FhTMzEj5HWI2WnZ6F7i
TLxJwjlRgbjG7pbyC7O25TESwTSA4siNG9ZP3769NlDJ3goIBnCvgHSet6xnnNoC
gzmr2i0H6zI3GpN+lnHOSsaPKM4gISEm7SAtIWiHYkFfFDFo+8Z0wWi9sJNWuqBL
OXN+w9S993I6DFOkGytapD1OREq6tDUWdx7fU+HWmcElv6Xwpy3HFokZhb25Lg6b
xA2mYuojy0U8bmkOA3l/IrkO4EwNJKrliPfReP9vEGB0D1NVVNxSAZFcSWHZO12e
NZZQ7T08AlDlrTGqn6B+h/M+cjx0WZL3p7yh7prHsF6+44y2fzBSQ4BbSeRtWEt6
UWzu8J4KO8zXTOdEmpnObQImtb6UUxBXeT+DndZG6ojV0iABdZAGsohZam1IqGY8
MTFAfjqq
=a4UA
-----END PGP SIGNATURE-----

--DO5DiztRLs659m5i--
