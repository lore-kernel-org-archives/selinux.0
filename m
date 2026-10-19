Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792431925;
	b=0jM7+iizPBsKlvZAZjyb2LFkz3tZF2TAGVv1JJmB3WF9o11Yy26lZuetgUU/FVs59NJM
	 sVIB/T6vdkTbaC6hGhiABvsSGFBHI0sccvfdwvQN3X/5vZtslFLeGa/BRTO5At55WScr7
	 vVC38/v1gMsRfDH0xM+4jZnXEV56h9HcPogrxLI09ld3AFnk6DyyuW9bwHyHqOS2jvNCq
	 8O6R8mcR9QC3cEyLxqhh8Cdq6oUrqiIIte7rDslTLkW8GAKtlqzfOurTa9lef/mERYACK
	 AKkX0jYob6U4uH4i0DrPJ9Sq0+IkY9BITYU8qiap4o/zQKcTE8GcTkY9cUHbqyKiioQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792431925;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=uHhz8edqGfRSRr1qX/tHz5Qnqw+Nw4GhhVe2mW6VnCk=;
	b=j5/vUMtSaOdWWjv7CZ0F2nG8RN9L16WyOM8lVlj+XyzHA9pz557eAOK6fqYnfAJLbgiP
	 yOA76VxQC/h1uP3hVJ0tZAX4s/EcBfZ9TTMizFPHNOncxVQmszyED0zzaLClM+zZC9rpn
	 inCH1ZHNieFavynN1MIFYud/NIYiYXlZGMqqOtGjhOxj/YmHBvJAhjH4dQwAYJ52uRQeD
	 lqyHhLwyiRhV5GOAmZ9ywYngYP9xL5jhsAqmBRMSWV5KjAK8blrmJesj/dCqUlTMbWuzg
	 DuRcOC1zMTD3qo7IwdxCP7Nnv70sxF8AH+/Fd/43c2UOSAPW4b6sqMlhsFASjkZvFPw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hZkqtp9p;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.49
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4791B606A31D
	for <selinux@vger.kernel.org>; Mon, 19 Oct 2026 17:45:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4791B606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hZkqtp9p
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-679a2297c55so1698947d50.1
        for <selinux@vger.kernel.org>; Mon, 19 Oct 2026 10:45:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792431923; cv=none;
        d=google.com; s=arc-20260327;
        b=VJe9/4FxBjp0qOfySepu9UIkbViS3t7xkjdPpamCP5349kQyyB+Ry5x65LPA6HtD1J
         BGvUwsBbiTc2pt8GIT3x5BYW/eY1aCR3Cv5HRSDApZ2uooRlDr2wuTyKsDaOVnfqdhpT
         bM3DbpSRwkoEkQ5U+t6clkc4Yyk9yVDEqUU+YOLGNXmpGK3gRmDtuKoniPARc0X0y+DU
         UgBCkG1GbjPqQ2QnCai5Eg/PMnDGyExVcqQeIbq+3gy5YWiPLAjo1yqFb1Jvv5Wp8Idy
         xbHFBKIScH0p3+m5Bk4RYr0XUmWwP1RBgu2OfOK6mKKXNPsO8aLX+I74r7lOORaUKoIm
         j+1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uHhz8edqGfRSRr1qX/tHz5Qnqw+Nw4GhhVe2mW6VnCk=;
        fh=5YbereN3JiRiJAKEH+m98inKm1ymEGq0JDGlNWo/Tc8=;
        b=d3NjiMrJ+Dk41HrsStEr1WPtXYiH0r79toqoLmUxFebqS8eCGoltIb1kxSNzFf0kRw
         wwa0suYV032tGOqtCAQYO4Ad6mTNmK9/CC5bvUcucJIz5+2sccL152QTR7R25lrnQLGm
         yPH4npAvcSzJ3CYRZjN717rVzNVuHt1o4cmSwpegB1bCealn7onoNrbm0iCKWXZSe48v
         xkJzTePGKIWVhYI0Ci0UzDV6W5bTL+86UFbeeyoezBQpwREMgr+SWA4nZO+QHTzp5YYf
         pO513gVioEq/aWGYOGQWVaRXrhyassjo2HcmjnoYOL1lnMb5Uwic+RQNNOXYolgjLzlw
         km7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792431923; x=1793036723; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uHhz8edqGfRSRr1qX/tHz5Qnqw+Nw4GhhVe2mW6VnCk=;
        b=hZkqtp9p7zWP2rp4sPkFkMKPwrurSWfBhIqN2awqtYmm3NqydM752J9f9wlXcS2B51
         0kA9XU2IU7yrnx/jrZE1qJHVa0rj2Xhqxk+fuezDynNJosWbKc+fClpR+hxmbWk3BTzZ
         MJXnU0Df2q8y3sk0AA5VjAn+rskFIPL7bWAHSKDwC9Q9Kk/Z1wLGm1isYoWWPZC+lulK
         zAvmMya4xPLk0gUqOuBqBB+7NOF8R0vl3PAQmZI29w3hsRP7lrY2f/3mIqxwlwF8Hx0x
         sr+C79lyk6MR7NWoFmHDbXLxxBAFWAK9gANbdmk5tEJjjTGXhMCGhoiUKEE7XXpKnw0S
         mfOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792431923; x=1793036723;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uHhz8edqGfRSRr1qX/tHz5Qnqw+Nw4GhhVe2mW6VnCk=;
        b=rSYZT1w9KFiWhLhEg2j0eaNIe3zGK6Ne34j4fRmnlHWYH0UVd55ufOfRZ/7hEafBnX
         s+Ts3R24IGGwkff1U9TJnlfFnqFRTJUE7hdx3iPGr6AvWzpPQeZB3RXJUcpE/+70siBc
         FJ6c7CIH+2KZngM1Ktj3/XJpgy2+fDvlrvB77eg307gLAFzplcn/zWTO1BrO2nQIsu1I
         S9XpNeqGGAQSiyz8qK1rjT1DifGIyYpLKBFzX3MR0dIMdETxdlhM+jDZc3W7z5oOd7Qy
         MWd7oQmNZM4mun8zcX39U7hUqwhiCRRxkUM0npgO+Ec+EsFXFVkz6G/IlaDEqMXfa8+T
         1UXQ==
X-Forwarded-Encrypted: i=1; AKwUvBxbkvRUmahhfgi3c+KgEewkWrddaMlFPQjUSsy2ftiMq3KUoJc7PNRxQjusYIUn3Pq+oBuLxJdV@vger.kernel.org
X-Gm-Message-State: AFq9FYJ782niPBJts1sLv3lUIfPA0TeZ8bJY+3L/3vp/3Pf2uKKKD78B
	G+yW2uXMg2x4gs1Hz+YSYWbaVK20BmyDlJmMRsuXAROfyVuHBm2QTSswo6s/aoX5YiSMlc9d+RE
	BKeDK3idY/vTPxa14Hw5KWbHbLtYQRQc=
X-Gm-Gg: AYBFou3hkH+rgnWspoMgtkhelMOtxZlo7KD9GfpiIBAMxwHHdnFcF1RTt+Brq8SvDUZ
	srl2WHtfhyC2lvgB40bakazEjQMzWm549nyqyx3Vg23EKr9+6zGxr51LehlaMeDsCxwvx4yfAqI
	pmg9qSBM1F/iocGNgKFMfGJaHX0fhccQu8ZN9ZXeio6nEG0XGMAyPsnv6X1D+W61Xc97lzvDIip
	i7uWon85HZvhyHKxkOMUwGm9wvIW2JIEKSvhTweH2kgN25fvxbQiNadFDCKh31ILoc9qBm5wpt8
	HJsCsOvu+vS0kF5OJSg/DDj9MvEk32C6SWuBCRI93Bz3GtDWhVtwl58gicajVOmLRt6JRD2OvtY
	luiQyAxF2TxNfFpxtulr3nEDjh/vbWRhc3IZA
X-Received: by 2002:a53:bb52:0:b0:679:8835:a554 with SMTP id
 956f58d0204a3-679ca8c7ce2mr1821558d50.94.1792431923051; Mon, 19 Oct 2026
 10:45:23 -0700 (PDT)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAAUqJDt1pXQ2KVBvMoMiDrzz8ishonqhQ0nnQLEppot4nmv9Bw@mail.gmail.com>
 <2026101814-strut-endnote-a0b5@gregkh> <atYj06gmgCa40q6T@google.com>
In-Reply-To: <atYj06gmgCa40q6T@google.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 19 Oct 2026 13:45:12 -0400
X-Gm-Features: AclHuK_-8oCMVYCMfn6OWm_mzIhewJqrVvI2D-1Z_lvoMQQq2xMophpcFyo4duc
Message-ID: <CAEjxPJ4zV-YE9vRJ0=DgjuQY5gjXwRa8hcd0KpgVtyK_9AM+oA@mail.gmail.com>
Subject: Re: BUG: selinux-testsuite binder tests fail with CONFIG_ANDROID_BINDER_IPC_RUST=y
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, 
	Carlos Llamas <cmllamas@google.com>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <christian@brauner.io>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 12:58=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> On Sun, Oct 18, 2026 at 06:53:49PM +0200, Greg Kroah-Hartman wrote:
> > On Sun, Oct 18, 2026 at 06:36:04PM +0200, Ondrej Mosn=C3=A1=C4=8Dek wro=
te:
> > > Hello Android binder maintainers,
> > >
> > > Fedora Linux has recently enabled CONFIG_ANDROID_BINDER_IPC_RUST [1],
> > > which turns out to cause the binder tests of selinux-testsuite [2] to
> > > fail.
> > >
> > > Minimal reproducer (no SELinux involved):
> > > # git clone https://github.com/SELinuxProject/selinux-testsuite
> > > # cd selinux-testsuite/tests/binder
> > > # make
> > > # ./init_binder.sh
> > > # setenforce 0   ### <-- may be needed if SELinux is enabled
> > > # ./manager -n &
> > > # sleep 1
> > > # ./service_provider -n &
> > > # sleep 1
> > > # ./client -n -c -r 3
> > > Client ioctl BINDER_WRITE_READ error: Invalid argument
> > > #
> > >
> > > With only CONFIG_ANDROID_BINDER_IPC=3Dy the last command succeeds.
> > >
> > > The issue reproduces even on a kernel compiled from commit
> > > eafedbc7c050, so it seems to date back to the origin of the Rust
> > > implementation. I'm not sure if it's a bug in the new kernel code or
> > > some bug/wrong assumption in the testsuite code - can you please look
> > > into it?
> >
> > Given that the "real" binder client works, perhaps the test is wrong an=
d
> > should be fixed?
>
> Apparently there is a divergence of behavior if the SELinux permission
> `binder { impersonate }` is granted to a process, though Android never
> uses this permission anywhere.
>
> Thanks for the report.

I would treat Android as authoritative here and fix the
selinux-testsuite to match unless you think there is an actual bug in
the Rust driver.
We originally implemented the binder impersonate check just to make
sure no one ever impersonated a different sender without us noticing.
