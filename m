Return-Path: <SRS0=onaf=UD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4E2C282CE
	for <selinux@archiver.kernel.org>; Tue,  4 Jun 2019 20:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 779B320859
	for <selinux@archiver.kernel.org>; Tue,  4 Jun 2019 20:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559680345;
	bh=S4TVF7E2iuUumroeAZ+UX1mM+MIND0JGN/wS2NYA7x4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Ek6oopi08HmtkjfASVnuoJbAkmfT2RW3B+0+i3Ge4XDY+jU2PHg2CTvpeaGViP1XN
	 pnysgXhBDFyDwi9kFVrpSpt+bajiQsn68rh9rq2IX8iXtiPNGbxnJHxY4fQz5m9Tww
	 AWnyrvkQF7u9kJm+dqWbEFCvL1rEd9yoWrHTQKi4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfFDUcY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 4 Jun 2019 16:32:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:60394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726792AbfFDUcX (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 4 Jun 2019 16:32:23 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7BD320883
        for <selinux@vger.kernel.org>; Tue,  4 Jun 2019 20:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559679979;
        bh=S4TVF7E2iuUumroeAZ+UX1mM+MIND0JGN/wS2NYA7x4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TZBQqTNxxTzP1mGVaees7RCepfLJrDp5RqAlHnL/Ymc/ao63W7bUZ2+GUYPGLR70H
         NfXQhyKCul5pGMw0cZZoSHpg0S1JbeoCbhmSuGPei3w66RYX2/ENL8maMPOo/zBUsi
         cFK3D30x08WNFrS12M+rfNw1TJIvGfAx/SxwGo54=
Received: by mail-wr1-f50.google.com with SMTP id x4so17194033wrt.6
        for <selinux@vger.kernel.org>; Tue, 04 Jun 2019 13:26:18 -0700 (PDT)
X-Gm-Message-State: APjAAAXcGUn4SqjQnL82yUpvKDbG0IdJX9wTdCZxL/8EH8DBTqDS0sTh
        Pf79PzZPS5vG0jbE4KGSy0R6fJoI3fuoBFXcY3QEtA==
X-Google-Smtp-Source: APXvYqwa0ftoy0sMT67Ri2vN0Uz4JEOrVwQyRXQKgM3vFKhn6zeRoO/sOuA5vu06dNe8x+pyx4YNLtPF6kNlT7kOoDU=
X-Received: by 2002:a5d:610e:: with SMTP id v14mr22433987wrt.343.1559679977366;
 Tue, 04 Jun 2019 13:26:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190531233159.30992-1-sean.j.christopherson@intel.com>
 <20190531233159.30992-8-sean.j.christopherson@intel.com> <960B34DE67B9E140824F1DCDEC400C0F654ECC53@ORSMSX116.amr.corp.intel.com>
In-Reply-To: <960B34DE67B9E140824F1DCDEC400C0F654ECC53@ORSMSX116.amr.corp.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 4 Jun 2019 13:26:06 -0700
X-Gmail-Original-Message-ID: <CALCETrVnpFFxNr0=PB9DWqQLeuNoFaa8_iihAcxcQMNrm5ChzA@mail.gmail.com>
Message-ID: <CALCETrVnpFFxNr0=PB9DWqQLeuNoFaa8_iihAcxcQMNrm5ChzA@mail.gmail.com>
Subject: Re: [RFC PATCH 7/9] x86/sgx: Enforce noexec filesystem restriction
 for enclaves
To:     "Xing, Cedric" <cedric.xing@intel.com>
Cc:     "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        Jethro Beekman <jethro@fortanix.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "nhorman@redhat.com" <nhorman@redhat.com>,
        "npmccallum@redhat.com" <npmccallum@redhat.com>,
        "Ayoun, Serge" <serge.ayoun@intel.com>,
        "Katz-zamir, Shay" <shay.katz-zamir@intel.com>,
        "Huang, Haitao" <haitao.huang@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Svahn, Kai" <kai.svahn@intel.com>, Borislav Petkov <bp@alien8.de>,
        Josh Triplett <josh@joshtriplett.org>,
        "Huang, Kai" <kai.huang@intel.com>,
        David Rientjes <rientjes@google.com>,
        "Roberts, William C" <william.c.roberts@intel.com>,
        "Tricca, Philip B" <philip.b.tricca@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Jun 2, 2019 at 11:29 PM Xing, Cedric <cedric.xing@intel.com> wrote:
>
> > From: Christopherson, Sean J
> > Sent: Friday, May 31, 2019 4:32 PM
> >
> > Do not allow an enclave page to be mapped with PROT_EXEC if the source page is backed by a
> > file on a noexec file system.
> >
> > Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> > ---
> >  arch/x86/kernel/cpu/sgx/driver/ioctl.c | 26 ++++++++++++++++++++++++--
> >  1 file changed, 24 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/kernel/cpu/sgx/driver/ioctl.c
> > b/arch/x86/kernel/cpu/sgx/driver/ioctl.c
> > index c30acd3fbbdd..5f71be7cbb01 100644
> > --- a/arch/x86/kernel/cpu/sgx/driver/ioctl.c
> > +++ b/arch/x86/kernel/cpu/sgx/driver/ioctl.c
> > @@ -576,6 +576,27 @@ static int __sgx_encl_add_page(struct sgx_encl *encl, unsigned long
> > addr,
> >       return ret;
> >  }
> >
> > +static int sgx_encl_page_protect(unsigned long src, unsigned long prot,
> > +                              unsigned long *allowed_prot)
> > +{
> > +     struct vm_area_struct *vma;
> > +
> > +     if (!(*allowed_prot & VM_EXEC))
> > +             goto do_check;
> > +
> > +     down_read(&current->mm->mmap_sem);
> > +     vma = find_vma(current->mm, src);
> > +     if (!vma || (vma->vm_file && path_noexec(&vma->vm_file->f_path)))
> > +             *allowed_prot &= ~VM_EXEC;
>
> Testing (vma->vm_flags & VM_MAYEXEC) == 0 should be a better approach.

I think I agree, although that would need a comment explaining why it works.
