Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C4B28695
	for <selinux@vger.kernel.org>; Wed,  5 Nov 2025 21:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762377338; cv=none; b=DCFT318Xd5B8kX3zFz7+vQ3zqPxoH8CUUltznix39f+59r/mg5l7wg0gtC2HxFwXrWdVgplIgbvxI5DBc4/wmmPHOn8JqXUJ1cO2RTbdaSCV6RGI5UmLwQeHqV4FOp5CkRC7mdUrhKy6qCD5Z5C0x04pcJQdWL73HEhxJkxIRGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762377338; c=relaxed/simple;
	bh=EXdYPTVr9jh8JwjVj0KxPX5+91BqSF4Eg7stUlvZ8+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RQrKG9HoWFibCJUwTQAHwiTMx4IABnpSWmJ0NPm/l8J8GOVbfOG2JxO9iMQjtcl1iEj38mka0KgfrvVR7SYK9XLQYfMnRWBZlE3q4IHJc4QJ1U6QTqKMjgBtgbKBvctSQaELT8/WvRp0TyzsRyA3I+ad6QzizVK4jmgmEKbAu8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=GyOHRbbO; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="GyOHRbbO"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-33be037cf73so350815a91.2
        for <selinux@vger.kernel.org>; Wed, 05 Nov 2025 13:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1762377337; x=1762982137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4wgQ4Z37rvB9kF5pHVDUflr6lOzM+ADVuKpbbQnWzIw=;
        b=GyOHRbbOMqzQuxkWH2LUgWozobIBZk2Kd1C4su6ipOCdQy/2WSZ7XpioeOMbbhTUkD
         u31Qm+0GgrlrVm7gPV28jG61co9VrJWfXLIJMWlTBQ6xNzx2hJbWfNyqstBDehJK6JjZ
         sEjszEkposLkkfpz1p15y03l+vkNhWcgSaISLhCunP4huFqLiSouSmJvfjlHqRhSrg/7
         5KOJ9ZJ9VC7kOszCy9Nq4zcAvCfmJ00nJ1wAp0+AlFEDplmxa9bNawKc1XJNe7bs3p/+
         jUe3oTWpt9WdlcqjeGjYrLkB9ytBtit9eE93tQcRFiT3rZWE5AnrQE/9CXqwJnqfgmcV
         w6Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762377337; x=1762982137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4wgQ4Z37rvB9kF5pHVDUflr6lOzM+ADVuKpbbQnWzIw=;
        b=LkX2Ru7GIy4MU8uai4zen4XX8NFd1AXv4O6wq7HtF2MuzvalC9T6WfJO0fjhHnvHOr
         Q2ctEglIUCwcOyS2HGMxvJ8zB6Dct/zC3GP05+1G04SYm/u1kcfH85Xr4bn+VlOn/6cw
         2gFcuRHzaErr5zDein/wCInfFE7pbQ6Z69xPCOMofpZQL6H3JJ8dFfOuZO+j+YPx8ZY4
         +xImudHrLsNjJykV9uWDJAfFE2OLMo5F0An4G6cnj08ROQLIBbufmgDKoIf/CIt4UwiR
         teNpjd8tBtqdzHIQHJ/Q3Cq5BuQn4Xu8gj6wyyi7Wa47bSCJMVwV3BlCVVVvfnctDWct
         5ntA==
X-Forwarded-Encrypted: i=1; AJvYcCXMht75V9l1tH3px2VtCPbUUu1+PNe4rx9bzH/6LtRny5l3hieQAsDjykSyKMarN1z91esJPuT0@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+3KwlJu51pfEoGyVB9t4sNb7AvfbcUiLMEhvHTcSvmBKRBsT8
	1YmWuzQnzVtIHyxHSprEPawME0z3OAbl4Fqo0TZ33U7veM2vxlKFHNdUSWNvpVZjpIcz0Krpn/w
	ta1kFazRPo4NJE98OjznIxAEcbDG9igFVZcVTXGHJ
X-Gm-Gg: ASbGnctCNdr3I5S80EU/jzOEHTkvBpCxOBLwiuTx++awcNacDA49VxOp+ZYiwVw+tHg
	tsraszqQLkuA5Xsvu3CDgxSXBLAtTifS6Y2imLpX5H3pX7zuaAP2xkamI+f9BmkAlLaaqzZnAAk
	J4ADqzYxZfqg6Otu/vtPzBTknQhIPk2ZocjPuACDAnXPUF9Exmmp7W6fOMZ7OkTPKlNkKHlVYCa
	S4WBWPjyUwKBeSq4Uu9jlErgC11UMcKaMfGLcuzsBq94ENxM6rcMVjzbaW1
X-Google-Smtp-Source: AGHT+IEYSQgRemo3Y4xqwtqxFHHspmhT+0aGpeDRLdSYjXxTsXY9ZvbzudjSJVwBV88nrZ0GyuPOPg3RfK7j0G+hINc=
X-Received: by 2002:a17:90b:3a48:b0:340:ff7d:c2e with SMTP id
 98e67ed59e1d1-341a6dd9cccmr5456500a91.29.1762377336695; Wed, 05 Nov 2025
 13:15:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9bf87e7a-17e7-4c74-bafd-885752dfe045@linux.microsoft.com>
 <CAEjxPJ5SX-9OyMPQF9B9wr4ixdaG9jxSmG5R7Ozev+KVztWoWg@mail.gmail.com>
 <CAHC9VhQjEo57SMp49A+iXMUiyEXkpMUOnHkSJ3cspTHGUFXdUA@mail.gmail.com>
 <CAFftDdr58R+9qGd8MYxyyxzY0wCRo7vSDKLMX78sm9dc7QMUUg@mail.gmail.com> <86627693-6ac7-485e-ab1d-091ff002ee9d@linux.microsoft.com>
In-Reply-To: <86627693-6ac7-485e-ab1d-091ff002ee9d@linux.microsoft.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 5 Nov 2025 16:15:25 -0500
X-Gm-Features: AWmQ_bmp8Cqydc1LIsUPA6IHsi92r-CnOKx9dYsidvJQ1rfkoT3ehWxxsTxJCT0
Message-ID: <CAHC9VhRWuHo6RLHERZfyzkk-MjRj1-BfO71hWuDKEszAYF1eAg@mail.gmail.com>
Subject: Re: SELinux documentation repo licensing
To: Daniel Burgener <dburgener@linux.microsoft.com>
Cc: William Roberts <bill.c.roberts@gmail.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 3:35=E2=80=AFPM Daniel Burgener
<dburgener@linux.microsoft.com> wrote:
> On 11/3/2025 11:31 AM, William Roberts wrote:
> > On Sat, Nov 1, 2025 at 11:30=E2=80=AFAM Paul Moore <paul@paul-moore.com=
> wrote:
> >>
> >> On Thu, Oct 30, 2025 at 9:02=E2=80=AFAM Stephen Smalley
> >> <stephen.smalley.work@gmail.com> wrote:
> >>> On Wed, Oct 29, 2025 at 5:19=E2=80=AFPM Daniel Burgener
> >>> <dburgener@linux.microsoft.com> wrote:
> >>>>
> >>>> Finally, Creative Commons seems like a fairly standard option. Howev=
er,
> >>>> we have decisions to make, since we can specify different CC variant=
s.
> >>>> Something like CC-BY gets us a more permissive MIT/BSD style license=
,
> >>>> CC-BY-SA would be similar to the GNU FDL (but of course mutually
> >>>> incompatible).
> >>>>
> >>>> My initial preference personally is for the CC-BY, but I'm happy wit=
h
> >>>> whatever license the community chooses.
> >>>
> >>> I am fine with CC-BY.
> >>
> >> Same here.
> >
> > FWIW, same.
>
> Thanks for the good discussion.  I've opened a PR to apply CC-BY to the
> repo here: https://github.com/SELinuxProject/documentation/pull/4
>
> I think the ACKs from Paul and Stephen who have already contributed are
> essential to collect before applying the patch (which I intend to apply
> to both the website and main branches).

I posted my ACK in the associated GH issue, but for the sake of
clarity I'll repeat that my ACK is both for the choice of the CC-BY
license for future work, as well as the (re)licensing of my
contributions in this repository to date.

Acked-by: Paul Moore <paul@paul-moore.com>

Thanks Daniel.

--=20
paul-moore.com
