Return-Path: <SRS0=qygk=4C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC8CC2BA83
	for <selinux@archiver.kernel.org>; Fri, 14 Feb 2020 13:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E3FE2187F
	for <selinux@archiver.kernel.org>; Fri, 14 Feb 2020 13:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DkHEhd0B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbgBNN0F (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 14 Feb 2020 08:26:05 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52894 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726191AbgBNN0F (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 14 Feb 2020 08:26:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581686765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yEUsCLFoOq5NEVcQNf9m7a4/gwUsvDbtbeOT7taaHw4=;
        b=DkHEhd0B1PmVT0+0q5lgduPfJQF5HZXqe0cijuMhVydqGLLU+GeRjDYAyrEd4J9btI5Oiy
        id9XeGzUTq/hqWU33TkrNj51GWz1q7gtVJ52vx70wZ0g7APBq68igTUlX50P8s8y0wMeA5
        BdVOdrVwJbVsBChV8l8qNkHGB5gjB0Y=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-iudykKSxNKCAAHzLh5FdSw-1; Fri, 14 Feb 2020 08:25:59 -0500
X-MC-Unique: iudykKSxNKCAAHzLh5FdSw-1
Received: by mail-ot1-f70.google.com with SMTP id e11so5086803otq.1
        for <selinux@vger.kernel.org>; Fri, 14 Feb 2020 05:25:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yEUsCLFoOq5NEVcQNf9m7a4/gwUsvDbtbeOT7taaHw4=;
        b=Jq6sDhD20bxoNd0iKXeJdymbfZn60B0kOTLJvUhKijEmnkvkpqvxTNlHCkRGmZUmUO
         0KDANPSHj3+j0IPaQlJGcJxg815PHMB1H0HPsDvQA3QJq1uF53lK/Ke9zzgiWCU5if9S
         735UWUSel5KMcBa9k5UclYE7RxryvW0CCG9sgq7EfP+dX5JT74WcHRMlRWqx83KcyoeO
         y/0aIbaVNLTRgyPg2majZkJzCV0LKCyPWYlx61+eM/lwPNf9Z6YdZNK59reuwVtdxjfD
         h1XkK3W2ZglF4Bj5Pw+D66cx5Td+lA4jHEYwxyuuz516sj7S15rHMsw6/+XA/4sg0A/d
         lICQ==
X-Gm-Message-State: APjAAAXcJohVP/2RGQpsWY/uWN+Ui4kPWFbFX1zaf5bisGsYKtWJWFgh
        0QYki0tL7wVuUi5a4l+w4wm9X7g57U4RtIW6hAmJxscuQu+Yc+NQLXDltkMYQF8SOXTO72snQtE
        8pewLxFRXctADMLsRoWmr3zgc0serX9xJFA==
X-Received: by 2002:a05:6808:48e:: with SMTP id z14mr1901681oid.26.1581686758577;
        Fri, 14 Feb 2020 05:25:58 -0800 (PST)
X-Google-Smtp-Source: APXvYqxa2Ikve9pW4VvUMSX2v+F9VAiW3zF5aV/yqkhg7C21+lyXJry0jU8ed9kPC2+OH2Q3Wey3BHex0GoI0DqPpvc=
X-Received: by 2002:a05:6808:48e:: with SMTP id z14mr1901674oid.26.1581686758366;
 Fri, 14 Feb 2020 05:25:58 -0800 (PST)
MIME-Version: 1.0
References: <20200129164256.3190-1-sds@tycho.nsa.gov> <CAFqZXNsk_fyPuLDz-jtjtjzJR5rZmBAKgFzPk3Z0y35ahyaeRw@mail.gmail.com>
 <f9f12adf-51b1-3ba5-fef2-f290b69d974e@tycho.nsa.gov>
In-Reply-To: <f9f12adf-51b1-3ba5-fef2-f290b69d974e@tycho.nsa.gov>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 14 Feb 2020 14:25:47 +0100
Message-ID: <CAFqZXNvn-qTDm21hnF-TcQkq79K4w6ghwR5NxgQBwSDL1ryYog@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: remove unused initial SIDs and improve handling
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Paul Moore <paul@paul-moore.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 14, 2020 at 2:22 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 2/14/20 7:46 AM, Ondrej Mosnacek wrote:
> > On Wed, Jan 29, 2020 at 5:42 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> >> Fully decoupling the policy and kernel initial SID values will
> >> require introducing a mapping between them and dyhamically
> >
> > Nit: s/dyhamically/dynamically/
>
> Ah, thanks; will fix if I need to re-spin.
>
> >> -               if (c->sid[0] == SECSID_NULL || c->sid[0] > SECINITSID_NUM) {
> >> -                       pr_err("SELinux:  Initial SID %s out of range.\n",
> >> -                               c->u.name);
> >> +               u32 sid = c->sid[0];
> >> +               const char *name = security_get_initial_sid_context(sid);
> >> +
> >> +               if (sid == SECSID_NULL) {
> >> +                       pr_err("SELinux:  SID null was assigned a context.\n");
> >>                          sidtab_destroy(s);
> >>                          goto out;
> >>                  }
> >
> > Your sentence "Stop treating it as an error if a policy defines
> > additional initial SIDs unknown to the kernel." and the removed check
> > for > SECINITSID_NUM suggest that you intend to not treat this
> > condition as an error, but sidtab_set_initial() called bellow will
> > reject such SID with -ENIVAL. Or am I misreading it and you just
> > wanted to remove the duplicate check?
>
> The comment and if statement below will cause it to ignore any initial
> SIDs unused by the kernel, whether they are ones <= SECINITSID_NUM whose
> names have been dropped and replaced by NULL or ones > SECINITSID_NUM.
> security_get_initial_sid_context() returns NULL for anything >
> SECINITSID_NUM.

Ah yes, it hits the "if (!name) continue;" check, of course... Never mind then.

>
> >
> >> +
> >> +               /* Ignore initial SIDs unused by this kernel. */
> >> +               if (!name)
> >> +                       continue;
> >> +
>

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

