Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com [74.125.224.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FC63C062C
	for <selinux@vger.kernel.org>; Fri, 25 Sep 2026 18:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790360729; cv=pass; b=ZWB/k9J2uuv3AJdW7WU8N1ES1YvfmBWLaY0Az/EKWKleQy4ODADgGnpIP3v0Yos1lGTLsDRpJhx48/4HGXSnZ+IwMQ6xlESnxNeGTHDyTyu1Tbpy4QmCsQIWFPCdhRXSVZ4rrlWc45mnhJuhT4hQBtztw/f1k9BVdDM7RFmYKcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790360729; c=relaxed/simple;
	bh=UFT4yj53f3oU2iWHMDpNh/6/LY3ZvL9ws3JrTwNjsho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kp1taTKDeeV6rSqMV3SNQknSkIsJca7SxsJSfOEj4EGkUycc+Rwy/LyVHB6xaAt/+zcdLkKxxLYii8V7UAxaOYrTKAj/lWtm9fTL3KaWkryfDr+VkwIMXTXNYXRmQ4zAEjCN/rs+V+RNS4VkHTRLlbkiWxR7vOIyi/Qdsx9klPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ADw5GLZD; arc=pass smtp.client-ip=74.125.224.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ADw5GLZD"
Received: by mail-yx2-f42.google.com with SMTP id 00721157ae682-8a45b788a71so9788537b3.0
        for <selinux@vger.kernel.org>; Fri, 25 Sep 2026 11:25:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790360725; cv=none;
        d=google.com; s=arc-20260327;
        b=jbT6WcrmrBn7l2+g5IfXwifE09xuzANxwPntmV/TiQJcBBPY40PSPbk3v+Zs3Qlk0+
         eRkWDG5qTQWh7Bwp6o1ZAeV0ou3VV/bab8SeW3hiY9AAf3DsJOgjkUN6MI/zuhe9kj+2
         1UDjM2fWfTU3hikN/6yjL5YHu6KD7eKEV5KPRvDtS5QOurtsSNUxlzDhE3GYmF2C5LVl
         JJb3s/68EenVf0Saav02uprbhol4aV0VvfYIo3S/d+Y9FlEzGsDQ+BxrCf3DvHrv1Ma+
         sWIWVgBL4nUElBg6/uOXPJxI8ykjfJQnDFdtXcGpowrJavBY5enX2lt4khDR/i0OGRHy
         yIag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PEYgoKur4+sVCBeAqWFDn/gc7iWU8BHlrPgJIgvAr4M=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=r7eK/+SkEV9xzVWEmj1q5qJDO4AOQxM5FQwZPoA5w/jGuhDh8/RqmuZZVy8oXN54+3
         PRhPyf0W7fYb8o8AZY2pStebKH4JnDMqvQqUe4hYpmNumMXUN0u1SwF2XEuQZIaHFYFm
         vQ/5OpxBx+W5Gwf/DcB0ds0Yql/madzMg/52XYsGJpd8ehZIItR/17KdTqrsryUIwj4+
         A6JOSEi1OYRlLd3I6Xq8lwxDe1GfwYHM2KYZhOHn9fRFHp6pXeMYvl1guE8DLA/+ksaB
         7I/3l0EoJW6MlPITp8RfinuZmH+i6qnB7Ke/28Iywkn/fqd5oULSeEVp2IrlNRTOgc61
         yCMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790360725; x=1790965525; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PEYgoKur4+sVCBeAqWFDn/gc7iWU8BHlrPgJIgvAr4M=;
        b=ADw5GLZDDWSh1qDrj96qlkpsNm00Q6glN9wtPnL2D85mAxlqhmPYA8IvVvmsWtt3ka
         Lh/JXxltFnVYjhnWREifaYVOOMukbIgJekHOs8PvVk/R/xOOZByLwNz1hKWwyHtY0poH
         FLcjPe7X9yy5uwg0VsboY0sJDLBd1B4y2jQ2x5XiF7WFLAabaHib1m5v85DLEhMWIEnJ
         jjwXzCC2HR1mm5lv+3g4E+qBzi/wbwSi9aCzAz7zxjEvN2PH3F6k+rHv8O/9gs/LXTDi
         u9D+mimdWwzCzuAKqvXMJclYxlOKkGKSvZjORTqisHEBBC+qCkvRdp4F8eX6f88lxPKv
         X2lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790360725; x=1790965525;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PEYgoKur4+sVCBeAqWFDn/gc7iWU8BHlrPgJIgvAr4M=;
        b=iKlInj3F5k3amsvMH8UBB7lgjg7Hdy7o/X3iGBIZvNJUVE8gr0bkob2purAyA0GT9U
         ON3x1h55kntD4U0xmJHuW+jZvhqvvW9+H353NdIrma5SCtrvqLB1RGNWbh0Aai3RekWI
         7hzDycrmF3nrYlRwsv3FD/aMeSuiluT2oPpwgC/RIN8HcZ8zcPJAMRFRpo3Oc33Jc5RX
         AKv5juncl2kOPkkC2rLxTRiigks3727Be/+mr7FHNfykX+MNRV/iBOEr2vSXSH0wk7mG
         rB5sJbI2TVM+6VrJCOp6fRVOVFVqJIt8gKuAYC+4NA0qcQJ5SJBufgij1ueCUmvtTjSA
         dIXw==
X-Gm-Message-State: AFuF++myERzM0g0a7JXi6JXMPLJ/5whLHNMHlniMO/lFAB1mW7Jo6bZ0
	HhzM6QyoT4lMPV2DQYztreoVdZrVflfomXmwxKqB1BncVbEfElKD3AeVsIwa4RIcdCyGF1U5s7D
	qxmjbs37MRmkP7cn1Yb4xmsHbadiXN+EB7Q==
X-Gm-Gg: AYBFou3Qn8etlPGfHnq8Ur5PNIVl2ZSbgElPcbXINuMwt6eBy4AQQ5kR2lnu+uxDeJO
	RGPcwClaZ1VctcVjTYb5U4iIKcc0kA/eCdxGLIDFpvOIRFOtTaGvs46r7TMFkWY6jOlozoQ/ToQ
	0/jACWfHceyGAQL/pZTz7qrbcpTLJJVxiIkI4d8O+FvjM4vbHxfTGAqZyNYISy3dyWyNxWrQh6X
	2SAYBnHi18uVirBJxVmu1lQhdOPYqzBteIe+0mq2PARESJvpOc8tSC+ewiZohQUSi4nbqv19SSo
	8pHF5RG5diGBblpwclg9E644ebbhPvjfFkanFVs8cx1yKUFpqKxeoTc=
X-Received: by 2002:a05:690c:d:b0:891:c494:1a99 with SMTP id
 00721157ae682-8a649978855mr36724547b3.24.1790360725208; Fri, 25 Sep 2026
 11:25:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925171755.2029271-1-cgoettsche@seltendoof.de> <20260925171755.2029271-19-cgoettsche@seltendoof.de>
In-Reply-To: <20260925171755.2029271-19-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 25 Sep 2026 14:25:14 -0400
X-Gm-Features: AclHuK-JjH2rre8UK5y0dTT1Bjdyj1Nu-2VSrWGqeDMhgiJ9yYRpZNfB3vlalHk
Message-ID: <CAEjxPJ5Epx5knedsBXPWV9Mqn7wa8KsiRjNTObhx1f6ss6Y06A@mail.gmail.com>
Subject: Re: [PATCH 20/21] tests: fail on compiler warnings and enable Wextra
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 1:19=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Warnings issued by -Wall and -Wextra most of the time point to actual
> issues in the code.  Treat the as error, so the resulting test run

s/the/them/ or s/the/the warnings/ and s/error/errors/
