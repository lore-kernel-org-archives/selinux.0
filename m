Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4834313277
	for <selinux@vger.kernel.org>; Thu, 13 Nov 2025 19:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763062166; cv=none; b=jeG39PolC6xiQ1gS3l/Txkazjl0PcBkerOlhIT2TOS9c22gwcHOflaWoJ11lt0DyxuyFI5VdVd56RiiC/Z3XGmnqidB/AHEnmamSrXBWhN+QIUXAkx0kf1jxAIkg4+4RUKktNMgm1Xz4tvdHzJHItSnzaOzFTntnq7eAyjXrjkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763062166; c=relaxed/simple;
	bh=CEq4tU2WCcnzFeDgdxomB4ncWDbvLxiJ62NP/GXl/4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RpUKlxI/PN/hoyPJI47IiWcnSQYT7ClRDBavW7CROfUpcb7rjtn2LKndoRtw+PfatiFKrRP4FYk+YdHbmCFyVlardgnEdhyKfKCePFM8LmXLs74iciob1hvE+hc0Yl/wJUXdGqZg/2ZDf/ONRAtM+XxkJbz/2eKJ4FgOspjHLyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M5xm1C4G; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5xm1C4G"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5957e017378so1417804e87.3
        for <selinux@vger.kernel.org>; Thu, 13 Nov 2025 11:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763062163; x=1763666963; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5xInb/ufNAWLBJ4zgyue8i32zFjpPKSB351NIXd8CHI=;
        b=M5xm1C4G8D3WAoadu5r69H0dnr+p4Y7f8i00ZWYJo1vsC9BHXJDJBstqeIA6i6HJ2U
         sBJueqaaGcEeD3kjAuwoFGeM4OZVUD0fysO7ceDgwA+DQrTFNjtjdRAuYpKbcE9cM1Kh
         4AitLpTNJqnFbyXOcmsW3GHsKqhUu0GewkP3crDvWkCS56vmpWiJFJSUMdQATrBIxnDt
         7le1GYPbve6kA/c0vvcXLTrne2WMhJg3CQLSwsj+el9qpJxHQfoYAB3XM5mPM3Ji5iYD
         iNZuqEWAgRWFOYWutcujomzbvc6kMfXjRFUBHwzsOHER1dE5BCTbCL9eIzsmglhWZSxr
         OnLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763062163; x=1763666963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5xInb/ufNAWLBJ4zgyue8i32zFjpPKSB351NIXd8CHI=;
        b=Q1gO9b2voP2NzD2jIoPoykCfGHwMgWDVwZNrJ+XzlgALy0z3zzcfiHOYsVCT9uswN4
         UaVJcyrhIXNhjbU049Uc7GQvrwBTiSOt4UFMv9WfDg1+5/AGJNQyEmV9TAPSDA1Y+iTp
         3vbibrHgpGvunQy2WClUcMzAxXqB3UiZaA6+QCdiTmbiM9tPuXeK6ODs0ecMw34StyXc
         HxtDdsbEs/ZpYKhZ0TVnghlUj/ncdaQQRuDjcVUhAaRGt1sk6DP3lGWf+Q0Zb/mABC1A
         8psuaGqTACjsiuXOTcI6bdRvfZRQs7+eYXHdVKSttSdnNdBaE2H4BM93cVwyjB/L/9cf
         DIPQ==
X-Gm-Message-State: AOJu0Yy4LPH0QlwYS/Ygwb9BNbBDRGeqssSQotzT1O+Mw+1+zUg2uw5c
	6+ySIr7QGNGwee9oBPIE3pJh/th7Aimx6BhSqNLvv2Qlb5KG7zxeCOCHFSOqvHwF8BoTZjKWNkz
	71KSFQr4Igjhr4W7kuI8+uXQHwQZ7QngZERTn
X-Gm-Gg: ASbGnct0WkGitX1F/fGT07MCepv9hMYFZ26d5cTf6URqwyzpg8Xymdvatm6v+2DyuTa
	DZoS6sfnrtF3LqiQaTdvx5NiTtPzIu1CrUA7wL/5qdGwtDqnMwosCOr2K+2DGHkW/4jgseyec1P
	JtcV1zhuMCbKvTnN30PtffZZvRTW9PcV7kD6H9uW/Cu3xACCvrr/lJ91tkqYG2P5bd6itt0MKgI
	BmLpLAfWNHFWT+8TIOA6sEuGUnpQGpiripu3T3TDuYPVq+trTXJDkUqEgk5PmaSAGdRTFX2
X-Google-Smtp-Source: AGHT+IGMUB3Y7Pe3ApPTCher0WFx/jNI1iim9vWpkGWfQUCBVu10sSoYILh3e/iiKvBg2lPnCJ/YGUqb+tIg4B7rN7k=
X-Received: by 2002:a05:6512:1508:10b0:594:2f25:d488 with SMTP id
 2adb3069b0e04-595841acf90mr147295e87.21.1763062162623; Thu, 13 Nov 2025
 11:29:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110180935.202229-1-vmojzis@redhat.com> <CAFftDdpQM3mgBsR9A1F=ybfqU7Wwp0gbKbvYjTc-Bdz1fatPYQ@mail.gmail.com>
 <CAFftDdoSdF2NYRichwF2pfNdriChOf7ob+N+CN7OjWZafLwGaA@mail.gmail.com>
 <0d41ceb7-5173-4360-a746-c258e86089e8@linux.microsoft.com>
 <CAFftDdoTR5ae1qORSjPuOj5ea1O15qtgrRiadhTp2HMh926swg@mail.gmail.com>
 <CAFftDdp3ZChoaVF-5FN=O=b09Hv6VSXAUzRQ0muW0NParjZBhA@mail.gmail.com> <394ce63e-2ea0-4b0f-9196-bb47c6721f85@linux.microsoft.com>
In-Reply-To: <394ce63e-2ea0-4b0f-9196-bb47c6721f85@linux.microsoft.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Thu, 13 Nov 2025 13:29:09 -0600
X-Gm-Features: AWmQ_bkgDIuP4wT7WxZzYZ-Jx6yx1Tc5t0Zs9V_LOartXErWwjE0wcJk4ZoUeMk
Message-ID: <CAFftDdrJ=Grx6_eHZXs5L0bN88WS7bG7XRBMHtgtYLBdYCXSuQ@mail.gmail.com>
Subject: Re: [PATCH] restorecon: Add option to count number of relabeled files
To: Daniel Burgener <dburgener@linux.microsoft.com>
Cc: SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 11:36=E2=80=AFAM Daniel Burgener
<dburgener@linux.microsoft.com> wrote:
>
> On 11/12/2025 7:43 PM, William Roberts wrote:
> > On Tue, Nov 11, 2025 at 10:34=E2=80=AFAM William Roberts
> > <bill.c.roberts@gmail.com> wrote:
> >>
> >> <snip>
> >>>>> I'm no longer an SELinux maintainer, so don't let my nack stop anyo=
ne.
> >>>
> >>> We have a need for a similar use case in terms of ensuring that
> >>> restorecon actually performed relabeling, but I agree that I don't th=
ink
> >>> this patch as is would meet our needs.
> >>>
> >>> One thing that might make the patch more usable and address these
> >>> comments would be to instead pass the expected number of relabels as =
an
> >>> argument to restorecon and then return success if the relabel count =
=3D=3D
> >>> the expected count.  That avoids all the problems around exit code
> >>> handling while still verifying the count.
> >>>
> >>> The other problem though is that in the presence of globbing it's not
> >>> clear that getting the expected number of files relabeled means that =
you
> >>> actually relabeled the files you expected to.  But I guess the answer=
 to
> >>> that is just "don't use the count feature with globbing".  Even witho=
ut
> >>> globbing though, if you don't relabel all the files, you don't know
> >>> which one you skipped without extra handling, which seems like you
> >>> really don't need to know the number relabeled as much as whether it =
was
> >>> the number you expected, which seems like a point in favor of "pass t=
he
> >>> expected count".
> >>>
> >>
> >
> > Sorry I accidentally sent this only to Daniel, adding back the list.
> >
> > With -v doesn't restorecon show what would be changed? Perhaps it
> > would be better
> > to add an option that produces some standard formatting for an audit
> > trail and that output
> > could include various statistics. Then folks could parse those
> > records. I see -p does some form
> > of progress/status meter as well, for whatever that is worth.
> >
> > <snip>
>
> My two cents FWIW is that being able to see whether you actually
> relabeled via exit status is way more useful than having to parse output
> to get at that info.  There's no need for the complexity of the wrapper,
> no opportunities for parser bugs, and you can just directly succeed/fail
> a systemd unit or bash script based on the return code.

How would someone distinguish between error and one file labeled? It's
also clipped to a very small
number, so will it really be useful on larger file systems?

We can simplify the output to stdout is just the number then no
parsing needed, albeit
we may want to look at the verbose option and define a format for that
as well (not now, future work).
So folks could do -vc or -c and have a way to get an audit trail of
files and a count independently.
The last line will always be the number in base 10 with a newline.
POSIX shells will strip that
in assignments from command substitution, so you can still just use
the number directly.

For -c:
set -e
x=3D"$(restorecon -c)"
if x =3D=3D 400; then
  whatever
fi

For -cv:
x=3D"$(restorecon -cv | tail -n1)"
if x =3D=3D 400; then
  whatever
fi
