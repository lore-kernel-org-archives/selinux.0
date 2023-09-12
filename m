Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB4BCA0ECF
	for <selinux@archiver.kernel.org>; Tue, 12 Sep 2023 03:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbjILDvI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 Sep 2023 23:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjILDvI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 Sep 2023 23:51:08 -0400
Received: from markus.defensec.nl (markus.defensec.nl [IPv6:2a10:3781:2099::123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543A1A4
        for <selinux@vger.kernel.org>; Mon, 11 Sep 2023 20:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=defensec.nl;
        s=default; t=1694490660;
        bh=xyPPTxc5yeADXwM1e6rfR6537pwPtimYPVXA7OQkg5c=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=OMI4vcEJnZqTlq03E7ozaifLRlkPWxWLAeHOxk4aePLkM77nhce49FkWE/hSEI6cV
         9ZPnvozoY4JzNkc4BMEauwgO6+jTqwpddP+b1Ni8BD+qU9v9gjVnoFulW7SPowxW4J
         E0MIk1d/ik9s7QRyY4HbkyZRfX8uoExK/3xqRlU4=
Received: from paulus (unknown [IPv6:2a10:3781:2099:0:67b:cbff:fe2b:1860])
        by markus.defensec.nl (Postfix) with ESMTPSA id 95D2E1959;
        Tue, 12 Sep 2023 05:51:00 +0200 (CEST)
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     Vit Mojzis <vmojzis@redhat.com>
Cc:     selinux@vger.kernel.org
Subject: Re: generating new type name using CIL macro
In-Reply-To: <324bb6b0-3d6c-707d-c0d1-1fdc1f43e845@redhat.com> (Vit Mojzis's
        message of "Mon, 11 Sep 2023 17:42:03 +0200")
References: <324bb6b0-3d6c-707d-c0d1-1fdc1f43e845@redhat.com>
Date:   Tue, 12 Sep 2023 05:50:59 +0200
Message-ID: <87pm2ouk0s.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Vit Mojzis <vmojzis@redhat.com> writes:

> Hello all,
> while trying to recreate some selinux-policy templates using CIL
> macros I got stuck on creating new type/role/attribute names.
> For example consider ssh_role_template [1], which uses its first
> parameter to create a new type $1_ssh_agent_t.
>
> Is there a way to recreate such functionality in a CIL macro (or
> another CIL feature)?

CIL uses blocks for it implementation of templating. If you want to leverage
native CIL then look into blocks.

Example:

cat > mytest.cil <<EOF
(typeattribute foo)

(block t
(blockabstract t)
(type t)
(typeattributeset .foo t))

(block bar
(blockinherit t))

(block baz
(blockinherit t))

(allow .foo .foo (process (signal)))
EOF

sudo semodule -i mytest.cil

seinfo -xafoo

Type Attributes: 1
   attribute foo;
        bar.t
        baz.t

sesearch -A -s foo -ds
allow foo foo:process signal;

>
> Something along the lines of:
> (macro new_type_macro ((string type_prefix))
> =C2=A0 (type (type_prefix)_t)
> )
> which when called (call new_type_macro ("yolo")) would produce
> (type yolo_t)
>
> I searched through CIL reference guide [2] and SELinuxProject CIL wiki
> on github, but didn't find anything close (maybe there is a better
> resource I don't know about).
> I'd appreciate any hints or links to other resources related to CIL macro=
s.
>
> Thank you,
> Vit
>
> [1] -
> https://github.com/TresysTechnology/refpolicy/blob/master/policy/modules/=
services/ssh.if#L301
> [2] -
> https://raw.githubusercontent.com/SELinuxProject/selinux-notebook/main/sr=
c/notebook-examples/selinux-policy/cil/CIL_Reference_Guide.pdf
> [3] - https://github.com/SELinuxProject/cil/wiki#macros
>

--=20
gpg --locate-keys dominick.grift@defensec.nl (wkd)
Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
Dominick Grift
Mastodon: @kcinimod@defensec.nl
