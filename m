Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69DD2777F3
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 13:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780665128; cv=pass; b=HHvhtmAzSbjqVdBZTXTaixQWL1+3s3EJAinfgWyHXTcZLQdPnnc0skJuQAqlOJjULInmS5GinJLsc5YLU8iD9XAIbmZhFvHDBGG/nKCroegZN1j5axR7fzFGVgkgeZKSA5CIXACPoiNUGsUvUe8R+RHkxDaTxnF8umin9aATpEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780665128; c=relaxed/simple;
	bh=NHXjNBuKJlrjATMonBbXmq9b4GVvn5PbB6ig6+TiPRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qNO5tPCkE7wwmsfmVPTvmosyXTJR8YE3/QEK8PkGbzm9ouLZCJjUM9tFFmc++S8DnHwQwhecc0QzGGzUJ5htO+rCPAOTHuovBCANSjSzV545KqxfiTwipZUl6DBgs15duNlYVm7dez46O8FA8dfgHywqGo9wa2DXUY01PGsBz1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KA5nUY+1; arc=pass smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KA5nUY+1"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-395f24a5f2cso18023841fa.2
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 06:12:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780665125; cv=none;
        d=google.com; s=arc-20240605;
        b=V2C+618C1PJBSs5z27riPq5Ndzv8GyDUOYlB+x4WR7csQRpPstbsL3YhtEYU2tR07K
         MsuX8mpNqnK1an1t/xl65FqfWO9DSn5T0Qp99Qld64j9PeKW9NqRwZlsRuIfu6u0LPyB
         wln3BpBd5SYa2OtNFCPq717iKir5SkD+enn/lNRlJMBfNkMdobWxE2raY/B/KK5D4+TB
         rbQaQwgH+yTG/hMNPQc6KXvFuJKG3vt0A8t/o16pTvjhBbKXOIG9DQCdEarf0NLKQqp8
         n4Ir6Ve9E/IKNd6d9ip4ajpXkHZI08Ymd3oYBe4KBbjgiq81rB32XFJrdgQhJonnVeBM
         Vi6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zGiTYxHM914Ou+qZmsyyXCAM0f9FOI9J5ONJvqLxvpc=;
        fh=nOcPTm+jzSpUJDDJhvsoEQt/GcMQFmPB1BDsWNtwPZ8=;
        b=Eq08byHpi7KnLKaDcS7QIgWks/k35Tas7FQaA5/rrRRt+PTwUlEqtjeeMtJxH1y4Yr
         x579ZsMG9oeF0ABRBP/vrOjJHvpbprl8fA9a+GUqHJZFNHDVRZJl7bRv46i3fKxjjozp
         5whCuFifYVpZ/bKcqKoC7UxzhbpT+oLMOINc/ejiuiFID3zQhozq4cuHcEMs9pEw5UHX
         Z/Xl3xShmjqJI6Eb6XdXSW2nStUMKKk9v9iOPDoZ5yfQQiP6NhlrNHOuJoDwSlJI+4cr
         U7kwItdQL/TDzRupna5QYggtGVL2902EBDvkOIbRKlZChDaABufBGwpXHAxJkyj7rQiq
         1WCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780665125; x=1781269925; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zGiTYxHM914Ou+qZmsyyXCAM0f9FOI9J5ONJvqLxvpc=;
        b=KA5nUY+10ybVn8n6JEz68SdONk4eB3EPfNWDEXIrtD/gm3rXYTOPpjblRsg1NyJO2G
         J6NT/N8BfWj77H4FqTQ5V0Lg7dwrdqxMp9kZg/otx259f3zMYxRrYPr19rERzWy2zPIf
         RT9wPq3QnGBuCdVmZAvRlYbCT+GyhR27vSjEZvYObf4Z+5YyZHEIKFOAHDfqCvIh9L4j
         pm2L+1zGREOSmNbnx72OFyb9aVWjI1zlfEzvZZKgLQWGy9pTJNWMpXGOKGrDxB4C5UBA
         Qab67ZWsBOP/pMRbDPhdg43Uywzfs0QxhgnMGSWUZasFdpaW91ohiZ2AsmUXHyLtvWbT
         B5sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780665125; x=1781269925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zGiTYxHM914Ou+qZmsyyXCAM0f9FOI9J5ONJvqLxvpc=;
        b=MJCk8Z/x3DeNgjN53o9Wq3gUWhk3hyT9WcNqsbDzgaIiqRTdPfkv4UeDuc7wjiI8Xa
         RsQiJP14Pk+nTxkuPWEvzIS29sX7o5pi2A6HPIWUH9vFvF9fmUj2514DutVqfSArKQTa
         OHEKRYNtqKSJXfiM8HYEoldrzpjMuWzgpfEaAkqe0ECS1vAmXIlIi0yVjnbLLtLHE1Rr
         ZPhYWZo886ZrdGEwes+LCurOye17Mp/dz8r+ro7YU9RRb7W3bNrdyJpGDRW79snx91p2
         asoipIroDXwrwpl2FYFZN1beo8RLINAHd0pqhU3jjG8AQGpjT61V7woUXCUrtc15HI2N
         ONiA==
X-Gm-Message-State: AOJu0YzoyGbf5oeYMnJcIKLe/oSNp3k0EJAQgryHUGULyFBDlgK7N9Ar
	z2BYnvcZ4FFf8KcWsEMqDzzTMg3eh9/4d+1FjlxsbDWuY33ABiezVenZybvMP+mjTRKTTQvHj/h
	J9N5ePbTuUx4Os/osA2SMNW+wnrqX8yiN5Q==
X-Gm-Gg: Acq92OFgQWHkhF9af2czBSwJfkdXwetQWWbk+ybzi+kTLUNfyYhevwv9H+zG6gi+dBb
	+r90GZyGlygdYx96nJXAs/u7mZcQ9qMn8YRgMQqyP3rFyDygW0WKrRZ5uduO0RChH3smjqGB9N2
	BRirILEFy5g5FIOKRPaGVYbN5qS4Mc/BgEFRXAAUNHlMJ3p0KfNIIp2E8N8dBW9rXdgJTpICOPr
	0bwwh1vjXGLKQ3+R2HpUKb4PoRWJSG786FwSNRyhKzaUekeGn7wZ8Z1Iic8/2QPu6AwU5VZfzLY
	Wyg3GJCtn2A1ghY=
X-Received: by 2002:a05:651c:1502:b0:394:184:f7a7 with SMTP id
 38308e7fff4ca-396d07f065cmr11108731fa.6.1780665124925; Fri, 05 Jun 2026
 06:12:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604134948.6312-1-jwcart2@gmail.com> <CAEjxPJ4teCpzENLJF-grEY2O0UeDjJ0TX34MrW+9RDMDB77kAA@mail.gmail.com>
In-Reply-To: <CAEjxPJ4teCpzENLJF-grEY2O0UeDjJ0TX34MrW+9RDMDB77kAA@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 5 Jun 2026 09:11:53 -0400
X-Gm-Features: AVVi8CeCjLvv3Bde99AXBnbypluj35vuvB7IsU57eWWCRR-lM64E9Ke3NP7SCig
Message-ID: <CAP+JOzSkLL8dG_NjPQ7gNFeSy0eVxvORwVOr7cgckepV8m_U1Q@mail.gmail.com>
Subject: Re: [PATCH] secilc/secilcheck: Exit with an error for an assertion violation
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 10:04=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Jun 4, 2026 at 9:53=E2=80=AFAM James Carter <jwcart2@gmail.com> w=
rote:
> >
> > secilcheck was exiting with SEPOL_OK upon an assertion violation
> > because the "goto exit" was missing.
> >
> > Added the "goto exit" and now secilcheck will exit with an error
> > for an assertion violation.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>

Merged.
Jim

> > ---
> >  secilc/secilcheck.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/secilc/secilcheck.c b/secilc/secilcheck.c
> > index bf12a812..e8e030ee 100644
> > --- a/secilc/secilcheck.c
> > +++ b/secilc/secilcheck.c
> > @@ -298,6 +298,7 @@ int main(int argc, char *argv[])
> >         if (violation =3D=3D 1) {
> >                 fprintf(stderr, "There was a neverallow violation\n");
> >                 rc =3D SEPOL_ERR;
> > +               goto exit;
> >         }
> >
> >         rc =3D SEPOL_OK;
> > --
> > 2.54.0
> >
> >
