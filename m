Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F194450413
	for <selinux@vger.kernel.org>; Tue,  6 Oct 2026 12:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791291320; cv=pass; b=h8Jym1DkhIREMjattBQuvLgeR1xc4FsNuPoXAIMx2/c2SUMRiJo6xnIY88MpFi40IkysPgsgUWz5oOEu6KHB9eGbWlNw0KfcXpgQOqndF380d5YMTcghnNguY1fGCLRfCVRRgSe6hJaqH5FNIgRzqUqIbcY9/CoKkjE9bJhmKNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791291320; c=relaxed/simple;
	bh=uUJIP6jokXoR79Dg9ssKUyLlKVNDtqLogegIGP37sK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QBvtOfQY5moRNxZYoE/GgASCef273ddOx++naTf2lmd3F1w5HrhAi/QFsy2yUz9fM86SRlCCqieTooEBTJWOgc2V5uqEVgr7arTlKCmYZy9SqkqiuUwySE4REKgO3SymoNi6Z0QbvERG6JGVD7euvty/ZorV85C9LTQIZ4HYJa4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dIx+od5v; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dIx+od5v"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-677dbe051d4so2278623d50.0
        for <selinux@vger.kernel.org>; Tue, 06 Oct 2026 05:55:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791291313; cv=none;
        d=google.com; s=arc-20260327;
        b=TUNI6/pG7tnmPU2SFTR010Lo3upH9KiYPd48/BcPLuOX28zmqPmgoZc2EnFwvAaFgj
         Gg8z6OYs6446qBbf4hii2Gu3+QPh0h/hjEJOJJ3iMeAoWUESJ6ABxccxVm3rrNOMC9Vx
         bsag5wwTiQxGVMMh1Zk/syYIDZfZD6J/BBylFNW0evJf90rmnF2yYKvY5PZ4WA6WVLV+
         YJSrnr7HzX2C2YD09LLWxvuqMKe/dpGS+hWM9iFRFBLBXnsIXEI5e5I0Qxx2TXjg5emv
         mOZeK+9DG8U894xMbDKVgyTw/vPjBT/9CW3cHlrJ17OnRAZSIfOj5oyTam7c/j+BChUs
         /sBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ItnmIQsg6HdPMCNQzlaSI2m0CMAoirO4akWL1c1Qd1U=;
        fh=7G7L2Ny+E+cJcpkypmioo+YjAIoyNxx5uzCWDuTSgwE=;
        b=S1FNnX9haRCajwNQU+HsdYJ9Kymi7G0w1mV11On47w13F1pRPH4UlhUO9h/IadjmxY
         u1rF9gYSgQHLxHtpqaP5TRELDeyUywilfnsiCjsUVSfBZX+Ois+hZNi4O5FceN+0cKho
         Ai5wsryvurmQEPQtO1+68XI0BiBKFYq1vPml8amHRZ7OWI2KUTkeqhsoTA4SWDQErsIy
         5dRrwAlYOU/LfL3KbzNAHlk+cmRdKLkNEFsyFYLWU7jefFJadiXmiNS6LQs50B1dPPyG
         qrbjeJ/XE+Cz0lmeft1T9Nyw2bjCe89GzboEtk+i4FlUcaC4canowfLsQO6jSauuM+Yg
         JppQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791291313; x=1791896113; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ItnmIQsg6HdPMCNQzlaSI2m0CMAoirO4akWL1c1Qd1U=;
        b=dIx+od5vE0TwfvJFgWSS0zWpNowz19tMscGqWE35pYU4xIJ9pyFBFTyeU8QcxP02ZH
         8Cwy9QuAy9m1r/03HLUTezcNpyxk6ZiU0Ib0i3QURoGnN5M+aMdFMkbrLf/w7SP/QBMm
         Reg5xpPqtXM+3a7ODNl3sWH78QKhOa9xE8adfJ+a4tInZ4UgELmernowG1O/msRclOD6
         2DJ3kljPjb42FMoQDAyDr9k6cgDFrEUFL2jqJ+0dMxvbZe46rnLmVn7oYedpBIsdhdwO
         os2r3pI01jmqSkhOB1QKcBcsaiFqDbDxYjYUYL67hzQlBzoxXScQfaKXNlkH7Vh7ObDF
         XuYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791291313; x=1791896113;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ItnmIQsg6HdPMCNQzlaSI2m0CMAoirO4akWL1c1Qd1U=;
        b=Ff6NCH/XvZck7yxgy00F0lxmdjF6dx6m6aH+JtEvHG4PJNldKzccVyfbNXrVpCxdba
         +JhKBb6s+ZmGnhs+dtxjxraES/bcmOyAYDJNR2sbEVhFJIhXhGok++si2QxFTvH/Jp6+
         rXsTHz6oJ3SCSq9gsxBduBtlfWyZ6Q+MRA/eWvsqSL4fjXPgqqrWcGre8hHsVQmQHfS7
         zbSYBsnn9iRnOBEfOOnecYGwacFuWvVMhrHlg8oDaeeTNCWYyVu/o08qmPExfsZGjRPl
         6R0k5CQAdcyAwVwI7O2N9mQOJ4iTt7WYfdezjDKJkutY8F9s8jXX1fXeo0q6RLwk+F7W
         JfWg==
X-Forwarded-Encrypted: i=1; AKwUvBwRRJSrlJJIivErVhTc9Zr+sKxjOAlxnXks8x0+EDBkxb2Y2Dpd0rw5Wb4dOBbmK5tq4Mj+9n5g@vger.kernel.org
X-Gm-Message-State: AFq9FYKtSxgt2kymcBWN5EASOcWUl9vLLF5YurzIBRK3VwzURB6ymMPP
	FV7Ywbb3CzgmMpQ9dshrU+hlUTY9SMnyoY+5mcU+4hreXmvM7gTf5WcLUtWfD2I/fB3z6xrJl1+
	z1svJP4imlsoP2gx6ud7VNvToYaiRel8=
X-Gm-Gg: AYBFou21sswYqcCDOV/9Tj4t+z0uSihcJIw3yGX3MEGHMUG3Q3Rq/+FjCSr73ZrNS0s
	9X7SUKLWGaVNrI8LlPHoa0MXJfEI/wnCsaIMoF4x4+lH/zqRfTlRhBp7gUqBJjCK6euTsOL0OnW
	9Oem2cHIVpScVtOgmp0XJ/lm3kia/bEyIc+bBV9PU/PfChDP6of1BfwqR3Q1wcK0rYHyT6oE/rX
	bQmaWzs0hEhfVQ53oPUYiXJ3tr1t1N14s6qZrD0M1ytdQG+sJ3hKX0YsrEqIm2hQqKgGdWd3Sxx
	yPV/A63JM0hV7Qaz4gdPwutNQuRiUz4QARKrKg34Dhk8+CzXbzQ+sSg=
X-Received: by 2002:a05:690e:484e:b0:677:c24d:ebfa with SMTP id
 956f58d0204a3-678fcf01d37mr262989d50.58.1791291313347; Tue, 06 Oct 2026
 05:55:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ6Ria-P6quOcjwkGSGdEyFRVCiJ0b+mwsd=LXGR5oW-Cg@mail.gmail.com>
 <20261005133120.2552484-1-bgrech@redhat.com> <CAEjxPJ4KY+E58gPPqvaKW_cBY=j3OAq+XU4BU=SYD+MUAoCyog@mail.gmail.com>
In-Reply-To: <CAEjxPJ4KY+E58gPPqvaKW_cBY=j3OAq+XU4BU=SYD+MUAoCyog@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 6 Oct 2026 08:55:01 -0400
X-Gm-Features: AclHuK-jVQh0mlerwBpASi1MPGNyShhXAVeyfxEqImVxJ6jVJX-JZCxLqAX1oqQ
Message-ID: <CAEjxPJ7VdVfrtDKZ47Bhpr=W7sXSPmdb4f6D9SkpY0RT3jJ0Xg@mail.gmail.com>
Subject: Re: [PATCH] tests: make IPv6 subtests optional on IPv4-only systems
To: Brian Grech <bgrech@redhat.com>
Cc: jonderka@redhat.com, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2026 at 10:41=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Oct 5, 2026 at 9:31=E2=80=AFAM Brian Grech <bgrech@redhat.com> wr=
ote:
> >
> > Skip or adapt IPv6-dependent subtests (inet_socket, extended_socket_cla=
ss,
> > sctp) when the system has no usable IPv6 on loopback, instead of
> > assuming ::1 and ip6tables always work.
> >
> > - Add tests/has_ipv6, checking /proc/net/if_inet6 and disable_ipv6
> >   sysctls.
> > - Gate IPv6-only cases behind $test_ipv6 and adjust test counts.
> > - inet_socket/server.c falls back to AF_INET when IPv6 is absent.
> > - Split IPv6 firewall rules into nftables-ipv6.load, invoked only when
> >   has_ipv6 succeeds.
> > - Select address family via has_ipv6 before entering confined test
> >   domains, rather than probing IPv6 from inside them: that probe can
> >   itself be denied by policy, silently selecting IPv4 while the runner
> >   keeps executing IPv6-only cases.
> >
> > Co-developed-by: Jan Onderka <jonderka@redhat.com>
> > Signed-off-by: Jan Onderka <jonderka@redhat.com>
> > Signed-off-by: Brian Grech <bgrech@redhat.com>
> > ---
>
> For future reference, normally one would add a "v2" (or "v3", "v4",
> ...) to the subject line and put a short changelog after the "---"
> before the diffstat describing what changed from the previous version.
> No need to re-spin this one though.
>
> Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This has been merged.
