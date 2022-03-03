Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8587BC433EF
	for <selinux@archiver.kernel.org>; Thu,  3 Mar 2022 22:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237063AbiCCWoV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 3 Mar 2022 17:44:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236956AbiCCWoV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 3 Mar 2022 17:44:21 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB41353E2F
        for <selinux@vger.kernel.org>; Thu,  3 Mar 2022 14:43:34 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id r13so13773731ejd.5
        for <selinux@vger.kernel.org>; Thu, 03 Mar 2022 14:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TWFw+stUbp0h5ZUplnGZXcqKL7OaMZQhxn2GjSbt4sI=;
        b=uSbT9KvcAE23tIq3bFpZbDmV981XIVoD3tGyw+sOcblstS+LpuOrybe510PBFV+8UZ
         jhEA71/Op6qVf2h+ZNm8ZIHbrgh8cLGoF/xD1CZHWzhv0obKg+3aSpb0ep+0OJYrdZNt
         C/Ko7e0uKNlTZkKYp9YggjeItMaKc0WTnd7hO9oTIC67Y/RXf8pvBb4TVCT6E/2uLNW5
         JbCg6jQ6eW+qmtblUISE8O4M0AJ5bdtfr3FiGbK/KfW+vIvXDKZhckN7nqeTrVH4Wv0h
         vs+KA/kTX311+3xylWG9ctAzbaGuDpH15dtMFG+ZmR93hQXL+iFi6evSveprF/XcD2Fa
         wCnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TWFw+stUbp0h5ZUplnGZXcqKL7OaMZQhxn2GjSbt4sI=;
        b=dU2FLGix88I/s2VEoNWmGkgkevFSlhhMHHTtyCMwUWbGaA1N62ax4Xe6Tslpo/+Rhv
         7IYJgOPk0XXmaxbrFfODNoIN0SV/ds2rgXJW/4RefisrqObww/7a9Hm5mWcuxqxtJwLJ
         wtJvX5SuNu9STKFk4ufHIXzj8IZN5rh5sA9hUnS28fidKig8DRceNAmHQQCQ4DihC2XH
         gASEDbU5LjhqxC3zjSyMYim+OQt/2CO46AfqN3Bt8nzubKGwxsYKagGXJvwtTcdC6AMq
         6XGrJ9dDcviGbkn7rYZh8/Nv9Hv2WehthggGpg86KfTsLWFSy7Uthuy9WBcrZ2zGkQuQ
         aSKg==
X-Gm-Message-State: AOAM532PKE+twOOpASfcsSQpcHj065dWxkJTpmKepUaRLAesZPu8Q1xt
        dpuZqUDCW9h6OXGxVJoqHKhIJjwzhz+QoQsaLem9
X-Google-Smtp-Source: ABdhPJyZ2zR9c6GT4pMGyrhtPLz/7drjvb5RnVrHg5g/Ud8VvqGRU33CiTiD0tmRvuuTZzsJaC1lBCZ1Cn6NdWO+72A=
X-Received: by 2002:a17:907:216f:b0:6ce:d85f:35cf with SMTP id
 rl15-20020a170907216f00b006ced85f35cfmr29020812ejb.517.1646347413216; Thu, 03
 Mar 2022 14:43:33 -0800 (PST)
MIME-Version: 1.0
References: <20220202235323.23929-1-casey@schaufler-ca.com>
 <20220202235323.23929-25-casey@schaufler-ca.com> <2f32ffa3-7165-f989-b162-4aab162b5027@schaufler-ca.com>
 <CAHC9VhSzaDJX0cxtorH0AvqUzSKsr0BSbhfGtHEJjFKDRWc7oQ@mail.gmail.com> <4e4ef3e2-ab41-12fd-5cd3-77abfc98c6a2@schaufler-ca.com>
In-Reply-To: <4e4ef3e2-ab41-12fd-5cd3-77abfc98c6a2@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 3 Mar 2022 17:43:22 -0500
Message-ID: <CAHC9VhQ1J5jFTSJk-EFkdA-dbsjde7BoXJOX_2ZgL=usrpJ5Eg@mail.gmail.com>
Subject: Re: [PATCH v32 24/28] Audit: Add framework for auxiliary records
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Mar 3, 2022 at 5:33 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 3/3/2022 2:27 PM, Paul Moore wrote:
> > On Wed, Mar 2, 2022 at 5:32 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >> On 2/2/2022 3:53 PM, Casey Schaufler wrote:
> >>> Add a list for auxiliary record data to the audit_buffer structure.
> >>> Add the audit_stamp information to the audit_buffer as there's no
> >>> guarantee that there will be an audit_context containing the stamp
> >>> associated with the event. At audit_log_end() time create auxiliary
> >>> records (none are currently defined) as have been added to the list.
> >>>
> >>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> >> I'm really hoping for either Acks or feedback on this approach.
> > The only callers that make use of this functionality in this patchset
> > is in kernel/audit*.c in patches 25/28 and 26/28, yes?
>
> Yes.

Thanks.  I just wanted to make sure you weren't planning on any
additional callers in a future revision.  I understand that things may
change, but I just wanted to make sure there wasn't already something
pending.

> I think that the container ID record could use it as well.
> I haven't looked deeply, but it should be usable for any aux record type.

Possibly, but I'm intentionally trying to keep that separated at this
stage as the ordering is uncertain.  If/when both bits of
functionality land we can reconcile things as needed; it's all
internal implementation details so we don't have to worry too much
about changing it later.

-- 
paul-moore.com
