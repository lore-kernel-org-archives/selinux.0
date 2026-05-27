Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9231E382298
	for <selinux@vger.kernel.org>; Wed, 27 May 2026 16:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779897969; cv=pass; b=ELVvKGRgZYKzxBU40n0xUAVnG/g0LNQjwT8fT4SwvxlFmXPguRQ2FWlH5tQv+tIgc2UUsnaQ/Ak2PyXRhOg3a+b14N2UNp1SYxzaWfpRo1MMi4BnUSRg2DP8Bdv6nwk2P0ogRvqy6KET6FnCQH8bndSCXpGs3erKLEGkzGhjpCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779897969; c=relaxed/simple;
	bh=i1icdQSbLVKb84W8T5OLxldeI4K9rAc4DdjpT+GW458=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T9XngvPBAQ/uuvBIWTbwIObWH2Kq672ZjA/nEXjPYQ9BQFI3OcV8sTlli950oGcU/0BRNvBi+mf1asO5rRbjEzcGArdGUIxUXpNEzwHVpcDcwJVFvwmFphyh4Or5BacZlBsZLZnO/LQ9PXhNb6eaus1fVngaSy3aRGDDyUVBoDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GLNhVbzy; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GLNhVbzy"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-65eb226b1ceso6245810d50.0
        for <selinux@vger.kernel.org>; Wed, 27 May 2026 09:06:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779897968; cv=none;
        d=google.com; s=arc-20240605;
        b=GNJ+71Fj0ce83i3biHFoSLRsK5vZ/tt6Kfl04aYmvCY0aPnGCGho2ImbZ0GLG7/3nE
         clIa2ODJiuQC/exGSBBOSNkl0v8lNVnzh7tDLzydhqIVgu43HEuMRfxEG92RssvYI8iq
         yUu0ng0+AS0/QNMryOzEOgWVLpaehQYftQmuRNeVoUqKBw+QDPAInLVSbtGUGP7Wq98p
         FFsieIueAxkXjBKewbk+s5oaDwuEZw9ph53aW6Ny+W4HZZdcaWkl0V7xHJKc/eOxv5Uw
         yx7wtSGfKZ4Su3ePYESRT+IS3O89TiV5jvKTx6c+2fgUPOs2kpJURz9bJbbT5pzUEua9
         sf9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MFz0JpS9h6a1QbnwdkkCkC2M7duzoq5zRNrxnxL5G8E=;
        fh=sz1+7I1/MMp1RL8/VkYFLlzcQfRnoqOPVR6yLViC7qE=;
        b=PhZP9por21miUlVMe0Bo1AGyPFGY8KbzMCWIYZ7AVYqXo/Wvv6GI7rFlTQI46n3EGA
         fCRB+lfS/nvjrskn59iA0v8feJ0p+J7E4W2TV54gwV8k2LrF3CZqYb48fGMniADySjzj
         bZ482ucA7f+blxEeuLD8VjJI68u8ayN5w/t5cS0WUOFSkYsXVyVVoO0aDjoDZ8iTN5MN
         +KzP4sITpDj3P5r9HCIi9uY5zmwUxFbpv9dy4cFrz7BSSey5G/aOdUL0tDbR1Sm4Pkyj
         mGauto1cFoCwln+Wfqh5VHW7YYpDFJxrvOL/k3P4Hgmr031MoK1vHN68GRTIGfnxGm/w
         Z41g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779897968; x=1780502768; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MFz0JpS9h6a1QbnwdkkCkC2M7duzoq5zRNrxnxL5G8E=;
        b=GLNhVbzykXj1By6sKduBzX9bIuxZq5cstweJmApT0hJhUcQpJRvziX/u8gC443JLNB
         Pn+KEPB94oam3RA6eAdMdxdQNsmoxr84pxJaQaixP9gnNX1lIw16oChbRDrmZeWiLyUW
         Q688DPqK9kBgxpql0x+243bTUa8+kCRJvPC4liYwizU7hq4ywc/imzcZ1y93d2Mde7ah
         sz5q9ULQgWaxxyR+19TBo4mYqHrwYCGCfKJGHlo7K/WMCR/3Ow05mgv80a0sQi1AGcC+
         BXaLV9wHgtS5wvxehcsoA3c7Ce8H2I2x9OW83keOPYLBXVxMrGnVBvDlkNqqacZjfID7
         GUQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779897968; x=1780502768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MFz0JpS9h6a1QbnwdkkCkC2M7duzoq5zRNrxnxL5G8E=;
        b=or7FN9GeRwuPLFa67JzYfe/Be34dN1xIE8FJSfGhMG82PryUOUdxJsHy3uJ+tRk2Zb
         jsJhSCpG/HBfDUxmnvGfBm/mqqF4mX/DkgfX/pBZ2uZ+h3Q9u9tXX1cXjTYOxs0B219g
         Q302X6XdaMpEYg12K6Nx+i+9c1B/8I3vbnwy9n4QmvLQZouxFTdM3yXtg+hKvIfGJvyG
         4Ihi9Gaf2i5rel+IbipFTPl7P65ny4iVnH2esiYf+7uRiItt3PYYcMmsCRep9YvSnPA/
         YCeqyMSSg7/WpUQWsZwBxumxeI0xz9nIQZFTNig7MuTndYFkUO6H+BFOvz1qPJxBRI6l
         T7Tw==
X-Forwarded-Encrypted: i=1; AFNElJ9Yfv7KMaNSCfFWSBWEoCRHXBEce+S/piJ45tTOjR1UE2zn3v0FkMel6Z8CBMaFQgjZu/0HDRLD@vger.kernel.org
X-Gm-Message-State: AOJu0Yzoogto+T9fvClQdAEGeMERuwTpDPwoLl0ym9ITzRWb65thXP/+
	i2H89nr9LXpIvBjm2GQY3Tz62jY3gMfiz+KQQBdEG7ap/jDx/k8o2DLu8PuTDUWtOVZYX3MOCIZ
	yU8imYSsTZZuXRO1m6BbWXb+sPZf88Ro=
X-Gm-Gg: Acq92OGK6H5y15Se6H1gJvlDf+fkVc6uhAUqhAlqSagfQg/lqogsB/wGiKYF+oS+i4j
	o4BUQdMc45EZrhWbV4eQ6cNmHbvvZ2UvXr5pWPpMuQ85IVfWys8XemApjr8u+BrCSfhqLXmnLYy
	QW31Ef6SqasRjEmmpsOvwpcWBeYk5onAKW+iZSDe76HHfyUeDfT0Z6JAl/VCeU0XqM8keeeitlc
	mRekkoRhTPY5YlhrgIz97F13cqeScu6YREV079cLw93ygmh24AHAKeQnYGyzfbHOLm0qy0rsTdu
	tLN1oeFQALhd8nvxdA==
X-Received: by 2002:a05:690e:480d:b0:657:a0f4:ac1d with SMTP id
 956f58d0204a3-65ec95f0ae3mr18086212d50.12.1779897967362; Wed, 27 May 2026
 09:06:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFftDdrzV2xC7HBcgS8EPb-YewJyCK9uos4crXOCh5ONm6SxSg@mail.gmail.com>
 <CAFftDdqp8b5n21hdEP6w0-PK+CoG7mmQxgrnhpBLU7-1GZxniw@mail.gmail.com> <090a355d-3680-4113-a542-ff3b1c565f58@schaufler-ca.com>
In-Reply-To: <090a355d-3680-4113-a542-ff3b1c565f58@schaufler-ca.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Wed, 27 May 2026 11:05:56 -0500
X-Gm-Features: AVHnY4K9DobnEhOiqOKEKCFAfQjNn8RffoFCvgjm5aUjo7D7Cai83DC0JmhlLS8
Message-ID: <CAFftDdqvvqrbm=+XsDdkJHdm12jxK9799_A=Txz6Q5goYC2ALQ@mail.gmail.com>
Subject: Re: security_task_prctl: why -ENOSYS
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: LSM <linux-security-module@vger.kernel.org>, 
	SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 6:42=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
>
> On 5/26/2026 4:21 PM, William Roberts wrote:
> > On Tue, May 26, 2026 at 5:39=E2=80=AFPM William Roberts
> > <bill.c.roberts@gmail.com> wrote:
> >> Hello,
> >>
> >> I am trying to understand the motivation behind having
> >> security_task_prctl only continue if the return value is -ENOSYS. This
> >> seems to be very different from other LSM hooks I have investigated.
> >> For example, in other hooks, the value from SE Linux avc_has_perms is
> >> used directly. This essentially means that a 0 will cause the check to
> >> pass, and anything < 0 usually an error.
> >>
> >> In commit:
> >> ----
> >> commit d84f4f992cbd76e8f39c488cf0c5d123843923b1 ("CRED: Inaugurate COW
> >> credentials")
> >>
> >> (8) security_task_prctl() and cap_task_prctl().
> >>
> >>          security_task_prctl() has been modified to return -ENOSYS if =
it doesn't
> >>          want to handle a function, or otherwise return the return
> >> value directly
> >>          rather than through an argument.
> >>
> >>          Additionally, cap_task_prctl() now prepares a new set of
> >> credentials, even
> >>          if it doesn't end up using it.
> >> ----
> >>
> >> The check in kernel/sys.c is currently:
> >>         error =3D security_task_prctl(option, arg2, arg3, arg4, arg5);
> >>         if (error !=3D -ENOSYS)
> >>                 return error;
> >>
> >> Should this be something like, "error && error !=3D -ENOSYS"?
> >>
> >> I ask because I am looking to leverage this hook in SE Linux, and it's
> >> annoying to have to coerce all 0 returns to -ENOSYS.
> > Of course after hours of banging my head and one email sent, it's more =
clear to
> > me now WHY. This hook isn't meant for making yes or no decisions on an =
operation
> > but rather to also handle special prctl flags for an LSM in question.
> >
> > I guess with the said, do we want this interface to be used for both
> > a, let the lsm handle
> > this prctl flag directed to me, as well as a yes/no security decision
> > or do we want to split
> > this out into two hooks?
>
> The task_prctl hook is used in capability and yama. It is only used to
> provide a place to process LSM specific prctl options. It is not used to
> make security decisions outside of processing the LSM's options. If you
> want to make security decisions on general prctl options you will need
> a new hook.

Yeah I finally saw that after I sent the email, as always :-p, but thanks
Casey for confirming my understanding.

So now for naming... We have security_task_prctl for handling random
prctl interface calls into LSMs. So what should this hook be called?
Perhaps security_task_prctl_check? Should we rename the old hook to
something else?

For now, I will just pick a name, but suggestions are welcome.

As an aside, any lore as to why go through generic prctl vs an
LSM specific filesystem or an lsm specific prctl (we already
have arch_prctl why not lsm_prctl)?





>
> >
> >> Thanks,
> >> Bill
