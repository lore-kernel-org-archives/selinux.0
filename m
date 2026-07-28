Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3171C29C328
	for <selinux@vger.kernel.org>; Tue, 28 Jul 2026 01:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785201864; cv=pass; b=dVjgvxZ8TDeneAJ2TL11Px0hU4/MMtCENDsiUfXO35y5uVIEF0Jg2bv8x18v5cg7xHst+gE1KPVx6N7aWksltup5msV33L2AbGOKxppa7BLu1gdJFD4pQChg3ei4GHcKjQ1l3z4JmuEmpQsVkx70LFXnn9c0uNhPtZIz5g37bPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785201864; c=relaxed/simple;
	bh=pmZ57bGhv8y0EYTBc4n9Ga7ODmgX92uMpsSk1AgbqoQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tian+ottIu1I5ay6EqBp5FUf/yukJg4qc8LIPVPVfGp5LSWRXnV0DAtZ/MMDjPUa8W5jDfuPapMPCHf0cLnFe41T2Ihww0hU1smNMQA3UsxynJVP9o98pcSPA5xgo4UquMNFhkfEchwAhgHuCQ1QaYcKVh/CxAd47kcwWk531lI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IX8eF4Qd; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IX8eF4Qd"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-51c01c79467so146281cf.0
        for <selinux@vger.kernel.org>; Mon, 27 Jul 2026 18:24:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785201862; cv=none;
        d=google.com; s=arc-20260327;
        b=hJep+gxDvy5x9rUMUjq+5ixsRS+JBCOHhk9mLeGdKLcnrWy6Wq72eYdV8ILp1USp3S
         nCun5MHMxMSMQ9nMokmJryzDSlVoAJgCIJiigq1NtKUIkG6reaGlp2ChHC8wRLWF6sdU
         FgIT2mizg9IZkpo34K2CYTl8zop/MsX7vx0bIX84IoIuBgX8dnebrBxx6gIS4UU7ANBE
         VYO3vb29CiAI8L6RdpE7ewxL8RZs3E+8vBcf2mZwGMYV2DAXPqkIH5pbeLECyGP6bNUF
         6ySU8R5hU7t0J+JJasam3NuKH+2QPNYSAIEJl4eo/3JRtjGaAlm+cUAH8zQZgMHno6iT
         eAZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pmZ57bGhv8y0EYTBc4n9Ga7ODmgX92uMpsSk1AgbqoQ=;
        fh=yU0suq9uxVJnW15ds/h86oPn0TGEoRmZIoshvk4GVQ4=;
        b=ENTWPyQEgeZ/VA7BS/uyKyHstS/1/kdCFzDzIH8jFna/witKa4nsd8lr2rGvOXS8uf
         HJqKWSVynboXis//DqTM8ueRN8j/Qic2XmAuOqrugztbUkdVjA8I7vZ187gBrkI8kZcv
         CddVG99Hq2YXha00E2VqsE4mtLDOWY/yx4GYfSPAqgdbKWfpwKmHjq65mJ6kWhSUiDpt
         wB5Z23wt7UH6mHZEdo7ZZy2gQe/sL9kZ0fluahyjpaI6H3dahcnO+ck/Mf/DtbrqjQJN
         CRnWT9NqlQQEQVWabd5s+/f+Q+RLq4Cg6Rzm+3Cxah+DuI7AS6Z3OQEKa2+zsi/oe07x
         rWmA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785201862; x=1785806662; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pmZ57bGhv8y0EYTBc4n9Ga7ODmgX92uMpsSk1AgbqoQ=;
        b=IX8eF4Qddfb18Wk+BtxXIUtSmQvCv21FggMPVtz708XWcVwzzXPxYlj69A/7BVXzCt
         Altpw+0RImw6qHa0Vw6zO0/bwwnn0QNvh/TvmBZpMADbJMclnK4pSjZPuJ2mAsIWgFwF
         Gznk3LI9yFDWOI/Bqy2aRcr0mrA979E31YxR0yqINGtc7Fef/9G6afLUpf8NIAKoJGfW
         SOtCRWZHFINjvMEyYa/crzqN6OZotc5HVgJizqQg/MZPTmxi5MyZXm8MgvclA49iHW07
         VS0a8LoSJqRHkFy5jW1ExqwgGFAkzJThT+AjwWrEgMzq3mSzHbcJpGeCsCcJ1ZFVDMq5
         0U1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785201862; x=1785806662;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pmZ57bGhv8y0EYTBc4n9Ga7ODmgX92uMpsSk1AgbqoQ=;
        b=p1vFVxktUIKgFxuLT3r6UP38HenlkOaPbeFCkTWAVsvKwwgY/+RurTBfLV5Ie197O5
         OgEjkg4gYcxvUalllis69e/AktDNyBFE5bk0A1Ru5LjAp5HxjaGMtqSxeh299SRKCt1P
         Wi21PJnqfnvUzPt+N401MeHIBAmDWBSdAyi73is9dsK1Bw8dQu+m8HQSu/JHQEInFfET
         jq0BV4UQISK0wWeTGh7R67YY70Sk3iQan1vkMzPsbVFL34QMhd5fe37qnEqODRmdowIc
         4owuur+66q3l3/S9MPd26JxGZYbUnbfYRPHbMDUy22ruvTLbzd4oPqTO47Fx/TREcIpj
         xG7A==
X-Gm-Message-State: AOJu0YxZU3xFOVtapzmHc2X4ep0+k8H84G7L4p24TaFTF4xaB+b1qXEo
	c2s2xE5BHP83FSE9MiitzWoWWBwCb429v9bLXIK1uCCMmdhCuE+NC8M9s5LnDxoyUG2xa1ylrV+
	MtZMj3JXL3paY6kaKpIJPYv7HYK/8aNYbuaH4+IOq
X-Gm-Gg: AR+sD10pTL6pFnlBdg9nSCZPYwWdTF8BbIUiyW5dBr+SI8v0Bdyvcton6KdV4cFW5uP
	yCoZmmzkvDuIxQNuW+qYRzI+7erTjg7OTpjslNLLSF765d8rg49H2+5IFXgcx0zcEHK5rX9LKbn
	ciV5+zkf0DjMttvCjzmYZssaKOgsCL+2BMO02XUE+vopyateLFYTP4++cp2AT5JBlL/n1uhK0hH
	SMs3Xs5tQX3fm6o9jg5AHRA+Ekv3/s7a57HoPbMnBBHwGnSCWkBJveQEq5xW8LBQYgSlsJt5iI0
	qcOIeWoFo/bEsoL1jneT60tVBFGvHVMKyGi86vhPSY5IxA==
X-Received: by 2002:a05:622a:a9cf:20b0:517:5ac7:332e with SMTP id
 d75a77b69052e-529a5e705b1mr46823311cf.6.1785201861475; Mon, 27 Jul 2026
 18:24:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727013929.2457799-1-tweek@google.com> <20260727013929.2457799-2-tweek@google.com>
 <CAEjxPJ5bkPUXBF5ge0zChcWHQVxMX3n0dGRFsYJnuSyfk44BCg@mail.gmail.com> <CAEjxPJ59uCpyzqv6mAt2C75DBnhQxnYiAUg_U65dRFrvJJtmvQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ59uCpyzqv6mAt2C75DBnhQxnYiAUg_U65dRFrvJJtmvQ@mail.gmail.com>
From: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date: Tue, 28 Jul 2026 11:24:04 +1000
X-Gm-Features: AUfX_mwBdR2ZhN_6NADNv4JHhliiOHiPuUwfIROp9u-U9shPJJeIoC61cx06McE
Message-ID: <CA+zpnLcGR5WNW8goyTj8-Fveha7ES_8F+zoc0uruuMWJvzmP8A@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] libselinux: support multiple context files for the
 file backend
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, James Carter <jwcart2@gmail.com>, 
	=?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 6:16=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Jul 27, 2026 at 9:30=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Sun, Jul 26, 2026 at 9:39=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@g=
oogle.com> wrote:
> > >
> > > Update the file labeling backend to support specifying multiple
> > > SELABEL_OPT_PATH options in selabel_open().
> > >
> > > All provided paths are stored in rec->spec_files and processed during
> > > initialization. Derived files, such as substitutions (.subs, .subs_di=
st)
> > > and auxiliary contexts (.homedirs, .local), continue to be based on t=
he
> > > first path (or default selinux_file_context_path()) when enabled.
> > >
> > > Duplicate checking is only performed within each context file. The cu=
rrent
> > > behavior expects the ability for a later file to overwrite a previous
> > > declaration (e.g., .local).
> > >
> > > Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> >
> > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> This series is merged.

Thanks for the reviews Stephen.
