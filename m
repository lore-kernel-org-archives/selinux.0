Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66E7C433DB
	for <selinux@archiver.kernel.org>; Thu, 11 Feb 2021 00:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70DDA64E3B
	for <selinux@archiver.kernel.org>; Thu, 11 Feb 2021 00:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbhBKAZz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 10 Feb 2021 19:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbhBKAZy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 10 Feb 2021 19:25:54 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1AAC06174A
        for <selinux@vger.kernel.org>; Wed, 10 Feb 2021 16:25:13 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id l25so7316219eja.9
        for <selinux@vger.kernel.org>; Wed, 10 Feb 2021 16:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RHZyjDLOFDi0ZfkqD61Yg3tZtOTffsyWTFvMKMIBqsk=;
        b=QOgP6URktIoHtmzQTAYppRNvm6zFn6NxboC+4KZJpsB3pxuX3MEWF3Lnf9Q+WxwZ2N
         JjgvdfcoaNoZQrgwcZm/suJd93cwKcrNpKljF/PJf5KEUK6PBufCHbO6bg/6DwGSXAgj
         7uvnK6KMd25eSy+ZgsF/OJu37jp0x/i87n0pH/yNUjCOsEc03FtXoS0DFE9L70cCXH8C
         Ba6zwx2H2cOc5pueHFyGrm7TPMmewIUZf+wdjJ7OJWWr4sgQZ99p5QCF5b5bYGh450uR
         qThsUJ5z58stqZ83AyDD5oHl8w+6AuqUEp5HlGniSR208pplcMWy0ouKOxN7rGwt3hrl
         mLQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RHZyjDLOFDi0ZfkqD61Yg3tZtOTffsyWTFvMKMIBqsk=;
        b=VDgFKGpKbltpvx6iKjx696qclkdgoq4KA1gME/WFYAxqJDbQn2BJKbIxlSl4W2zb2A
         3+YvhmJLPc77a1vAOHyncQ/Ra0f6b7kVE4k0Z9wVDeiw6KTRxUG+Ho2HkEjcMjPicBgI
         gko6A84hCyxy2Fup1QbH0OT2x0v+XzvsvJNKK/zmOza4//EaU7s3iMQLjY7ul0txTgj2
         Q6aG0lFXvsmAl32ijEY4RVtqhT0h16I2PivO6z6rVahlk+LJSSrfdlXUsAw9izrgJlwM
         mpovmRDJCIN07fIWp4/KVRk823aGraJ3h0tHMlHDxM6Tm8p+J5hZ8REfsk+Dd+BUUH7z
         suXQ==
X-Gm-Message-State: AOAM532+uj0P2kqOK23rEE1IFN8pDbt1J9qP98X7PcHYqDE0ZXWfDpkW
        qpb/4CFi4B17eHYIobckxvZGqEo4hdpXj/v7AkGe
X-Google-Smtp-Source: ABdhPJy0a3+FyBRiGWnsDbYetXqlm9kV3kpbG6lLHcGNtYRoztkaWSUQX0snDzneJ/A3OVGRTJdhSedCWBZx1y7huzI=
X-Received: by 2002:a17:906:1199:: with SMTP id n25mr5455044eja.431.1613003112253;
 Wed, 10 Feb 2021 16:25:12 -0800 (PST)
MIME-Version: 1.0
References: <20210129164926.3939-1-nramas@linux.microsoft.com>
In-Reply-To: <20210129164926.3939-1-nramas@linux.microsoft.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 10 Feb 2021 19:25:00 -0500
Message-ID: <CAHC9VhQR7pq3h2ca28SynkRiT7D-aa=EowPkurci8Nug1W=ySQ@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: measure state and policy capabilities
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

On Fri, Jan 29, 2021 at 11:49 AM Lakshmi Ramasubramanian
<nramas@linux.microsoft.com> wrote:
>
> SELinux stores the configuration state and the policy capabilities
> in kernel memory.  Changes to this data at runtime would have an impact
> on the security guarantees provided by SELinux.  Measuring this data
> through IMA subsystem provides a tamper-resistant way for
> an attestation service to remotely validate it at runtime.
>
> Measure the configuration state and policy capabilities by calling
> the IMA hook ima_measure_critical_data().
>
> To enable SELinux data measurement, the following steps are required:
>
>  1, Add "ima_policy=critical_data" to the kernel command line arguments
>     to enable measuring SELinux data at boot time.
>     For example,
>       BOOT_IMAGE=/boot/vmlinuz-5.11.0-rc3+ root=UUID=fd643309-a5d2-4ed3-b10d-3c579a5fab2f ro nomodeset security=selinux ima_policy=critical_data
>
>  2, Add the following rule to /etc/ima/ima-policy
>        measure func=CRITICAL_DATA label=selinux
>
> Sample measurement of SELinux state and policy capabilities:
>
> 10 2122...65d8 ima-buf sha256:13c2...1292 selinux-state 696e...303b
>
> Execute the following command to extract the measured data
> from the IMA's runtime measurements list:
>
>   grep "selinux-state" /sys/kernel/security/integrity/ima/ascii_runtime_measurements | tail -1 | cut -d' ' -f 6 | xxd -r -p
>
> The output should be a list of key-value pairs. For example,
>  initialized=1;enforcing=0;checkreqprot=1;network_peer_controls=1;open_perms=1;extended_socket_class=1;always_check_network=0;cgroup_seclabel=1;nnp_nosuid_transition=1;genfs_seclabel_symlinks=0;
>
> To verify the measurement is consistent with the current SELinux state
> reported on the system, compare the integer values in the following
> files with those set in the IMA measurement (using the following commands):
>
>  - cat /sys/fs/selinux/enforce
>  - cat /sys/fs/selinux/checkreqprot
>  - cat /sys/fs/selinux/policy_capabilities/[capability_file]
>
> Note that the actual verification would be against an expected state
> and done on a separate system (likely an attestation server) requiring
> "initialized=1;enforcing=1;checkreqprot=0;"
> for a secure state and then whatever policy capabilities are actually
> set in the expected policy (which can be extracted from the policy
> itself via seinfo, for example).
>
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> Suggested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Suggested-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/ima.c         | 77 ++++++++++++++++++++++++++++++++--
>  security/selinux/include/ima.h |  6 +++
>  security/selinux/selinuxfs.c   |  6 +++
>  security/selinux/ss/services.c |  2 +-
>  4 files changed, 86 insertions(+), 5 deletions(-)
>
> diff --git a/security/selinux/ima.c b/security/selinux/ima.c
> index 03715893ff97..5c7f73cd1117 100644
> --- a/security/selinux/ima.c
> +++ b/security/selinux/ima.c
> @@ -13,18 +13,73 @@
>  #include "ima.h"
>
>  /*
> - * selinux_ima_measure_state - Measure hash of the SELinux policy
> + * selinux_ima_collect_state - Read selinux configuration settings
>   *
> - * @state: selinux state struct
> + * @state: selinux_state
>   *
> - * NOTE: This function must be called with policy_mutex held.
> + * On success returns the configuration settings string.
> + * On error, returns NULL.
>   */
> -void selinux_ima_measure_state(struct selinux_state *state)
> +static char *selinux_ima_collect_state(struct selinux_state *state)
> +{
> +       const char *on = "=1;", *off = "=0;";
> +       char *buf;
> +       int buf_len, i;
> +
> +       /*
> +        * Size of the following string including the terminating NULL char
> +        *    initialized=0;enforcing=0;checkreqprot=0;
> +        */
> +       buf_len = 42;

It might be safer over the long term, and self-documenting, to do the
following instead:

  buf_len = strlen("initialized=0;enforcing=0;checkreqprot=0;") + 1;

> +       for (i = 0; i < __POLICYDB_CAPABILITY_MAX; i++)
> +               buf_len += strlen(selinux_policycap_names[i]) + 3;

's/3/strlen(on)/' or is that too much?

> +
> +       buf = kzalloc(buf_len, GFP_KERNEL);
> +       if (!buf)
> +               return NULL;
> +
> +       strscpy(buf, "initialized", buf_len);

I wonder if it might be a good idea to add a WARN_ON() to the various
copies, e.g.:

  rc = strXXX(...);
  WARN_ON(rc);

The strscpy/strlcat protections should ensure that nothing terrible
happens with respect to wandering off the end of the string, or
failing to NUL terminate, but they won't catch a logic error where the
string is not allocated correctly (resulting in a truncated buffer).

> +       strlcat(buf, selinux_initialized(state) ? on : off, buf_len);
> +
> +       strlcat(buf, "enforcing", buf_len);
> +       strlcat(buf, enforcing_enabled(state) ? on : off, buf_len);
> +
> +       strlcat(buf, "checkreqprot", buf_len);
> +       strlcat(buf, checkreqprot_get(state) ? on : off, buf_len);
> +
> +       for (i = 0; i < __POLICYDB_CAPABILITY_MAX; i++) {
> +               strlcat(buf, selinux_policycap_names[i], buf_len);
> +               strlcat(buf, state->policycap[i] ? on : off, buf_len);
> +       }
> +
> +       return buf;
> +}

-- 
paul moore
www.paul-moore.com
