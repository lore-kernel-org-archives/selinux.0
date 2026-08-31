Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B07449B37
	for <selinux@vger.kernel.org>; Mon, 31 Aug 2026 16:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788193602; cv=pass; b=pSkGwAMLPew38NDegWJpIJsRybp51/UC87RQhr2jc9u2r5OCFK25xISw5qv++PeMYyeJfM2g/xA1fRa78mH0FBSp6GtU3lY2SD/gkHIkr4axHGvrFTrvTKZdzx2bgb4Bzftvj643VcD2gaoqk7XHTu0qZTBTWMMV8vi/7YSEQiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788193602; c=relaxed/simple;
	bh=TQEIuizKAeOocOS9Rvqv0GBMwlQfQLoQePnK2/FSFwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JpxL4fdNqSyi8XXh7Wq2O3+/jtzi69tLjv/8jo+xpj7VNUN/530vLDke+4+QGIzxqPaKFLsmss/gkN3IFhF2/n+V7OCTV1ghU6KuuRvN7lF4mNLBiUbomEnZMbjBqn4BKdmxmoLoJccfivJ+5zgd8ofNFUTxjAbAHeFEKLlf3IM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZbP/wJGJ; arc=pass smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZbP/wJGJ"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-46ac530ba95so840530fac.0
        for <selinux@vger.kernel.org>; Mon, 31 Aug 2026 09:26:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788193600; cv=none;
        d=google.com; s=arc-20260327;
        b=qKzG+z800Jql0sQthR3NfWd8/esvNBk4Dse/YapIJLgr8g7ErDOBknsO4hDjITP7tX
         VdVbizPt02FG5djQoPmHB/i39U/ZjD5NO5IgnpCqvMrAy6HCVWH9pUsrQmq1uC9U1/pP
         r9IIM7IocEKpapsCSe7CuZKt/FhUQ/sdjOC993ioQVGItneRhryG5murfBHYyuPC+FO9
         UURhBZJDuuywU4AGIIrvH+9nu9ztHAhxWekVfh+nGRj5hYK5QCWINjJKchNdbh0k7DmB
         SJcw8JZ4LoNY6dwPX1GQcCRuKPNp2fwqTkowvA5hHX82LcykKs+PDz/61JNQx4fGO140
         tHSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JcJrM5ajQEGaZas3s8eOCvsrz2ClqYsMcIbs7ID22ss=;
        fh=eQaouqZSrQIAlDzRIrQq/aTJzazDySYLD2N+VW7naxU=;
        b=IeU+xmnwXy8Z6B9mUW41NIny5h92iimg9uxfbcuIdY524gnt52GYJOlMTyKjR4v+hq
         VUqfbxgdyEE9ISwaLVOpFkAeBLHC/s/5hSlyfCI2gkyIq+N61sb26zUxBDVfD86dIpqr
         h0D+GrXoCXsghtXLrdLNCzggdrV6ZUxBWx3Ta3A15+TFfhYgjASVSHv/neQfDU6d/P5J
         IOOUAwxqGRt+yWl/VO8ZU04+oJh0jGFGz0mpaQXf5z5ykIZk0SjCRg6HWq/51FBXCnsc
         VWzg372TAXaF+VnJeyEVcT/rt2LOjMlX9REG3h3ywq/Mr6TGk3O6my83vHDg1JECZRH+
         8fjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788193600; x=1788798400; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JcJrM5ajQEGaZas3s8eOCvsrz2ClqYsMcIbs7ID22ss=;
        b=ZbP/wJGJFGE2SdNXoNW4Z+clfXzCmtRbdc69i1RmXr2b0cbQqjO907qPm9OJdPwB1X
         2u16VmYdyYqeez6jsZcyOSQGr44jOowKSOGto8/cgBqAgAJCf803PLMeP8ZjsXQd8QCE
         54HSjnNKYdpDJ/4IpixruiLCncdLSyMHG2uUSYdcpvja57Q9X9U3HilfSVBPOwJJHzF7
         ntZyY2gHriLKYR5yIn7he8e0K4X8z297Pn2qFdDO6co1VRfegmeglQQMtHnHnG9UMpYS
         iXkvbKy1e6zj07bZJOmANgzXWlKHTN5vvg9NRKvX7WsRYJOt230uC/RCSToMGIwO/Qi7
         uT8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788193600; x=1788798400;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JcJrM5ajQEGaZas3s8eOCvsrz2ClqYsMcIbs7ID22ss=;
        b=q6Wixd7ZnwqyAEeGbQRdVjV4wS1euiuvAzOHg946lHA44MqhDDSmIJZt+q9LPZsH9r
         EcKqoGhEUZZlhOe6rbLz0cCmiDHcUtBjnwPYi2dYjcHuBH/4DRtNE1egS8PqOCOGRxl2
         h2Ar5TQJIpF2upCIvG0XLRqSpE1cb5n8WcIC/7yXbHbztPkN6twZAgj4ThNI86UpCPxE
         p3g3hEMXP0kRSvdAGoxRbt8tdrpElr3JAJ+oeNrf78QfAZ4O7s4TkOA846mQE9K9TpVN
         sVUezthr46H4t7QD7ozEqxJhfLhMDGXE5R7pwRsEb324dmxUDvjohXw3tWbxUmK5FGGh
         euwQ==
X-Gm-Message-State: AFuF++ltSpHEC60rNGP5yjH4U/ziUKLW+jiDusToC5QGn3rG4m9qJ/Bk
	U5KdKXzPnWIhlhOWRXVHrELWzak+8I2wx0YJiZ++Jl36iS8fybpdhBVn5FXQANgLJdy+DDqOFSn
	oQzyW942ztBFuHo8QCv2I3AdJKQhXOoQ=
X-Gm-Gg: AR+sD11m5kdw2gFlgVtXZNQqGB16V+WQsFLn/Qo1LXej05qH2Wa58Tyt8r5/L7vbBg3
	1O+l9gqaoS42Aaq+KPnN+7I7NCkLz/gLwB09+o6yOqmpBaGrSGMVygnJ5a6XpLaIjQhmKN3AbWd
	dgPXs2qf5eQEhegrFCIfMPnzuEjGYlANWQh/QwzjlXJRa02/bW+C2d3T9cekkx4gCN80yEHXfWJ
	aH4rpn1+MkWT4fV/p9V9fbvow1XopSFBELNLo0cGbFA0i8965ymYnVGJIgid7iwReahOPpqMQf4
	+ItSFeemE1ZhlBGodbk/v5UnkFEVALB6dGdcCTE3274o
X-Received: by 2002:a05:6870:a0a2:b0:46a:d6a3:8c22 with SMTP id
 586e51a60fabf-46af568caa2mr2119011fac.12.1788193599716; Mon, 31 Aug 2026
 09:26:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831133509.3287-1-dburgener@linux.microsoft.com>
In-Reply-To: <20260831133509.3287-1-dburgener@linux.microsoft.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 31 Aug 2026 12:26:28 -0400
X-Gm-Features: AcwNN1U0YPXf4S98uTU3eqvN-pcJO2fdokksgJsFipnnquFCKTlwAOQpiFpqDxw
Message-ID: <CAEjxPJ7DeQkzeFTBGHoBaO63M_6i38qkqobQCz7-AZ4O=6dQiw@mail.gmail.com>
Subject: Re: [PATCH] libselinux: Use correct struct name in comments
To: Daniel Burgener <dburgener@linux.microsoft.com>
Cc: selinux@vger.kernel.org, jwcart2@gmail.com, plautrba@redhat.com, 
	omosnace@redhat.com, jason@perfinion.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 9:35=E2=80=AFAM Daniel Burgener
<dburgener@linux.microsoft.com> wrote:
>
> The struct selabel_opt does not exist.  The correct struct name is
> selinux_opt.
>
> Signed-off-by: Daniel Burgener <dburgener@linux.microsoft.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
