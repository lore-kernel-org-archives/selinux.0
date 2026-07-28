Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952512EC0A2
	for <selinux@vger.kernel.org>; Tue, 28 Jul 2026 14:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785250269; cv=pass; b=ElDVv4mSRCd8rGfgO/ncPBTeB/ckf9qnQjobA3GYrUgAelq8qzTUeMbICB9DchKwtRhXz/X9I71hJp4ZjnHVLPubS4yuIVIUlc5o5NnDyygkYdVZneBLHXQrvHdXYZd47FrH7a53JrZJ6vz8TLp9Wv6pctcFViuig+dWjbiiNzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785250269; c=relaxed/simple;
	bh=SBPbMPXfBLI/3mVKdq89R8RVbDNxPDLMoLYiSWiy5OA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fV7WNop5lszYAuu7RRjT+asSY0eeZXlvtxc/R9zXCpfqUPQ3XCUBCGvz3ainEY1jgU0e0xgLNmHEFmRXzOrt3S9FOCIDcoUBvrrrxAkySIYdyffaPcKaKJ0lEuuY2uUocc/EkVtFO7M+JlGgWmt4odr5P2QrhGa7BGItcsMHcYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZYyGTxMs; arc=pass smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYyGTxMs"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7eb64371a2aso2389288a34.0
        for <selinux@vger.kernel.org>; Tue, 28 Jul 2026 07:51:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785250266; cv=none;
        d=google.com; s=arc-20260327;
        b=oGFPphERS3q2x7VO9bDt2rzZRuMVsj62KuMcPa6sx7moIj9t+ATASfjNkRcC1gXmUF
         DhghvrRx1IgXbm0R5YrU6SeqyASGBENBDdK75OJY5B3sevAtBCYhvrFTCVvdhfzN5a1Z
         9KFIO+oDCSkTP7hl2VEl+0TQt7KAe1ZhnkddoXkl3Yi4/Thr1I7vg9PIKNlmJlYqqo6p
         JkA6GHLWpmhgpZLfqdJ0ePQd6NXK/yu/e+x+0J1d5nO/E8BMfULMEF6Owpk3xPAIYZJV
         OMIClVFoWGW58ClDz8qeu4fPGhg5qNO/H67/eouFliiM4RJ+NstphSyLy5M0PcjM6iOH
         1w8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MNYdphumDNBHwBWI9ok86emctjSMl+JVrJgINu9rmGU=;
        fh=E51Jjr8Bz9WzQ+Ik80n9UcoRPIh3NakEhV8l9xr/qbM=;
        b=V3FwOC2tVCR5PYRbo+iqMajHzPjczsNgQKmBx1L3XnhkYjBrn2wZJLhtnxcE50GUFO
         LynJewtm6xYi61+CzLuBcrRber0UdDlEzUFII61N1TiPia+GxqprO4kZgX6TrBGBg6Ho
         R4LtNFkR6vADrULJLlmFS6S3PDAmRjt+7KuxwCDqMiyCTFUa3Z1d3S1CawS6lp0tFr9v
         P6WCqHUK5+m2nv0KsZdIZouOcCAdKsVbYdFv+e0PLHc2KLJZZZO6F58AGt+j0s5vhsjb
         4NvvFitVrJhHGxgQW+9FYHn7Qec2tmLcjYzokrLz5wtRvHbyzxhByGxqibtyRifVJSMN
         q86g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785250266; x=1785855066; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MNYdphumDNBHwBWI9ok86emctjSMl+JVrJgINu9rmGU=;
        b=ZYyGTxMsPyyUcchp4rjhrYCmNizxRdybeR7WgqLkf9HLeGiibagRqGpNSJD8MXVjAP
         Qht1t5i4PGXj2xajP2OlFR7qZTW7b5zkE/wDTPIj5BTI73k/enik+07N7c1wTcYzTvVu
         r6AeHMfxlLOB7neor0wxisJZW3cs067Wpiq63asah5gsQb/EwdVV6QVr4n/rqK8JNhi1
         9LlByWrFIlNY96UZCmAwuL15gTdJiO5SxfizzIqf2p66gYoIoTZFB9MH1zZxE/dvwXEc
         JocLyFzvnMrm/AoU8soJaIrhc98BfWgJxSXhhcupIE0nauR9MS95SlB6VKzbAlYBo8xL
         fZFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785250266; x=1785855066;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MNYdphumDNBHwBWI9ok86emctjSMl+JVrJgINu9rmGU=;
        b=Mn7IVJgpjgtbeZ8poMa8ohs3plTyhCVC0cU1kcxP1m11gBnqdIHk5nfqCHzEBdnOCu
         g8mkh4RrTGVw5B+PiYl3cMe1g+3LED6zVneJ96OgDWbkXMOT26jgwRBpLPEt5j3nXf9j
         EeZAJITpdDzKTe/u2QJBzALmxRIky6JZcP+huEOlJFzuRTf2RiknW85ydVoaj2z//VBt
         sfKE2hYWtNxeVR47uBJmZRoKcuoHQxrfNKkmh3c3n5quXa8fZvu72mzPWn+7qOLBtzpo
         hQ/i+JKo4DVpRn50EMxCJ2+RsL5q5LwyJBkBuULqogTEmyLWQgEUJxJ1bcxEfJO/Qjzz
         slBw==
X-Gm-Message-State: AOJu0YwNlMMLJ5RMG8Q1iVWIbKAOpJz//sfwqjCr0uydCBkcGUlPi+rU
	mL3z1o9VkBCX+QUSCDLiDcQ9BC+mOFEa6kiS2YDf7NvBN+aAQGyw23YuVjXzJor84vUJgRQzVgZ
	z+zo6f0slLlgXpSm3RnVlJSKQ4CN3wWc=
X-Gm-Gg: AR+sD12JbJAwXAxhkma+kr9kK7mnzAFDt9zzcbjyYc25/gNia1SdfNQMN9qPoi+M+GM
	fI+q2Ptm6zsuVTufxuori9QCOAYQ8Yf3L9sNaJQwBR79LoZ3vLcxbkCAWTexn/Q5w4qEzjOtgfr
	8OM4skuP+4iwe20yP8F5UJLZMDG5dHQ49meIMVqBkmLU0Do3SGLmlbzbomu8V58eDdUjI8HpyjZ
	DVk09t8XUpiGIoImhM/12MoN88cbNn8gr9aQTBTwx2oE5GPvAIPCa+fIbCQIg==
X-Received: by 2002:a05:6820:5602:b0:6a3:74ad:fb35 with SMTP id
 006d021491bc7-6ac96d767b3mr988842eaf.53.1785250266416; Tue, 28 Jul 2026
 07:51:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260728065917.1343947-1-jsegitz@suse.de> <20260728065917.1343947-2-jsegitz@suse.de>
In-Reply-To: <20260728065917.1343947-2-jsegitz@suse.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 28 Jul 2026 10:50:55 -0400
X-Gm-Features: AUfX_mzgmz-C-YhiM6VI5RJLq3QAWfrthx3erH3yE5mzR3XE1Z2CbXmMubN6dPc
Message-ID: <CAEjxPJ529Be7_1Pw1LRFsUtABDa3yVo_-wD=mT0QxiuA0sKfsA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] man: Document directory cycle handling of selinux_restorecon
To: Johannes Segitz <jsegitz@suse.de>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 3:09=E2=80=AFAM Johannes Segitz <jsegitz@suse.de> w=
rote:
>
> Skipping directory cycles instead of aborting the file tree walk is a
> user visible behavior change: restorecon -R over a tree containing e.g.
> a bind mount of an ancestor directory now logs a warning, skips the
> cycle and completes successfully, instead of failing with ELOOP.
>
> Document the new behavior for the flag SELINUX_RESTORECON_RECURSE,
> including that a cycle is not an error and therefore is neither
> affected by SELINUX_RESTORECON_ABORT_ON_ERROR nor counted by
> SELINUX_RESTORECON_COUNT_ERRORS, and note the previous behavior in the
> selinux_restorecon(3), restorecon(8) and setfiles(8) man pages.
>
> Signed-off-by: Johannes Segitz <jsegitz@suse.de>

Thank you for doing this!

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  libselinux/man/man3/selinux_restorecon.3 | 28 ++++++++++++++++++++++++
>  policycoreutils/setfiles/restorecon.8    | 20 +++++++++++++++++
>  policycoreutils/setfiles/setfiles.8      | 14 ++++++++++++
>  3 files changed, 62 insertions(+)
>
> diff --git a/libselinux/man/man3/selinux_restorecon.3 b/libselinux/man/ma=
n3/selinux_restorecon.3
> index 9bcd3d42..bafa86a2 100644
> --- a/libselinux/man/man3/selinux_restorecon.3
> +++ b/libselinux/man/man3/selinux_restorecon.3
> @@ -99,6 +99,21 @@ and if successful write an SHA1 digest of the specfile=
 entries to an
>  extended attribute as described in the
>  .B NOTES
>  section.
> +.RS
> +Note that directory cycles encountered while descending, for example a b=
ind
> +mount of an ancestor directory or nested BTRFS subvolumes, are not follo=
wed.
> +A warning is logged, the offending directory is not descended into and t=
he
> +file tree walk continues with the remaining entries. Such cycles are not
> +treated as errors, therefore they neither abort the file tree walk when
> +.B SELINUX_RESTORECON_ABORT_ON_ERROR
> +is set, nor are they included in the count returned by
> +.BR selinux_restorecon_get_skipped_errors (3)
> +when
> +.B SELINUX_RESTORECON_COUNT_ERRORS
> +is set. See the
> +.B NOTES
> +section for details of the previous behavior.
> +.RE
>  .sp
>  .B SELINUX_RESTORECON_VERBOSE
>  log file label changes.
> @@ -302,6 +317,19 @@ with the
>  .B SELINUX_CB_LOG
>  .I type
>  option.
> +.IP "6." 4
> +Up to and including libselinux 3.11 a directory cycle was fatal:
> +.BR selinux_restorecon ()
> +logged an error, stopped the file tree walk and returned \-1 with
> +.I errno
> +set to
> +.BR ELOOP ,
> +regardless of the
> +.B SELINUX_RESTORECON_ABORT_ON_ERROR
> +and
> +.B SELINUX_RESTORECON_COUNT_ERRORS
> +flags. Since then the cycle is skipped as described above, so a file tre=
e
> +walk over a directory tree containing a cycle can complete successfully.
>  .
>  .SH "SEE ALSO"
>  .BR selabel_get_digests_all_partial_matches (3),
> diff --git a/policycoreutils/setfiles/restorecon.8 b/policycoreutils/setf=
iles/restorecon.8
> index 982701c2..443f29ab 100644
> --- a/policycoreutils/setfiles/restorecon.8
> +++ b/policycoreutils/setfiles/restorecon.8
> @@ -145,6 +145,9 @@ options are mutually exclusive.
>  .TP
>  .B \-R, \-r
>  change files and directories file labels recursively (descend directorie=
s).
> +Directory cycles are skipped, see the
> +.B NOTES
> +section for details.
>  .br
>  .TP
>  .B \-v
> @@ -240,6 +243,23 @@ and provided the
>  .B \-n
>  option is NOT set and recursive mode is set, files will be relabeled as
>  required with the digests then being updated provided there are no error=
s.
> +.IP "4." 4
> +When descending directories (i.e. the
> +.B \-R
> +or
> +.B \-r
> +option is set)
> +.B restorecon
> +detects directory cycles, for example a bind mount of an ancestor direct=
ory or
> +nested BTRFS subvolumes. A cycle is reported as a warning and the offend=
ing
> +directory is not descended into, the remaining entries are still relabel=
ed.
> +A directory cycle is not counted as a relabeling error, so it does not a=
ffect
> +the exit status and does not stop the file tree walk. Up to and includin=
g
> +version 3.11 a directory cycle was instead treated as a fatal
> +.B ELOOP
> +error, terminating
> +.B restorecon
> +with a non-zero exit status.
>
>  .SH EXAMPLE
>  .nf
> diff --git a/policycoreutils/setfiles/setfiles.8 b/policycoreutils/setfil=
es/setfiles.8
> index d55b42db..17cabe37 100644
> --- a/policycoreutils/setfiles/setfiles.8
> +++ b/policycoreutils/setfiles/setfiles.8
> @@ -307,6 +307,20 @@ and provided the
>  .B \-n
>  option is NOT set, files will be relabeled as required with the digests =
then
>  being updated provided there are no errors.
> +.IP "4." 4
> +.B setfiles
> +detects directory cycles while descending directories, for example a bin=
d
> +mount of an ancestor directory or nested BTRFS subvolumes. A cycle is re=
ported
> +as a warning and the offending directory is not descended into, the rema=
ining
> +entries are still relabeled. A directory cycle is not counted as a relab=
eling
> +error, so it does not affect the exit status and does not stop the file =
tree
> +walk. Up to and including version 3.11 a directory cycle was instead tre=
ated
> +as a fatal
> +.B ELOOP
> +error, terminating
> +.B setfiles
> +with exit status
> +.BR 255 .
>
>  .SH EXAMPLE
>  .nf
> --
> 2.55.0
>
>
