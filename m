Return-Path: <SRS0=yrd7=PT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50EEDC43444
	for <selinux@archiver.kernel.org>; Fri, 11 Jan 2019 01:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 218C520872
	for <selinux@archiver.kernel.org>; Fri, 11 Jan 2019 01:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="nmWCcgFH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729351AbfAKB7A (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 10 Jan 2019 20:59:00 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37572 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729272AbfAKB67 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 10 Jan 2019 20:58:59 -0500
Received: by mail-lf1-f67.google.com with SMTP id y11so9732452lfj.4
        for <selinux@vger.kernel.org>; Thu, 10 Jan 2019 17:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=biEXveIIWlHYRnTiNlQ6xr1FRYJ4Al3pBDVlp4lnCEY=;
        b=nmWCcgFHln68V/K71WmR/JQwXFjx3RT8L8yjftoRCSy6RSeweS2hKMNRy5weCJb0tl
         SI1Bc1+zIZbYwpYUnonhUhZe+CUXJAfIBg30NSoNcdPvPtmTwRXVUfE4gLULPchZH6/p
         UUadrktGLxxWVhNnQiBL3r16I0wR/93DiJvgDISW4qXIhYqEauvgVv9bFrLox9dORuj1
         71l84ZeKRDxiKXODLzb28Txef36Z7XY2XOb+XRIdGSq7HEnrhC1B0cSdGAktP57+VLuN
         F0jFjd8WaeN8oh4zAMF7d9Jsh7GxKjhTkdArjAZIQxJt0q+zduXQY+zHWgEo5blmWPoG
         x5LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=biEXveIIWlHYRnTiNlQ6xr1FRYJ4Al3pBDVlp4lnCEY=;
        b=Tabh4X7CJMSdWCv/DH9oIJ0Cc1essJ3IZd1zwTlSfAyxLTpXTEnT511wwTl1BOxxaN
         GF1dRrcKKJ0kUzvLrc6ks0UwDy0eWklYNzixf+iKB4i+OnBDGnnvuSTUU1Rahavbrj3p
         FXas+xTIcvCzUAbrjQ6S/tS4zL0+pKuZ+Qo6wDx3VhhpxWkG1jWQTSvaHDUV/+BpjdGB
         bDjrqTygbW6EKoXJvlH8x4fqlPtXsVDyvK37Tpe0ZOTnQ3xY63UZ8Ig+U8yDxeFpMm2D
         ewbAQ+Dogc/7fbSDW2PFGUUM6Erbte3Ke1QXpD/epzgp2Ymhl+M+EE+U5M3ySvx34ies
         YKcg==
X-Gm-Message-State: AJcUukdGakN/Fjd2Bf1JCxLJKcfc9/Cu2p/Jnmz9z60fIaZKCWiSzSo/
        lz5j/D6gZLo1TOoEiDdzFMmML4+yZ+Y6C2L4KM1S
X-Google-Smtp-Source: ALg8bN5riWmItiRrPT+BRNzXK+OMPgRewKUfQn6tBhmnC7tNjZu3FwOq2fNrdWd7aSIS/Bh68BJVs9NNu1CVSk1wbl4=
X-Received: by 2002:a19:6719:: with SMTP id b25mr6594750lfc.38.1547171937741;
 Thu, 10 Jan 2019 17:58:57 -0800 (PST)
MIME-Version: 1.0
References: <20190109091028.24485-1-omosnace@redhat.com> <20190109091028.24485-3-omosnace@redhat.com>
 <f14d46d2-26f3-2c62-963d-7736a82a78b4@tycho.nsa.gov>
In-Reply-To: <f14d46d2-26f3-2c62-963d-7736a82a78b4@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 10 Jan 2019 20:58:46 -0500
Message-ID: <CAHC9VhSzvrkowdOdhkh6yWJLii8_p16CVz=-D7dRfLEhYmzqjQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] selinux: Implement the object_init_security hook
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jan 9, 2019 at 9:38 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 1/9/19 4:10 AM, Ondrej Mosnacek wrote:
> > The hook applies the same logic as selinux_determine_inode_label(), with
> > the exception of the super_block handling, which will be enforced on the
> > actual inodes by other hooks.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>
> Reviewed-by: Stephen Smalley <sds@tycho.nsa.gov>

Looks good to me too.

> > ---
> >   security/selinux/hooks.c | 41 ++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 41 insertions(+)
> >
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 7ce012d9ec51..29c038513504 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -3526,6 +3526,45 @@ static int selinux_inode_copy_up_xattr(const char *name)
> >       return -EOPNOTSUPP;
> >   }
> >
> > +/* file-like object operations */
> > +
> > +/* Used e.g. for kernfs_node for newly created nodes */
> > +static int selinux_object_init_security(void *parent_ctx, u32 parent_ctxlen,
> > +                                     const struct qstr *qstr, u16 mode,
> > +                                     void **ctx, u32 *ctxlen)
> > +{
> > +     const struct task_security_struct *tsec = current_security();
> > +     u32 parent_sid, newsid, clen;
> > +     int rc;
> > +     char *context;
> > +
> > +     rc = security_context_to_sid(&selinux_state, parent_ctx, parent_ctxlen,
> > +                                  &parent_sid, GFP_KERNEL);
> > +     if (rc)
> > +             return rc;
> > +
> > +     if (tsec->create_sid) {
> > +             newsid = tsec->create_sid;
> > +     } else {
> > +             u16 secclass = inode_mode_to_security_class(mode);
> > +
> > +             rc = security_transition_sid(&selinux_state, tsec->sid,
> > +                                          parent_sid, secclass, qstr,
> > +                                          &newsid);
> > +             if (rc)
> > +                     return rc;
> > +     }
> > +
> > +     rc = security_sid_to_context_force(&selinux_state, newsid,
> > +                                        &context, &clen);
> > +     if (rc)
> > +             return rc;
> > +
> > +     *ctx = context;
> > +     *ctxlen = clen;
> > +     return 0;
> > +}
> > +
> >   /* file security operations */
> >
> >   static int selinux_revalidate_file_permission(struct file *file, int mask)
> > @@ -6965,6 +7004,8 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
> >       LSM_HOOK_INIT(inode_copy_up, selinux_inode_copy_up),
> >       LSM_HOOK_INIT(inode_copy_up_xattr, selinux_inode_copy_up_xattr),
> >
> > +     LSM_HOOK_INIT(object_init_security, selinux_object_init_security),
> > +
> >       LSM_HOOK_INIT(file_permission, selinux_file_permission),
> >       LSM_HOOK_INIT(file_alloc_security, selinux_file_alloc_security),
> >       LSM_HOOK_INIT(file_free_security, selinux_file_free_security),
> >
>


-- 
paul moore
www.paul-moore.com
