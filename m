Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F22A9C77B7E
	for <selinux@archiver.kernel.org>; Thu,  1 Jun 2023 21:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjFAVDo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 1 Jun 2023 17:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjFAVDn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 1 Jun 2023 17:03:43 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC434189
        for <selinux@vger.kernel.org>; Thu,  1 Jun 2023 14:03:41 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2af177f12d1so19838711fa.0
        for <selinux@vger.kernel.org>; Thu, 01 Jun 2023 14:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685653420; x=1688245420;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=htHLBaszbef2qZhC9F7J6DWVHmMjexLnjWq22rbKqvE=;
        b=Ps17iC5VC17YGwzUGJ4jpramuxwk8EjNWY1wrmVzpV7SwkH5X9c00gVDC2Rr2SSUfP
         4Iss1SihcMu+JpGFOCB1F/v/VdSLZs6cgKuwdnvM7MNOH+XdTZwq13UMKN8ij3c38vcL
         FDmr7noNbE6+6UOjnvwyQiOzCcQtl/5qNrw4SWJrV0RNDiSd0KM162Wu65k0cv0+pXsw
         w2rxCYC4pFhauLaAXTT533q+6J01ECJeqVE2vTUqVBI6p2dSZJqz54Z+K6f/ePW9r2CG
         NXz38b6hw/AMvGp1POen1bV5Mtag8ViV0YdW6TpacgyPhwmUIM0/bfrPfIYAltxYbAig
         6tng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685653420; x=1688245420;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=htHLBaszbef2qZhC9F7J6DWVHmMjexLnjWq22rbKqvE=;
        b=Y8YSTaHeWG5LkQb9U9vjAhjhKifSjC3G7zQ9cfBeeRiHRsKzOpp9RB1X4tbQJnbb9S
         8yyYW+Cra1vB3OxEoAiTSuZlGGHZkU8l9FVhMylLgyORRQHbcxz7M6OfmCJCuFkFWrgr
         05/bJaysd47mLV53NcUUOLZ2dftqjBrPk1qU0ZnM9UKeapkQb7hh9phg34aIj4K12sgH
         QAnIq9fG+Z1mAsdSNKpDcXIDGAuZin/+dYCLS4sMKg2N5jbx8EoIW2peaZ61V3nJxLAK
         SnZ8U2gHYmdxSUtQgoCuSJAMrVqlOPwXUDo1VDoKenfVUnBU6bpY2Klw3dUGMByQFVSG
         VDBA==
X-Gm-Message-State: AC+VfDyqE3I/fhtAb4u5vt5YcOZ1mHTQJgnNdNHK6qdBlxDsfsW8UPib
        qMXQTI7IzOFGMKO8m3xGXHuSZck4/rDngyjpg3o=
X-Google-Smtp-Source: ACHHUZ4UnxJ13QJ2h1kMfuLxJHFwgCdJ6d6I8e03LQe+7JFHI9ExrH41p5SyDiuX3LgH5ihthHFjvJ6M4ZtSxrXNDIo=
X-Received: by 2002:a2e:9c8b:0:b0:2ad:90c8:7fa3 with SMTP id
 x11-20020a2e9c8b000000b002ad90c87fa3mr425959lji.29.1685653419692; Thu, 01 Jun
 2023 14:03:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230531114914.2237609-1-juraj@jurajmarcin.com>
In-Reply-To: <20230531114914.2237609-1-juraj@jurajmarcin.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 1 Jun 2023 17:03:28 -0400
Message-ID: <CAP+JOzS1nhxF8EttikRtYBW2QtW=ck+P4mC2dovgP4kp-g9WQQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] checkpolicy, libsepol: add prefix/suffix matching to
 filename type transitions
To:     Juraj Marcin <juraj@jurajmarcin.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000004bec0c05fd17c5be"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--0000000000004bec0c05fd17c5be
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I did a bit of testing.

These all work:
~/local/usr/bin/secil2tree -o test_01.cil.tree test_01.cil
~/local/usr/bin/secilc -o test_01.cil.bin test_01.cil
~/local/usr/bin/checkpolicy -C -b -o test_01.cil.bin.cil test_01.cil.bin

/local/usr/bin/checkpolicy -o test_01.conf.bin test_01.conf
~/local/usr/bin/checkpolicy -C -b -o test_01.conf.bin.cil test_01.conf.bin

~/local/usr/bin/secil2conf -o test_01.cil.conf test_01.cil
~/local/usr/bin/checkpolicy -o test_01.cil.conf.bin test_01.cil.conf

~/local/usr/bin/checkmodule -o base_01.mod base_01.te
~/local/usr/bin/checkmodule -m -o mod_02.mod mod_02.te
~/local/usr/bin/semodule_package -o base_01.pp -m base_01.mod
~/local/usr/bin/semodule_package -o mod_02.pp -m mod_02.mod
~/local/usr/bin/semodule_link -o test_01.pp.lnk base_01.pp mod_02.pp
~/local/usr/bin/semodule_expand test_01.pp.lnk test_01.pp.bin

These do not work:
~/local/usr/bin/checkpolicy -F -b -o test_01.cil.bin.conf test_01.cil.bin
~/local/usr/bin/checkpolicy -F -b -o test_01.conf.bin.conf test_01.conf.bin
~/local/usr/bin/checkpolicy -F -b -o test_01.pp.bin.conf test_01.pp.bin

It appears something is wrong with translating the binary to a
policy.conf, but I haven't had a chance to look deeper.

I've attached the very simple test policies I used.

Thanks,
Jim

On Wed, May 31, 2023 at 7:51=E2=80=AFAM Juraj Marcin <juraj@jurajmarcin.com=
> wrote:
>
> Currently, filename transitions are stored separately from other type
> enforcement rules and only support exact name matching. However, in
> practice, the names contain variable parts. This leads to many
> duplicated rules in the policy that differ only in the part of the name,
> or it is even impossible to cover all possible combinations.
>
> This series implements equivalent changes made by this kernel patch
> series [1].
>
> First, this series of patches moves the filename transitions to be part
> of the avtab and avrule structures. This not only makes the
> implementation of prefix/suffix matching and future enhancements easier,
> but also reduces the technical debt regarding the filename transitions.
> Next, the last three patches implement the support for prefix/suffix
> name matching itself by extending the structures added in previous
> patches in this series and adding the support to CIL in the last of the
> triple.
>
> Even though, moving everything to avtab increases the memory usage and
> the size of the binary policy itself and thus the loading time, the
> ability to match the prefix or suffix of the name will reduce the
> overall number of rules in the policy which should mitigate this issue.
>
> [1]: https://lore.kernel.org/selinux/20230531112927.1957093-1-juraj@juraj=
marcin.com/
>
> Juraj Marcin (8):
>   checkpolicy, libsepol: move transition to separate structure in avtab
>   checkpolicy, libsepol: move filename transitions to avtab
>   checkpolicy, libsepol: move filename transition rules to avrule
>   libsepol: implement new kernel binary format for avtab
>   libsepol: implement new module binary format of avrule
>   checkpolicy, libsepol: add prefix/suffix support to kernel policy
>   checkpolicy, libsepol: add prefix/suffix support to module policy
>   libsepol/cil: add support for prefix/suffix filename transtions to CIL
>
>  checkpolicy/checkmodule.c                  |   9 +
>  checkpolicy/module_compiler.c              |  12 -
>  checkpolicy/module_compiler.h              |   1 -
>  checkpolicy/policy_define.c                | 211 +-----
>  checkpolicy/policy_define.h                |   3 +-
>  checkpolicy/policy_parse.y                 |  15 +-
>  checkpolicy/policy_scan.l                  |   6 +
>  checkpolicy/test/dismod.c                  |  39 +-
>  checkpolicy/test/dispol.c                  | 106 +--
>  libsepol/cil/src/cil.c                     |   8 +
>  libsepol/cil/src/cil_binary.c              |  63 +-
>  libsepol/cil/src/cil_build_ast.c           |  25 +-
>  libsepol/cil/src/cil_copy_ast.c            |   1 +
>  libsepol/cil/src/cil_internal.h            |   5 +
>  libsepol/cil/src/cil_policy.c              |  17 +-
>  libsepol/cil/src/cil_resolve_ast.c         |  10 +
>  libsepol/cil/src/cil_write_ast.c           |   2 +
>  libsepol/include/sepol/policydb/avtab.h    |  19 +-
>  libsepol/include/sepol/policydb/hashtab.h  |  14 +
>  libsepol/include/sepol/policydb/policydb.h |  50 +-
>  libsepol/src/avrule_block.c                |   1 -
>  libsepol/src/avtab.c                       | 336 +++++++++-
>  libsepol/src/conditional.c                 |   6 +-
>  libsepol/src/expand.c                      | 149 ++---
>  libsepol/src/kernel_to_cil.c               | 182 ++----
>  libsepol/src/kernel_to_common.h            |  10 +
>  libsepol/src/kernel_to_conf.c              | 178 ++----
>  libsepol/src/link.c                        |  57 +-
>  libsepol/src/module_to_cil.c               |  86 +--
>  libsepol/src/optimize.c                    |   8 +
>  libsepol/src/policydb.c                    | 479 +++-----------
>  libsepol/src/policydb_validate.c           | 100 +--
>  libsepol/src/services.c                    |   5 +-
>  libsepol/src/write.c                       | 712 ++++++++++++++++-----
>  34 files changed, 1534 insertions(+), 1391 deletions(-)
>
> --
> 2.40.0
>

--0000000000004bec0c05fd17c5be
Content-Type: text/plain; charset="US-ASCII"; name="test_01.conf"
Content-Disposition: attachment; filename="test_01.conf"
Content-Transfer-Encoding: base64
Content-ID: <f_lidmi2ds1>
X-Attachment-Id: f_lidmi2ds1

Y2xhc3MgQ0xBU1MxCmNsYXNzIENMQVNTMDEKY2xhc3MgQ0xBU1MwMgpjbGFzcyBDTEFTUzAzCmNs
YXNzIENMQVNTMDQKY2xhc3MgQ0xBU1MwNQpjbGFzcyBDTEFTUzA2CnNpZCBrZXJuZWwKY2xhc3Mg
Q0xBU1MxIHsgUEVSTTEgfQpjbGFzcyBDTEFTUzAxIHsgUEVSTTAxIH0KY2xhc3MgQ0xBU1MwMiB7
IFBFUk0wMiB9CmNsYXNzIENMQVNTMDMgeyBQRVJNMDMgfQpjbGFzcyBDTEFTUzA0IHsgUEVSTTA0
IH0KY2xhc3MgQ0xBU1MwNSB7IFBFUk0wNSB9CmNsYXNzIENMQVNTMDYgeyBQRVJNMDYgfQp0eXBl
IFRZUEUxOwp0eXBlIHRhOwp0eXBlIHRiOwp0eXBlIHRjOwphbGxvdyBUWVBFMSBzZWxmIDogQ0xB
U1MxIHsgUEVSTTEgfTsKdHlwZV90cmFuc2l0aW9uIHRhIHRiIDogQ0xBU1MwMSB0YyAiZmlsZTAx
IjsKdHlwZV90cmFuc2l0aW9uIHRhIHRiIDogQ0xBU1MwMiB0YyAiW2ZpbGUwMl0iOwp0eXBlX3Ry
YW5zaXRpb24gdGEgdGIgOiBDTEFTUzAzIHRjICJmaWxlMDMiOwp0eXBlX3RyYW5zaXRpb24gdGEg
dGIgOiBDTEFTUzA0IHRjICJmaWxlMDQiIG1hdGNoX3ByZWZpeDsKdHlwZV90cmFuc2l0aW9uIHRh
IHRiIDogQ0xBU1MwNSB0YyAiZmlsZTA1IiBtYXRjaF9zdWZmaXg7CnJvbGUgUk9MRTE7CnJvbGUg
Uk9MRTEgdHlwZXMgeyBUWVBFMSB9Owp1c2VyIFVTRVIxIHJvbGVzIFJPTEUxOwpzaWQga2VybmVs
IFVTRVIxOlJPTEUxOlRZUEUxCg==
--0000000000004bec0c05fd17c5be
Content-Type: application/vnd.ms-artgalry; name="test_01.cil"
Content-Disposition: attachment; filename="test_01.cil"
Content-Transfer-Encoding: base64
Content-ID: <f_lidmhx7i0>
X-Attachment-Id: f_lidmhx7i0

KGhhbmRsZXVua25vd24gZGVueSkKKGNsYXNzIENMQVNTMSAoUEVSTTEpKQooY2xhc3MgQ0xBU1Mw
MSAoUEVSTTAxKSkKKGNsYXNzIENMQVNTMDIgKFBFUk0wMikpCihjbGFzcyBDTEFTUzAzIChQRVJN
MDMpKQooY2xhc3MgQ0xBU1MwNCAoUEVSTTA0KSkKKGNsYXNzIENMQVNTMDUgKFBFUk0wNSkpCihj
bGFzcyBDTEFTUzA2IChQRVJNMDYpKQooY2xhc3NvcmRlciAoQ0xBU1MxIENMQVNTMDEgQ0xBU1Mw
MiBDTEFTUzAzIENMQVNTMDQgQ0xBU1MwNSBDTEFTUzA2KSkKKHNpZCBrZXJuZWwpCihzaWRvcmRl
ciAoa2VybmVsKSkKKHVzZXIgVVNFUjEpCihyb2xlIFJPTEUxKQoodHlwZSBUWVBFMSkKKGNhdGVn
b3J5IENBVDEpCihjYXRlZ29yeW9yZGVyIChDQVQxKSkKKHNlbnNpdGl2aXR5IFNFTlMxKQooc2Vu
c2l0aXZpdHlvcmRlciAoU0VOUzEpKQooc2Vuc2l0aXZpdHljYXRlZ29yeSBTRU5TMSAoQ0FUMSkp
CihhbGxvdyBUWVBFMSBzZWxmIChDTEFTUzEgKFBFUk0xKSkpCihyb2xldHlwZSBST0xFMSBUWVBF
MSkKKHVzZXJyb2xlIFVTRVIxIFJPTEUxKQoodXNlcmxldmVsIFVTRVIxIChTRU5TMSkpCih1c2Vy
cmFuZ2UgVVNFUjEgKChTRU5TMSkoU0VOUzEgKENBVDEpKSkpCihzaWRjb250ZXh0IGtlcm5lbCAo
VVNFUjEgUk9MRTEgVFlQRTEgKChTRU5TMSkoU0VOUzEpKSkpCgoodHlwZSB0YSkKKHR5cGUgdGIp
Cih0eXBlIHRjKQoKOyBOb3JtYWwgZmlsZW5hbWUgdHlwZXRyYW5zaXRpb25zCih0eXBldHJhbnNp
dGlvbiB0YSB0YiBDTEFTUzAxICJmaWxlMDEiIHRjKQoodHlwZXRyYW5zaXRpb24gdGEgdGIgQ0xB
U1MwMiAiW2ZpbGUwMl0iIHRjKQoKOyBQcmVmaXggYW5kIFN1ZmZpeCBmaWxlbmFtZSB0eXBldHJh
bnNpdGlvbnMKKHR5cGV0cmFuc2l0aW9uIHRhIHRiIENMQVNTMDMgImZpbGUwMyIgbWF0Y2hfZXhh
Y3QgdGMpCih0eXBldHJhbnNpdGlvbiB0YSB0YiBDTEFTUzA0ICJmaWxlMDQiIG1hdGNoX3ByZWZp
eCB0YykKKHR5cGV0cmFuc2l0aW9uIHRhIHRiIENMQVNTMDUgImZpbGUwNSIgbWF0Y2hfc3VmZml4
IHRjKQo=
--0000000000004bec0c05fd17c5be
Content-Type: application/octet-stream; name="base_01.te"
Content-Disposition: attachment; filename="base_01.te"
Content-Transfer-Encoding: base64
Content-ID: <f_lidmi7p82>
X-Attachment-Id: f_lidmi7p82

Y2xhc3MgQ0xBU1MxCmNsYXNzIENMQVNTMDEKY2xhc3MgQ0xBU1MwMgpjbGFzcyBDTEFTUzAzCmNs
YXNzIENMQVNTMDQKY2xhc3MgQ0xBU1MwNQpjbGFzcyBDTEFTUzA2CnNpZCBrZXJuZWwKY2xhc3Mg
Q0xBU1MxIHsgUEVSTTEgfQpjbGFzcyBDTEFTUzAxIHsgUEVSTTAxIH0KY2xhc3MgQ0xBU1MwMiB7
IFBFUk0wMiB9CmNsYXNzIENMQVNTMDMgeyBQRVJNMDMgfQpjbGFzcyBDTEFTUzA0IHsgUEVSTTA0
IH0KY2xhc3MgQ0xBU1MwNSB7IFBFUk0wNSB9CmNsYXNzIENMQVNTMDYgeyBQRVJNMDYgfQp0eXBl
IFRZUEUxOwphbGxvdyBUWVBFMSBzZWxmIDogQ0xBU1MxIFBFUk0xOwpyb2xlIFJPTEUxOwpyb2xl
IFJPTEUxIHR5cGVzIFRZUEUxOwp1c2VyIFVTRVIxIHJvbGVzIFJPTEUxOwpzaWQga2VybmVsIFVT
RVIxOlJPTEUxOlRZUEUxCg==
--0000000000004bec0c05fd17c5be
Content-Type: application/octet-stream; name="mod_02.te"
Content-Disposition: attachment; filename="mod_02.te"
Content-Transfer-Encoding: base64
Content-ID: <f_lidmica13>
X-Attachment-Id: f_lidmica13

bW9kdWxlIG1vZF8wMiAwLjAuMTsKCnJlcXVpcmUgewoJY2xhc3MgQ0xBU1MwMSB7IFBFUk0wMSB9
OwoJY2xhc3MgQ0xBU1MwMiB7IFBFUk0wMiB9OwoJY2xhc3MgQ0xBU1MwMyB7IFBFUk0wMyB9OwoJ
Y2xhc3MgQ0xBU1MwNCB7IFBFUk0wNCB9OwoJY2xhc3MgQ0xBU1MwNSB7IFBFUk0wNSB9OwoJY2xh
c3MgQ0xBU1MwNiB7IFBFUk0wNiB9Owp9Cgp0eXBlIHRhOwp0eXBlIHRiOwp0eXBlIHRjOwoKdHlw
ZV90cmFuc2l0aW9uIHRhIHRiIDogQ0xBU1MwMSB0YyAiZmlsZTAxIjsKdHlwZV90cmFuc2l0aW9u
IHRhIHRiIDogQ0xBU1MwMiB0YyAiW2ZpbGUwMl0iOwp0eXBlX3RyYW5zaXRpb24gdGEgdGIgOiBD
TEFTUzAzIHRjICJmaWxlMDMiIG1hdGNoX2V4YWN0Owp0eXBlX3RyYW5zaXRpb24gdGEgdGIgOiBD
TEFTUzA0IHRjICJmaWxlMDQiIG1hdGNoX3ByZWZpeDsKdHlwZV90cmFuc2l0aW9uIHRhIHRiIDog
Q0xBU1MwNSB0YyAiZmlsZTA1IiBtYXRjaF9zdWZmaXg7Cg==
--0000000000004bec0c05fd17c5be--
