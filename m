Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F22460DC3
	for <selinux@vger.kernel.org>; Tue, 13 Feb 2024 19:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707853028; cv=none; b=jmE+l/7uQR6bnH7eUDnMb+RYZlhQaFnmLIWzIolq34JujLk3h8PtzdvE3nEfsulIf1jw4mbAMs+HFU4j3/ClBQ6fVuafkoOC4OO5rXIf3FqIi68HiRYfPlTfq1aPNUa9S0yY28eZwdeWL+SPI+q7QyfoRlCrQxX3/hMvMvhB4cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707853028; c=relaxed/simple;
	bh=u46SKisFUMLX/7IWDChtoyZvekWmFrOtp6qva/dUUug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MGoj6aeBNQSCyPywIzdXCc6Qma5zEpdfkkA9t62TU4vYlDssJlkCq3DKHdLEPIbM9qX2Q1pibPcAPlBDX1LoOIEv2lMFAoqjl/6kanuBQV99r4YKujiGrh17WVBLxujSIULynTQrQIWkrB0unngpPDGUL8KZyP4N2WOo1LryxaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KVx+9tSL; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KVx+9tSL"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33b29b5ea96so41030f8f.0
        for <selinux@vger.kernel.org>; Tue, 13 Feb 2024 11:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707853025; x=1708457825; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=di/4NnCIukfz7My68Fc8zeRyDvoUNBZ0RwAPGewxckI=;
        b=KVx+9tSLFzP/sXM2mUrcc3OkwN7oi0FvB57jDskUUzkHFGMMg7TJlbbYANeuveYZIb
         OqKc7T3yPxk83MRMMerk/1eTr2b5DF0ln9wJ23w3BugDM8l71Lw7rkgUSB+9t1nsz4CZ
         Hz7pK3RK6mXEhyner87vvdDfoTfCswqF2vKQ7PybAgnKLY6jZ+M5Hj712cpR6WGXxRks
         w2Lr+YmQmZhm0cHmHFdz0PYdAlHkHLWPh3md1RxvqlTXMduoFvH+mRrQ5quFqlsc0Oem
         xQ3adxTyZRwqCFCE5USZgVfN8wMe6DgK04rerIcoY7pDBxppxfxjKFHf8GkaVFtmp3v8
         R4ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707853025; x=1708457825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=di/4NnCIukfz7My68Fc8zeRyDvoUNBZ0RwAPGewxckI=;
        b=CGa3E64qaJwDYsYmwBjGYKFu35528E/5tR0AczfWxL/uyhSYHOGHsuadA6fLo72TAh
         RMuQA6noIpKXhbeWXcPfJi4+O1CYdVAup1phwKf9UdX03MMS4iJsPQ6orv8c8Bo8xd33
         ecUaFt+ZlWFu0KDjHqdTK1yllmA/W5EDMSEnldMnQnXmJbugfpjz/PAazsT235syLmz1
         Ofk+iSVG+TsddubSR+gZ3PxtQML+N1bj7r5goAxf/c/VVr+wCkWIGpcc/EEGtTqf0fxJ
         koIu63Xs4O6EjWHtnAvBcZiDtzXDTTG1COh6Brh34Xpb+S676KbMxAD+DrfvBvA0jFNf
         SY6w==
X-Forwarded-Encrypted: i=1; AJvYcCUzKfHUCyBeiDkk3XYO2xWtyqro7nBUfI+KLaF0cyOQ1grvTUBtbCpD+sNsieMSK8Dkvt+OYO6sb1bup6MJxdLEvidFzj7vjg==
X-Gm-Message-State: AOJu0YxZRnTYnU9a0O0DXsYAWQ8lgpY5ejPP+2bUjZmt5dGgrfErFKJa
	8zZ+uLYzRiWsIHRe1q3XPh62lslbv0u/2tl/G+CA+EG9ehT7PDyn2xcGJDuvaxQMUrgcB3z1Kni
	uuTGWlpCobXoy5Y7bhAAfT+FC+Z1O/YPFQ2Q8
X-Google-Smtp-Source: AGHT+IF/X0BETIZY0DVItf74GRHk+a/+RMMSZBAlSw2R6aVsGAmjD3msuAjj/xJbHNp5zhWUpY5vNmKVyF9bPKq3C3w=
X-Received: by 2002:adf:e946:0:b0:33c:e084:aaf9 with SMTP id
 m6-20020adfe946000000b0033ce084aaf9mr448611wrn.4.1707853024662; Tue, 13 Feb
 2024 11:37:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213001920.3551772-1-lokeshgidra@google.com>
 <20240213001920.3551772-4-lokeshgidra@google.com> <20240213033307.zbhrpjigco7vl56z@revolver>
 <CA+EESO5TNubw4vi08P6BO-4XKTLNVeNfjM92ieZJTd_oJt9Ygw@mail.gmail.com>
 <20240213170609.s3queephdyxzrz7j@revolver> <CA+EESO5URPpJj35-jQy+Lrp1EtKms8r1ri2ZY3ZOpsSJU+CScw@mail.gmail.com>
 <CAJuCfpFXWJovv6G4ou2nK2W1D2-JGb5Hw8m77-pOq4Rh24-q9A@mail.gmail.com>
 <20240213184905.tp4i2ifbglfzlwi6@revolver> <CAJuCfpG+8uypn3Mw0GNBj0TUM51gaSdAnGZB-RE4HdJs7dKb0A@mail.gmail.com>
 <CA+EESO6M5VudYK-CqT2snvs25dnrdTLzzKAjoSe7368X-PcFew@mail.gmail.com>
 <20240213192744.5fqwrlqz5bbvqtf5@revolver> <CAJuCfpEvdK-jOS9a7yv1_KnFeyu8665gFtk871ac-y+3BiMbVw@mail.gmail.com>
In-Reply-To: <CAJuCfpEvdK-jOS9a7yv1_KnFeyu8665gFtk871ac-y+3BiMbVw@mail.gmail.com>
From: Lokesh Gidra <lokeshgidra@google.com>
Date: Tue, 13 Feb 2024 11:36:52 -0800
Message-ID: <CA+EESO6TowKNh10+tzwawBemykVcVDP+_ep1fg-_RiqBzfR7ew@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] userfaultfd: use per-vma locks in userfaultfd operations
To: Suren Baghdasaryan <surenb@google.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, akpm@linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, 
	kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com, 
	david@redhat.com, axelrasmussen@google.com, bgeffon@google.com, 
	willy@infradead.org, jannh@google.com, kaleshsingh@google.com, 
	ngeoffray@google.com, timmurray@google.com, rppt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 11:31=E2=80=AFAM Suren Baghdasaryan <surenb@google.=
com> wrote:
>
> On Tue, Feb 13, 2024 at 11:27=E2=80=AFAM Liam R. Howlett
> <Liam.Howlett@oracle.com> wrote:
> >
> > * Lokesh Gidra <lokeshgidra@google.com> [240213 14:18]:
> > ...
> >
> > > > > We could use something like uffd_prepare(), uffd_complete() but I
> > > > > thought of those names rather late in the cycle, but I've already=
 caused
> > > > > many iterations of this patch set and that clean up didn't seem a=
s vital
> > > > > as simplicity and clarity of the locking code.
> > >
> > > I anyway have to send another version to fix the error handling that
> > > you reported earlier. I can take care of this in that version.
> > >
> > > mfill_atomic...() functions (annoyingly) have to sometimes unlock and
> > > relock. Using prepare/complete in that context seems incompatible.
> > >
> > > >
> > > > Maybe lock_vma_for_uffd()/unlock_vma_for_uffd()? Whatever name is
> > > > better I'm fine with it but all these #ifdef's sprinkled around don=
't
> > > > contribute to the readability.
> > >
> > > I'll wait for an agreement on this because I too don't like using so
> > > many ifdef's either.
> > >
> > > Since these functions are supposed to have prototype depending on
> > > mfill/move, how about the following names:
> > >
> > > uffd_lock_mfill_vma()/uffd_unlock_mfill_vma()
> > > uffd_lock_move_vmas()/uffd_unlock_move_vmas()
> > >
> > > Of course, I'm open to other suggestions as well.
> > >
> >
> > I'm happy with those if you remove the vma/vmas from the name.
>
> Sounds good to me.
>
Sure. I'll do that:

Asking to avoid any more iterations: these functions should call the
currently defined ones or should replace them. For instance, should I
do the following:

#ifdef CONFIG_PER_VMA_LOCK
... uffd_mfill_lock()
{
        return find_and_lock_dst_vma(...);
}
#else
...uffd_mfill_lock()
{
       return lock_mm_and_find_dst_vma(...);
}
#endif

or have the function replace
find_and_lock_dst_vma()/lock_mm_and_find_dst_vma() ?

> >
> > --
> > To unsubscribe from this group and stop receiving emails from it, send =
an email to kernel-team+unsubscribe@android.com.
> >
