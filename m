Return-Path: <SRS0=ReYj=NA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E98ECDE43
	for <selinux@archiver.kernel.org>; Sat, 20 Oct 2018 01:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A00421476
	for <selinux@archiver.kernel.org>; Sat, 20 Oct 2018 01:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dihl8FN4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A00421476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbeJTJN2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 20 Oct 2018 05:13:28 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:32933 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbeJTJN2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 20 Oct 2018 05:13:28 -0400
Received: by mail-ot1-f67.google.com with SMTP id q50so34943496otd.0;
        Fri, 19 Oct 2018 18:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LD8XOidpVS2eZW8x41+5BM6VxFe2Ww6IEayKzSCtTms=;
        b=Dihl8FN4TF9BlfrB5Pe7nykmdOYPXpcx0WhPT4NV5n5UNnYVql24TCaXPWOGkB7+9O
         zrOFiKldxDf55YNH3KV6whKTvsaleW7ZGMbAHRFjQqdn0yhO+Rh36vxv6Cn0JQb2ahbK
         /qArBDrNQ28LfisHW0tLLYNcJ/8x5a2h4j+EveQ1hWzvemuQYgEszQSYBJO/I4Nm1r2Q
         s+aaug8HlYy5MGQr+rSn1w5nACZKgzK6Vm/VMbeWdCPOIPKNqCg+C0BZpJntas0moEx9
         yvPyglAmdPaMbdnbApVA7Sh9fpBI5GimGiY+bhgRIoaSyzeEjdavTNbiam9by0VoQXu3
         qiZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LD8XOidpVS2eZW8x41+5BM6VxFe2Ww6IEayKzSCtTms=;
        b=EtbTVo+9WTFA+Q6FmlL7Q8MOcrPHc6pb3Ye90l9qQ5IFJq1OC0bN8DEkq4aaawB/Cj
         D0UYEz8G3E1I7ZPimxUcv24LXKiviB/1C6cfQdqT6Iciu+r8pJeBViPIOlNP8rQY0Tup
         yySiLdnrHfN+TO1xZcf/TQ02cq379DLLYwkOqX61iAs5j9A3E8Tsk1ErUT95eAWBsOD/
         I4DHbFiAu8behWpl3gWzuDvXg1v23Oh4MlE8XrUuvS0hzqcB8Vnsg/3hz9JEx+wUIzBE
         MEDOqWqTef07JM95DUddffnmKJN1foQuXk8WLOdY3DEPPI6iCBz8IqBLTZ6e5R60Exdd
         yfyA==
X-Gm-Message-State: ABuFfoiOSqA7pan+z5YiLaOCaS7MgGkuA/Xof4opUNy4DdpXIRHl0eNP
        HfxilZwp1gMv6qD91NI0Lv3wwvP0WOoC5y3IhF4=
X-Google-Smtp-Source: ACcGV60VFM2+F6duoo/7AwQmg/b30oEr4P91UKuU8hsZ0lV5W4vux1lNbs/WNfEck0+Wb0YoRpFilOjGhycTBXaIah0=
X-Received: by 2002:a9d:2832:: with SMTP id m47mr22646113otb.109.1539997496124;
 Fri, 19 Oct 2018 18:04:56 -0700 (PDT)
MIME-Version: 1.0
References: <20181018074704.23835-1-omosnace@redhat.com> <45457a65-93f0-b93b-876b-6e9216a8754b@tycho.nsa.gov>
In-Reply-To: <45457a65-93f0-b93b-876b-6e9216a8754b@tycho.nsa.gov>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Fri, 19 Oct 2018 18:04:45 -0700
Message-ID: <CAFftDdqjKgQWSM85B=fm7S5cGa3oER9=cvdYocyVB7tj+K_pog@mail.gmail.com>
Subject: Re: [PATCH v4] selinux: policydb - fix byte order and alignment issues
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     omosnace@redhat.com, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>, stable@vger.kernel.org,
        dledford@redhat.com, selinux <selinux@tycho.nsa.gov>,
        eli@mellanox.com
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Oct 19, 2018 at 7:28 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> On 10/18/2018 03:47 AM, Ondrej Mosnacek wrote:
> > Do the LE conversions before doing the Infiniband-related range checks.
> > The incorrect checks are otherwise causing a failure to load any policy
> > with an ibendportcon rule on BE systems. This can be reproduced by
> > running (on e.g. ppc64):
> >
> > cat >my_module.cil <<EOF
> > (type test_ibendport_t)
> > (roletype object_r test_ibendport_t)
> > (ibendportcon mlx4_0 1 (system_u object_r test_ibendport_t ((s0) (s0))))
> > EOF
> > semodule -i my_module.cil
> >
> > Also, fix loading/storing the 64-bit subnet prefix for OCON_IBPKEY to
> > use a correctly aligned buffer.
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
> >   security/selinux/ss/policydb.c | 46 +++++++++++++++++++++++-----------
> >   1 file changed, 32 insertions(+), 14 deletions(-)
> >
> > Changes in v4:
> >   - defer assignment to 16-bit struct fields to after the range check
> >
> > Changes in v3:
> >   - use separate buffer for the 64-bit subnet_prefix
> >   - add comments on the byte ordering of subnet_prefix
> >   - deduplicate the le32_to_cpu() calls from checks
> >
> > Changes in v2:
> >   - add reproducer to commit message
> >   - update e-mail address of James Morris
> >   - better Cc also the old SELinux ML
> >
> > diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> > index f4eadd3f7350..d50668006a52 100644
> > --- a/security/selinux/ss/policydb.c
> > +++ b/security/selinux/ss/policydb.c
> > @@ -2108,6 +2108,7 @@ static int ocontext_read(struct policydb *p, struct policydb_compat_info *info,
> >   {
> >       int i, j, rc;
> >       u32 nel, len;
> > +     __be64 prefixbuf[1];
> >       __le32 buf[3];
> >       struct ocontext *l, *c;
> >       u32 nodebuf[8];
> > @@ -2217,21 +2218,30 @@ static int ocontext_read(struct policydb *p, struct policydb_compat_info *info,
> >                                       goto out;
> >                               break;
> >                       }
> > -                     case OCON_IBPKEY:
> > -                             rc = next_entry(nodebuf, fp, sizeof(u32) * 4);
> > +                     case OCON_IBPKEY: {
> > +                             u32 pkey_lo, pkey_hi;
> > +
> > +                             rc = next_entry(prefixbuf, fp, sizeof(u64));
> > +                             if (rc)
> > +                                     goto out;
> > +
> > +                             /* we need to have subnet_prefix in CPU order */
> > +                             c->u.ibpkey.subnet_prefix = be64_to_cpu(prefixbuf[0]);
> > +
> > +                             rc = next_entry(buf, fp, sizeof(u32) * 2);
> >                               if (rc)
> >                                       goto out;
> >
> > -                             c->u.ibpkey.subnet_prefix = be64_to_cpu(*((__be64 *)nodebuf));
> > +                             pkey_lo = le32_to_cpu(buf[0]);
> > +                             pkey_hi = le32_to_cpu(buf[1]);
> >
> > -                             if (nodebuf[2] > 0xffff ||
> > -                                 nodebuf[3] > 0xffff) {
> > +                             if (pkey_lo > U16_MAX || pkey_hi > U16_MAX) {
> >                                       rc = -EINVAL;
> >                                       goto out;
> >                               }
> >
> > -                             c->u.ibpkey.low_pkey = le32_to_cpu(nodebuf[2]);
> > -                             c->u.ibpkey.high_pkey = le32_to_cpu(nodebuf[3]);
> > +                             c->u.ibpkey.low_pkey  = pkey_lo;
> > +                             c->u.ibpkey.high_pkey = pkey_hi;
> >
> >                               rc = context_read_and_validate(&c->context[0],
> >                                                              p,
> > @@ -2239,6 +2249,7 @@ static int ocontext_read(struct policydb *p, struct policydb_compat_info *info,
> >                               if (rc)
> >                                       goto out;
> >                               break;
> > +                     }
> >                       case OCON_IBENDPORT:
> >                               rc = next_entry(buf, fp, sizeof(u32) * 2);
> >                               if (rc)
> > @@ -2249,13 +2260,14 @@ static int ocontext_read(struct policydb *p, struct policydb_compat_info *info,
> >                               if (rc)
> >                                       goto out;
> >
> > -                             if (buf[1] > 0xff || buf[1] == 0) {
> > +                             c->u.ibendport.port = le32_to_cpu(buf[1]);
>
> ibendport.port is a u8 here, same issue.

Good catch. Which made me notice this hunk is absent from the
userspace side and the userspace code has the same issue.
If we fix it up here in this patch we should be doing the same in the
libsepol patch.

>
> > +
> > +                             if (c->u.ibendport.port > 0xff ||
> > +                                 c->u.ibendport.port == 0) {
> >                                       rc = -EINVAL;
> >                                       goto out;
> >                               }
> >
> > -                             c->u.ibendport.port = le32_to_cpu(buf[1]);
> > -
> >                               rc = context_read_and_validate(&c->context[0],
> >                                                              p,
> >                                                              fp);
> > @@ -3105,6 +3117,7 @@ static int ocontext_write(struct policydb *p, struct policydb_compat_info *info,
> >   {
> >       unsigned int i, j, rc;
> >       size_t nel, len;
> > +     __be64 prefixbuf[1];
> >       __le32 buf[3];
> >       u32 nodebuf[8];
> >       struct ocontext *c;
> > @@ -3192,12 +3205,17 @@ static int ocontext_write(struct policydb *p, struct policydb_compat_info *info,
> >                                       return rc;
> >                               break;
> >                       case OCON_IBPKEY:
> > -                             *((__be64 *)nodebuf) = cpu_to_be64(c->u.ibpkey.subnet_prefix);
> > +                             /* subnet_prefix is in CPU order */
> > +                             prefixbuf[0] = cpu_to_be64(c->u.ibpkey.subnet_prefix);
> >
> > -                             nodebuf[2] = cpu_to_le32(c->u.ibpkey.low_pkey);
> > -                             nodebuf[3] = cpu_to_le32(c->u.ibpkey.high_pkey);
> > +                             rc = put_entry(prefixbuf, sizeof(u64), 1, fp);
> > +                             if (rc)
> > +                                     return rc;
> >
> > -                             rc = put_entry(nodebuf, sizeof(u32), 4, fp);
> > +                             buf[0] = cpu_to_le32(c->u.ibpkey.low_pkey);
> > +                             buf[1] = cpu_to_le32(c->u.ibpkey.high_pkey);
> > +
> > +                             rc = put_entry(buf, sizeof(u32), 2, fp);
> >                               if (rc)
> >                                       return rc;
> >                               rc = context_write(p, &c->context[0], fp);
> >
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
