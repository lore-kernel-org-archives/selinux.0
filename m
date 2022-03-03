Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49156C433F5
	for <selinux@archiver.kernel.org>; Thu,  3 Mar 2022 22:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236849AbiCCW2X (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 3 Mar 2022 17:28:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234471AbiCCW2V (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 3 Mar 2022 17:28:21 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7EADFD15
        for <selinux@vger.kernel.org>; Thu,  3 Mar 2022 14:27:34 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id y2so3818668edc.2
        for <selinux@vger.kernel.org>; Thu, 03 Mar 2022 14:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oKHXsyB04tyrJoKYD+RLcWyJjpgay072O5wpIWtKaKA=;
        b=J1fz7M71dKOpgDo/StLM97I0vmRTW7N5Hrz1DXlgrELKtffMid03VfmO03Xzka4KLN
         GwypvtaVKYwog4l2KSWvnjxc2Xj7Ts6Q58UP0vgELxuvgFmxHcDjAgWE/NeQkWp0YjCc
         HkeVx3ndWVcDRnTJIFVeX16Ot+tTQ6HNu+vHH2/QMp+n6U8H9zfHZEnFezZ31A+xaUum
         1f4gW/NS+6ocPSJBqY7Tz9BTxmWIs4o5aQiRdtnGVs4ltLsvctuovaQxFIhO/4fjYhyO
         EmiFBvT7+m41p45AUzn0xL0QfaYDos5G5FCbalRV8cQOIypFO4vvopekgYZGmACIr0Mp
         odBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oKHXsyB04tyrJoKYD+RLcWyJjpgay072O5wpIWtKaKA=;
        b=UVJt5k2jqWFqklM/n4HtfLWrrkM6KT3AA1jkxkfJlckDUx28oc3KtE3PsEVbJgCyf3
         B5yW6c7gKB9FyFicjgtueAXLoQMpWNTZDATqA8PmgKZxZ1ewCeZ6NKp6PSbTXVjN62dz
         uOiXna+bdziEff/N8ym6K/pJWfeFK6G5QrKgzRe9h/DMcOvamp2767dPN0VAg8Jf/gcA
         xpwvX5DvauB66GPAFiiYTgbNxKxPk99Llupo4OTO8XHtyp74h5rslJWZ/k5Obw4sUjvE
         wDQKvHXAMD608Xwv4+yrxt9ofeGTWFJVoCO2izv0cUsMhfW45S8cY3x6qhBLXrFyJ+d6
         jPXA==
X-Gm-Message-State: AOAM5316ryVdBamq2BUtQ5ZTmuXqOFveTsHa0ywsNsYfBUx3H28FdB+y
        SAXmaLtTmjLleDJBznVgnm0MDmxZQSy5A5h4i0WZ
X-Google-Smtp-Source: ABdhPJx+2FAptwXLjRrLT4R1TUzNt8nfeE3yEvFAt8uEvg5KRUpu7Sf81EPLXtm8CbNiuakfJdr87xEHHjj0U53GUJg=
X-Received: by 2002:a50:fb02:0:b0:40f:bd67:205f with SMTP id
 d2-20020a50fb02000000b0040fbd67205fmr36237709edq.409.1646346453376; Thu, 03
 Mar 2022 14:27:33 -0800 (PST)
MIME-Version: 1.0
References: <20220202235323.23929-1-casey@schaufler-ca.com>
 <20220202235323.23929-25-casey@schaufler-ca.com> <2f32ffa3-7165-f989-b162-4aab162b5027@schaufler-ca.com>
In-Reply-To: <2f32ffa3-7165-f989-b162-4aab162b5027@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 3 Mar 2022 17:27:22 -0500
Message-ID: <CAHC9VhSzaDJX0cxtorH0AvqUzSKsr0BSbhfGtHEJjFKDRWc7oQ@mail.gmail.com>
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

On Wed, Mar 2, 2022 at 5:32 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 2/2/2022 3:53 PM, Casey Schaufler wrote:
> > Add a list for auxiliary record data to the audit_buffer structure.
> > Add the audit_stamp information to the audit_buffer as there's no
> > guarantee that there will be an audit_context containing the stamp
> > associated with the event. At audit_log_end() time create auxiliary
> > records (none are currently defined) as have been added to the list.
> >
> > Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>
> I'm really hoping for either Acks or feedback on this approach.

The only callers that make use of this functionality in this patchset
is in kernel/audit*.c in patches 25/28 and 26/28, yes?

-- 
paul-moore.com
