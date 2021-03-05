Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8543CC433DB
	for <selinux@archiver.kernel.org>; Fri,  5 Mar 2021 01:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53CE565005
	for <selinux@archiver.kernel.org>; Fri,  5 Mar 2021 01:45:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbhCEBpy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 4 Mar 2021 20:45:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhCEBpx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 4 Mar 2021 20:45:53 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C659C061574
        for <selinux@vger.kernel.org>; Thu,  4 Mar 2021 17:45:53 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id lr13so404395ejb.8
        for <selinux@vger.kernel.org>; Thu, 04 Mar 2021 17:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2jQAAzkMyDz9j2A6XfWMQGCSaoR8rT2Fso6F62ldjHg=;
        b=bDqeNAH84+nJyInnN4WTMsRnjdw75/XreazONyhpvGLex+Q0RCII/NWn7wzQUSAu8j
         lfJAChB1VzlvI1Q739ir64e7tn437yxHNo41Jf5+Cne7k/vtuDrE15H749xSV7gv3Gji
         jaKUTTrWzJbIGqtcEOn0/3BBNGIQe6dvikIdNltDqGUVCYq0hyuxcaRZj9WQw/AIjL3s
         2AAz66ATU1T1wKPv/kTZKpbtcfeIfJHwZmmcxmBOssF5QwXTO6Prq1yh6i4/+WNJZIAm
         E6IfP/BFcuPxGprkW96zr4IHthYoFJETpE+7jIu5SpHvE1gJ9i87BH7TZ1tEpTTB63Vi
         Vyww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2jQAAzkMyDz9j2A6XfWMQGCSaoR8rT2Fso6F62ldjHg=;
        b=txOtLDx4PYm+drjRzaqn1UmOYSOdOPuuEnYIP/ygReBt1r/UE5e+f21qfFbAtkEHlW
         X2p23U9TL4pUDqMbinLg64qRX2erHPRfD4W2t7aeX8k7ZFv3C2/pYUwtq5eMuG19sAHb
         VuZp9dsyB3nLqJC7WKLB3p5bl/PU9VgMVm0/12Feu9GAVmSwmIg/vWA07HQhK0DBFQml
         8B5O/25GNE6OIuOcWZshV1NS2LD1QiNTshXn7UA88wlWVC3ygRLMchQFh98r9iGnCMa0
         4SYviwZUIa6eJcjkNyQTsJ54ceZHIiJvDHfRoEwfPgA/oe8xmG9boi/3G2VsTtbffsyS
         BQHw==
X-Gm-Message-State: AOAM532U79oIVl1aqG6g4RY/5BFkXvn994p4uCr7BrhdelUxztNkJJYO
        nC0o0bGmAZDHF3gQ8zyKeCziF7q1GYJG/MdhLq8g
X-Google-Smtp-Source: ABdhPJzL6KN7ohNuopHXUHTY5N50drq9D6Opy/MeC8ZA8MApREWAtEryhlz7TohVEuG0EtSlBqyZ1X6NbT5qGO133Ls=
X-Received: by 2002:a17:906:2bd6:: with SMTP id n22mr271467ejg.91.1614908752118;
 Thu, 04 Mar 2021 17:45:52 -0800 (PST)
MIME-Version: 1.0
References: <20210212163709.3139-1-nramas@linux.microsoft.com> <87273030-2303-e791-4e5d-25373faf0880@linux.microsoft.com>
In-Reply-To: <87273030-2303-e791-4e5d-25373faf0880@linux.microsoft.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 4 Mar 2021 20:45:41 -0500
Message-ID: <CAHC9VhT4pnsFTL3N8pZgrgpqzgCU+Odd4V=SGvTA9QcKAGwasw@mail.gmail.com>
Subject: Re: [PATCH v3] selinux: measure state and policy capabilities
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     zohar@linux.ibm.com,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        tusharsu@linux.microsoft.com, tyhicks@linux.microsoft.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, sashal@kernel.org,
        James Morris <jmorris@namei.org>,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Mar 4, 2021 at 2:20 PM Lakshmi Ramasubramanian
<nramas@linux.microsoft.com> wrote:
> On 2/12/21 8:37 AM, Lakshmi Ramasubramanian wrote:
>
> Hi Paul,
>
> > SELinux stores the configuration state and the policy capabilities
> > in kernel memory.  Changes to this data at runtime would have an impact
> > on the security guarantees provided by SELinux.  Measuring this data
> > through IMA subsystem provides a tamper-resistant way for
> > an attestation service to remotely validate it at runtime.
> >
> > Measure the configuration state and policy capabilities by calling
> > the IMA hook ima_measure_critical_data().
> >
>
> I have addressed your comments on the v2 patch for selinux measurement
> using IMA. Could you please let me know if there are any other comments
> that I need to address in this patch?

The merge window just closed earlier this week, and there were a
handful of bugs that needed to be addressed before I could look at
this patch.  If I don't get a chance to review this patch tonight, I
will try to get to it this weekend or early next week.

-- 
paul moore
www.paul-moore.com
