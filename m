Return-Path: <SRS0=xPDW=WE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5141AC433FF
	for <selinux@archiver.kernel.org>; Thu,  8 Aug 2019 16:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 209A02184E
	for <selinux@archiver.kernel.org>; Thu,  8 Aug 2019 16:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="a8+EQTG7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732544AbfHHQam (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 8 Aug 2019 12:30:42 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37132 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731278AbfHHQam (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 8 Aug 2019 12:30:42 -0400
Received: by mail-lf1-f65.google.com with SMTP id c9so67269088lfh.4
        for <selinux@vger.kernel.org>; Thu, 08 Aug 2019 09:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iY8nuKTlngZ6cVx7pjJ+gcI4zt0MUj4vPq7BpastRy8=;
        b=a8+EQTG7BiGxv4u4aTmwJqwb4qnmNsqHUpML7PKh4xM0iB7FR/kSJ8k2dUsVcC2Ejr
         MzB5jtrTwjPkXRXfhG0ZF2flgLpWsRi1Z5prbAhvELkDA72Jvug47tARy5V9GrJTNiy/
         4Rp1K/afNw8XKnP1/9drSPw1ytJqjpp1o5DwGEoyiCr2PnGIBzUTo9be+o7trZuBSucT
         Mi45XtY8PjiWI+OI/PsRXBskkz+JsTP1oMPpz3jwjB60IcMTErNafiUN81ApYszP8Js2
         ncAObqH3h7dHBwVufFQnjjhBDUiXHDWkbCbOgB/eteDvUoDeD0Sgw7Wsi7ZhrM8qfxAc
         OePw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iY8nuKTlngZ6cVx7pjJ+gcI4zt0MUj4vPq7BpastRy8=;
        b=OFR3fIp6q7dBojoprz9FcNRH3LjkzN7sgAssIudYgan5ti4QLy+zZjHiF4T3YglRx5
         Bwc7ujIhNVosUziiZpoF+BP1q/Sjw1PAmQrp5HdaO2+7eARiytv3oYjmc1td2eQzKKpc
         VdhGg59eM/K2w+FVNYJ/VOuZCMGd8xUSBAx+l7PUphd+oIeOdgo0RV+6XKi0jFKx153g
         z2zqZstkdRPq5ezqDmhoJAbj37EI8PdzAgasGJ5U7POoBPQrW08XdmiRrKRzLSrZWJRE
         IPx6/8t30SVmN6AfjgdBm7kiul6ylnWTm4KN+6ZLwZfnrKRdLlqNkUH1hJsjACvYVLJr
         dk6g==
X-Gm-Message-State: APjAAAWmSkxOkhMOiaDXsjTIGrFIuRMCLexNfmHWG5mRdzhHz2Um5GgC
        aV2Mj4uk+/zlLr+QJXefLoug/QmtaRsJZWJJdh5F
X-Google-Smtp-Source: APXvYqwVXF9SRbb6l7UmJ40+7Sy0n+wlkxBLnQUVXaicekRi8iUM4mIz6wJAMn34OZDv5bhMZStPI7lWK//AdVQlLKI=
X-Received: by 2002:ac2:4c37:: with SMTP id u23mr9734454lfq.119.1565281839463;
 Thu, 08 Aug 2019 09:30:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190801144313.1014-1-acgoide@tycho.nsa.gov>
In-Reply-To: <20190801144313.1014-1-acgoide@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 8 Aug 2019 12:30:28 -0400
Message-ID: <CAHC9VhTSWiz45vh+M+sgu+ePwgFPZ4Mr8GmRZQjsGWQSzkjbLg@mail.gmail.com>
Subject: Re: [RFC PATCH v2] security,capability: pass object information to security_capable
To:     Aaron Goidel <acgoide@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        luto@amacapital.net, James Morris <jmorris@namei.org>,
        Stephen Smalley <sds@tycho.nsa.gov>, keescook@chromium.org,
        Serge Hallyn <serge@hallyn.com>, john.johansen@canonical.com,
        casey@schaufler-ca.com, mortonm@chromium.org, rgb@redhat.com,
        Nicholas Franck <nhfran2@tycho.nsa.gov>, linux-audit@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Aug 1, 2019 at 10:43 AM Aaron Goidel <acgoide@tycho.nsa.gov> wrote:
> From: Nicholas Franck <nhfran2@tycho.nsa.gov>
>
> At present security_capable does not pass any object information
> and therefore can neither audit the particular object nor take it
> into account. Augment the security_capable interface to support
> passing supplementary data. Use this facility initially to convey
> the inode for capability checks relevant to inodes. This only
> addresses capable_wrt_inode_uidgid calls; other capability checks
> relevant to inodes will be addressed in subsequent changes. In the
> future, this will be further extended to pass object information for
> other capability checks such as the target task for CAP_KILL.
>
> In SELinux this new information is leveraged here to include the inode
> in the audit message. In the future, it could also be used to perform
> a per inode capability checks.
>
> It would be possible to fold the existing opts argument into this new
> supplementary data structure. This was omitted from this change to
> minimize changes.
>
> Signed-off-by: Nicholas Franck <nhfran2@tycho.nsa.gov>
> Signed-off-by: Aaron Goidel <acgoide@tycho.nsa.gov>
> ---
> v2:
> - Changed order of audit prints so optional information comes second
> ---
>  include/linux/capability.h             |  7 ++++++
>  include/linux/lsm_audit.h              |  5 +++-
>  include/linux/lsm_hooks.h              |  3 ++-
>  include/linux/security.h               | 23 +++++++++++++-----
>  kernel/capability.c                    | 33 ++++++++++++++++++--------
>  kernel/seccomp.c                       |  2 +-
>  security/apparmor/capability.c         |  8 ++++---
>  security/apparmor/include/capability.h |  4 +++-
>  security/apparmor/ipc.c                |  2 +-
>  security/apparmor/lsm.c                |  5 ++--
>  security/apparmor/resource.c           |  2 +-
>  security/commoncap.c                   | 11 +++++----
>  security/lsm_audit.c                   | 21 ++++++++++++++--
>  security/safesetid/lsm.c               |  3 ++-
>  security/security.c                    |  5 ++--
>  security/selinux/hooks.c               | 20 +++++++++-------
>  security/smack/smack_access.c          |  2 +-
>  17 files changed, 110 insertions(+), 46 deletions(-)

You should CC the linux-audit list, I've added them on this mail.

I had hoped to see some thought put into the idea of dynamically
emitting the proper audit records as I mentioned in the previous patch
set, but regardless there are some comments on this code as written
...

> diff --git a/security/lsm_audit.c b/security/lsm_audit.c
> index 33028c098ef3..18cc7c956b69 100644
> --- a/security/lsm_audit.c
> +++ b/security/lsm_audit.c
> @@ -229,9 +229,26 @@ static void dump_common_audit_data(struct audit_buffer *ab,
>         case LSM_AUDIT_DATA_IPC:
>                 audit_log_format(ab, " key=%d ", a->u.ipc_id);
>                 break;
> -       case LSM_AUDIT_DATA_CAP:
> -               audit_log_format(ab, " capability=%d ", a->u.cap);
> +       case LSM_AUDIT_DATA_CAP: {
> +               const struct inode *inode;
> +
> +               audit_log_format(ab, " capability=%d ", a->u.cap_struct.cap);
> +               if (a->u.cap_struct.cad) {
> +                       switch (a->u.cap_struct.cad->type) {
> +                       case CAP_AUX_DATA_INODE: {
> +                               inode = a->u.cap_struct.cad->u.inode;
> +
> +                               audit_log_format(ab, " dev=");
> +                               audit_log_untrustedstring(ab,
> +                                       inode->i_sb->s_id);
> +                               audit_log_format(ab, " ino=%lu",
> +                                       inode->i_ino);
> +                               break;
> +                       }

Since you are declaring "inode" further up, there doesn't appear to be
any need for the CAP_AUX_DATA_INODE braces, please remove them.

The general recommended practice when it comes to "sometimes" fields
in an audit record, is to always record them in the record, but use a
value of "?" when there is nothing relevant to record.  For example,
when *not* recording inode information you would do something like the
following:

  audit_log_format(ab, " dev=? ino=?");

> +                       }
> +               }
>                 break;
> +       }
>         case LSM_AUDIT_DATA_PATH: {
>                 struct inode *inode;
>

-- 
paul moore
www.paul-moore.com
