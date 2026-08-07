Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1F237DE9D
	for <selinux@vger.kernel.org>; Fri,  7 Aug 2026 18:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786128012; cv=pass; b=SmhI7KZCHVXsJ6o1UryaXIkuNcKHd0XxB0puiMIlYQYXpvYJOAAaUOA4HnrhSGuMuIhkdkwCaRIUPdcL1LMFTWYK/sCywCHDvb/Jxcnsk1aY6AtuiNIcTqH3C6XViTTBLkGyIRKhqW85zG1UilAxdyiCVujPL426BhR+wPCtXO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786128012; c=relaxed/simple;
	bh=4t1u8IDvwX25+lOZrqLwXdw+ACiTLNTd4kaGSqRJdOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eKm9wVbOyp4vvNv5gk/jRs5wLehpjdRPMvvVWyJ2fMmfybopHGgF3W7JPi/oy8bbufzW/CzCQ6l/wmJFbvrLJmElTMKBi9NCVp8zOMfrrruDrdxbpbKhgvdMh7tj+1EYIHtOZ5EwjQaD1hbIpdn0HjPDQnKpo9VKGr9IQrpCOUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KvahY19l; arc=pass smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KvahY19l"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6aae90e595fso1672234eaf.1
        for <selinux@vger.kernel.org>; Fri, 07 Aug 2026 11:40:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786128006; cv=none;
        d=google.com; s=arc-20260327;
        b=avXYtOEkds6aHy+NlQKAYO6SccK25EQntDAWG0Bj4NSkRu74ikCCX6wCSw82Kgjatz
         of6rSMmjDKuG3QLc0FgXCfeQRKnbqRKpDarQjHUDUpU0AL6OYuHZFeio5uPc0MNX2em6
         2uS3YiqT0Qb75g9PUtsaqyg98wb/4GoGVeUgDsiwVGmcGYncq9y5SMZ3nxjd5ayzNvjH
         cAlicSI4kaMSkvTDjFd5O2OQoFiYKiTNmBcQAC4Key9ZQSFZsyyIaaBN9iYIlS0+Cx6Q
         Exkn1ovBWeY8DqACqKyzkHXihpib5IxF6lg40HpbOOfhsKVXSgULdVnDdpQrDHMjLQRc
         2MVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4t1u8IDvwX25+lOZrqLwXdw+ACiTLNTd4kaGSqRJdOg=;
        fh=XCM8fo7IfM89sTn06SjGxcUqBXOhXzH4qY9c7awlrP0=;
        b=khIaPVuq4+leLoRCMskHdLaF7kTUQ0OULL1EC1JG/21mJjIL25ahhFfIyyLWMCQJbR
         gdWwrE1ElA2tqG0plTiagFVb18HwFd6LgQQd/abxkmoLSK2Bz9t52lacHoWj/FJ5kMA9
         Rexvbt/VbavWY65qPDvVR2o98ZONoipHFjYKHYjI/OtaiI951gFSA4mxnofruXzDJP7f
         BNErhxVrjBqB1RnD8Jn6fCcbaSNVg5pCulATxx/bIacYZvJE12oa6zs89WA7ua29oAfc
         xRjM8m7GIXoTIfz1E2G5wSglNgKca5el6fmOF6Yz8dMk507pjbLenUo5Dh5c2hd/7zoV
         Nxnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786128006; x=1786732806; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4t1u8IDvwX25+lOZrqLwXdw+ACiTLNTd4kaGSqRJdOg=;
        b=KvahY19loFHkq6mRTETd4/o5Ew9S+eqO6oEahxuIQ+vnAwp/sANG5cMhFx2Y5SDmuG
         JzGf0EUWxZNCV/TxN7BoNl3y2GH4WIrs+9qLwWLbMKXeoOOCQtQiRD4ujDPSyL7M+OEo
         wJBzF3rIFKU+w7pD3MzVRz2JILV7ZkwR0leoAj/Xej+cPRqXKwQpoplVgMOUFQQGwKTA
         TPCjIxIkDnIsK6d6k+50QLJ+Cw9XqZxD2yFfQywJCQhbpnbXDtCGhlnEWgwrNfg732EE
         u0Q/OmJihgY0HFrj3MmRVuJ9MSEj6DYMvr1//WWbcvfG60VvKzEFdLNO1PiT/esZx/6Q
         Bwdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786128006; x=1786732806;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4t1u8IDvwX25+lOZrqLwXdw+ACiTLNTd4kaGSqRJdOg=;
        b=bv0JCAtWe2K9nLHcVPREGVw03imWtywLf3+cFt3UjYaaTIXea7tZ6D+P9AyCQc6Yr8
         Lg2A0kDOWe7+T72Af//70Vz+CvlRdqlYvxJ9hzIwmtov5bBOvEu3G5eWylgr8ASFM3nh
         mJL8F+Bu9sNPYptOx4wFkhq9kHlv8m4BFBNMaFUnW5OswAfb6tF+XBbQNlhxkhOPFf3X
         TYK4UJ2pnV07uzxzzxi4lltCRO6za84Yj6ik+3C5pAsM7vQ4kOmshb4BqwCDc0FgZZbQ
         eAF7yBh/0dperu3UPoF7Cu2OPHFiy893Xm/voE8Plk2VEwnjEDNZ+0D/QU5nrxVk0bKh
         63+Q==
X-Gm-Message-State: AOJu0Yw8sMZ1vVhUJnV3y3uS8aJqXk1DAn3wPY0KeyjMFh2WgYERSWN0
	CbjhSy/qQQCmZY3tf6z0dKJG0tk8EIYPtYAygWYU00uGjZWQ6jImenvOV5X4w5rpS0MVO0J5/RW
	PZv0+nXHjgmbvc/ArsII+6g2x1VoN+dk=
X-Gm-Gg: AR+sD107Iop4geDUa1cYuKZXbTlAtoXNkdtEMNIh4HH+2RSQWY0AYnDln1Qhgupl1YX
	8S36ftckLWkxvAmV22SIEaxN+Z8f0+1yfrXaClk/kQ0W84hioD+8zny5Nrr2R4tz/2OaM4/Z9Ik
	/kIUmF5DlYCp4pgo5hyzRTaC8DAIkLYkdEukIQYnAM/CgOv9B+3U45qGSuAMsmvrLd3mhSWnLS4
	SDTISi80ibpvcLkiZ1T9lB2s8GhCJHxw6R8BXlaKSaNHsLnb8ycqcbjP0WoxR3g3UHc6t3MnWxg
	zg7pXYi56K1eOgyEHCg+psE8Feq/IEYMR7ib43wzoX2P
X-Received: by 2002:a05:6820:4b17:b0:6ae:88f0:1dd with SMTP id
 006d021491bc7-6ae96c8c6bbmr13605811eaf.11.1786128005629; Fri, 07 Aug 2026
 11:40:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806194125.371718-1-vmojzis@redhat.com> <CAEjxPJ4WCk27pfZQWbxiU=SK_VNbGWeeZuD0--Ws6iqT-GZRMQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ4WCk27pfZQWbxiU=SK_VNbGWeeZuD0--Ws6iqT-GZRMQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 7 Aug 2026 14:39:54 -0400
X-Gm-Features: AUfX_mzDcL5Ib8QABg2Y6e5Rzb_m5Rq-LtUIfidvuNRU8CHD5cLjGr3q2vWXkRA
Message-ID: <CAEjxPJ4EX_q8NfasHiu+FEMYzoEhs39OBALNpLTVLHNx7aP4OA@mail.gmail.com>
Subject: Re: [PATCH] libselinux: restorecon_xattr: reset dir_xattr_list on
 every call
To: Vit Mojzis <vmojzis@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 8:32=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Aug 6, 2026 at 3:41=E2=80=AFPM Vit Mojzis <vmojzis@redhat.com> wr=
ote:
> >
> > selinux_restorecon_xattr(3) documents that "xattr_list must be set to
> > NULL before calling selinux_restorecon_xattr(3). The caller is
> > responsible for freeing the returned xattr_list entries." Commit
> > b5a23d7f30c1 ("libselinux: restorecon_xattr: clear dir_xattr_* after
> > freeing") reset the dir_xattr_list/dir_xattr_last statics after
> > freeing them on the internal error-cleanup path of the recursive
> > walk, but not on the normal success path.
> >
> > After a successful call, dir_xattr_list/dir_xattr_last are left
> > pointing at the just-returned, now caller-owned list. Once the caller
> > frees it as required and calls the function again, add_xattr_entry()
> > finds dir_xattr_list non-NULL and appends the next entry through
> > dir_xattr_last->next, a dangling pointer into memory the caller has
> > already freed - a use-after-free write.
> >
> > Reset both pointers to NULL at the top of every call instead of only
> > in the error path: by the API description, any list from a prior call
> > is not valid.
> >
> > Co-Authored-By: Claude Sonnet 5 <noreply@anthropic.com>
> >
> > Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Thanks, merged.
