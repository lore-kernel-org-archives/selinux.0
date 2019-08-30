Return-Path: <SRS0=26Hx=W2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE6DC3A5A6
	for <selinux@archiver.kernel.org>; Fri, 30 Aug 2019 21:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C4692343B
	for <selinux@archiver.kernel.org>; Fri, 30 Aug 2019 21:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="X1gvas1I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbfH3Vge (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 30 Aug 2019 17:36:34 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39265 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728053AbfH3Vge (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 30 Aug 2019 17:36:34 -0400
Received: by mail-lj1-f196.google.com with SMTP id j16so1562954ljg.6
        for <selinux@vger.kernel.org>; Fri, 30 Aug 2019 14:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XMZWKko+ASVT2TCnNlqNttXBAJkFIN4ztuF0Hu7LsTw=;
        b=X1gvas1I05qTsw5aRndWhgeH4Sd1K8y15NLruTKX0LLi0JhaMtpud1ERzMvci5sod0
         XtPdY+yepT0CP/gIm+y2XhimptqhGFQD0MxuA0yQRE96uebkXhYlHtOGxm8EFJqoA3Z2
         6UD0lSO1AHGsEGq1RxU+QAtdl2+9k3X0hnwqToiBd9Qbwr0PHnHGHSFx9A5WLdxZUxVZ
         /tlVKIZWrfjgHp0xsLbWH7COEUckRAPQzKErC9pU5btdOgc+7C+Rz8kMKxVihzQIGso9
         BYQl+jQ+gsEHx6Kqa8o3MF/KNOx1xmsUz5wwxUxMBfa2WLL2en+iAmHMazsmXOT1ubAu
         iCNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XMZWKko+ASVT2TCnNlqNttXBAJkFIN4ztuF0Hu7LsTw=;
        b=sugy9iwzFi2r0cJyFc7AOQKhy0TPjUDhKLIQMkDGWOXSroIyyWmdi2oM0flLu17eP5
         bptKgrx0rf8X4v6pP/YglfhQO+Qys9D4XSjJ+m3r9wvIrU6kbZMQgRU7humZAVr8Z8AG
         NmNlOMJXazKriGwWH/itYoN4gztQ7kiWQIUkX0B50ZCZwxGcnk6fs7IbRpwfS4ejfF7f
         GGLdZ3yDWKy0/Fxnc35zjOD6O49QcRYov/FRZ/yESd6a/rFqgPF2lGwW3f0MjSjcQzd0
         yfs1j6bOTg5La9wd+w3gc+UoxuYX9kvKTwuBJF08m2n+EeWEVQIbWfbFLz9gXlUahtNm
         ksnw==
X-Gm-Message-State: APjAAAUEf2nE813Nsg8po9dHnkfINO5LGYwdvGgnZISEIrYN5SItNzrl
        HtDehswIyrJqeOMY7b78ROYtlt1wu/y+VQR9P4Fh
X-Google-Smtp-Source: APXvYqxN58iqSTPhCSXTXwCNYVxXTgrmsQQzuBl6M6p3v3BOy43vHoXsjfgnk4HjmSAUeq/WqHoa7HIAVHKNOFpWmyA=
X-Received: by 2002:a05:651c:1111:: with SMTP id d17mr9362023ljo.87.1567200992082;
 Fri, 30 Aug 2019 14:36:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190815174111.6309-1-acgoide@tycho.nsa.gov> <edfe85bc-108a-f0cb-8678-67dc143284d5@tycho.nsa.gov>
 <c5156aaf-e361-65e6-3ca5-89f17fee54bd@schaufler-ca.com>
In-Reply-To: <c5156aaf-e361-65e6-3ca5-89f17fee54bd@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 30 Aug 2019 17:36:21 -0400
Message-ID: <CAHC9VhQhDQ1TQcdEmTNsgZUgMLWpFm38U1D4GwungW7xPb1X_w@mail.gmail.com>
Subject: Re: [RFC PATCH] audit, security: allow LSMs to selectively enable
 audit collection
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Aaron Goidel <acgoide@tycho.nsa.gov>,
        James Morris <jmorris@namei.org>,
        Serge Hallyn <serge@hallyn.com>, keescook@chromium.org,
        rgb@redhat.com, linux-audit@redhat.com,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Aug 30, 2019 at 11:31 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 8/30/2019 6:44 AM, Stephen Smalley wrote:
> > On 8/15/19 1:41 PM, Aaron Goidel wrote:
> >> Presently, there is no way for LSMs to enable collection of supplemental
> >> audit records such as path and inode information when a permission denial
> >> occurs. Provide a LSM hook to allow LSMs to selectively enable collection
> >> on a per-task basis, even if the audit configuration would otherwise
> >> disable auditing of a task and/or contains no audit filter rules. If the
> >> hook returns a non-zero result, collect all available audit information. If
> >> the hook generates its own audit record, then supplemental audit
> >> information will be emitted at syscall exit.
> >>
> >> In SELinux, we implement this hook by returning the result of a permission
> >> check on the process. If the new process2:audit_enable permission is
> >> allowed by the policy, then audit collection will be enabled for that
> >> process. Otherwise, SELinux will defer to the audit configuration.
> >
> > Any feedback on this RFC patch?  I know Paul provided some thoughts on the general topic of LSM/audit enablement in the other patch thread but I haven't seen any response to this patch.
>
> Audit policy should be independent of security module policy.
> I shouldn't have to change SELinux policy to enable this data
> collection. I should be able to change the audit configuration
> to get this if I want it.

The idea is that the LSM can request that the audit subsystem
selectively enable auditing (per-task, and hopefully per-record-type);
the audit policy can still be configured as you normally.  This is to
work around people (and distros) that disable audit, yet still want to
audit some information (yeah, I know ...).

-- 
paul moore
www.paul-moore.com
