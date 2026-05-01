Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24585350D7D
	for <selinux@vger.kernel.org>; Fri,  1 May 2026 12:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777637695; cv=pass; b=fp8HHF4pO8Rtd6lYx6IJoEyBYmqdiJM4NsxFGIPpEuqUl8qznEFNxeqrfIM7alpWvHUqBkSnjtlz29XfyPXBkOS3UdC9HFJiBJHi550Dpazeo6NxHo2glIJMu9FDBSibxEE3eWOdOUVTCtptlhP5SFpdEpsmrXDPrXE+yT0e4V8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777637695; c=relaxed/simple;
	bh=Ibr/MAjxMVe/j+smlNAJM6tYPcUMJJm6RL3MSVeh4Lc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YA/p7yJp2Eztur76OaZqVq2aVC3BtSuPydcX1lpsGwJYGaAeAOynAIXWP+sEtSJBgtEBaX5obhvNCtmim7PTKzQPmR8tQnk4vwAe3PqjC2tpx9RViA5QvxhrS1Rec0xdgDcSIEQigkMOIGHKaJQqAVX6ZvG2eW0Ai2CTlS1MQWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h82Knw04; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h82Knw04"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-362bb3260f1so1333709a91.2
        for <selinux@vger.kernel.org>; Fri, 01 May 2026 05:14:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777637693; cv=none;
        d=google.com; s=arc-20240605;
        b=QW4Hl7YQBwq1VLumi88a+GfZ4NEV96AfBN7U5Rxx/f6sr9l9RSkwcJHAAMUNpFUbce
         y30Hfp/WINiR0BrbhTRhuTQmcusZ1MadlPG4UbzqXhDj03GTDQF7QnRNdC1ek773Jn0I
         Q5cVekiZeWAfD1L+1h4g9vQfC4wt5cAEUOMsZB+dlYmuaxar27fW/p4X33musqS3ZQP7
         37dDuRI9P8PER1h1DC0zELJhhMgw2GVbrXfm8DqHNOnNPDRMtnHYjuIfwNzzBljdkj33
         0Qs5UAfzipl6E1rFuG7K7H2IuSF1w57lwkGD8UyO1F/m2Cz2mh0ebT/nMgaeR9SKEZaU
         Bs1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ibr/MAjxMVe/j+smlNAJM6tYPcUMJJm6RL3MSVeh4Lc=;
        fh=ZlKqpZpQp1DJ5c3Br8OchqalgDubFg3PTgpCIbXBxN4=;
        b=HcHYHPdf9x4hPErO2sQD78zqEkYAWBnHrkr4zYLwIJuosh2BQuXtPrdJymtFXIthKQ
         GcAem0G5HrTIIGr7/kkRsOCGn5IbaVTsQvevcAQzE+B3DjwQ18yNenbgUbZWQ0PmJtkZ
         zOf5Pph3u3oasirV38Xpym8yPVzXJVl1lDtzTeAu5kc4bVmFspNMAt2mSC2sINAPfpb/
         OkZccQsy2DwPMDsSMCVGas9i7DKDxqxlZZgmF8hiSc+eG4PSblOhUfhAR9uvfwgXtkmZ
         PoFSz86lnLFWhGNPHzY72d4nU63vHxnyntQcPSrtTmcd9/Yi/OQh0hHw3zFEbwPxlRXe
         gC0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777637693; x=1778242493; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ibr/MAjxMVe/j+smlNAJM6tYPcUMJJm6RL3MSVeh4Lc=;
        b=h82Knw04byJlfVHPsclZ+VE9JY3zOMNnjgDieFOXJHbvoaIQZj4w+oLXC5oIszBGjU
         Dp6jG2lF22A+IK85e5HJmihd0kNDFjLHX+CWHMnCckt+T7CbM+0isYb6hHbjToniOljv
         dlLGqyAdeU2D+bbMkNzr9qywQmer0F772X9bBnGuyujzUO9Bj6pviNDu1QZagBPGEehJ
         8x/GhtkJd1+EdRcJeLPdE437GBAKbsDT+egC2lecyppn/xox/UzluzpWS0bBSGjgWhE1
         XeCURl055r3pI8kGhfXDI5bZimiDMvarcTbLDVPuTW6N1N590S/21wsqH3H+Sjs9Hq/I
         YhAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777637693; x=1778242493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ibr/MAjxMVe/j+smlNAJM6tYPcUMJJm6RL3MSVeh4Lc=;
        b=mst+3Gzk+DC/e1DPqjelWWksPV/QreqY/KlZiAmW6Xx8vwNmfqmkXuQIIlf3AjnOkf
         KbTymEb1oVrpxoz30yePEm7OU4XvsKuNmjQioEKuoeAo2LfdxutJCWBQGLcL5vqgHF1t
         aYUBP5/OKif/R6oIZZMcbG75zndJoM1bUd2dnYSN5hh1Y+U1lCEmQvKEqeU6JhEtE2Dg
         Yx79wrqJQq4/ONj68leWbgsUHB6YZadVWpM4rFAl0JkKcGHrv56DBz+JGvOKi7kTw3+J
         PsMqWEJsW79j/jG61SqC1hltOlMGOM2S88p+XKgRZhjONPR5Q1AfRRMlr2YePUb8DcUO
         6Kqw==
X-Gm-Message-State: AOJu0Yx+IWAv1ihLKCfHDtu2yYkwYliAsSaOBLj7veCoFhxl8YHtQhoR
	Y2q8IYJRjNUs3FMWrnKCKNyJtLeL9MUpYVGiBlHbsrGlGxhBSgZP1NVwXMNgVN0P0NvMQwWu55s
	/H0jA6QBphrGijuMR7U5l6QnC6ZpF/kM=
X-Gm-Gg: AeBDievuilHXlRtaKvVPVRbeOACho8+m4GCzz8RT5SmU9lcccQNBnCsynI0+DHrRf4x
	HKTr7pCDFSeIVSFS6bLmkYYwHEMQ8P4cDHbpzmIpzV7NdzAYfM223tcmyDJ0Yw1XV6UjTLEJk7+
	BUvO/DOTixpRDWLFyJw2WuwZb0TJOzj9POpRvZX0L23cjeELYiVtZneQxEiOoGQvuAizeRILeoN
	1HdBghIqIHzAlOdijii9D3Xk6yald0nqzdUB9cWApM304gdtTKN2Y2wmy+OjIOhB1eGGDbxPy0E
	E2D8aC4DBIw9ZZ8frQ==
X-Received: by 2002:a17:90b:57e5:b0:35d:a5cb:95c1 with SMTP id
 98e67ed59e1d1-364c3149065mr7988798a91.23.1777637693365; Fri, 01 May 2026
 05:14:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429211229.3750-1-stephen.smalley.work@gmail.com>
 <CAHC9VhRZ6Y5BvzUd_D+oeqRnaYk1NdfK-FpXELK00VkpHZBzGA@mail.gmail.com> <CAEjxPJ4UjVCvrMeT3nF5YvzKGdHgk3nMxBisXt=vzA26r8K6cg@mail.gmail.com>
In-Reply-To: <CAEjxPJ4UjVCvrMeT3nF5YvzKGdHgk3nMxBisXt=vzA26r8K6cg@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 1 May 2026 08:14:42 -0400
X-Gm-Features: AVHnY4J1s3Vha4cRLDpCkRWRdlixgsXxMIwvDfRa8xWB-4pBv2osggRdGZPsznA
Message-ID: <CAEjxPJ7V7r5KTP2st1=b_u3ZDPk0sbfM6oA=WJdx3UdFdx_dHg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] selinux: prune deprecated interfaces
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org, omosnace@redhat.com, 
	Petr Lautrbach <plautrba@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2026 at 8:01=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> Sorry about that - thought it would pick up the same cover note that I
> used previously. Don't think it is worth re-posting just for the cover
> letter.
> As before, this series prunes already deprecated selinuxfs interfaces
> but unlike the previous version leaves the selinuxfs nodes intact and
> just returns a non-error status of the appropriate form to avoid
> breaking userspace. Only one I'm not 100% sure about is
> /sys/fs/selinux/user;
> I didn't have a system with an old enough libselinux to test its
> effect on e.g. pam_selinux and friends.

I've confirmed that even RHEL 8 has stopped using
/sys/fs/selinux/user, so I don't believe there are any still-supported
versions of RHEL
that were depending on it.
