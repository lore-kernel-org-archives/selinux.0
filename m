Return-Path: <SRS0=HWKQ=Q2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EBCAC43381
	for <selinux@archiver.kernel.org>; Tue, 19 Feb 2019 11:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E372921773
	for <selinux@archiver.kernel.org>; Tue, 19 Feb 2019 11:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NpWHq0Bn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725805AbfBSLIT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 19 Feb 2019 06:08:19 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38835 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbfBSLIT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 19 Feb 2019 06:08:19 -0500
Received: by mail-ed1-f67.google.com with SMTP id h58so16349356edb.5
        for <selinux@vger.kernel.org>; Tue, 19 Feb 2019 03:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Sr3P5H1/SA9EpTZVfI6kUGR1QwuY17SVFFPShHTSgBs=;
        b=NpWHq0BnB4QXJXlsWnpvsa8OXR8W2Vs8+dlznhyzKhwE8GBi009IPqR4wjljC0Ny/3
         hcfW5ceEhwJoYVlax/gEEDVN+I91mC8VTRY0g0T6ogq/LRJmo8Vy4zWPrQhPkD+05/Gc
         roowBnKbJe/PplJP3NLaEfJKrAvROanr8WpOAdp7Es8kzlxzK1yp1CSomBJ9QsIpCZx7
         DRU5RSYyLj2Gk1FoNe7IxXwja++aIdBBDrI+FIKJy0lkzLCrKuwQF+0FX+dg4LswFO7w
         zNkntxJCfFZTpv4tl504muG18fz8JfaBbO3HBysmc2fJsQ6jWTVOSchjroboe7Z3HU1F
         8zuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=Sr3P5H1/SA9EpTZVfI6kUGR1QwuY17SVFFPShHTSgBs=;
        b=pgWzGZnisi8NPMjzijfkWOeSRBWKeej+PPCRp8IyEdYILv0QpfRHK8MRDEivffThhP
         gPFSU2tTSQcxGv0WBsVcFwEIP1zbextjFAWuUpm0MXEloaXXGMKCmN5vTUlChtcbAwwz
         3tsmGFsbbUxPaw7hnwDt/vRRwEZSzKUnGCjDlvqf8yI8czYWo0tV7Z/lC0KVRYSMFmae
         bDCpvirZ9xZM7Eo28XUQ/sWuJpzx2J+L4inwaG8jvBEurhI/bfGQ4fzr+mYZPlfzPKL7
         Jvx5FWuUWEcR791HB+8HC1qLqO59BuMwMEXTwh5NQ7E7FamB0MxnXETuEzwT9Yq6thfL
         z7Kg==
X-Gm-Message-State: AHQUAub4sEMES8oEgx0w1Zy8AzXGKG/dTFgD+hgzTt+a6djPz6rlf0gj
        Ey85AaFRW4d+dPtUyryIUlU=
X-Google-Smtp-Source: AHgI3Ib5IDWv67lAxV5VnIsC3wl0+BomIQ9sFWr3OGlOZkZiU2JhczvhkxyLyDYsMnEOjjurxVYaWA==
X-Received: by 2002:a50:96c2:: with SMTP id z2mr23768188eda.11.1550574496437;
        Tue, 19 Feb 2019 03:08:16 -0800 (PST)
Received: from brutus.lan (brutus.defensec.nl. [2001:985:d55d::438])
        by smtp.gmail.com with ESMTPSA id b22sm111821edb.5.2019.02.19.03.08.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 03:08:15 -0800 (PST)
Date:   Tue, 19 Feb 2019 12:08:13 +0100
From:   Dominick Grift <dac.override@gmail.com>
To:     Stephen Smalley <stephen.smalley@gmail.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        "Stephen D. Smalley" <sds@tycho.nsa.gov>, selinux@vger.kernel.org,
        Petr Lautrbach <plautrba@redhat.com>
Subject: Re: [PATCH v3] scripts/selinux: add basic mls support to mdp
Message-ID: <20190219110813.GA22984@brutus.lan>
Mail-Followup-To: Stephen Smalley <stephen.smalley@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        "Stephen D. Smalley" <sds@tycho.nsa.gov>, selinux@vger.kernel.org,
        Petr Lautrbach <plautrba@redhat.com>
References: <CAHC9VhR9b8udyh7WWAw0-G64DuaLBN59QXByteBdVbtZKnUj-A@mail.gmail.com>
 <87lg2g97sr.fsf@gmail.com>
 <98436a4a-0048-2839-acff-b1bc38075a8c@tycho.nsa.gov>
 <87h8d4974p.fsf@gmail.com>
 <27efd865-7d08-fc61-e004-0a07f27e165e@tycho.nsa.gov>
 <20190216120412.GA11908@brutus.lan>
 <20190216121256.GB11908@brutus.lan>
 <CAHC9VhQsj8UnV=CZ+vkvruB6Nn_W7SzW-W4oTK9=QcJRkfeiJg@mail.gmail.com>
 <87d0np8tfw.fsf@gmail.com>
 <CAB9W1A3f1jxJQPrU-o=gEKzgjRGmbThoqPvzbK7QNqprdE-LAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
In-Reply-To: <CAB9W1A3f1jxJQPrU-o=gEKzgjRGmbThoqPvzbK7QNqprdE-LAw@mail.gmail.com>
User-Agent: Every email client sucks, this one just sucks less.
X-PGP-Key: https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 18, 2019 at 07:07:33PM -0500, Stephen Smalley wrote:
> On Mon, Feb 18, 2019, 2:09 AM Dominick Grift <dac.override@gmail.com wrot=
e:
>=20
> > Paul Moore <paul@paul-moore.com> writes:
> >
> > > On Sat, Feb 16, 2019 at 7:12 AM Dominick Grift <dac.override@gmail.co=
m>
> > wrote:
> > >>
> > >> On Sat, Feb 16, 2019 at 01:04:12PM +0100, Dominick Grift wrote:
> > >> > On Fri, Feb 15, 2019 at 02:48:45PM -0500, Stephen Smalley wrote:
> > >> > <snip>
> > >> >
> > >> > >
> > >> > > Oh, I see: scripts/selinux/install_policy.sh just invokes
> > checkpolicy
> > >> > > without specifying -U / --handle-unknown, so the policy defaults=
 to
> > deny,
> > >> > > and that would indeed render dbus-daemon and systemd broken with
> > that
> > >> > > policy.  Might be as simple to fix as passing -U allow.
> > >> >
> > >> > I have looked a litte into this and here are some observations:
> > >> >
> > >> > 1. You can boot mdp as-is in permissive mode if you use `checkpoli=
cy`
> > with `-U allow`
> > >> >
> > >> > 2. You need *at least* an `/etc/selinux/dummy/seusers` with
> > >> > `__default__:user_u` and an accompanying
> > >> > `/etc/selinux/dummy/contexts/failsafe_context` with
> > >> > `base_r:base_t` to boot mdp in enforcing
> > >
> > > Wow.  I didn't expect we would get to this point so quickly.
> > >
> > > Originally my plan had been to just merge the mdp changes that Stephen
> > > submitted, and leave the rest for some other time.  Although based on
> > > everything in this thread, it looks like we are really close to having
> > > something that you can build and boot without too many hacks.
> > >
> > >> > 3. There is an issue with checkpolicy and object_r:
> > >> >
> > >> > PAM libselinux clients such as `login` try to associate `object_r`
> > with the tty and fail.
> > >> >
> > >> > if you try to append: `role object_r; role object_r types base_t;`
> > >> > to policy.conf and compile that with `checkpolicy` then the
> > >> > `roletype-rule` does *not* end up in the compiled policy for some
> > >> > reason.
> > >
> > > This sounds like a bug in checkpolicy ... ?
> >
> > Yes, looks like it
> >
>=20
> I don't think so. object_r has always been handled specially. The kernel
> ignores the role-type definition for it and always exempts contexts that
> contain it from user-role, role-type, and user-range restrictions. We
> didn't use to include it in the policy at all; I think CIL does but we on=
ly
> generate a stub in the kernel policy with the role name and value but no
> types and the kernel ignores it. What exactly breaks with pam_selinux?
>=20

Tried it again and this time I tried to run install_selinux.sh with selinux=
 disabled (previously i did not bother to boot with selinux disabled)

Now I think I see what you were seeing:

1. setfiles is called in install_selinux.sh but it does not relabel when se=
linux is disabled
2. the system is misabeled and when you boot, that prompts an autorelabel (=
don't what does that but maybe systemd) which ,for some reason, does not wo=
rk either even though it looks like its doing something
3. system does not start properly (even in permissive mode) because it look=
s like systemd can't compute a valid context using the mislabeled /sbin/init

This, i think, would address that:

1. dont try to run setfiles in install_selinux.sh because it does not work =
in the scenario where you run install_selinux.sh when selinux is disabled (=
audit actually prints an FS_RELABEL event but nothing is relabeled)
2. in /etc/selinux/config use SELINUX=3Dpermissive instead of SELINUX=3Denf=
orcing (it needs to relabel in permissive mode in the next step)
3. echo '-F' > /.autorelabel

When all is said and done I still hit the issue where I am not able to log =
into the system in enforcing mode:

Feb 19 12:05:04 myguest login[1175]: pam_selinux(login:session): Setting fi=
le context "user_u:object_r:base_t" failed for /dev/ttyS0: Operation not su=
pported

>=20
> > >
> > >> > thus, you cannot log in because object_r:base_t is not valid.
> > >> >
> > >> > To hack around this add `default_role * source` rules to policy.co=
nf
> > and recompile.
> > >> >
> > >> > This will allow you to log into the system locally in enforcing mo=
de.
> > >> >
> > >> > 4. I also noticed that fedoras' ssh seems to hardcode `sshd_net_t`
> > >> > for its "privsep" functionality so, while untested, you probably
> > >> > need an `openssh_contexts` with `privsep_preauth=3Dbase_t`
> > >
> > > Petr, what's the deal with ssh on Fedora?
> >
> > I wonder whether it would be possible (and feasible) to not transition =
on
> > privsep_preauth at all *unless* a privsep preauth type is specified in
> > openssh_context.
> >
> > Currently it falls back to a hardcoded type to transition to if
> > openssh_contexts does not exist.
> >
> > Then again, i would not want to risk breaking or regressing some of the
> > nice
> > functionality openssh in fedora has for selinux. It's state is currently
> > very good even compared to RHEL.
> >
> > >
> > >> The `install_policy.sh` script should probably also do a bash file t=
est
> > for `checkpolicy` and fail gracefully if its not found
> >
> > --
> > Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
> > https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6=
B02
> > Dominick Grift
> >

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlxr45kACgkQJXSOVTf5
R2mbAwv/esiu/JlL27lqb2tdDfwPZ+QnRSS16OQ6J+4UFygwCELqmf91/KwrYwxd
xSLAHtk4gjQHsnrnrc+FLvTdtldjvWNKkWKBUPrYz7Elx/O29tyJMYHYe0Txg1c0
WRysnItNpQrmwNJ2NotsFIKxQq6AKtMOyJChpUX6zZT8akqF9tuq6pXmBh/OeAvt
FchEoS4KTsC9ptlRRF4fszPPF4Xn9kp00kJK8ZqCSqQAdrYSRBNWNN34hcF3HcP3
ExdgMqh9al7ybc59hlPeu5R0npWKNaPTrweXnfDktMK6zLtjdIXe3V0wwI91wHhU
hoKy3Vt6sYKlaclRU+lPvmAS7Mm3WyB0xw+cpQPJY67JTDsjnH6trL1xhKCW2bO3
GUAFJ7udduNmyW1Jv6kDVvuIdedGbvNmhMC1OrcghNK3S6zVStGq0JUfky2LTO6W
U6ei+ikuk7Q9wFmDGWiYoce/XHFaCf5IbFiYhMOIls4/LvCh+ObZJayJnbK6V8Wh
WnnDj3xg
=8toC
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
