Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842A9C43334
	for <selinux@archiver.kernel.org>; Tue, 28 Jun 2022 21:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiF1VzR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 Jun 2022 17:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiF1VzQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 28 Jun 2022 17:55:16 -0400
Received: from mx1.polytechnique.org (mx1.polytechnique.org [129.104.30.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3791AF1A
        for <selinux@vger.kernel.org>; Tue, 28 Jun 2022 14:55:14 -0700 (PDT)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 9E4625646B1
        for <selinux@vger.kernel.org>; Tue, 28 Jun 2022 23:55:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=m4x.org; s=svoboda;
        t=1656453312; bh=z07A4V0AUoULpVjrLY7zCBDOhEFlJdfChoW6gk8XiHw=;
        h=References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc;
        b=si7xYFCFqVvot95qJZvTqzzmZUS8+X57hVHKO0QOnGsnpw1iCYAeJawNBK50sCU1w
         ihkB2AjNOeqN5OTjhouOtFidgLXT2BKVMQG8hRTYNIQlBqlIWi2qDF108awvUq77KW
         Ub0/oxxQn2yxOqTyjoRPvNTaLBgon7X35+bhH0HA=
Received: by mail-pf1-f176.google.com with SMTP id p14so13213386pfh.6
        for <selinux@vger.kernel.org>; Tue, 28 Jun 2022 14:55:12 -0700 (PDT)
X-Gm-Message-State: AJIora/qAvQWQroVyd9fhgLBPuzQCK7ZQia5YY0au/OQVSd5RWrvqwdY
        CbgBBet5tfIHtvlaeGw0qn13Bejpabu1ZIABdzY=
X-Google-Smtp-Source: AGRyM1ss2JBrsFQ32pIwaSmwkdSOjec6YYgZG9+SHwbeePobc/ETyHRdWd5Ft+LzFvT5H2yj1tfp6RFXo5rYiGLXwUI=
X-Received: by 2002:a05:6a00:170f:b0:525:467c:3516 with SMTP id
 h15-20020a056a00170f00b00525467c3516mr5726773pfc.22.1656453311371; Tue, 28
 Jun 2022 14:55:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220616131409.23271-1-cgzones@googlemail.com> <20220616131409.23271-3-cgzones@googlemail.com>
In-Reply-To: <20220616131409.23271-3-cgzones@googlemail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Tue, 28 Jun 2022 23:54:59 +0200
X-Gmail-Original-Message-ID: <CAJfZ7==WS4NArNjLWG=WMUXqqTKFi4PxhwB9-XhUQHLFu=imAQ@mail.gmail.com>
Message-ID: <CAJfZ7==WS4NArNjLWG=WMUXqqTKFi4PxhwB9-XhUQHLFu=imAQ@mail.gmail.com>
Subject: Re: [RFC PATCH 3/4] libsepol: add compile-time constraint for mutual
 exclusive attributes
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Tue Jun 28 23:55:13 2022 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jun 16, 2022 at 3:14 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Add a new compile-time constraint, similar to neverallow, which enables
> to specify two or more type attributes to be mutual exclusive.  This
> means no type can be associated with more than one of them.
>
> The constraints are stored as a linked-list in the policy for modular
> policies, by a new modular policy version, and are discarded in kernel
> policies, not needing any kernel support.
>
> Some Reference Policy examples:
>
>     unpriv_userdomain, admindomain:
>
>         <no violations>
>
>     client_packet_type, server_packet_type:
>
>         <no violations>
>
>     auth_file_type, non_auth_file_type:
>
>         <no violations>
>
>     pseudofs, xattrfs, noxattrfs:
>
>          <no violations>
>
>     reserved_port_type, unreserved_port_type:
>
>          <no violations>
>
>     security_file_type, non_security_file_type:
>
>         libsepol.check_segregate_attributes: segregate_attributes violate=
d by type dnssec_t associated with attributes security_file_type and non_se=
curity_file_type
>
>     ibendport_type, packet_type, sysctl_type, device_node, ibpkey_type,
>     sysfs_types, domain, boolean_type, netif_type, file_type, node_type,
>     proc_type, port_type:
>
>         libsepol.check_segregate_attributes: segregate_attributes violate=
d by type virt_content_t associated with attributes device_node and file_ty=
pe
>         libsepol.check_segregate_attributes: segregate_attributes violate=
d by type sysctl_fs_t associated with attributes sysctl_type and file_type
>         libsepol.check_segregate_attributes: segregate_attributes violate=
d by type initrc_devpts_t associated with attributes device_node and file_t=
ype
>         libsepol.check_segregate_attributes: segregate_attributes violate=
d by type qemu_image_t associated with attributes device_node and file_type
>         libsepol.check_segregate_attributes: segregate_attributes violate=
d by type user_devpts_t associated with attributes device_node and file_typ=
e
>         libsepol.check_segregate_attributes: segregate_attributes violate=
d by type dockerc_t associated with attributes domain and file_type
>         libsepol.check_segregate_attributes: segregate_attributes violate=
d by type cpu_online_t associated with attributes sysfs_types and file_type
>         libsepol.check_segregate_attributes: segregate_attributes violate=
d by type cardmgr_dev_t associated with attributes device_node and file_typ=
e
>         libsepol.check_segregate_attributes: segregate_attributes violate=
d by type sysctl_t associated with attributes sysctl_type and file_type
>         libsepol.check_segregate_attributes: segregate_attributes violate=
d by type bootloader_tmp_t associated with attributes device_node and file_=
type
>         libsepol.check_segregate_attributes: segregate_attributes violate=
d by type xen_image_t associated with attributes device_node and file_type
>         libsepol.check_segregate_attributes: segregate_attributes violate=
d by type svirt_prot_exec_image_t associated with attributes device_node an=
d file_type
>         libsepol.check_segregate_attributes: segregate_attributes violate=
d by type xen_devpts_t associated with attributes device_node and file_type
>         libsepol.check_segregate_attributes: segregate_attributes violate=
d by type proc_t associated with attributes file_type and proc_type
>         libsepol.check_segregate_attributes: segregate_attributes violate=
d by type sysfs_t associated with attributes sysfs_types and file_type
>         libsepol.check_segregate_attributes: segregate_attributes violate=
d by type proc_xen_t associated with attributes file_type and proc_type
>         libsepol.check_segregate_attributes: segregate_attributes violate=
d by type svirt_image_t associated with attributes device_node and file_typ=
e
>         libsepol.check_segregate_attributes: segregate_attributes violate=
d by type virt_image_t associated with attributes device_node and file_type
>         libsepol.check_segregate_attributes: segregate_attributes violate=
d by type container_file_t associated with attributes device_node and file_=
type
>
>     libsepol.check_assertions: 20 segregate attribute failures occurred
>
> Closes: https://github.com/SELinuxProject/selinux/issues/42
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>


Hello,

Thanks for your patches. This feature seems to be interesting to help
ensuring using a sane policy at compile-time. The example you gave
based on refpolicy clearly show a nice use-case of this feature.

The code looks good and quite simple. It nevertheless lacks some tests
to ensure this feature is implemented in a way which is the intended
one. I know that libsepol/tests/ is probably not the most
developer-friendly test framework, but it can help catch issues caused
by future code refactoring. In order to apply these patches, I would
expect at least a test with a policy which uses some attributes in a
correct way and a test with a policy which triggers a violation.

Moreover, your changes are only about the .te policy compiler and
(unless I missed something) ignore the CIL support. It makes sense for
a feature which mainly targets the Reference Policy, but the issue it
solves can probably also be found in policies written in CIL or in
languages which compile to CIL. Would it make sense to link
segregate_attributes with the CIL compiler too? (I do not have a clear
opinion on this question)

Cheers,
Nicolas

