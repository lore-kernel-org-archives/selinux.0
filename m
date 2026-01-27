Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CA22264AB
	for <selinux@vger.kernel.org>; Tue, 27 Jan 2026 18:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769539168; cv=none; b=OFenuSxDuq4P9xL/IowJEIhswF0iWlEWZ9N0HxruVoTWAIKGCrycUGju9cf/ojg2xMQtLcL4UON9FJ+G/DWyY5tFx5Vmu0imek4JscL6B2gybajsUhY45hoZr9W1YZET1T7WY3zc7eVWsEwViy0I7lma2zKXnNzZNtFTwzkuohI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769539168; c=relaxed/simple;
	bh=Puce/Y2uoOhkmXAnyMr90G2Ehk1ZPgymehgrzrUE1uw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cov6bZvfW6P7nVW01svsDTiAL4wd29UnxZDhGKIKu72AyJTFeVThYrPiBqTvf3jazydIwPBeQTt3r2utXvwsqK0+KmtadROe4eAPtjDco/bzf7Tu1pI/synO8ha0nRlefH7yW/8lFvr84UDD+3SdjoHQahyCY24KCXSgTKwYsgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Mg0a8xkO; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Mg0a8xkO"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-65832eb9723so11134256a12.1
        for <selinux@vger.kernel.org>; Tue, 27 Jan 2026 10:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1769539161; x=1770143961; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IB3BhFyIjodZhUGQQ41xIA4/U0Zmh362p3tEBCm/trs=;
        b=Mg0a8xkO7+PxtfLqcRLEzjUr8RWC731AqPjHZn6+PP+s73GLD9jfte8+XOgLrrcpFH
         p2nZYto6mwwxGB5TdlAscDcUgGSSZunWssHESg0He4Yl/ze3Fc0/lQhBo4d4R6PTs1uH
         SatLNBaGfE+u9MUCmVZPNugm9ArLYItahntac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769539161; x=1770143961;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IB3BhFyIjodZhUGQQ41xIA4/U0Zmh362p3tEBCm/trs=;
        b=iuV6324evCMAe+ZH/ZKB9+rmTL+vH3QxoOkFFj8RQ07C/yfS1HHvkplATAusB85z4f
         5Hc4hthtpnpc7blufnCsq/Na2PHvXIiu6zxKFQHE4pEYcDz6Su1VA/MkdJsytu/vCQMa
         O9Q0R/Fz+bH/2nllxUudNVnLHPeI6qnPndtECvfNnoPoScqjJMLq/2x53k+YzT96Ets8
         Dp7DowQ12ML6wHSQNBbGOTNxPlttRsHyORAsNvStosA8ep6fll+EDe9opl3wZT806DO9
         HXLGVWpDSZXt3OB5X1CNl6BgGhRGX6aNXc76GB8t9abhUl/xFtk9CHkblArAwt5WnUOI
         uCAw==
X-Forwarded-Encrypted: i=1; AJvYcCXJMRYqZyKO9W24y9sM/ztRuXenr7VPEhV+RzSbIx4/xPbG2+Xwx6lw/EcYo9f6BBzElNw8xjEF@vger.kernel.org
X-Gm-Message-State: AOJu0YwYNdspf6jx9icklv2za8zeu+ujEU+jI1+M3Nd9up78EbtpgZn5
	vMOQdgS5S/FStCpdc2sW9p5Z+GH46mIRQymj28Pw6MoxOqZoplYPmPQfvVzO1wijLiznKCx5ck7
	hC+BMNt8=
X-Gm-Gg: AZuq6aJrIxKjewjVHPsE1fL/KKR97cZlRapV2H1EL4pGImj9KE153PsmDD51SjWW809
	Shvo/xFLO91h7LBCAmTgfvCtNLM7Ex0gOmcfTaYRp7pQz36ZJEpPqvvazzLBxHeCvDWVPewl4dc
	u7jbrupxjH2C1F75/KcbHKIep1iBuWeahjTRCDfZ+0fpQbZSARKXSpc1hC5CGaIiGxLRwH5q9rc
	6fKGWO+xqn4qNSvQSRhJDHxEYMNrUHHeeoyixquDhiSoI8d8u2o91T2ZEtSpg7IXxLbDVX74Mfd
	wSxv6XV8ZBFdlCe08pvY2FDaMcE1lzLrLTBBO7CWwCKavDXcFdh7EO1E0U4baI8lvEEpt7ANiGJ
	1dhNRwLoSk4RGma4k8/9N8RMTz34zrzcZYOsdZJaHSu5o5vLVau412liW1cx7u8UOXYmuA/fDBB
	ASAQq629oTow+4Z1asHM15hVddoIgSLDgDK+K6+FhUF8n+qoFvdTzi07Cpjzvq
X-Received: by 2002:a05:6402:524c:b0:640:e75a:f95d with SMTP id 4fb4d7f45d1cf-658a6055351mr1921423a12.15.1769539161245;
        Tue, 27 Jan 2026 10:39:21 -0800 (PST)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-658b40efb01sm236963a12.0.2026.01.27.10.39.21
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 10:39:21 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-65832eb9723so11134236a12.1
        for <selinux@vger.kernel.org>; Tue, 27 Jan 2026 10:39:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWoN/RTAu5nCbYCYR+dgC+OGsmUC1jSORfQ/a2Ee4j3MYV4+E+55wfYhLhPp4ZYv76jGAsykuKQ@vger.kernel.org
X-Received: by 2002:a05:6402:27c6:b0:64b:9d9b:f0f7 with SMTP id
 4fb4d7f45d1cf-658a60c5513mr1939607a12.33.1769539160812; Tue, 27 Jan 2026
 10:39:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118051604.3868588-1-viro@zeniv.linux.org.uk>
 <CAG2KctrjSP+XyBiOB7hGA2DWtdpg3diRHpQLKGsVYxExuTZazA@mail.gmail.com> <2026012715-mantra-pope-9431@gregkh>
In-Reply-To: <2026012715-mantra-pope-9431@gregkh>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 27 Jan 2026 10:39:04 -0800
X-Gmail-Original-Message-ID: <CAHk-=whME4fu2Gn+W7MPiFHqwn51VByhpttf-wHdhAqQAQXpqw@mail.gmail.com>
X-Gm-Features: AZwV_QjTvEFSmpHcnOP1NJLVZBe5xlcj-dD5ZtjcNC__rjqudIVF0E_rBxSpQA4
Message-ID: <CAHk-=whME4fu2Gn+W7MPiFHqwn51VByhpttf-wHdhAqQAQXpqw@mail.gmail.com>
Subject: Re: [PATCH v4 00/54] tree-in-dcache stuff
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Samuel Wu <wusamuel@google.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, brauner@kernel.org, jack@suse.cz, 
	raven@themaw.net, miklos@szeredi.hu, neil@brown.name, a.hindborg@kernel.org, 
	linux-mm@kvack.org, linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
	kees@kernel.org, rostedt@goodmis.org, linux-usb@vger.kernel.org, 
	paul@paul-moore.com, casey@schaufler-ca.com, linuxppc-dev@lists.ozlabs.org, 
	john.johansen@canonical.com, selinux@vger.kernel.org, 
	borntraeger@linux.ibm.com, bpf@vger.kernel.org, clm@meta.com, 
	android-kernel-team <android-kernel-team@google.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 26 Jan 2026 at 23:42, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> Note that I had to revert commit e5bf5ee26663 ("functionfs: fix the
> open/removal races") from the stable backports, as it was causing issues
> on the pixel devices it got backported to.  So perhaps look there?

Hmm. That commit is obviously still upstream, do we understand why it
caused problems in the backports?

                 Linus
