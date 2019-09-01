Return-Path: <SRS0=nwEP=W4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD5FC3A5A4
	for <selinux@archiver.kernel.org>; Sun,  1 Sep 2019 16:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DD8E2190F
	for <selinux@archiver.kernel.org>; Sun,  1 Sep 2019 16:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbfIAQnu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 1 Sep 2019 12:43:50 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:51404 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728848AbfIAQnu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 1 Sep 2019 12:43:50 -0400
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id AF91C5606B6
        for <selinux@vger.kernel.org>; Sun,  1 Sep 2019 18:43:45 +0200 (CEST)
Received: by mail-oi1-f174.google.com with SMTP id o6so8852026oic.9
        for <selinux@vger.kernel.org>; Sun, 01 Sep 2019 09:43:45 -0700 (PDT)
X-Gm-Message-State: APjAAAX7CaaTjhguAUOZpFwhi/0OOEa4DRpPfnDaFi339f26dTMmrCc5
        UPpsXFO2Eryw51xr/zgpyEKwfat1954OvIxhjIQ=
X-Google-Smtp-Source: APXvYqz2T48N88jMuEhvGTD4iM2j9oe1dJFKEFHmck3nA1va20M2Pk5nI7D68tyLqE4Z+J2lChyULz/JQ2v/gOTj+UI=
X-Received: by 2002:aca:c396:: with SMTP id t144mr16636125oif.172.1567356224572;
 Sun, 01 Sep 2019 09:43:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfZ7==K7hT=vMz=-E75xkEb1S8u1b-XU+k8DB4u=WG5=xtLrg@mail.gmail.com>
In-Reply-To: <CAJfZ7==K7hT=vMz=-E75xkEb1S8u1b-XU+k8DB4u=WG5=xtLrg@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sun, 1 Sep 2019 18:43:33 +0200
X-Gmail-Original-Message-ID: <CAJfZ7==sqBV_YCEpvUc3SOj4=m_8FcyNywZivyKU_R=ca7X52w@mail.gmail.com>
Message-ID: <CAJfZ7==sqBV_YCEpvUc3SOj4=m_8FcyNywZivyKU_R=ca7X52w@mail.gmail.com>
Subject: Re: [PATCH] Fix many misspellings
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Sep  1 18:43:46 2019 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi,

I tried to send a large patch a few weeks ago, but it appears it was
dropped somewhere in transit because I can't find it on
https://lore.kernel.org/selinux/. The patch was about fixing may
misspellings in the userspace code and is available as a Pull Request
on GitHub: https://github.com/SELinuxProject/selinux/pull/173. May I
merge it, or would you really like to have the patch on the mailing
list (in which case I will split it in smaller pieces)?

Cheers,
Nicolas

On Tue, Aug 6, 2019 at 10:22 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> Hi all,
>
> I sent yesterday a patch that fixes many misspellings in SELinux
> userspace code, but it seems that my message never hit the mailing
> list. As it is quite large, it might have been discarded because it
> exceeded some size limits. I am therefore trying again with the patch
> sent as an attachment to the message. If for whatever reason the patch
> disappears, it is also available on GitHub:
> https://github.com/SELinuxProject/selinux/pull/173 (the raw patch can
> be downloaded through
> https://github.com/SELinuxProject/selinux/pull/173/commits/338d6cff11c0f224a69672823095fc035e25cbb4.patch).
>
> If you prefer this patch to be split for each directory (gui/,
> libselinux/, libsemanage/, etc.), I can do this. I have not done so at
> first because it was simpler on my side, but I could understand that
> reviewers prefer smaller patches.
>
> Please find below the commit message and the diffstat.
>
> Thanks,
> Nicolas
> --
> Use codespell (https://github.com/codespell-project/codespell) in order
> to find many common misspellings that are present in English texts.
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>  CONTRIBUTING.md                                  |  2 +-
>  checkpolicy/policy_define.c                      |  8 ++++----
>  dbus/selinux_server.py                           |  2 +-
>  gui/polgen.ui                                    |  4 ++--
>  gui/polgengui.py                                 |  2 +-
>  gui/system-config-selinux.py                     |  2 +-
>  libselinux/include/selinux/get_context_list.h    |  2 +-
>  libselinux/include/selinux/selinux.h             |  2 +-
>  libselinux/man/man3/security_compute_av.3        |  2 +-
>  libselinux/man/man3/selinux_restorecon.3         |  4 ++--
>  libselinux/src/label_file.c                      |  2 +-
>  libselinux/src/label_file.h                      |  2 +-
>  libselinux/src/regex.h                           |  4 ++--
>  libselinux/src/sestatus.c                        |  2 +-
>  libselinux/src/sha1.c                            |  2 +-
>  libselinux/src/stringrep.c                       |  2 +-
>  libselinux/utils/sefcontext_compile.c            |  2 +-
>  libsemanage/include/semanage/modules.h           |  2 +-
>  libsemanage/src/boolean_internal.h               |  2 +-
>  libsemanage/src/booleans_policydb.c              |  2 +-
>  libsemanage/src/database.h                       |  2 +-
>  libsemanage/src/fcontext_internal.h              |  2 +-
>  libsemanage/src/handle.c                         |  2 +-
>  libsemanage/src/iface_internal.h                 |  2 +-
>  libsemanage/src/modules.c                        |  4 ++--
>  libsemanage/src/policy.h                         |  2 +-
>  libsemanage/src/semanageswig_python.i            |  2 +-
>  libsemanage/src/user_internal.h                  |  2 +-
>  libsemanage/src/utilities.c                      |  2 +-
>  libsemanage/src/utilities.h                      | 14 +++++++-------
>  libsemanage/tests/test_bool.c                    |  4 ++--
>  libsepol/cil/src/cil_binary.c                    |  6 +++---
>  libsepol/cil/src/cil_binary.h                    |  8 ++++----
>  libsepol/cil/src/cil_build_ast.c                 |  4 ++--
>  libsepol/cil/src/cil_fqn.c                       |  2 +-
>  libsepol/cil/src/cil_post.c                      |  2 +-
>  libsepol/cil/src/cil_resolve_ast.c               |  4 ++--
>  libsepol/include/sepol/policydb/hashtab.h        |  2 +-
>  libsepol/include/sepol/policydb/services.h       |  2 +-
>  libsepol/src/conditional.c                       |  2 +-
>  libsepol/src/ebitmap.c                           |  2 +-
>  libsepol/src/link.c                              |  4 ++--
>  libsepol/src/module_to_cil.c                     |  4 ++--
>  .../tests/policies/test-deps/base-metreq.conf    |  2 +-
>  .../tests/policies/test-deps/base-notmetreq.conf |  2 +-
>  .../tests/policies/test-deps/small-base.conf     |  2 +-
>  .../tests/policies/test-expander/alias-base.conf |  2 +-
>  .../tests/policies/test-expander/role-base.conf  |  2 +-
>  .../tests/policies/test-expander/small-base.conf |  2 +-
>  .../tests/policies/test-expander/user-base.conf  |  2 +-
>  .../tests/policies/test-hooks/cmp_policy.conf    |  2 +-
>  .../tests/policies/test-hooks/small-base.conf    |  2 +-
>  .../tests/policies/test-linker/small-base.conf   |  2 +-
>  libsepol/tests/test-deps.c                       |  4 ++--
>  libsepol/tests/test-downgrade.c                  |  2 +-
>  libsepol/tests/test-downgrade.h                  |  2 +-
>  libsepol/tests/test-expander-attr-map.c          |  2 +-
>  libsepol/tests/test-linker-cond-map.c            | 10 +++++-----
>  mcstrans/share/examples/default/setrans.conf     |  4 ++--
>  mcstrans/share/examples/include/setrans.conf     |  6 +++---
>  .../examples/include/setrans.d/include-example   |  4 ++--
>  mcstrans/share/examples/nato/setrans.d/rel.conf  |  4 ++--
>  .../examples/urcsts-via-include/setrans.conf     |  6 +++---
>  mcstrans/src/mcscolor.c                          |  2 +-
>  policycoreutils/hll/pp/pp.c                      |  2 +-
>  policycoreutils/newrole/hashtab.h                |  2 +-
>  policycoreutils/newrole/newrole.c                |  6 +++---
>  policycoreutils/po/af.po                         | 10 +++++-----
>  policycoreutils/po/aln.po                        | 10 +++++-----
>  policycoreutils/po/am.po                         | 10 +++++-----
>  policycoreutils/po/ar.po                         | 10 +++++-----
>  policycoreutils/po/as.po                         | 10 +++++-----
>  policycoreutils/po/ast.po                        | 10 +++++-----
>  policycoreutils/po/az.po                         | 10 +++++-----
>  policycoreutils/po/bal.po                        | 10 +++++-----
>  policycoreutils/po/be.po                         | 10 +++++-----
>  policycoreutils/po/bg.po                         | 10 +++++-----
>  policycoreutils/po/bn.po                         | 10 +++++-----
>  policycoreutils/po/bn_BD.po                      | 10 +++++-----
>  policycoreutils/po/bn_IN.po                      | 10 +++++-----
>  policycoreutils/po/bo.po                         | 10 +++++-----
>  policycoreutils/po/br.po                         | 10 +++++-----
>  policycoreutils/po/brx.po                        | 10 +++++-----
>  policycoreutils/po/bs.po                         | 10 +++++-----
>  policycoreutils/po/ca.po                         | 10 +++++-----
>  policycoreutils/po/cs.po                         | 10 +++++-----
>  policycoreutils/po/cy.po                         | 10 +++++-----
>  policycoreutils/po/da.po                         | 10 +++++-----
>  policycoreutils/po/de.po                         | 10 +++++-----
>  policycoreutils/po/dz.po                         | 10 +++++-----
>  policycoreutils/po/el.po                         | 10 +++++-----
>  policycoreutils/po/en_GB.po                      | 10 +++++-----
>  policycoreutils/po/eo.po                         | 10 +++++-----
>  policycoreutils/po/es.po                         | 10 +++++-----
>  policycoreutils/po/es_MX.po                      | 10 +++++-----
>  policycoreutils/po/et.po                         | 10 +++++-----
>  policycoreutils/po/eu.po                         | 10 +++++-----
>  policycoreutils/po/fa.po                         | 10 +++++-----
>  policycoreutils/po/fi.po                         | 10 +++++-----
>  policycoreutils/po/fr.po                         | 10 +++++-----
>  policycoreutils/po/ga.po                         | 10 +++++-----
>  policycoreutils/po/gl.po                         | 10 +++++-----
>  policycoreutils/po/gu.po                         | 10 +++++-----
>  policycoreutils/po/he.po                         | 10 +++++-----
>  policycoreutils/po/hi.po                         | 10 +++++-----
>  policycoreutils/po/hr.po                         | 10 +++++-----
>  policycoreutils/po/hu.po                         | 10 +++++-----
>  policycoreutils/po/hy.po                         | 10 +++++-----
>  policycoreutils/po/ia.po                         | 10 +++++-----
>  policycoreutils/po/id.po                         | 10 +++++-----
>  policycoreutils/po/ilo.po                        | 10 +++++-----
>  policycoreutils/po/is.po                         | 10 +++++-----
>  policycoreutils/po/it.po                         | 10 +++++-----
>  policycoreutils/po/ja.po                         | 10 +++++-----
>  policycoreutils/po/ka.po                         | 10 +++++-----
>  policycoreutils/po/kk.po                         | 10 +++++-----
>  policycoreutils/po/km.po                         | 10 +++++-----
>  policycoreutils/po/kn.po                         | 10 +++++-----
>  policycoreutils/po/ko.po                         | 10 +++++-----
>  policycoreutils/po/ks.po                         | 10 +++++-----
>  policycoreutils/po/ku.po                         | 10 +++++-----
>  policycoreutils/po/ky.po                         | 10 +++++-----
>  policycoreutils/po/la.po                         | 10 +++++-----
>  policycoreutils/po/lo.po                         | 10 +++++-----
>  policycoreutils/po/lt.po                         | 10 +++++-----
>  policycoreutils/po/lt_LT.po                      | 10 +++++-----
>  policycoreutils/po/lv.po                         | 10 +++++-----
>  policycoreutils/po/lv_LV.po                      | 10 +++++-----
>  policycoreutils/po/mai.po                        | 10 +++++-----
>  policycoreutils/po/mg.po                         | 10 +++++-----
>  policycoreutils/po/mk.po                         | 10 +++++-----
>  policycoreutils/po/ml.po                         | 10 +++++-----
>  policycoreutils/po/mn.po                         | 10 +++++-----
>  policycoreutils/po/mr.po                         | 10 +++++-----
>  policycoreutils/po/ms.po                         | 10 +++++-----
>  policycoreutils/po/my.po                         | 10 +++++-----
>  policycoreutils/po/nb.po                         | 10 +++++-----
>  policycoreutils/po/nds.po                        | 10 +++++-----
>  policycoreutils/po/ne.po                         | 10 +++++-----
>  policycoreutils/po/nl.po                         | 10 +++++-----
>  policycoreutils/po/nn.po                         | 10 +++++-----
>  policycoreutils/po/nso.po                        | 10 +++++-----
>  policycoreutils/po/or.po                         | 10 +++++-----
>  policycoreutils/po/pa.po                         | 10 +++++-----
>  policycoreutils/po/pl.po                         | 10 +++++-----
>  policycoreutils/po/policycoreutils.pot           | 10 +++++-----
>  policycoreutils/po/pt.po                         | 10 +++++-----
>  policycoreutils/po/pt_BR.po                      | 10 +++++-----
>  policycoreutils/po/ro.po                         | 10 +++++-----
>  policycoreutils/po/ru.po                         | 10 +++++-----
>  policycoreutils/po/si.po                         | 10 +++++-----
>  policycoreutils/po/si_LK.po                      | 10 +++++-----
>  policycoreutils/po/sk.po                         | 10 +++++-----
>  policycoreutils/po/sl.po                         | 10 +++++-----
>  policycoreutils/po/sq.po                         | 10 +++++-----
>  policycoreutils/po/sr.po                         | 10 +++++-----
>  policycoreutils/po/sr@latin.po                   | 10 +++++-----
>  policycoreutils/po/sv.po                         | 10 +++++-----
>  policycoreutils/po/ta.po                         | 10 +++++-----
>  policycoreutils/po/te.po                         | 10 +++++-----
>  policycoreutils/po/tg.po                         | 10 +++++-----
>  policycoreutils/po/th.po                         | 10 +++++-----
>  policycoreutils/po/tl.po                         | 10 +++++-----
>  policycoreutils/po/tr.po                         | 10 +++++-----
>  policycoreutils/po/uk.po                         | 10 +++++-----
>  policycoreutils/po/ur.po                         | 10 +++++-----
>  policycoreutils/po/vi.po                         | 10 +++++-----
>  policycoreutils/po/vi_VN.po                      | 10 +++++-----
>  policycoreutils/po/wo.po                         | 10 +++++-----
>  policycoreutils/po/xh.po                         | 10 +++++-----
>  policycoreutils/po/zh_CN.GB2312.po               | 10 +++++-----
>  policycoreutils/po/zh_CN.po                      | 10 +++++-----
>  policycoreutils/po/zh_HK.po                      | 10 +++++-----
>  policycoreutils/po/zh_TW.Big5.po                 | 10 +++++-----
>  policycoreutils/po/zh_TW.po                      | 10 +++++-----
>  policycoreutils/po/zu.po                         | 10 +++++-----
>  policycoreutils/scripts/fixfiles                 |  2 +-
>  python/audit2allow/sepolgen-ifgen                |  4 ++--
>  python/semanage/semanage                         |  2 +-
>  python/semanage/seobject.py                      |  2 +-
>  python/sepolgen/HACKING                          |  2 +-
>  python/sepolgen/src/sepolgen/access.py           | 14 +++++++-------
>  python/sepolgen/src/sepolgen/interfaces.py       | 16 ++++++++--------
>  python/sepolgen/src/sepolgen/matching.py         |  2 +-
>  python/sepolgen/src/sepolgen/module.py           |  2 +-
>  python/sepolgen/src/sepolgen/objectmodel.py      |  8 ++++----
>  python/sepolgen/src/sepolgen/policygen.py        |  8 ++++----
>  python/sepolgen/src/sepolgen/refparser.py        |  2 +-
>  python/sepolgen/src/sepolgen/refpolicy.py        |  4 ++--
>  python/sepolgen/src/sepolgen/util.py             |  6 +++---
>  python/sepolgen/tests/test_refpolicy.py          |  2 +-
>  python/sepolicy/sepolicy/booleans.py             |  2 +-
>  python/sepolicy/sepolicy/communicate.py          |  2 +-
>  python/sepolicy/sepolicy/generate.py             |  2 +-
>  python/sepolicy/sepolicy/gui.py                  |  4 ++--
>  python/sepolicy/sepolicy/manpage.py              |  4 ++--
>  python/sepolicy/sepolicy/network.py              |  2 +-
>  python/sepolicy/sepolicy/transition.py           |  2 +-
>  restorecond/user.c                               |  2 +-
>  sandbox/sandbox                                  |  2 +-
>  sandbox/seunshare.c                              |  4 ++--
>  secilc/COPYING                                   |  2 +-
>  .../docs/cil_class_and_permission_statements.md  |  4 ++--
>  secilc/docs/cil_context_statement.md             |  4 ++--
>  secilc/docs/cil_policy_config_statements.md      |  2 +-
>  secilc/docs/cil_reference_guide.md               |  4 ++--
>  secilc/docs/cil_role_statements.md               |  2 +-
>  secilc/docs/cil_user_statements.md               |  6 +++---
>  208 files changed, 712 insertions(+), 712 deletions(-)

