Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793888735;
	b=0I7Jhdu2tYGIl5ul1eqLCzYlch+FrRUa75XJDP706aFGalAbc6cut7Zl+ELXyBfKbt/X
	 UZ8DNb3C3gjmBTgXwFpbxD3MylluGt7xQz81h5Su3kLObAxQ36+e9SWjTlwtx4cKrCoLn
	 joum/rc5Xng6879g6ZWXiMb1JzEvFFQqDlRQHvK1GokNT8HuOzXDkQTS+jjNPkhaXSpLr
	 /bmqIdjspnjEOdc3IwTSA3xhAtCj71GAcYQbFwW5LV9kR8mKswBSbSEPg/a3yuiqb07Rn
	 jjd+7B6U/LZA8+xy9URGcB8pbtL4rLA/twninN2tdHgbIW8LIHirb1T3rrDwf+cJxIA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793888735;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Content-Type:Content-Transfer-Encoding;
	bh=r1oB0f4XylEMOZFUljgS6qgOZVo+wBfV0YYbYvdIhKw=;
	b=YgrqnZVhMQ4TAznAYawFvf0lOhROUGqoqIVZa9KF4FggmiFpwcCYO+kMJDLSxt3ey4TT
	 9kyKx4kke7fVmkQaU8ZIuSyCUJcaqSJ2tGsEBwlAuf+ymgIlteokKoGD1BKlswPAKkgO6
	 5sAtI1yJCuPkKpwZ/7fBM/AyfLj+EA2o6gY3oyvei75DXIZTZIREq4waRV4yZcoXVHy+s
	 LzaoMtKxGON/lR6v0otVxoBnF6x15rIz+nhZrLkwqI1d6j0cSLdYjWWMbPO4mx6vew+jz
	 XJWlDKGEhbeu6OfLRPGet0CLSg4n1lnbpb3b352BNR3PQNiiVBA9u+/uu9uhZAdy1OQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Fn2j8xFg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.50
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2076A606A31B
	for <selinux@vger.kernel.org>; Thu,  5 Nov 2026 14:25:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2076A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Fn2j8xFg
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-679a2b5fe87so2043906d50.3
        for <selinux@vger.kernel.org>; Thu, 05 Nov 2026 06:25:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793888734; cv=none;
        d=google.com; s=arc-20260327;
        b=blaNtKVllnYqzTJoEjQ/YQu7/+Me1K0TxCD/5beE41n/zPXNFJGpYKWSSxhqCzrdSI
         BXTsZgj0Owc0A7GDgxf5UauhcoknZYJsq4RdcqAIa34vv6tNUtAfvlnHRd+NUuCDksD9
         eNRiQoxYv2svtWYhfm0AkuM4W3HLrcUGbxK+v7FcvDQK7C/Tl0pFokfobaOCxVVXeHz6
         JyzkVtYWPsygF+jh+S/zBco1nhJPFI5mCsWa677NAbggqYi3dulZ19a0ZDoEUCylVnRh
         ullRtHXQCaDSidQ2ysf8j9US8DpdnAMS3rwMIP3QfSvPyd7dok0x09uTt4Q45VWjHeM1
         KDKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r1oB0f4XylEMOZFUljgS6qgOZVo+wBfV0YYbYvdIhKw=;
        fh=IB69jQmb8YFDvqdTklnjhd3TGUXK7ajRHr+E4bH9WZU=;
        b=PFWdS1YeTUOnLqVYsrZjo+immPjMu54pY5Mc8xphYZKYLs1rkTAKoZ3KLXeSC2xC7e
         bYgT9AhbSeHC9e3j/ONFVAT+P92Yzyp426qN6vv/yww1oQ6rG2qMjTOLqMUOu/6hOt+v
         hSPMWqwwzQpD/4eCeO+HivPDIeiSj96feOqVkReAZZ3Ia2+Tw7veBPX06KuNoLoLEFF4
         xp9oSiDYg7oE7PmciFPoPGkE3369eCHCk0MwurD/wvxrccjfcsGAOGBcLhfxuktEfIrZ
         Lkc2SsJldmcmgK+3psP9ng/jBS0Qfq85CTMVcvjpGlCN+jAuTpCO5hXjzYl60uvB8B15
         w/4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793888734; x=1794493534; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r1oB0f4XylEMOZFUljgS6qgOZVo+wBfV0YYbYvdIhKw=;
        b=Fn2j8xFg08H6p4qb30kly63CuYBDMxNLLj3OHA0LvjwifkovJD4aiGBwwThAlINJKk
         GmTYtS388/TWAwhmSBCFjuD72S6Aa/Q5U7NOKhjJ+Ldcbef4PyVea9jGWLIT/fDcc9me
         Lhx9O8TDkvzr7HWDThCWDL/vLGfgT3ggpaKd81gcdB1h5BEW4g17fHUCEevI5lgVbx9D
         rTvcVJ6cT58flTjv8NNZW28I+6JiOw9m1tKgvqi4Uf90oNcg0mjmyEjLn0Lf6mgb1v9N
         OsGo3dCfRxLySvCUql00d5x2/E4BMdTqD9R1Xr0ZuG2eLNsCQXPzr3mwxTFtUDqr0Edb
         cuVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793888734; x=1794493534;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=r1oB0f4XylEMOZFUljgS6qgOZVo+wBfV0YYbYvdIhKw=;
        b=pTjHHYM7yAOAI3GyNdIN4TUSe3UJwZtlx+wO5114sziS51752avynZsSqKScjhTzmB
         3peJPY7FYZHIumvLO8VIzDg+NIn/DwlWQIhAbvs66QaA1NBc+/r5gOe7mmQbfTh8svha
         LikwNsLUzmyglbDWPfezBhb9hmjQr/JuK9+6kcFKusv+RAuUgc14iT2GdzLc7yntb1Vz
         HPZBYgRepu8RBJQgzvvXvBZyi2xwdp+MoJYpLiomOP42E5cweYpj2EOkPWUHqwNg1tes
         dpmbYk69tmqps52Wt3VntXAogSpoCTKBbv3+trJWg4mAmtWLc8s97umkAspExuZWPGHo
         sMWw==
X-Forwarded-Encrypted: i=1; AKwUvBzKPL1bK2aLzdiQQ0XmUtSpQmqJdCNDl8gS67alQSlJ2v4YXmLAuE3sDGm2/xsHfYwOOwn4qP47@vger.kernel.org
X-Gm-Message-State: APuU4Z/s1SRKrciJ5uwtN+zw8oDSOos5HdBwUdBNcpIrdu16FuA7wtdx
	TXAOujKvqCXe1eDQDjOGj8Kzqw1yryJZUqoGzQrHcHClp9Hy2ThpbbYLbOYSQnFHzTgqAqvEb8J
	vJuexOh3D3CmClBMyDzYsofOI9Fsq97w=
X-Gm-Gg: AYBFou2whaIb2hgKM4Gz5ARa96DDjFkN5i1elKq4716ifbSNb6Fwk19k0ghMBI6o+DF
	jFjweZIFRh5DwJ9KkZg9i1jIwZfoY1vf4ra4DLSDcITmFQRvJRuVvs/EHKXUBkvRS2OoOH8Geyx
	6kpHzzijr9Ri3H9OkZ0QQpDiXj6aYyrOr/rRnHLo3tm4FoSnNnSf4gdFRSV8drAGJLSoq4gkToW
	v5W/OdcQJNTyAESeAfUmLp72VO7WhNEjJxfwEAygzJDcNEsc4hpBxn1E0k0ZmP77S4Fd4lBBcjr
	fkvZx3bqHY2kZZ+HK7TkyEMAz/AE44MTh1Jv/706O17Hwkjn/7glHDjguJU/WuUnSbJYOAgXBRP
	ijXMh7AzQi439sDbPNTjahubc88r778cWNdJQV70uUn5LSYWqo56LPb/wJ0Jjafgt22URwmmms9
	B4KuyVBKjiqnXTn8V6+3kDA++T6emISgy6q0JtXUL195+JDn1uQfjd/kk0Aw==
X-Received: by 2002:a05:690e:1387:b0:67b:fd46:ef9b with SMTP id
 956f58d0204a3-67bfd46f25amr2004584d50.47.1793888733929; Thu, 05 Nov 2026
 06:25:33 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <76k2qxgeqgik3rdq6pnve7c6fqu43pjjeskxshtztal6rwllrd@ta3gvtdds4it>
 <CAEjxPJ6yTtMA4a-CvrQW0uTJ8mTEkdr6WE9mVJw67BKH5KRwyA@mail.gmail.com>
 <auxhNtTcQa-6TS35@suse.com> <CAEjxPJ7w5BMmMW-cZNG-fVpZT73BW0C9d-cBcrG3AVW-ArS=Tg@mail.gmail.com>
In-Reply-To: <CAEjxPJ7w5BMmMW-cZNG-fVpZT73BW0C9d-cBcrG3AVW-ArS=Tg@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 5 Nov 2026 09:25:23 -0500
X-Gm-Features: AclHuK_VidJyz2tNvAH6VlHNdqTHjdQVpn-gBKgdT40Z7eJylKRQB5Oo3TFbQ-s
Message-ID: <CAEjxPJ6ihzVO32+RAah_g9vo7vbFQTK5EGybgvJhow9u6tzMbg@mail.gmail.com>
Subject: Re: Question about libselinux *_with_level functions
To: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org, 
	selinux@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 9:18=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Nov 5, 2026 at 6:03=E2=80=AFAM Filippo Bonazzi <fbonazzi@suse.de>=
 wrote:
> >
> > On 2026-05-27 13:46 (UTC -0400), Stephen Smalley wrote:
> > >I believe this is a regression introduced by the deprecation/removal
> > >of /sys/fs/selinux/user,
> > >as used by security_compute_user(), which was formerly used by
> > >get_ordered_context_list*().
> >
> > Hi,
> >
> > Just checking the state of this. Is this planned to be fixed at some po=
int?
>
> Sorry I saw Petr's response in the GitHub issue and was then unclear
> that there is anything to be fixed at the moment. Patches accepted if
> there is in fact a real bug for a real user of this interface.

Actually, on a re-read, I see that there is indeed a bug that likely
has a relatively simple fix; is that something you want to create or
should we?
