Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44771C001B2
	for <selinux@archiver.kernel.org>; Mon, 19 Dec 2022 22:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbiLSWYn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 19 Dec 2022 17:24:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiLSWYm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 19 Dec 2022 17:24:42 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C189B7CC
        for <selinux@vger.kernel.org>; Mon, 19 Dec 2022 14:24:41 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id v13-20020a17090a6b0d00b00219c3be9830so10254089pjj.4
        for <selinux@vger.kernel.org>; Mon, 19 Dec 2022 14:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VAT/DeU4WF68oq7nSs81RA7o2EbEGc7CyHhB3lQLXe4=;
        b=GgGIluoprh00zY/KQJOuCpGQ8xQZ+yMoUwdFW/1pMXkUmgm+gflowLVZAy6RIzO0h8
         sdW3yR0kfA0HA0gH9xYdYKBELdmACUSLvGeRs8O5opcvC5lCkn4uGPhE9zwmT8UkBfte
         jnTuvUdkwAECXCbaqvJ1sdLfa2smauLfvuGywfGkUGHRULbeEv5VdZ3dygx3sMadXR4o
         J6vmHaEVLLVYfBbAMt82VwXzDVKlBbSgOf6U0ko6NTeAUANd8V7SWOqKdvbAx1XaglmY
         Pra0GwFtC5SUmK2iZywxYzYlyOLuPLnyZbYRHB4Jli5FdZecXdRz49X0qX5T1DkwJR94
         C+pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VAT/DeU4WF68oq7nSs81RA7o2EbEGc7CyHhB3lQLXe4=;
        b=2RJcEat44CyxH+NQ2dBCAE4uQ8F/WM0o0Jd6m309jodfRUgGJdi+I6FtJiMXYpRrz/
         dubXToknmrX8psRJ7px+yMxXlkJfxYGcE0yqZdAlihL9a/NzrtbYXjM6W9U5FHbZpaqz
         6fdco43WQnTccLysJNn4gOMa0DTqD7mAssqJSuAKPnV5oo+4PW/ZYFG56ArBhwpAHOFx
         zZVp9g5ROlL6bdgWqQqiCmEmglngLkoFOXm/xrUNEiP/AGjdbrRL1W+oOwaKGV87Zz0j
         mi0JJ8BxjR0oDXTyLxZAewRjEK1d3WuuiHy/QTZwM4/lzQEVq5wnjlf00xli/Ys/5YYF
         RYSg==
X-Gm-Message-State: AFqh2kpqt0Gmjmsu4ZQZB7gcLt5Zn/tI/bAXPQyTl7SeF4sYiF5UGm5Q
        78q0STEutkMYWjNfT5kfKI3DQifSh5y7xXienlJjotu08aPm
X-Google-Smtp-Source: AMrXdXsgvCSuQsV5A3IA7e2nywnPvULN+JePYCpJFFzRUH/F9wNdmrLucNJ4UzmtEMrD+9wKjOAcEMhqw357dWJmEM0=
X-Received: by 2002:a17:90a:6481:b0:221:5597:5de7 with SMTP id
 h1-20020a17090a648100b0022155975de7mr1623054pjj.147.1671488680853; Mon, 19
 Dec 2022 14:24:40 -0800 (PST)
MIME-Version: 1.0
References: <20221219175449.1657640-1-omosnace@redhat.com> <20221219175449.1657640-2-omosnace@redhat.com>
 <fae32a51-d422-d3ea-0bee-6223ca2cf902@schaufler-ca.com>
In-Reply-To: <fae32a51-d422-d3ea-0bee-6223ca2cf902@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 19 Dec 2022 17:24:29 -0500
Message-ID: <CAHC9VhT8TiEFPBFeRXzE6qCyyXjL4rtQc7=iJ+AqeBkkfgw-mA@mail.gmail.com>
Subject: Re: [PATCH 1/2] audit: introduce a struct to represent an audit timestamp
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>,
        selinux@vger.kernel.org,
        Peter Enderborg <peter.enderborg@sony.com>,
        linux-security-module@vger.kernel.org, linux-audit@redhat.com,
        Zdenek Pytela <zpytela@redhat.com>,
        Michal Sekletar <msekleta@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Dec 19, 2022 at 1:47 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 12/19/2022 9:54 AM, Ondrej Mosnacek wrote:
> > Join the two fields that comprise an audit timestamp into a common
> > structure. This will be used further in later commits.
>
> Patch 30/39 of my LSM stacking patchset[1] is almost identical to this.
> The only significant difference is the structure name. You use audit_timestamp
> whereas I use audit_stamp. I believe that audit_stamp is more correct and
> more consistent with the code that uses it.
>
> [1] https://lore.kernel.org/lkml/f6b8ac05-6900-f57d-0daf-02d5ae53bc47@schaufler-ca.com/T/#m3205b98b2a6b21a296fb831ed35892f01ead191f

For the record, if "audit_stamp" and "audit_timestamp" are my only two
options I prefer "audit_stamp" simply because it is shorter :)

That said, see my comments on patch 2/2.  While an audit timestamp
struct improvement such as is proposed here and in the LSM stacking
patchset is fine, I'm not in favor of exposing the audit timestamp
outside the audit subsystem.

-- 
paul-moore.com
