Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3CA1A6824
	for <selinux@vger.kernel.org>; Mon, 24 Aug 2026 13:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787577407; cv=pass; b=iHi/u4PSBHUpBhdUoJvL5iLs2SC5KuiSaJxkE0Kblxtuauw3g1xNQMQ6U+RWe6Yp63dFbNoQKrXbeeuF5ZarwmpIG/GWjIa4D2H3ifVos2ohJXwOM1FKR2ZbMnWKAqMBWfmkRVp3z+f0R5qrjfJ1/T0IlaAotjykUCx3vDqGncI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787577407; c=relaxed/simple;
	bh=JwRCFU85ji/Ad80p7F/lSRyKmnJAtbJ5lMJnJj0Pt5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=agCJMcMxXXziqajXyKxVK9NKLhmEejg0O0JFE6rCUHg4F/Ivz0/LfHzae00Uu3H5It4i2eHtof82EyFNlg34bBvvbvd86E0KklbZqfj9DWqH7bjRkGotKEeW4kdTsISI/qCGtiPbhdj5WKUQqeNbw6bpdGKUEPHl5/jMeVhWDM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSOkebkh; arc=pass smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSOkebkh"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-902fc790cd5so21180706d6.1
        for <selinux@vger.kernel.org>; Mon, 24 Aug 2026 06:16:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787577405; cv=none;
        d=google.com; s=arc-20260327;
        b=dDaaKE1LmEZ8hLO04CtvkRTkv/Qyo/uAZTMjYcbTjelxz2WL7fM5YZsbAryb7qA3AR
         PBaiHBt4/uQHDls76zq4AwVvy2vyblwhKlso0hMp862VoMd9vT64fibtqTpbm9qSb/yU
         hOeNDtMFqLZC66qzsNYiGVkPjsxv1Y6kGO5jtrOLzMKiF+DZzM/9BaOkbKHCGH5ls/eL
         ku34KnrpaUXEAq04LDgv6Hk3sjLSfkRf0gtPk5AELHea+3Lxp6q2qvNSkuUrxOntuG8T
         EPPFZp8NB3E/xotSNyAW0sYPmWjVyN/XLCxW/zS12O8vFffOkkZfiSKCDah+vq1yfwYW
         6Bhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Hk8o/iorhKRU62UTHY3YUz8eIwdIMzVx4Pnmv+8whFs=;
        fh=zfDUEDhb3Au3NJI3MrDnWhPolJWjYyhfJ7v/XOCD7XQ=;
        b=swV3i+c53FFbjvOKPMOyGfUaSdXdvXF09rua9rYkf5wW8pgtGBUvg6V/n0LxWSFyO8
         FT3lXeM7s0fPdVNvxDn+JroQcar0PstC6njvpFwg9CYk6P0SJTVkDRVxCQJ0bflJN2vO
         i+Zf2eAD89D9I4Z+u7ylG/9aYrkGeeFEa7qCbUnapEpWKVulT23rJTQbygDBN01Da/0S
         xyGNOQb0YooZ86sBKklfQcqH+vqDoYQ7ChAg/1VnuJnPvhKXZ1P6TKHgjnrMxLp0/QG7
         /joQhScFINVkfoWYOpI20GRU92AJvbCUC7sGoExmnkf9ko/kupdBZHQ44iI4tW/zNDrI
         TNpw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787577405; x=1788182205; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Hk8o/iorhKRU62UTHY3YUz8eIwdIMzVx4Pnmv+8whFs=;
        b=BSOkebkhNQI9C1z3jzyqiSklJeOwhRZzYAzCpjAAAbpai58lSphFy5CkXqqlZxD0px
         bbSPWkFbYXNKJcpDozJjlq0lPmSA9TQU1PD3rzUV2ldytOqrHD0gqc4ZKSb3MhLD+68q
         UJRbMF6fYDw13rIPw+pKbRozd9VIbfOcIutcFBBz8c300p1rd5F5HjHyfRjGmP8l5kD4
         s5EN1IcGTu/eFRqKpHcEG3lQYX62eR065cJO+Nj6oy9lwY/HgZ7dcxAyfk8v9nDDqyiF
         Hgkgl64WrNSiEWzTJk6lvDQt6HcCBu3m5UUUQQGQwSyZVZBOuXOCZ3VNScBBaZMC4Xuj
         Qzow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787577405; x=1788182205;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hk8o/iorhKRU62UTHY3YUz8eIwdIMzVx4Pnmv+8whFs=;
        b=EuDcC200FZpnzuV/1IC2CY3zNhzKtEAquueuGNT+Ji6HalelK1e4lUEo31f2tVmKHk
         4Bf40okvsGEgM8IlGncZW8SzqZ0tgXng746PkoxtgSkaPJ1gGnKLekWTrw1moQBvAx22
         2MyrbUDJn8GraZetIuwp9V/kBjZb4VqkhqdI9yDyRIUa7dMSMTUqD+rsGSGzJ1+zaGeg
         hCuYT23Ekj7UPAlneflZT5597DufviIha5McifLe0Bm918aO9H4ld8TWZ2p9UPbP00JA
         RCTii7iYL4eOpABVD3LCb3/ay0M+Y3cIP2J3uJVedTRPOKPZN/I6sz03RF+8N48hwSQ2
         qFnQ==
X-Gm-Message-State: AFuF++khdBdzcZ+qY/jNxGiNC9YczPkuK/XGIsKb7JsRAx9Bn1ePckik
	D8NA79oyIiQvr4eNRnfVYNanbnJIf7r6O2gX1U6bAz0SBv4/1STOewusd/5i6Tp3dGpTQAgTbkA
	LsmieKEoTLRZ2YKUXzCTN4hYdTRigd2s=
X-Gm-Gg: AR+sD13nGvZ4WA0N1idWLFGCibGOv8wEGuG5ceteZs9OJmQWNnfV3XwbmZ53y+fxBwm
	h+ROAe+Gbfgy+3FHzZIpsldZFI8NITLvj2XpNE27xmi+IDkomQ+4GYKqWJcNS9jsTx0gaPThDd/
	3HaRp+2Gzlbg6OYuMo1JU+gJgUyrDOf5PyFcjptADor7A2YsF5EV707gGKWrTmQvWYVPSYhOAJk
	TgvwUUBHnpfTeh3T6qMaadw0QIwnfdlV6ouoaCw18pnM3FhqvwFyPjMxRx5d8JAegmQrqcor1K7
	xL+33nEMsMGUzACWL7VZqJ1/2Nfnzg1Jwp7A0ibjyPnU
X-Received: by 2002:a05:6214:3293:b0:908:a729:73a4 with SMTP id
 6a1803df08f44-90c809c2b56mr287482336d6.5.1787577404673; Mon, 24 Aug 2026
 06:16:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729131413.1390890-1-pmatyas@redhat.com> <CAEjxPJ48Ov9pT6oZ6Q-OU5eJMObA1spPnFhdcKOOjmrSAD7pQg@mail.gmail.com>
 <CAEjxPJ7uiGT9VDg_dqG9Y=p_Ckrd6BFYQPKOrsMGpBuJVVTGwQ@mail.gmail.com> <CAEjxPJ68QBO9TDBN26z3WGG_eJCUxrBbJGLxk_=Na4acipmvEA@mail.gmail.com>
In-Reply-To: <CAEjxPJ68QBO9TDBN26z3WGG_eJCUxrBbJGLxk_=Na4acipmvEA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 24 Aug 2026 09:16:33 -0400
X-Gm-Features: AcwNN1XillodDePfhlo7yMNSP8ruSceeOicuwYLBNoPwvuHfq3OHjAlmDsOJipM
Message-ID: <CAEjxPJ6p2NoguEWWPJwaQeqanpwUnOFhGNWaSQc+GOVoSWPSpQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] libselinux: prevent ReDoS in file context regex matching
To: Petr Matyas <p.matyas13@gmail.com>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Jeffrey Vander Stoep <jeffv@google.com>, Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org, Petr Matyas <pmatyas@redhat.com>, 
	James Carter <jwcart2@gmail.com>, Petr Lautrbach <lautrbach@redhat.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 2:20=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Aug 21, 2026 at 9:21=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Fri, Aug 21, 2026 at 8:55=E2=80=AFAM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > On Wed, Jul 29, 2026 at 9:40=E2=80=AFAM Petr Matyas <p.matyas13@gmail=
.com> wrote:
> > > >
> > > > The PCRE2 interpreter is susceptible to catastrophic backtracking o=
n
> > > > crafted file context patterns or lookup keys. Since libselinux neve=
r
> > > > called pcre2_jit_compile(3) or pcre2_jit_match(3), the JIT was
> > > > available but unused, leaving the interpreter exposed on all platfo=
rms.
> > > >
> > > > Fix with two complementary mitigations:
> > > >
> > > > 1. Call pcre2_jit_compile() after every pattern compilation (includ=
ing
> > > >    mmap deserialization) to engage JIT for both complete and partia=
l
> > > >    matching. regex_match() now calls pcre2_jit_match() and falls ba=
ck to
> > > >    pcre2_match() only on PCRE2_ERROR_JIT_BADOPTION (JIT unavailable=
 or
> > > >    not compiled for the requested mode).
> > > >
> > > > 2. Create a shared pcre2_match_context with a backtrack step limit =
of
> > > >    10 000 000 and pass it to both pcre2_jit_match() and the fallbac=
k
> > > >    pcre2_match(). PCRE2_ERROR_MATCHLIMIT is treated as no-match to =
keep
> > > >    the lookup safe rather than failing noisily. This bounds worst-c=
ase
> > > >    matching time to milliseconds for any pattern/subject combinatio=
n,
> > > >    regardless of JIT availability.
> > > >
> > > > The vulnerability was reproduced and confirmed fixed on:
> > > > - RHIVOS 2.0 / aarch64
> > > > - RHEL 10.3 / x86_64
> > > > - Fedora 44 / x86_64
> > > >
> > > > Reproducer (149 bytes, base64):
> > > > AwovMi0GLy8GCygKeAYGKwYLKAoKCgAAAPpXKgsoCi8vBgs8PG5vbmU+PgovMi0GLy8=
GCygKeAYG
> > > > KwYLKAoKCiNXLy8wCwsoCgojV1dXClcqCygKLy8vV1cueHhXV1d4eHgveCsGCygKCgo=
nVy9XV3cy
> > > > eHgveAcGJAsoCi8tLwYvMi0GLy8GCzw8bm9uZT4+3q2+7y8=3D
> > > >
> > > > Signed-off-by: Petr Matyas <pmatyas@redhat.com>
> > >
> > > It occurs to me belatedly that this change (which we already merged
> > > along with several follow-ups)
> > > likely triggers SELinux execmem checks on any process that uses
> > > selabel_open(SELABEL_CTX_FILE,...)
> > > due to the JIT compilation.
> >
> > I experimentally confirmed that this does trigger execmem denials on
> > Fedora if I setsebool deny_execmem=3DTrue. The denial is not fatal sinc=
e
> > it falls back to the interpreter but it will show up in the audit logs
> > for any confined domain or if deny_execmem=3DTrue for all domains.
> >
> > > Given that fact along with the fact that
> > > we are still seeing cases [1] where
> > > oss-fuzz can trigger stack smashing on pathological regexes and that
> > > this was originally motivated by
> > > concerns about such regexes and that the source of these regexes is
> > > always trusted (root-only config,
> > > and in the case of Android integrity-verified, I am starting to wonde=
r
> > > if this change is harmful rather than
> > > beneficial. Open to others' thoughts. At the very least, I suspect
> > > Android might want to disable this.
>
> Barring objections or counter-proposals, I think we may want to revert
> the use of the PCRE2 JIT
> to avoid users of libselinux selabel_open(SELABEL_CTX_FILE, ...)
> suddenly triggering execmem denials.
> We can keep the other part of this change intact.

Rather than revert it entirely, I submitted a patch making it opt-in via:
https://lore.kernel.org/selinux/20260824131154.68022-1-stephen.smalley.work=
@gmail.com/T/#u
