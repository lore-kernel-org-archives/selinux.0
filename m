Return-Path: <SRS0=LfCf=UQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FCE6C31E5B
	for <selinux@archiver.kernel.org>; Mon, 17 Jun 2019 22:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E646220657
	for <selinux@archiver.kernel.org>; Mon, 17 Jun 2019 22:15:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="t+fWdAO+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbfFQWPd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 17 Jun 2019 18:15:33 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39769 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbfFQWPc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 17 Jun 2019 18:15:32 -0400
Received: by mail-lf1-f68.google.com with SMTP id p24so7723130lfo.6
        for <selinux@vger.kernel.org>; Mon, 17 Jun 2019 15:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c5UIf+bhX+TscweExnBplZZa2iUS4eVkN91TUCyDIjc=;
        b=t+fWdAO+kDytO6Qe2BvENv40nSMghSAZkq/QjTqjeur22v/BBMKMR2T2iwMdgFuCK/
         wL4fe2VCXZMM9bnyZ6OGwplg3xS0ff5gcj3IsH/BpmxTyAJIlE4GVMGvFgeBH0WC6h8B
         4kIv18eoGH+jcMa2iKr08PaRi3yYeLj32DUAdKpPzKLrHKPpTdX9F30IORcnvkGkmHnq
         CTb3nYcsO3Rja53nkvmFYBBsi67iNt1EapUWX5nVD7RPNrV6p/7IFNz3cP1v4DoICSSg
         tAtsAqm78XQx9N/+QnXmtpeDQwOMmd9jJulg0P5RVzzXQFu7wHyys0WZ5jhwSga67MW4
         L8fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c5UIf+bhX+TscweExnBplZZa2iUS4eVkN91TUCyDIjc=;
        b=jKWtUvRInkW3d5FhzPn3UBs8KHSiCySoF08SoHMP5eZRFIQ6UKipcjv04WzSrm1pMr
         6hZ4NGn4wDmzQhdJNs9Zg+C3lyWMwW5c28uMUejqE7exiaEgO1h9OBhI4kE9sO+EAHyE
         JhhLyje72Np6N6lpQMm0qc5nnIJ+tf1gmckl6L8W35/gtcTIobKWetSVyd8+Jsub7pNj
         INaWOWa2W7lq1f/QaWInSwPbYoAvp4FBJEE2IUoWTYqmO3Rtr7n3MYy3I8XbCbvxX4zR
         4En2YIbN40WJ65vcYlSaE6FHsx6iiDqtsFis9iHtXqlbCtpm7DD9KKoz8OFsRkKOjwXX
         RulQ==
X-Gm-Message-State: APjAAAWSD/IbCq4XRqWtBmoNqR+MLt0UtyV+ES0U4xB0rVwSeKqMLpem
        2dWEU23ubtbz7L0+57BsWiO60O7TvtOvy6EVS7GO
X-Google-Smtp-Source: APXvYqzJk1+r3WEYAvcSc4G69gUJrY/Lj0o95tRZ6iNfY9UKCSo0STH+khxu8QVrnuz2PewmDfXmvQA2r6UC6596xrU=
X-Received: by 2002:ac2:410a:: with SMTP id b10mr6357850lfi.175.1560809730743;
 Mon, 17 Jun 2019 15:15:30 -0700 (PDT)
MIME-Version: 1.0
References: <53af233d05da5e07d75d122878387288a10276df.1560447640.git.rgb@redhat.com>
 <CAFqZXNvTAj_MhgbUB0kbQwF+gDQTTO5jXPagQfW9qwfHEzc1iQ@mail.gmail.com>
In-Reply-To: <CAFqZXNvTAj_MhgbUB0kbQwF+gDQTTO5jXPagQfW9qwfHEzc1iQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 17 Jun 2019 18:15:19 -0400
Message-ID: <CAHC9VhRnwnzPikvBg1GaJU30zhj009zN7N8HmM_kt6v8o+8HBg@mail.gmail.com>
Subject: Re: [PATCH ghak57 V1] selinux: format all invalid context as untrusted
To:     Ondrej Mosnacek <omosnace@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Eric Paris <eparis@redhat.com>, Steve Grubb <sgrubb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jun 14, 2019 at 4:05 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Thu, Jun 13, 2019 at 8:43 PM Richard Guy Briggs <rgb@redhat.com> wrote:

...

> > diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> > index cc043bc8fd4c..817576802f7d 100644
> > --- a/security/selinux/ss/services.c
> > +++ b/security/selinux/ss/services.c
> > @@ -1588,6 +1588,8 @@ static int compute_sid_handle_invalid_context(
> >         struct policydb *policydb = &state->ss->policydb;
> >         char *s = NULL, *t = NULL, *n = NULL;
> >         u32 slen, tlen, nlen;
> > +       struct audit_buffer *ab;
> > +       size_t audit_size;
> >
> >         if (context_struct_to_string(policydb, scontext, &s, &slen))
> >                 goto out;
> > @@ -1595,12 +1597,22 @@ static int compute_sid_handle_invalid_context(
> >                 goto out;
> >         if (context_struct_to_string(policydb, newcontext, &n, &nlen))
> >                 goto out;
> > -       audit_log(audit_context(), GFP_ATOMIC, AUDIT_SELINUX_ERR,
> > -                 "op=security_compute_sid invalid_context=%s"
> > -                 " scontext=%s"
> > -                 " tcontext=%s"
> > -                 " tclass=%s",
> > -                 n, s, t, sym_name(policydb, SYM_CLASSES, tclass-1));
> > +       /* We strip a nul only if it is at the end, otherwise the
> > +        * context contains a nul and we should audit that */
> > +       if (n) {
> > +               if (n[nlen - 1] == '\0')
> > +                       audit_size = nlen - 1;
> > +               else
> > +                       audit_size = nlen;
> > +       } else {
> > +               audit_size = 0;
> > +       }
>
> If you reasonably assume that (n == NULL) implies (nlen == 0), then
> you can simplify this down to:
>
>     audit_size = nlen;
>     if (nlen && n[nlen - 1] == '\0')
>         audit_size--;
>
> (or similar), see my recent patch to log *rawcon as untrusted [2].
> That is IMHO faster to parse. But I see you copied it from
> selinux_inode_setxattr(), where it is like this...

You could likely simplify this even further by getting rid of
audit_size and just using nlen; there is no reason why we need to
preserve the original nlen value in this function.  Also, keep in mind
that if you are hitting that chunk of code, and not jumping to "out"
due to a context_struct_to_string() error, then you should have a
properly formatted SELinux label, it just happens to be invalid for
the currently loaded policy.  Something like the following should be
safe:

  if (n[nlen - 1] == '\0')
    nlen--;
  audit_log_start(...);
  audit_log_format("... invalid_context=");
  audit_log_n_untrustedstring(n, nlen);
  audit_log_format(...);
  audit_log_end(...);

Also, to be honest, the string you get back from
context_struct_to_string() is always going to be NUL-terminated so you
could simplify this further:

  audit_log_start(...);
  audit_log_format("... invalid_context=");
  /* no need to record the NUL with untrusted strings */
  audit_log_n_untrustedstring(n, nlen - 1);
  audit_log_format(...);
  audit_log_end(...);

> I'm not sure if it
> is worth changing this patch / consolidating the style across all
> places that do this / creating a helper function...

If anyone is going to look into that, it should be done in a separate patch.

-- 
paul moore
www.paul-moore.com
