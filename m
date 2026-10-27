Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793127736;
	b=DgPefeDA8ZydPhOhKtKlZfPiQCarackbPWpSgFXZhp8GR/NznSEwSMpnpT8ahlN8amTZ
	 KN9J5MbZFH+HAlffRoI/Ly+UTS6XbHUaF4TM9hf6Lvk2Pw0SNo3U/AY91bgSmEQtjGwKh
	 /DGU0s+MagV/RhjNYV1ayr4Ay9VyCR1MaTTsyFrVAvGh0JAbO72RN9yDJeaOeuE9DXUqQ
	 DwWgLZIaz6I80cRy85uFYmdcEjKpx0KogYVpRIG6ZRV0G61Kn/UPw/jYZTMahcr1a3C/+
	 9X+Hv2DNpvGO2T47uAus2DbJkWeCKaMd7hFb7DElaDlWp4BN3AVfP3mS/zTsIDDmkyg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793127736;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=qmCHWL7vWUY3vj1605uFBJsC6d9Tv6esIfz2iSWqW/8=;
	b=OTj3CohWZPzp/L23OUXEGEIQ7QG3Y1BNrmV7CLh8zNQTyeFngXgG1uW2QKbLQzMqQRA6
	 gh9baT4DyzqGdZi4/Y92d1lef/j8zfbsGfFwWh2vq0CMOyy6hLouZ9c5oZA3hLTSkI9De
	 IuzXDhchGADx4vYiwmr8igYuNxwg6ujzSc39iz/hiQrxWKEvkMzOGnUehUNVNE1eALNsZ
	 5ce9y33kdta39U9zavzQPdCGnJhH89XewYyl0zVSSWHr+VlAIas4ii41qdHji5OfTzZfK
	 jJ1Xt5Aa+2l56P8jOLKqIXhqSvCTGS8R9X/8j6GaQC3qZ0jM8G/yBRnai2EUlUPeBoQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="rX7L+SX/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.49
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BCF606A320
	for <selinux@vger.kernel.org>; Tue, 27 Oct 2026 19:02:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21BCF606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rX7L+SX/
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-67583c777abso262527d50.1
        for <selinux@vger.kernel.org>; Tue, 27 Oct 2026 12:02:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793127735; cv=none;
        d=google.com; s=arc-20260327;
        b=q8+S0WEMft9xKsWtR1PJ6IgYnD2LD1HuNn6khR/9iEx+T+Z1eWZhlVhUlepspJqDO9
         v4Wd7DGqCegDi7+5uxiSyo1tcr6zaMviosXhfW/XcvPHTdku5bjatBzt/B1DV/xKRHpt
         jMJIcj6j14xfShIl1tsHm+Jm0Fyb5Q96pR64TdBj7O2BR72RRPv9kqypOz/gGwwteWCE
         nEOuwMatjqPfBJ9MjaWAy2SrxH+05tQOVzx+0Shu3K0UUWKZQorZ1KjugICmG0l+yn0K
         4pt9ZOgvU09YP8FEDl40ZkYM6KctisxRD/WFUix2NOhqpSljLY0KFxn+/yF7Z2lc2ky1
         bSuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qmCHWL7vWUY3vj1605uFBJsC6d9Tv6esIfz2iSWqW/8=;
        fh=88SD3A1r43C8ue1eh/tUY31otzODxDx4N77mxCQa0yI=;
        b=KowusILDU0q6xWUaEDfvVEZX6QtPRL4QLSWzKnny2n3HntBaGwh/ShU8oPMA2SG+6N
         NK+d0ov6LVv490O9Obzp+RFHf/N8ld3i2YqCroiQ+QWCJ6oEpPWtN5nmlXHVjxSfkq/s
         Q2JIIdiRZwQ03j/z6kb360KZhEdBG3LlPFACpMXKgvmAaZvDpyxswRmACSLU1dgU4wo0
         W1Oda7LnpTn/jJjeLkx/0Z3UnFiXDgVBQXUgIiyy24WszFbVJMIxIarAylmRWC0DZMs6
         1W6bHoZpGVTMShBQZ0uyI24DLgsfzeZ76XTP1VOu2YpQIJoABdAPTdPYztXzwbpbGSbZ
         BlcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793127735; x=1793732535; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qmCHWL7vWUY3vj1605uFBJsC6d9Tv6esIfz2iSWqW/8=;
        b=rX7L+SX/yHdpWOKOh3+m1FNoNqqCV9ONIhxC3ioLzSjMStZR+Ks2yorxH0M+cikD9L
         IIVpCJpBLQjUk+nWdNuLDfmc2SmId6w+u5hZWtcG4hkpP5ZiYDxYD2BlTuzoQZkzpLdf
         KkgaI+uF/V+BsLL/S2RWhBtoacI5/z5caRaDIaKrcRxqioXiw1kKSLmsry0OWN+NdsEw
         CwviDRItr2fS3SgJU6G+sxrI9acm1hfDQoy+rnCaBDMay3rFVJudsbvnjOvmxTovNSmc
         Nvyt5cuuDdD8UO0hDr8OzsyW1XZtivRQIv0ecXXxTVR+Nad9GsZ3KAQKsk/rRgIHvbLq
         qK0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793127735; x=1793732535;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qmCHWL7vWUY3vj1605uFBJsC6d9Tv6esIfz2iSWqW/8=;
        b=G6NJsVfdx6X57SAXu1z0JF3JbhW2styHfCUZS6QEGHMvS+M2KSV+3rAS+HlpkiV3uy
         lzk+XRXmmByLz0GED3WFTNoNGbwtuPxlDI7bncwnxFZm5IuQgw76SUFeX9juvI6q0pML
         e4EcTx6/TevHWpymx2Qq76rSmaCIyrTUzR17xTfnRaPwH67LAg8OGlDnkjMutSq2WylG
         RwgInLmKesdEUFJvT0sQAvk6tH4wVV6l83Py55JC22ivKT6veDaEdXIdjspZAY1+gaZX
         Ns9uWSwr0riM51Ld0zy9ffvqRlaDm5lHOC2++lRMVj1C++kkkaXj+HaB3F4Up8mdE0lC
         hjpg==
X-Gm-Message-State: AFq9FYJQ1P9KPqsf0+jdJ80Y4dHXSjHErxStdZORU2IbFIym9L4NB1qA
	zwRhe+fLVLS8wJ4TUkX03QdQr4Xx7oLrrFRtkU+nbFp7iTceCNSKCvB0A4brRqPty2kl8ZsSRkh
	c/aKab8r4yorBW4dOtbzO3lbaXyCw3lqgJMDn
X-Gm-Gg: AYBFou2xRTqKQliHj8740kdDBU8RrY19VHqmDOYXJea9EsHZkKpj5mQJ9j2B4ZiUfVy
	kU8Nj+PQM8TP+hTayIZRr/j+I8iH9u0H38Eqc7zzKClxonAoXzeHqqk6R5g6HGqFA9NsAqqSVUc
	vJpMKs2L2xGbnagPirB0fD3we0VO3WvNTbXzzEiF9wwD0OqVOGSKJYuND5J8Xu31zPhgL2oVzNB
	4az8pmFd0eVqe73cOuDKhe+prszecfRSXZgyknzu0DKdKTMQDz/xCFuncar7owSxMhJbcc0ZWGf
	ld+uCM/f7lfPPkdSh+kqs0bwF6IfrjGGMTtVKrJwI82hyEhNUflQZ5UvaCx/Y9nqE+2Y5mn0Ikf
	d6GxqksaasQ2fL7nUHAb5BAgNQ3qez8wxddsKEteq9xrq/8slXW+gHOw2qvRGbBbOnOOq7a4/F9
	b5/CmeydGqPrKCoM79QvxAWA==
X-Received: by 2002:a05:690e:80a:10b0:677:b2d9:de8a with SMTP id
 956f58d0204a3-67a7bd0ca00mr252571d50.43.1793127734936; Tue, 27 Oct 2026
 12:02:14 -0700 (PDT)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027161833.90630-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20261027161833.90630-2-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 27 Oct 2026 15:02:02 -0400
X-Gm-Features: AclHuK9tUG-7A_sI3YtMzyylbcFH8JOmgt1pdVLJTDpCbKmt7N1QxunTxNQQwoM
Message-ID: <CAEjxPJ5xdgskV4SRhEc-N2eAvjS5T6PAQUfDOEjA9AFcnRfpdA@mail.gmail.com>
Subject: Re: [PATCH] policycoreutils: fixfiles: honor last exclude line
 without newline
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com, omosnacek@gmail.com, jason@perfinion.com, 
	jwcart2@gmail.com, cahu@suse.de, jsegitz@suse.de, tweek@google.com, 
	Vaibhav Bhope <vbhope@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 12:19=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> From: Vaibhav Bhope <vbhope@redhat.com>
>
> exclude_dirs_from_relabelling() uses `while read`, which exits with
> status 1 at EOF when the final line lacks a trailing newline, so that
> entry is silently dropped from -e exclusions. Process the leftover
> buffer with `|| [ -n "$i" ]` so the last path is still applied.
>
> Signed-off-by: Vaibhav Bhope <vbhope@redhat.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
