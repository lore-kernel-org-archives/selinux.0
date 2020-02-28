Return-Path: <SRS0=XvAr=4Q=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD54C3F2CD
	for <selinux@archiver.kernel.org>; Fri, 28 Feb 2020 17:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFA4324695
	for <selinux@archiver.kernel.org>; Fri, 28 Feb 2020 17:20:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDW1+mxj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgB1RUr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 28 Feb 2020 12:20:47 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44075 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgB1RUr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 28 Feb 2020 12:20:47 -0500
Received: by mail-oi1-f195.google.com with SMTP id d62so3522011oia.11
        for <selinux@vger.kernel.org>; Fri, 28 Feb 2020 09:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A9Fb/fznksxyrl4Bw6Tl76pBHeca2lFqctxvtfpvHrc=;
        b=CDW1+mxjZodhJLIM3RDZZNzOQRExKCJ2R1ps/045cNjNKoCp0GB2HqDPNUQ4Ro12Sj
         VSxPNe5vtb9bbrC/dHLQf5lqoOgQzQqCqlMFRrn94B5T2q23Q66uGPuZ1KJOc2fwI4sv
         imI5mrpt2cWLjejqDtG+5if0LNxYLTn3t1oa2vZhI712JhtkZFdE0YLcHiiMcj5erqF4
         QsRBvLg0W5AAUcPTYBtQ6dYBQmZapIp9uqdkN0X0nz3q0Q25Olfha/N0K5STBXptnp7J
         M307m9qO7IlT1eb65COotERGBZgMJJguXl1xleULoEfZspYWYfTBvfgjb+fUl4PKaqdM
         lrFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A9Fb/fznksxyrl4Bw6Tl76pBHeca2lFqctxvtfpvHrc=;
        b=CmYWF5q2yCtZUT4ODv1MS1IER1WXHp6gOyeZ3B1nLv4yKAC9Tvz9KK6ZdLzn5twv+H
         JBYCcME4KmNBYMzNpOXUzc42iUoTWnG/hp8FNgHA4HWsfdVyNgPd9s8YO+TznT55cagL
         QKYV54tPV0H3FnuY6LInwH2k1Th+LqUsJCKjcpmUV+sYCYgbJjWmfki8O1QXGfCBArP/
         xZ3IrWjRUqEqoEG1UkK9qfuaFG5t9YUXYRUn0djH+MorGdT7CPZ3D/NgI3wB30akOZiE
         tUYM2AcVJk0o1DS0I2xTx43d6ydvDLol9KiPa+wSr4a8U03HRlEHNpEUb/QcQ9AbHdzo
         MrSQ==
X-Gm-Message-State: APjAAAXGf5bL//LDBwbQl0PXtYSj0ACJznBOoLrglenTzU+IhHIPwG0f
        9Pg/3z/orDgq6qYnHGo5nn81U6vk/8mBTZL11uE=
X-Google-Smtp-Source: APXvYqweEDuxWiMKI8jYKkKo1NocYBJl3pm78AC9oRw5D3NWEGlTcIQAX/S/X8LA/u9lwo1/D2biV5X7HspeMGkC9EA=
X-Received: by 2002:a05:6808:48c:: with SMTP id z12mr3825243oid.92.1582910446367;
 Fri, 28 Feb 2020 09:20:46 -0800 (PST)
MIME-Version: 1.0
References: <20200220181031.156674-1-richard_c_haines@btinternet.com>
 <20200220181031.156674-2-richard_c_haines@btinternet.com> <c5d6ae72-4f5d-fe41-c025-0eaa4616b7eb@tycho.nsa.gov>
 <103614.1582905334@warthog.procyon.org.uk>
In-Reply-To: <103614.1582905334@warthog.procyon.org.uk>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 28 Feb 2020 12:22:04 -0500
Message-ID: <CAEjxPJ576NeKrvopJaUOLqpD_ZnW6Fj9HGeQ6nFxv1CqP0N8dw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] selinux: Add support for new key permissions
To:     David Howells <dhowells@redhat.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Richard Haines <richard_c_haines@btinternet.com>,
        SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 28, 2020 at 10:56 AM David Howells <dhowells@redhat.com> wrote:
>
> Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> > Regardless, we need to revert the original patch and create a new one that
> > addresses the KEY_NEED_PARENT_JOIN issue I mentioned and that adds the
> > key_perms capability in the right place in the first place, not apply a fix on
> > top.
>
> I think the problem is that selinux_key_permission() is munging the new perm
> set into the old perm set and then passing that to avc_has_perm().  Really, we
> need to work backwards if the SELinux policy is described in terms of the old
> perm set.
>
> Is there any way to make that possible?

That's not the problem.  The problem is that security_key_permission()
needs to be passed something (an additional flag or
a different permission) in order to differentiate the two different
callers so that SELinux can support both the old logic (when the
new key_perms capability is disabled) and the new logic (when it is
enabled). The old patch tried to do this by introducing a new
KEY_NEED_PARENT_JOIN permission.  But it didn't expose this as a
KEY_ACE value and therefore creates a conflict/inconsistency
between the ACE permissions and the internal permissions.  Either it
needs to be exposed as a legitimate ACE value too, or
it needs to be handled differently, e.g. as an additional
kernel-internal flag that gets passed down so SELinux can distinguish
them.
