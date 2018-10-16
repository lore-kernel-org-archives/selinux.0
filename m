Return-Path: <SRS0=LxTM=M4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE423C04EBD
	for <selinux@archiver.kernel.org>; Tue, 16 Oct 2018 14:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A682F205C9
	for <selinux@archiver.kernel.org>; Tue, 16 Oct 2018 14:19:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A682F205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbeJPWKF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 16 Oct 2018 18:10:05 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45666 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbeJPWKF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 16 Oct 2018 18:10:05 -0400
Received: by mail-ot1-f65.google.com with SMTP id u22so22649596ota.12
        for <selinux@vger.kernel.org>; Tue, 16 Oct 2018 07:19:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gf7RmK2fMQyHp9LRvGTvGrUWfpRjxMSAc74/+ysz738=;
        b=dB+ibwxvpDNLSktsZcP60IYE0hnqtmwDZlF+ellMI/fesN2KEtPaKKMxhpXBUfHa25
         gxFDYidqFHvHHe3HbI4ft3c+dFgFnwEPFyZjIli9aV1dswRVFCP2noymo8FzwaF6cP2c
         zjthRXLa187yhuhUyKoD9FF2TvS10t5CcFQM90/2UGk9xfrPbXFxKMj4TFg+3y/sKhkE
         VIlY/SsSLuaVLjnBvWbcr86SyLOMnKB04jpzFsppfOfwyH7aWw2K6MQTbxS1TbldNsfG
         m8sMw5QcoCE2OpsgfC9p+GOW/qp0adixaFk8KjQ/CRGIQk771i7D7pJlzwu4At8dU/eF
         79Qg==
X-Gm-Message-State: ABuFfogzldF51dPuMrGEzn1dukc8c1EzSS/P1l2F8c7Hfj/Uo18TJRni
        YRDlutQcBizw0bnJuvwdoI9ha9pWRidzqexMD0lx/A==
X-Google-Smtp-Source: ACcGV63LKO7ExVuoIud08S5NMDeD3rG5zz+hhrxT1/qfazKUQo6xQsXNr3VTL+233kGnqvhIIaEKCrhAc4GSZLkQuIk=
X-Received: by 2002:a9d:6387:: with SMTP id w7mr13155895otk.250.1539699563743;
 Tue, 16 Oct 2018 07:19:23 -0700 (PDT)
MIME-Version: 1.0
References: <20181016070917.5530-1-omosnace@redhat.com> <759badb4-86fe-03b3-7bf6-0f4ff12e7026@tycho.nsa.gov>
In-Reply-To: <759badb4-86fe-03b3-7bf6-0f4ff12e7026@tycho.nsa.gov>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 16 Oct 2018 16:19:11 +0200
Message-ID: <CAFqZXNtYY5z_XHxsAmKax-pHS5B+H329OfHHO8nphuYLpDzQiQ@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: fix byte order and alignment issues in policydb.c
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        SElinux list <selinux@tycho.nsa.gov>,
        Daniel Jurgens <danielj@mellanox.com>,
        Eli Cohen <eli@mellanox.com>, James Morris <jmorris@namei.org>,
        Doug Ledford <dledford@redhat.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Oct 16, 2018 at 2:53 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 10/16/2018 03:09 AM, Ondrej Mosnacek wrote:
> > Add missing LE conversions to the Infiniband-related range checks. These
> > were causing a failure to load any policy with an ibendportcon rule on
> > BE systems. This can be reproduced by running:
> >
> > cat >my_module.cil <<EOF
> > (type test_ibendport_t)
> > (roletype object_r test_ibendport_t)
> > (ibendportcon mlx4_0 1 (system_u object_r test_ibendport_t ((s0) (s0))))
> > EOF
> > semodule -i my_module.cil
> >
> > (On ppc64 it fails with "/sbin/load_policy:  Can't load policy: Invalid
> > argument")
> >
> > Also, the temporary buffers are only guaranteed to be aligned for 32-bit
> > access so use (get/put)_unaligned_be64() for 64-bit accesses.
> >
> > Finally, do not use the 'nodebuf' (u32) buffer where 'buf' (__le32)
> > should be used instead.
> >
> > Tested internally on a ppc64 machine with a RHEL 7 kernel with this
> > patch applied.
> >
> > Cc: Daniel Jurgens <danielj@mellanox.com>
> > Cc: Eli Cohen <eli@mellanox.com>
> > Cc: James Morris <jmorris@namei.org>
> > Cc: Doug Ledford <dledford@redhat.com>
> > Cc: <stable@vger.kernel.org> # 4.13+
> > Fixes: a806f7a1616f ("selinux: Create policydb version for Infiniband support")
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >   security/selinux/ss/policydb.c | 28 +++++++++++++++-------------
> >   1 file changed, 15 insertions(+), 13 deletions(-)
> >
> > Changes in v2:
> >   - add reproducer to commit message
> >   - update e-mail address of James Morris
> >   - better Cc also the old SELinux ML
> >
> > diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> > index f4eadd3f7350..2b310e8f2923 100644
> > --- a/security/selinux/ss/policydb.c
> > +++ b/security/selinux/ss/policydb.c
> > @@ -37,6 +37,7 @@
> >   #include <linux/errno.h>
> >   #include <linux/audit.h>
> >   #include <linux/flex_array.h>
> > +#include <asm/unaligned.h>
> >   #include "security.h"
> >
> >   #include "policydb.h"
> > @@ -2108,7 +2109,7 @@ static int ocontext_read(struct policydb *p, struct policydb_compat_info *info,
> >   {
> >       int i, j, rc;
> >       u32 nel, len;
> > -     __le32 buf[3];
> > +     __le32 buf[4];
> >       struct ocontext *l, *c;
> >       u32 nodebuf[8];
> >
> > @@ -2218,20 +2219,20 @@ static int ocontext_read(struct policydb *p, struct policydb_compat_info *info,
> >                               break;
> >                       }
> >                       case OCON_IBPKEY:
> > -                             rc = next_entry(nodebuf, fp, sizeof(u32) * 4);
> > +                             rc = next_entry(buf, fp, sizeof(u32) * 4);
> >                               if (rc)
> >                                       goto out;
> >
> > -                             c->u.ibpkey.subnet_prefix = be64_to_cpu(*((__be64 *)nodebuf));
> > +                             c->u.ibpkey.subnet_prefix = get_unaligned_be64(buf);
> >
> > -                             if (nodebuf[2] > 0xffff ||
> > -                                 nodebuf[3] > 0xffff) {
> > +                             if (le32_to_cpu(buf[2]) > 0xffff ||
> > +                                 le32_to_cpu(buf[3]) > 0xffff) {
> >                                       rc = -EINVAL;
> >                                       goto out;
> >                               }
> >
> > -                             c->u.ibpkey.low_pkey = le32_to_cpu(nodebuf[2]);
> > -                             c->u.ibpkey.high_pkey = le32_to_cpu(nodebuf[3]);
> > +                             c->u.ibpkey.low_pkey = le32_to_cpu(buf[2]);
> > +                             c->u.ibpkey.high_pkey = le32_to_cpu(buf[3]);
>
> I'm wondering why the handling here is inconsistent with that of
> OCON_NODE/OCON_NODE6, which also deals with network byte order / big
> endian data.

I believe OCON_NODE/OCON_NODE6 doesn't call be32_to_cpu() because the
kernel code probably expects those values to be in the "network
order", in the sense that when you call ntohl() (basically an alias
for be32_to_cpu()) on them, then you get a value where the low bytes
are actually in the low bits of the integer. There are comments that
seem to be intended as a justification doing this. Perhaps the
subnet_prefix has different semantics, perhaps not...

> Also it is inconsistent with the corresponding userspace
> code in libsepol for IBPKEY, which just does a memcpy() for copying
> between the subnet_prefix and the buffer.

Hm... indeed, the userspace code doesn't match here. Now noone really
knows which of them has the intended format... this is a mess :/

>
> Switching to buf entirely doesn't seem right since it is __le32 and the
> first part is actually __be64.

That's why I switched to using get/put_unaligned_be64() there. Now the
first two elements are just treated as some eight bytes of memory, so
it doesn't matter what type they are. The only issue with the
unaligned accessors might be perfomance, but I don't think this part
of code is that performance critical. Anyway, maybe I'm just trying
too hard to avoid declaring a yet another buf there :)

>
> Maybe we ought to be splitting this into two next_entry() calls, one to
> fetch the be64 subnet prefix into an appropriately aligned and typed
> buffer and one to fetch the le32 low/high pkey values into buf?

Yeah, that's probably the right way to do it, but I was too lazy to
check what next_entry() does and I wasn't sure if splitting the call
wouldn't break something.

>
> We also need to fix the libsepol code
> (selinux/libsepol/src/policydb.c:ocontext_read_selinux) for the validity
> check at least.

Yes, there are similar bugs there as well...

>
> >
> >                               rc = context_read_and_validate(&c->context[0],
> >                                                              p,
> > @@ -2249,7 +2250,8 @@ static int ocontext_read(struct policydb *p, struct policydb_compat_info *info,
> >                               if (rc)
> >                                       goto out;
> >
> > -                             if (buf[1] > 0xff || buf[1] == 0) {
> > +                             if (le32_to_cpu(buf[1]) > 0xff ||
> > +                                 le32_to_cpu(buf[1]) == 0) {
> >                                       rc = -EINVAL;
> >                                       goto out;
> >                               }
> > @@ -3105,7 +3107,7 @@ static int ocontext_write(struct policydb *p, struct policydb_compat_info *info,
> >   {
> >       unsigned int i, j, rc;
> >       size_t nel, len;
> > -     __le32 buf[3];
> > +     __le32 buf[4];
> >       u32 nodebuf[8];
> >       struct ocontext *c;
> >       for (i = 0; i < info->ocon_num; i++) {
> > @@ -3192,12 +3194,12 @@ static int ocontext_write(struct policydb *p, struct policydb_compat_info *info,
> >                                       return rc;
> >                               break;
> >                       case OCON_IBPKEY:
> > -                             *((__be64 *)nodebuf) = cpu_to_be64(c->u.ibpkey.subnet_prefix);
> > +                             put_unaligned_be64(c->u.ibpkey.subnet_prefix, buf);
> >
> > -                             nodebuf[2] = cpu_to_le32(c->u.ibpkey.low_pkey);
> > -                             nodebuf[3] = cpu_to_le32(c->u.ibpkey.high_pkey);
> > +                             buf[2] = cpu_to_le32(c->u.ibpkey.low_pkey);
> > +                             buf[3] = cpu_to_le32(c->u.ibpkey.high_pkey);
> >
> > -                             rc = put_entry(nodebuf, sizeof(u32), 4, fp);
> > +                             rc = put_entry(buf, sizeof(u32), 4, fp);
> >                               if (rc)
> >                                       return rc;
> >                               rc = context_write(p, &c->context[0], fp);
> >
>
> Likewise this doesn't seem consistent with the OCONTEXT_NODE/NODE6
> handling here or the libsepol ocontext_write_selinux code for
> OCON_IBPKEY.  We could also split this into two put_entry() calls to
> preserve the typing separation between the be64 and le32 data.

See above.

I will try to investigate the IBKEY inconsistency and fix it. In the
meantime I should probably split off the checks fixes into a separate
patch and re-send it (plus replicate them upstream). Stay tuned...

--
Ondrej Mosnacek <omosnace at redhat dot com>
Associate Software Engineer, Security Technologies
Red Hat, Inc.
