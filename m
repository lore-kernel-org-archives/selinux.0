Return-Path: <SRS0=nwEP=W4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B12C3A5A4
	for <selinux@archiver.kernel.org>; Sun,  1 Sep 2019 17:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A4C822D6D
	for <selinux@archiver.kernel.org>; Sun,  1 Sep 2019 17:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYMbTyeD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbfIARFo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 1 Sep 2019 13:05:44 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43906 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728753AbfIARFo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 1 Sep 2019 13:05:44 -0400
Received: by mail-ed1-f66.google.com with SMTP id w9so3307418edx.10
        for <selinux@vger.kernel.org>; Sun, 01 Sep 2019 10:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vxZjAQK6VqXNVBthZ2eu0eQ6g3LJ0wnDTX2/5vzaAEU=;
        b=AYMbTyeDYmsTg8EHHyKWuO+J6Vd/oH0Rkned2vbKBZY/YZX8x1Y49eGrPYCFsHSdH9
         O4CZSSn8Kg0V1H7TlpJacu7Xjf/rOlUbEo3PQ0IZ5Y9dmZL9yD/Xz+C/n+0VRSzlce5s
         zAm/XlQDQ9XgnKub3zkNhdj2+KJzn5kKtdmU65W/RrBuiTHDeh+V0aVrX5pOVj02lhRK
         4lXZxXjnbao0+FFD9mv4q8f9QKz2Exs7vgpC4oGetavnwMWEKr+T6MdMmtRNfyFKEBNn
         Me4Vy5ZNVbJ0HAzjdBURtjliLdNTglqyUhCTA8DM1TNOF+g+tg0xLoRga2zIjHPyIlhk
         RUBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=vxZjAQK6VqXNVBthZ2eu0eQ6g3LJ0wnDTX2/5vzaAEU=;
        b=uKg7XzcXnadfmWh+MD+gLF5m7AL8eC50ftKLYlKpq+AwIDUy2vmi6LS0zRMAlQfiO6
         gwIdA54WV1FnrNeO+W/dYK8Us6Edpyki+meYxAO4ZtrKqIhSTYz0wYZA+Dgwwc8s6MIr
         eolLcJm9v2gar6JMF+gGPEsEaJOVL353/rSBYvQwR/TORGcjs9dVGYaHyZIMoOxwYhbR
         fDmQzwQ/lclYh22btibb0axsicYZ7oNBXY+7isRrgNCgJ/kut2GzOY89dcAmLc7ulQmM
         QJ7hObC19Y32Bs8nj2VcNtmMMuvUx2rxmEuSmMC5fn7D/Hb21tDhv6IVmUz3NwRyMky7
         kxYw==
X-Gm-Message-State: APjAAAUJYm3Z4D6q8Q3Q6GhYP+mlR3NFeO3XBq3WSYL7IZBGoxXOPjUG
        Ib+J0u5gx/lzCTuCPL2KYmY=
X-Google-Smtp-Source: APXvYqyY6mBL4wHx9MNj+VMBGRIMjKSHIejKSN5jB1UvDSW0Zvf+84hobwZ0p0vCQq700fiThKjUVw==
X-Received: by 2002:a50:cdd9:: with SMTP id h25mr25969388edj.231.1567357541489;
        Sun, 01 Sep 2019 10:05:41 -0700 (PDT)
Received: from brutus.lan (brutus.defensec.nl. [2001:985:d55d::438])
        by smtp.gmail.com with ESMTPSA id x42sm2382166ede.24.2019.09.01.10.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2019 10:05:40 -0700 (PDT)
Date:   Sun, 1 Sep 2019 19:05:38 +0200
From:   Dominick Grift <dac.override@gmail.com>
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Subject: Re: [PATCH] Fix many misspellings
Message-ID: <20190901170538.GB152026@brutus.lan>
Mail-Followup-To: Nicolas Iooss <nicolas.iooss@m4x.org>,
        SElinux list <selinux@vger.kernel.org>
References: <CAJfZ7==K7hT=vMz=-E75xkEb1S8u1b-XU+k8DB4u=WG5=xtLrg@mail.gmail.com>
 <CAJfZ7==sqBV_YCEpvUc3SOj4=m_8FcyNywZivyKU_R=ca7X52w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gj572EiMnwbLXET9"
Content-Disposition: inline
In-Reply-To: <CAJfZ7==sqBV_YCEpvUc3SOj4=m_8FcyNywZivyKU_R=ca7X52w@mail.gmail.com>
User-Agent: Every email client sucks, this one just sucks less.
X-PGP-Key: https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--gj572EiMnwbLXET9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 01, 2019 at 06:43:33PM +0200, Nicolas Iooss wrote:
> Hi,
>=20
> I tried to send a large patch a few weeks ago, but it appears it was
> dropped somewhere in transit because I can't find it on
> https://lore.kernel.org/selinux/. The patch was about fixing may
> misspellings in the userspace code and is available as a Pull Request
> on GitHub: https://github.com/SELinuxProject/selinux/pull/173. May I
> merge it, or would you really like to have the patch on the mailing
> list (in which case I will split it in smaller pieces)?

FWIW I reviewed this. Looks good.

>=20
> Cheers,
> Nicolas
>=20
> On Tue, Aug 6, 2019 at 10:22 PM Nicolas Iooss <nicolas.iooss@m4x.org> wro=
te:
> >
> > Hi all,
> >
> > I sent yesterday a patch that fixes many misspellings in SELinux
> > userspace code, but it seems that my message never hit the mailing
> > list. As it is quite large, it might have been discarded because it
> > exceeded some size limits. I am therefore trying again with the patch
> > sent as an attachment to the message. If for whatever reason the patch
> > disappears, it is also available on GitHub:
> > https://github.com/SELinuxProject/selinux/pull/173 (the raw patch can
> > be downloaded through
> > https://github.com/SELinuxProject/selinux/pull/173/commits/338d6cff11c0=
f224a69672823095fc035e25cbb4.patch).
> >
> > If you prefer this patch to be split for each directory (gui/,
> > libselinux/, libsemanage/, etc.), I can do this. I have not done so at
> > first because it was simpler on my side, but I could understand that
> > reviewers prefer smaller patches.
> >
> > Please find below the commit message and the diffstat.
> >
> > Thanks,
> > Nicolas
> > --
> > Use codespell (https://github.com/codespell-project/codespell) in order
> > to find many common misspellings that are present in English texts.
> >
> > Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> > ---
> >  CONTRIBUTING.md                                  |  2 +-
> >  checkpolicy/policy_define.c                      |  8 ++++----
> >  dbus/selinux_server.py                           |  2 +-
> >  gui/polgen.ui                                    |  4 ++--
> >  gui/polgengui.py                                 |  2 +-
> >  gui/system-config-selinux.py                     |  2 +-
> >  libselinux/include/selinux/get_context_list.h    |  2 +-
> >  libselinux/include/selinux/selinux.h             |  2 +-
> >  libselinux/man/man3/security_compute_av.3        |  2 +-
> >  libselinux/man/man3/selinux_restorecon.3         |  4 ++--
> >  libselinux/src/label_file.c                      |  2 +-
> >  libselinux/src/label_file.h                      |  2 +-
> >  libselinux/src/regex.h                           |  4 ++--
> >  libselinux/src/sestatus.c                        |  2 +-
> >  libselinux/src/sha1.c                            |  2 +-
> >  libselinux/src/stringrep.c                       |  2 +-
> >  libselinux/utils/sefcontext_compile.c            |  2 +-
> >  libsemanage/include/semanage/modules.h           |  2 +-
> >  libsemanage/src/boolean_internal.h               |  2 +-
> >  libsemanage/src/booleans_policydb.c              |  2 +-
> >  libsemanage/src/database.h                       |  2 +-
> >  libsemanage/src/fcontext_internal.h              |  2 +-
> >  libsemanage/src/handle.c                         |  2 +-
> >  libsemanage/src/iface_internal.h                 |  2 +-
> >  libsemanage/src/modules.c                        |  4 ++--
> >  libsemanage/src/policy.h                         |  2 +-
> >  libsemanage/src/semanageswig_python.i            |  2 +-
> >  libsemanage/src/user_internal.h                  |  2 +-
> >  libsemanage/src/utilities.c                      |  2 +-
> >  libsemanage/src/utilities.h                      | 14 +++++++-------
> >  libsemanage/tests/test_bool.c                    |  4 ++--
> >  libsepol/cil/src/cil_binary.c                    |  6 +++---
> >  libsepol/cil/src/cil_binary.h                    |  8 ++++----
> >  libsepol/cil/src/cil_build_ast.c                 |  4 ++--
> >  libsepol/cil/src/cil_fqn.c                       |  2 +-
> >  libsepol/cil/src/cil_post.c                      |  2 +-
> >  libsepol/cil/src/cil_resolve_ast.c               |  4 ++--
> >  libsepol/include/sepol/policydb/hashtab.h        |  2 +-
> >  libsepol/include/sepol/policydb/services.h       |  2 +-
> >  libsepol/src/conditional.c                       |  2 +-
> >  libsepol/src/ebitmap.c                           |  2 +-
> >  libsepol/src/link.c                              |  4 ++--
> >  libsepol/src/module_to_cil.c                     |  4 ++--
> >  .../tests/policies/test-deps/base-metreq.conf    |  2 +-
> >  .../tests/policies/test-deps/base-notmetreq.conf |  2 +-
> >  .../tests/policies/test-deps/small-base.conf     |  2 +-
> >  .../tests/policies/test-expander/alias-base.conf |  2 +-
> >  .../tests/policies/test-expander/role-base.conf  |  2 +-
> >  .../tests/policies/test-expander/small-base.conf |  2 +-
> >  .../tests/policies/test-expander/user-base.conf  |  2 +-
> >  .../tests/policies/test-hooks/cmp_policy.conf    |  2 +-
> >  .../tests/policies/test-hooks/small-base.conf    |  2 +-
> >  .../tests/policies/test-linker/small-base.conf   |  2 +-
> >  libsepol/tests/test-deps.c                       |  4 ++--
> >  libsepol/tests/test-downgrade.c                  |  2 +-
> >  libsepol/tests/test-downgrade.h                  |  2 +-
> >  libsepol/tests/test-expander-attr-map.c          |  2 +-
> >  libsepol/tests/test-linker-cond-map.c            | 10 +++++-----
> >  mcstrans/share/examples/default/setrans.conf     |  4 ++--
> >  mcstrans/share/examples/include/setrans.conf     |  6 +++---
> >  .../examples/include/setrans.d/include-example   |  4 ++--
> >  mcstrans/share/examples/nato/setrans.d/rel.conf  |  4 ++--
> >  .../examples/urcsts-via-include/setrans.conf     |  6 +++---
> >  mcstrans/src/mcscolor.c                          |  2 +-
> >  policycoreutils/hll/pp/pp.c                      |  2 +-
> >  policycoreutils/newrole/hashtab.h                |  2 +-
> >  policycoreutils/newrole/newrole.c                |  6 +++---
> >  policycoreutils/po/af.po                         | 10 +++++-----
> >  policycoreutils/po/aln.po                        | 10 +++++-----
> >  policycoreutils/po/am.po                         | 10 +++++-----
> >  policycoreutils/po/ar.po                         | 10 +++++-----
> >  policycoreutils/po/as.po                         | 10 +++++-----
> >  policycoreutils/po/ast.po                        | 10 +++++-----
> >  policycoreutils/po/az.po                         | 10 +++++-----
> >  policycoreutils/po/bal.po                        | 10 +++++-----
> >  policycoreutils/po/be.po                         | 10 +++++-----
> >  policycoreutils/po/bg.po                         | 10 +++++-----
> >  policycoreutils/po/bn.po                         | 10 +++++-----
> >  policycoreutils/po/bn_BD.po                      | 10 +++++-----
> >  policycoreutils/po/bn_IN.po                      | 10 +++++-----
> >  policycoreutils/po/bo.po                         | 10 +++++-----
> >  policycoreutils/po/br.po                         | 10 +++++-----
> >  policycoreutils/po/brx.po                        | 10 +++++-----
> >  policycoreutils/po/bs.po                         | 10 +++++-----
> >  policycoreutils/po/ca.po                         | 10 +++++-----
> >  policycoreutils/po/cs.po                         | 10 +++++-----
> >  policycoreutils/po/cy.po                         | 10 +++++-----
> >  policycoreutils/po/da.po                         | 10 +++++-----
> >  policycoreutils/po/de.po                         | 10 +++++-----
> >  policycoreutils/po/dz.po                         | 10 +++++-----
> >  policycoreutils/po/el.po                         | 10 +++++-----
> >  policycoreutils/po/en_GB.po                      | 10 +++++-----
> >  policycoreutils/po/eo.po                         | 10 +++++-----
> >  policycoreutils/po/es.po                         | 10 +++++-----
> >  policycoreutils/po/es_MX.po                      | 10 +++++-----
> >  policycoreutils/po/et.po                         | 10 +++++-----
> >  policycoreutils/po/eu.po                         | 10 +++++-----
> >  policycoreutils/po/fa.po                         | 10 +++++-----
> >  policycoreutils/po/fi.po                         | 10 +++++-----
> >  policycoreutils/po/fr.po                         | 10 +++++-----
> >  policycoreutils/po/ga.po                         | 10 +++++-----
> >  policycoreutils/po/gl.po                         | 10 +++++-----
> >  policycoreutils/po/gu.po                         | 10 +++++-----
> >  policycoreutils/po/he.po                         | 10 +++++-----
> >  policycoreutils/po/hi.po                         | 10 +++++-----
> >  policycoreutils/po/hr.po                         | 10 +++++-----
> >  policycoreutils/po/hu.po                         | 10 +++++-----
> >  policycoreutils/po/hy.po                         | 10 +++++-----
> >  policycoreutils/po/ia.po                         | 10 +++++-----
> >  policycoreutils/po/id.po                         | 10 +++++-----
> >  policycoreutils/po/ilo.po                        | 10 +++++-----
> >  policycoreutils/po/is.po                         | 10 +++++-----
> >  policycoreutils/po/it.po                         | 10 +++++-----
> >  policycoreutils/po/ja.po                         | 10 +++++-----
> >  policycoreutils/po/ka.po                         | 10 +++++-----
> >  policycoreutils/po/kk.po                         | 10 +++++-----
> >  policycoreutils/po/km.po                         | 10 +++++-----
> >  policycoreutils/po/kn.po                         | 10 +++++-----
> >  policycoreutils/po/ko.po                         | 10 +++++-----
> >  policycoreutils/po/ks.po                         | 10 +++++-----
> >  policycoreutils/po/ku.po                         | 10 +++++-----
> >  policycoreutils/po/ky.po                         | 10 +++++-----
> >  policycoreutils/po/la.po                         | 10 +++++-----
> >  policycoreutils/po/lo.po                         | 10 +++++-----
> >  policycoreutils/po/lt.po                         | 10 +++++-----
> >  policycoreutils/po/lt_LT.po                      | 10 +++++-----
> >  policycoreutils/po/lv.po                         | 10 +++++-----
> >  policycoreutils/po/lv_LV.po                      | 10 +++++-----
> >  policycoreutils/po/mai.po                        | 10 +++++-----
> >  policycoreutils/po/mg.po                         | 10 +++++-----
> >  policycoreutils/po/mk.po                         | 10 +++++-----
> >  policycoreutils/po/ml.po                         | 10 +++++-----
> >  policycoreutils/po/mn.po                         | 10 +++++-----
> >  policycoreutils/po/mr.po                         | 10 +++++-----
> >  policycoreutils/po/ms.po                         | 10 +++++-----
> >  policycoreutils/po/my.po                         | 10 +++++-----
> >  policycoreutils/po/nb.po                         | 10 +++++-----
> >  policycoreutils/po/nds.po                        | 10 +++++-----
> >  policycoreutils/po/ne.po                         | 10 +++++-----
> >  policycoreutils/po/nl.po                         | 10 +++++-----
> >  policycoreutils/po/nn.po                         | 10 +++++-----
> >  policycoreutils/po/nso.po                        | 10 +++++-----
> >  policycoreutils/po/or.po                         | 10 +++++-----
> >  policycoreutils/po/pa.po                         | 10 +++++-----
> >  policycoreutils/po/pl.po                         | 10 +++++-----
> >  policycoreutils/po/policycoreutils.pot           | 10 +++++-----
> >  policycoreutils/po/pt.po                         | 10 +++++-----
> >  policycoreutils/po/pt_BR.po                      | 10 +++++-----
> >  policycoreutils/po/ro.po                         | 10 +++++-----
> >  policycoreutils/po/ru.po                         | 10 +++++-----
> >  policycoreutils/po/si.po                         | 10 +++++-----
> >  policycoreutils/po/si_LK.po                      | 10 +++++-----
> >  policycoreutils/po/sk.po                         | 10 +++++-----
> >  policycoreutils/po/sl.po                         | 10 +++++-----
> >  policycoreutils/po/sq.po                         | 10 +++++-----
> >  policycoreutils/po/sr.po                         | 10 +++++-----
> >  policycoreutils/po/sr@latin.po                   | 10 +++++-----
> >  policycoreutils/po/sv.po                         | 10 +++++-----
> >  policycoreutils/po/ta.po                         | 10 +++++-----
> >  policycoreutils/po/te.po                         | 10 +++++-----
> >  policycoreutils/po/tg.po                         | 10 +++++-----
> >  policycoreutils/po/th.po                         | 10 +++++-----
> >  policycoreutils/po/tl.po                         | 10 +++++-----
> >  policycoreutils/po/tr.po                         | 10 +++++-----
> >  policycoreutils/po/uk.po                         | 10 +++++-----
> >  policycoreutils/po/ur.po                         | 10 +++++-----
> >  policycoreutils/po/vi.po                         | 10 +++++-----
> >  policycoreutils/po/vi_VN.po                      | 10 +++++-----
> >  policycoreutils/po/wo.po                         | 10 +++++-----
> >  policycoreutils/po/xh.po                         | 10 +++++-----
> >  policycoreutils/po/zh_CN.GB2312.po               | 10 +++++-----
> >  policycoreutils/po/zh_CN.po                      | 10 +++++-----
> >  policycoreutils/po/zh_HK.po                      | 10 +++++-----
> >  policycoreutils/po/zh_TW.Big5.po                 | 10 +++++-----
> >  policycoreutils/po/zh_TW.po                      | 10 +++++-----
> >  policycoreutils/po/zu.po                         | 10 +++++-----
> >  policycoreutils/scripts/fixfiles                 |  2 +-
> >  python/audit2allow/sepolgen-ifgen                |  4 ++--
> >  python/semanage/semanage                         |  2 +-
> >  python/semanage/seobject.py                      |  2 +-
> >  python/sepolgen/HACKING                          |  2 +-
> >  python/sepolgen/src/sepolgen/access.py           | 14 +++++++-------
> >  python/sepolgen/src/sepolgen/interfaces.py       | 16 ++++++++--------
> >  python/sepolgen/src/sepolgen/matching.py         |  2 +-
> >  python/sepolgen/src/sepolgen/module.py           |  2 +-
> >  python/sepolgen/src/sepolgen/objectmodel.py      |  8 ++++----
> >  python/sepolgen/src/sepolgen/policygen.py        |  8 ++++----
> >  python/sepolgen/src/sepolgen/refparser.py        |  2 +-
> >  python/sepolgen/src/sepolgen/refpolicy.py        |  4 ++--
> >  python/sepolgen/src/sepolgen/util.py             |  6 +++---
> >  python/sepolgen/tests/test_refpolicy.py          |  2 +-
> >  python/sepolicy/sepolicy/booleans.py             |  2 +-
> >  python/sepolicy/sepolicy/communicate.py          |  2 +-
> >  python/sepolicy/sepolicy/generate.py             |  2 +-
> >  python/sepolicy/sepolicy/gui.py                  |  4 ++--
> >  python/sepolicy/sepolicy/manpage.py              |  4 ++--
> >  python/sepolicy/sepolicy/network.py              |  2 +-
> >  python/sepolicy/sepolicy/transition.py           |  2 +-
> >  restorecond/user.c                               |  2 +-
> >  sandbox/sandbox                                  |  2 +-
> >  sandbox/seunshare.c                              |  4 ++--
> >  secilc/COPYING                                   |  2 +-
> >  .../docs/cil_class_and_permission_statements.md  |  4 ++--
> >  secilc/docs/cil_context_statement.md             |  4 ++--
> >  secilc/docs/cil_policy_config_statements.md      |  2 +-
> >  secilc/docs/cil_reference_guide.md               |  4 ++--
> >  secilc/docs/cil_role_statements.md               |  2 +-
> >  secilc/docs/cil_user_statements.md               |  6 +++---
> >  208 files changed, 712 insertions(+), 712 deletions(-)
>=20

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--gj572EiMnwbLXET9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAl1r+l4ACgkQJXSOVTf5
R2lZ2gv/ThOsBbLYQgga+MbwAu2Bw4Ag/cmCcmtvSeqOiIVk17zjMqAjcvVog8b/
XttMrSclVHG77et9ka61j3/Zoly6UfpRfbaGxJDO101vuchiHnKkp1bO3f3qUMWB
SREcJMDapA4pnjEBwDZafQs0iqE4fQCNzvfZTVAHBMxJMhQdGxQl0zuArVZrfzcD
zBuvxFqVlUeRqHmTe2vjUBkqIVLpjWCaBF2pSDXwdBlAVUtSB7JK1/6kduz9W5pU
TFAfizEClfSPLL77fG+x8mvtcsHTEA14vasfx+ng3asLSRnbRJXD2jbypvxoOstt
uEekGTcVSiySh81z/6UAz3ZOji8Oa/XZyVOghuAJsX9TfdCwiWsVilpJSpSFELB0
Fzp1ft4sqQIy4ji88DP21YW2hgWh8xH+zlEh7ZFTaWcGquSIXCqM4wOUarYWX4dh
3ozinS/kULRMScaAEDUKH7PJiHZ/+y6vVQ97U/TsjT68v/qHaMy5oynw8BuVZAcp
Lv4q+4wk
=TKpY
-----END PGP SIGNATURE-----

--gj572EiMnwbLXET9--
