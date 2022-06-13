Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E072C43334
	for <selinux@archiver.kernel.org>; Mon, 13 Jun 2022 20:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235878AbiFMUy1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 13 Jun 2022 16:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347992AbiFMUw7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 13 Jun 2022 16:52:59 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85483E70
        for <selinux@vger.kernel.org>; Mon, 13 Jun 2022 13:12:29 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id u8so8436776wrm.13
        for <selinux@vger.kernel.org>; Mon, 13 Jun 2022 13:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LOq+BPckvYHQKeGJ0rXgOkEOuJiM+yu8YvLI9pqoBQg=;
        b=qbUZAt+v2CC3Q4p5lcEFp4Xh1PKc/r5H9G7bNEQigUvWNsRWB4MhuO/Ezj6rAtwRO+
         9mxq2US6cR+VK5ELpo/lGOXCy78OLH1Tte5aNJVOG4tYTk0sKdkGGmSJrf9QJPeJu7xq
         a2mnDe8z6Gw/ibphd2lPonjlj8G1gllZSrn+7X3QreVjL5oJL/N1/g0V/JQHoBFNFjeF
         L3ZOnnkwPt1+XHBfbkUf14MLpuDJIx33DbK4PBkMPCSV5lqJT15pIdKLc8WKKPGoAhrG
         zQiGgqA6N42M154UgN1I44grr8G7D7qc2rLsUF6yRkhfkcH5jgl6Aw9HNcA2oteX4aNf
         vQVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LOq+BPckvYHQKeGJ0rXgOkEOuJiM+yu8YvLI9pqoBQg=;
        b=M/jNI1naBs8V87O8t0Tsow+OoEGODhMcU+suQapuQkYBuAk21bRs6qup1rOlqIRLdW
         7RO0Gj5yQHIUjYj8Nn6HUdcgbjprYlztFDgpPl2IBx7t1ZYnVGvpmlksDaV2Lh1d3J5J
         dUsHY3Zkh8DBGf3afKhEESfXnvI8Rl65ktMB59/G8nXMn4lmPVhOwpAw5OcLM1f2mRq5
         fXlah3+UYXhREbBrX6FqXdI/fmRXVM+96tWwxVC0/fFrNI+VZPkNHGYhlmCcasG8dCaD
         fcqzG97BRpteY3VKS3xG+0oTN1Z2xzI1lXHR/bCm7qMpHRu14Rol9WNwJ200J2r77XJH
         j1RQ==
X-Gm-Message-State: AJIora+nG2lrctN++ndvtq6Ol4Bqi5B+3sKq0HcAe/n03TdOwJU+6Gcx
        0ZB0cOfXW/ffdqhkqruz4cLQXKDM7gLnJR4Ivnh/
X-Google-Smtp-Source: AGRyM1tFkfiIW9amUpPXfaCCRQ/xd+Xqwkzg6K5j832uqkVmOJDT5j0HzXP4wx7mJlOsDpCCDoWXKNtJYb1IDHc0cQQ=
X-Received: by 2002:a5d:64e7:0:b0:218:5626:7e7f with SMTP id
 g7-20020a5d64e7000000b0021856267e7fmr1374504wri.245.1655151148059; Mon, 13
 Jun 2022 13:12:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220301041454.18960-1-rdunlap@infradead.org> <CAHC9VhSuzpuEm437SCYC8pf0mU6qdWXRU38sb2+JjVtj-8T4Kw@mail.gmail.com>
 <CAHC9VhSa74OFVV=XcceO12kVOxivm5cnyvBo-yeMbyPT8+t5Kg@mail.gmail.com> <87mtegz7t5.fsf@meer.lwn.net>
In-Reply-To: <87mtegz7t5.fsf@meer.lwn.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 13 Jun 2022 16:12:26 -0400
Message-ID: <CAHC9VhTSzVH+jrYieE8WbRLGgkAR65jDX7qtATuFCQRSX+dSgg@mail.gmail.com>
Subject: Re: [PATCH] docs: selinux: add '=' signs to kernel boot options
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        patches@lists.linux.dev,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jun 13, 2022 at 3:23 PM Jonathan Corbet <corbet@lwn.net> wrote:
> Paul Moore <paul@paul-moore.com> writes:
>
> > I assumed the doc folks would have picked this up but I don't see it
> > in the tree so I'm going to pull it into the selinux/next tree right
> > now.  Thanks again Randy, I'm sorry for the delay.
>
> Sorry, the "doc folks" have learned that, in general, folks in the
> security subsystems prefer to carry their own patches upward, so I
> assumed this one was taken care of.  If you'd rather I picked up SELinux
> documentation patches, I'd be glad to do so.

Hi Jon,

I don't care much either way, as long as Linus' tree is correct I'm
happy.  In this particular case there were no changes under
security/selinux so I assumed that the "doc folks" would merge it; I
have similar assumptions regarding other subsystems when it comes to
SELinux adjacent patches.  However, we all know the old joke about
making assumptions, so I generally keep tracking those patches for a
while and apply them myself if the other subsystems do not.

Generally speaking, if I add an Acked-by for a patch I'm not expecting
to merge that patch (hence the ACK to let the other maintainer know
I'm okay with the patch).  Otherwise I'll merge the patch and send a
reply to the thread that it has been merged into the relevant SELinux
branch.

-- 
paul-moore.com
