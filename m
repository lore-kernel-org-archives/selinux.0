Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E1C1A9FB0
	for <selinux@vger.kernel.org>; Wed,  8 Oct 2025 13:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759929370; cv=none; b=vEhH2iLkRjSKpmdFGg77lRyUurc3vtLF9Ec7KNzUrueGLNxRdmkXai/rLRBNYXeZTzLygd+5QEr0yQhZX6/Hn8RjNJoC1hTvoWwKKyKj6Wb5B3Fe1kI2rggAIlKW8NppFLICilye6Mf3AdZpr3hVrcxjDN1mp1khgvBHAsg5Mo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759929370; c=relaxed/simple;
	bh=6qYx+/z+lPHBdPXPGFP8RgooK733/VjJjn2pLT4e/4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eYVNPpQhcENcJ9tezprxdfytDc4wLcr7Kf0kHZvNabUvyibJwqsYOOTb8vwbfhQ4EpWWfsbKqON7PVnBbBsRd3MvNnAkJM7HJ1PNA0ChJsqFOLjfpFwlvoPORaxjcsnDoJ9wLSYiqB/Cwr3VXZf+XJ2sNRxymeVevnhL/mjVjwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OpNg8qRg; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OpNg8qRg"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-27edcbcd158so96857455ad.3
        for <selinux@vger.kernel.org>; Wed, 08 Oct 2025 06:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759929368; x=1760534168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l9HCfFlGnkE+X4h7oIP7P/6fW4+GzpcsomXq+bGkOGs=;
        b=OpNg8qRg53yTyd9JPBAzOdPH4VBP8a4ozgBFDR9254PP181vpANIRHk6hMw8j9cy2Q
         527RNNCKeP4Vlq1AQLjdWYi+htvLhxTxE+hiHMvNUyLlpjULM/1Mv1RVT84na/Tnheph
         /jRzx7jxZyDhEe2dBut92hqaEUPOnhrq5U8G5s7HQW1CLPG5vElgMuxkjXjL5ZUjsWok
         LxCu+aQQRHTqeDMQOvDfdT/0Coqf504E5gc9Mxp4r0/eyxWfsYetcRhM/4Tjc+EXhLUK
         rdaRJKFPIcqhEuDyfqD40UoEB+346SRPFgSxZnyAaUDFtgXYzH1H/qfJHaRBAmpkjTd4
         6eHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759929368; x=1760534168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l9HCfFlGnkE+X4h7oIP7P/6fW4+GzpcsomXq+bGkOGs=;
        b=JUkrPvxKKVR8ksfYW0yOiKCelvVEQNfCRfBqFB3baDWeRDwpw8XmQgZIVVXu5T8d5v
         nM3GCh9IY3QQaHYg3DpbBTsx4L7ES5IL+Awtfv/ClMwMDdMJ8Pn85DhMahdPvIcjOo09
         xFt/QLWMTVVlickMLUJOfJDnvuKwe3/L3NzknngsoGGl+QjnqlI+WHkZxQrxXTaWTVnf
         Dque+SuHbV/tqPAHS/0LmPMjXpd+QXBUn02ST6ubzZMJCACg/JgRP0JDfIvz1VGiZcK8
         Iy+p6ODiufmzncWt7fCS985gSiudprRso3q3NFBWEVL20B3/xlhi9qMiil6ItDcdqHuS
         RlFQ==
X-Gm-Message-State: AOJu0Yx36Uw0M3JULvW23QaorpN4NI30opNAmtVDFvaP6AgVz5xZOfRs
	E4oAKL3gjiI7RNnP7Sf4jZChGWXksPmP/R8HXeZwyESxBEeuiHC4CToDtCaEyiKa55/kO1OSUTU
	r2WBjWRfFXYhg7rBO1OCqiC+HmdxCEQA=
X-Gm-Gg: ASbGncuzyF4yHVgKAVS4LX7oqFZNNpFRrZKK+e7ZEWFe58vkl77LNQkPjbpESj7YHpH
	pR91AJWDcZONBDt6g9e/+lRYF0q6Gl25qqYb2gu20TQpkrvIAscpgGKdGJir2OCj5nHMlUxW7eR
	WNvTDk0m6fMAET2desnfes0RCBEetb9A5FS2tvjbUra8H6EA0P6a/fRkuYvn2bMvFok1O+gnjZM
	Mv/KXTKuraSA6cNjnJWxcbSShpozrU=
X-Google-Smtp-Source: AGHT+IHr6rKBJTfMiIbSbvL1Urpp/sBK0sTXrlNvwmokEti3rCbQ+dJOxdFYVuRSO1KRvabtEPTLyuzGgsHkT3ep3IQ=
X-Received: by 2002:a17:902:f693:b0:27d:6cdc:99e4 with SMTP id
 d9443c01a7336-2902723ba41mr45934325ad.21.1759929368098; Wed, 08 Oct 2025
 06:16:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007150659.33954-1-plawate@redhat.com> <20251007150659.33954-2-plawate@redhat.com>
 <CAEjxPJ5MFzohCxfjkk6x=c1V2qqBR5gqX22DY6Bc0PDQF-yzWg@mail.gmail.com>
In-Reply-To: <CAEjxPJ5MFzohCxfjkk6x=c1V2qqBR5gqX22DY6Bc0PDQF-yzWg@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 8 Oct 2025 09:15:57 -0400
X-Gm-Features: AS18NWBFzRVAQc186l9O78JT4ZjvhZSrzVeHKv6V7bhRfQNnp9WPQHLOuqVdX2A
Message-ID: <CAEjxPJ4vfm3xnpohOCpete075hTLJMr9Kbi6w0u0kMRoVa87qg@mail.gmail.com>
Subject: Re: [PATCH 1/1] improve semanage man pages: Add examples for -r RANGE
 flag usage
To: Pranav Lawate <plawate@redhat.com>
Cc: selinux@vger.kernel.org, pran.lawate@gmail.com, vmojzis@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 11:14=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Oct 7, 2025 at 11:07=E2=80=AFAM Pranav Lawate <plawate@redhat.com=
> wrote:
> >
> > From: Pranav Lawate <pran.lawate@gmail.com>
> >
> > This patch adds missing examples to the semanage-port and
> > semanage-fcontext man pages showing the correct usage of the -r RANGE
> > flag for MLS/MCS systems. Currently, users who try to use the -r flag
> > without proper examples often encounter unclear error messages when
> > they provide invalid range formats.
> >
> > For example, here is a command with wrong range string value:
> > libsepol.mls_from_string: invalid MLS context s0.c0 (No such file or di=
rectory)
> > [...error output...]
> >
> > The added examples demonstrate:
> >   - Correct MLS range format: s0:c0.c255
> >   - Complete command syntax with the -r flag for both port and
> >     fcontext operations
> >   - Clear indication that this is for MLS/MCS systems only
> >   - Verification method using seinfo for port changes (semanage port -l
> >     only shows type, not MLS range)
> >   - Use -F flag to restorecon in fcontext example (required to force
> >     relabeling)
> >
> > Signed-off-by: Pranav Lawate <pran.lawate@gmail.com>
>
> Technically tcp port 9999 seems to already be defined in my policy for
> jboss_management_port_t and has an entry in /etc/services for
> "distinct" but I don't feel strongly enough to insist on changing it
> again.
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Thanks, merged.
