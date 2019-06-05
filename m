Return-Path: <SRS0=z8TV=UE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF50C28D18
	for <selinux@archiver.kernel.org>; Wed,  5 Jun 2019 20:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 477A120872
	for <selinux@archiver.kernel.org>; Wed,  5 Jun 2019 20:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="cmnRJyjY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfFEUOH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 5 Jun 2019 16:14:07 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46344 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbfFEUOH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 5 Jun 2019 16:14:07 -0400
Received: by mail-pg1-f194.google.com with SMTP id v9so12988556pgr.13
        for <selinux@vger.kernel.org>; Wed, 05 Jun 2019 13:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=znk5vD5rMbn5z4a3+WKbn3kzpOM9HaH0Z0fJiM8Yq8Y=;
        b=cmnRJyjY3QFQ+BQOSejlOb1DI3VR7qg0TxLdoYYyAOnIePiy2kqrOVzKDPJKqyKt9q
         6q6cFyKC3bXadxZhDLpIDnTiAj8qBNzlGCp37zCdo1f6DCz1Pm3E2QJGiuEr6GohiQn+
         Vr98wk6xFFOxQ30tZJaRSGuwppW7Qtx7FFdY0fNjUohl14NwFJNhUVubaWb2DCq6mNWh
         k/b5SlOspVX9Czxbn2EeK2gY+egCxGLPlimc5AjRPkJ5g5YN2ALuFTsFJgULIkd8aurI
         DcuI0FhRG8rGZm95wu9C/ee/tWCwSl6UO3MZ8pJFxkXgv9nFwH56xau/aFS4XvtaKP9V
         Qx1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=znk5vD5rMbn5z4a3+WKbn3kzpOM9HaH0Z0fJiM8Yq8Y=;
        b=DX1+d7hFfH2nsNTp3Z98kTMprPKnc2NZ8SHSOJXAYc6TCZRXsPVo+Y0ZVPv5ZxB+0n
         5t3oByXxpBYUmZoAueBpXakW6SFdxgz3hOlJJ156Xa7P6CSyTd3b00YxKoy0awUGyLKo
         oNj9lnYNrK7BeZxgOfXk1n+ceP99vi6TbEs7deQ2C4Vfoqp3nmAjiwT99OJkbiHchbRT
         C1syJDFO7/TZp9Uz8Ao+3GnNi7Ze2/IOixLHmAg7cknNk1/IPrgCWoKkL+ntrIItJvDf
         A9fJvCoT/VYt12MMHP2NqRZVbHqWSkzG3ACmzHw43qkD3mfG4eb+5wJh7hfBtjt61BRV
         LbxA==
X-Gm-Message-State: APjAAAUQv8oPnu2w+yOaia10i00SjvwaMypmjeWCuXvIYIRH2CpkpqN2
        rk4PuQ/IVJhPmiy8XfBBbwsA3Q==
X-Google-Smtp-Source: APXvYqwkFteFZdFh9mxUp8CCyQXSglviTfuR92Oyp0Kt3F6L2PL4pyQvZRQ6L94JnZ7YLK0WWCrYRw==
X-Received: by 2002:a17:90a:8409:: with SMTP id j9mr47854496pjn.2.1559765646373;
        Wed, 05 Jun 2019 13:14:06 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:31dd:a2eb:ca:4a50? ([2601:646:c200:1ef2:31dd:a2eb:ca:4a50])
        by smtp.gmail.com with ESMTPSA id c6sm42250854pfm.163.2019.06.05.13.14.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 13:14:05 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH 2/9] x86/sgx: Do not naturally align MAP_FIXED address
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16F203)
In-Reply-To: <20190605151653.GK11331@linux.intel.com>
Date:   Wed, 5 Jun 2019 13:14:04 -0700
Cc:     "Xing, Cedric" <cedric.xing@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
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
Content-Transfer-Encoding: quoted-printable
Message-Id: <5A85C1D7-A159-437E-B42A-3F4254E07305@amacapital.net>
References: <20190531233159.30992-1-sean.j.christopherson@intel.com> <20190531233159.30992-3-sean.j.christopherson@intel.com> <20190604114951.GC30594@linux.intel.com> <CALCETrVe0jhAWAFmx+NFEjJcijSJv2LDVC7cUXi0w99kNKjh_g@mail.gmail.com> <960B34DE67B9E140824F1DCDEC400C0F654EDBDE@ORSMSX116.amr.corp.intel.com> <20190605151653.GK11331@linux.intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org



> On Jun 5, 2019, at 8:17 AM, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.c=
om> wrote:
>=20
>> On Tue, Jun 04, 2019 at 10:10:22PM +0000, Xing, Cedric wrote:
>> A bit off topic here. This mmap()/mprotect() discussion reminds me a
>> question (guess for Jarkko): Now that vma->vm_file->private_data keeps
>> a pointer to the enclave, why do we store it again in vma->vm_private?
>> It isn't a big deal but non-NULL vm_private does prevent mprotect()
>> from merging adjacent VMAs.=20
>=20
> Same semantics as with a regular mmap i.e. you can close the file and
> still use the mapping.
>=20
>=20

The file should be properly refcounted =E2=80=94 vm_file should not go away w=
hile it=E2=80=99s mapped.=
