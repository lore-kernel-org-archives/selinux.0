Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4526BC433DB
	for <selinux@archiver.kernel.org>; Thu, 18 Feb 2021 22:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F144C64DFD
	for <selinux@archiver.kernel.org>; Thu, 18 Feb 2021 22:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhBRWw2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Feb 2021 17:52:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27139 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229752AbhBRWw0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Feb 2021 17:52:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613688659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0NmuO8Ncz/2Okx8AGpJE+t//bYGbqGxM3FFWVwf0U4g=;
        b=ZSpP48w+Q4XArT72Q7gA/yti10fxEugd2g7x1Ev7bcCaRSx/T/MXsSXQkh6neW2uNlJdia
        9o+VMbpYxi+Q0rwZqLVsB5a8/RUvX0q31sAALRZ2m3MNKdbvsBNwf02/YymCFyyxWvDodp
        gDKficacVQBXKlqdwfVTI9ZGw6MwpFY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-j8oEKShuMqaby3G8E2C8bA-1; Thu, 18 Feb 2021 17:50:57 -0500
X-MC-Unique: j8oEKShuMqaby3G8E2C8bA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9607919611A2;
        Thu, 18 Feb 2021 22:50:56 +0000 (UTC)
Received: from x2.localnet (ovpn-115-136.rdu2.redhat.com [10.10.115.136])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 11D1A60877;
        Thu, 18 Feb 2021 22:50:52 +0000 (UTC)
From:   Steve Grubb <sgrubb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com
Cc:     Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: security_task_getsecid() and subjective vs objective task creds
Date:   Thu, 18 Feb 2021 17:50:51 -0500
Message-ID: <806848326.0ifERbkFSE@x2>
Organization: Red Hat
In-Reply-To: <5f8a424a-2aab-f11a-0e06-f8f075c644f6@schaufler-ca.com>
References: <CAHC9VhSiq5gqY1bfouia4GwYsE9MGGXnUOqwEtHi2u0-1=8aZQ@mail.gmail.com> <5f8a424a-2aab-f11a-0e06-f8f075c644f6@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thursday, February 18, 2021 5:07:52 PM EST Casey Schaufler wrote:
> On 2/18/2021 11:34 AM, Paul Moore wrote:
> > Hi all,
> > 
> > When looking into a problem I noticed that audit was recording the
> > wrong subject label for a process.  Doing a bit of digging I realized
> > this was caused by the SELinux security_task_getsecid() implementation
> > returning the objective security label (taken from task->real_cred),
> > and not the subjective security label (taken from task->cred).
> > 
> > Looking around at the other LSMs which implement this hook, Smack and
> > AppArmor, it appears they both do the same thing: return the objective
> > security ID for the process.  Looking quickly at the various non-LSM
> > callers of the security_task_getsecid() hook, it unfortunately looks
> > like all of them expect the subjective security ID to be returned.
> > The only caller I'm not 100% confident in is binder, but from what I
> > can tell it looks like they are expecting the subjective ID too.
> > 
> > At least we are consistently wrong :)
> 
> We may have come down with a case of helperitis.
> 
> > How do we want to fix this?  The obvious fix is to change the SELinux,
> > AppArmor, and Smack security_task_getsecid() implementations to return
> > the subjective security ID (->cred), and likely make a note in
> > lsm_hooks.h,
> 
> That would be my choice.
> 
> >  but if someone can see a case where we would need both
> > 
> > the subjective and objective security labels speak up and we can
> > introduce a new hook for the subjective label, and likely add a "_obj"
> > to the end of the existing hook to help make it more clear.  If
> > neither of those options are acceptable, we could convert all of the
> > existing callers to use something like the line below (assumes
> > current), but that is the least appealing option as far as I'm
> > concerned.
> > 
> >   security_cred_getsecid(current_cred(), &sid);
> > 
> > Opinions?
> 
> If the objective cred isn't being used in the access control decision
> it seems pointless to add it to the audit record. If there is a case
> where the task is being treated as an object, signal delivery comes to
> mind, you still want the objective credential. So it seems like care
> may be required to ensure that the correct value (sub vs obj) is
> used.

Yes, ptrace, process_vm_readv, process_vm_writev, pidfd_open, 
process_madvise, pidfd_send_signal all seem to operate on a different process 
and might be candidates for an OBJ_PID record which is where it would get 
recorded.

-Steve


