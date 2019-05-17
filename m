Return-Path: <SRS0=HICo=TR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4F7C04AB4
	for <selinux@archiver.kernel.org>; Fri, 17 May 2019 18:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A0702168B
	for <selinux@archiver.kernel.org>; Fri, 17 May 2019 18:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558116282;
	bh=VajmFIi4cuLIvqMkyBZ/ftEaIqnCUIfCR3EwyJx4A1Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=l+GLClv50eaZBmjK3OOkhhM7iC5nyyHcMYMaAIcKskKdg4/Fp0GCCeNhaS3nQvPx9
	 /c62ETlRBWB6n/L1DAGOF3jEb7KwoXquBmLVCJO1m+LfXKhSU7NmhmORK/bQ3IASco
	 bSyNVM/d0zeZHvyYIZrH2FJafVUugmCTMsHA5sSI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbfEQSEm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 17 May 2019 14:04:42 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34011 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbfEQSEl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 17 May 2019 14:04:41 -0400
Received: by mail-lf1-f65.google.com with SMTP id v18so5982999lfi.1
        for <selinux@vger.kernel.org>; Fri, 17 May 2019 11:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GqLsKGWePcHeYkjL6WcpBkvnp3m99gvexZby0QRo7VY=;
        b=FLSkmQlUFMZbLyvTJKsJsbzUTzwJ007awR+MJFBzBBIfeyUsLSpio9pw1egk8rl+1T
         GED5nIz0MTZm4wj6hHTQGkolwiBKx+3k5poKvYAAORvXGNs8I19OUvhU2aPU09ae6kVb
         04zIZrSmhGYDYVb200BkHqJrTSJZ0aDJZNgqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GqLsKGWePcHeYkjL6WcpBkvnp3m99gvexZby0QRo7VY=;
        b=D0d0QtgzsRoRwBYAWNsBnd2X7SS6zrBE0H2hm9eYATssg5e9Qy25cXNS0zf+z2uxMs
         5jKGPsK4O8q/eoJwM6n3GRgP/6MpesIApSDW6GijSo52m8Dbf0lQ2XpjM1bhTtF4xKD9
         du0SPk5F1iwd+YXq9XDSo47KxzRReyh+lu6CFzZ+2otFe/IOu4UICFfuQzd+9/c/oGke
         fgGjDd+ydRRWrpMDiosG/H33fgzULvXm6BjqWjEkcHzeBbC+e4U/0ef6RHi52xo1kSOn
         FTxwxFF6ykb+KnP4z0pYFBwFNW4AfClVNGSpw862RDIMOftCkRSuSRk2201CKAR6t7Jx
         k1sg==
X-Gm-Message-State: APjAAAUT89+tLBLmSh5MNwXOW2GyTB5haqJI5Vzlz4GOVVXXI3EVhJz1
        7k3GqHge6GhtIkZXtwM1mGWsAcC4yXk=
X-Google-Smtp-Source: APXvYqycQ9v86334x+Or0IUTaDSebCL4n2F6Qv4EvuKs98shrB90884TDP4xWBT3F8d1Vy/YoBjYxQ==
X-Received: by 2002:a05:6512:206:: with SMTP id a6mr29695596lfo.18.1558116279805;
        Fri, 17 May 2019 11:04:39 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id h11sm1792834lfh.8.2019.05.17.11.04.39
        for <selinux@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 11:04:39 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id h13so5956632lfc.7
        for <selinux@vger.kernel.org>; Fri, 17 May 2019 11:04:39 -0700 (PDT)
X-Received: by 2002:ac2:59c7:: with SMTP id x7mr24467304lfn.75.1558116278802;
 Fri, 17 May 2019 11:04:38 -0700 (PDT)
MIME-Version: 1.0
References: <CALCETrX2ovRx3Rre+1_xC-q6CiybyLjQ-gmB4FZF_qCZ-Qd+4A@mail.gmail.com>
 <960B34DE67B9E140824F1DCDEC400C0F654E38CD@ORSMSX116.amr.corp.intel.com>
 <CALCETrUfmyQ7ivNzQic0FyPXe1fmAnoK093jnz0i8DRn2LvdSA@mail.gmail.com>
 <960B34DE67B9E140824F1DCDEC400C0F654E3FB9@ORSMSX116.amr.corp.intel.com>
 <6a97c099-2f42-672e-a258-95bc09152363@tycho.nsa.gov> <20190517150948.GA15632@linux.intel.com>
 <ca807220-47e2-5ec2-982c-4fb4a72439c6@tycho.nsa.gov> <80013cca-f1c2-f4d5-7558-8f4e752ada76@tycho.nsa.gov>
 <20190517172953.GC15006@linux.intel.com> <DFE03E0C-694A-4289-B416-29CDC2644F94@amacapital.net>
 <20190517175500.GE15006@linux.intel.com>
In-Reply-To: <20190517175500.GE15006@linux.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 17 May 2019 11:04:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgH2FBzBG3_RZSuatpYCj8DCQZipJYp9vh3Wy_S3Qt4-g@mail.gmail.com>
Message-ID: <CAHk-=wgH2FBzBG3_RZSuatpYCj8DCQZipJYp9vh3Wy_S3Qt4-g@mail.gmail.com>
Subject: Re: SGX vs LSM (Re: [PATCH v20 00/28] Intel SGX1 support)
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "Xing, Cedric" <cedric.xing@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jethro Beekman <jethro@fortanix.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Dr. Greg" <greg@enjellic.com>,
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
        David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 17, 2019 at 10:55 AM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> In this snippet, IS_PRIVATE() is true for anon inodes, false for
> /dev/sgx/enclave.  Because EPC memory is always shared, SELinux will never
> check PROCESS__EXECMEM for mprotect() on/dev/sgx/enclave.

Why _does_ the memory have to be shared? Shared mmap() is
fundamentally less secure than private mmap, since by definition it
means "oh, somebody else has access to it too and might modify it
under us".

Why does the SGX logic care about things like that? Normal executables
are just private mappings of an underlying file, I'm not sure why the
SGX interface has to have that shared thing, and why the interface has
to have a device node in the first place when  you have system calls
for setup anyway.

So why don't the system calls just work on perfectly normal anonymous
mmap's? Why a device node, and why must it be shared to begin with?

                  Linus
