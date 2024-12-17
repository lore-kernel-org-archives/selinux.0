Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D211DC747
	for <selinux@vger.kernel.org>; Tue, 17 Dec 2024 10:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734430088; cv=none; b=IYA/ByC1waAp7yfONVEpOLy8ngiFn7xwBbT8JADPXwY3PUve+VIwzlptEajneLjg4PpBzLak9SHs1iXcJGfHEG9x7icJfLqsaCgHjZXhPmH3Zn22F5swzjwJG6gYHV1HI7vrnEjYVBBPWhoegI2MWfCjT4rp0Q4Ld+x4bSZqNQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734430088; c=relaxed/simple;
	bh=TVX428iSJM9YWNxGi4F+mQldfkKb7fYAYTj00eSPBNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f/aEqsqxcdAmcHXiBgy1m9LYu9fcUhmVtFRnQbbWnICi2w2yf5h4DITgtGvZiTS1iChe9f1sOld2EWQ1VKltJn8KMmlGVZlIofGYMscRMWhb7BT2B/UetYs3pVn50r2jBiH9CI5dg3BSwuh+BC9j46rC5lmxIUzMeqjJx4GGwTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LxuEDHxS; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LxuEDHxS"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30167f4c1e3so56388271fa.3
        for <selinux@vger.kernel.org>; Tue, 17 Dec 2024 02:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734430084; x=1735034884; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TVX428iSJM9YWNxGi4F+mQldfkKb7fYAYTj00eSPBNE=;
        b=LxuEDHxSAZoB7Y33gs5iJF3N17uOjWF9KzUnlC8CPGG4ZySd7U571DmRLEFtjh3Maa
         8aGuzdepdNKHZEm7fu+7L/ApY4QbCFvUKZQ7DvEOLcjmnG4XsDD6sp59NDODMMzfg1ny
         rl5unIHPDM2/CnXPYqK7DDUXTaQ6NDS7Id6Ys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734430084; x=1735034884;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TVX428iSJM9YWNxGi4F+mQldfkKb7fYAYTj00eSPBNE=;
        b=nIJ80YaP3i+icqFVVfE/LFyER2RtiPRMHoCRAKHxrcQQGIrajjXggELoYdUlyxUcgL
         gWfLkDriTqri2UtKENhCOxv4AfPLDCPKIiwb41TDuz0YYR3sCEyDqvGiuPU0LtkDmIEv
         dvkRzzT6SNTucyrQd4yhdjoiPrFrP3gd98OcSeJe/wkhTamLx+YoX4FUCSYKA/eorO0Z
         afFsydIqE4bk/+HjWESld2xOkMawVTpWnJJSm/TCeY3luVMf3AaeDGwlp9Fqbkf346Jb
         2ZRoEoMn98yJTIrU3xhlvV+QHaTCt0vNRbvDdiUXYtIMQFDd1U3JqLL9gEZIbGCOA5hT
         DtrA==
X-Gm-Message-State: AOJu0Yxrgw8d+Y/r2uu+mifakRUDZUoBAPu88fkPukb5j+pj+7kexpcx
	0lsj/ZF+ZgeFJJCHR1JIGySgiJAFnZJ4D51fEITzaeNFkUzA1AlDGm0eBrRBWuIV8SJteXUc21+
	nRkg9gr1/okpI9wTugG69z2W1N6nYW7w/PELwtH0nPQfz2654
X-Gm-Gg: ASbGnctwudbxX82LGp71SKwO6P33A9eKt2AgLgsKdlz+RegX93tIeCRDu8O5brq5tAQ
	M15betvhJ/mjoyp8MUD1od0rXuRM4js9eqDtcjTxadkgY8TQFETLnSMcB6Jp4jxymTA==
X-Google-Smtp-Source: AGHT+IFxskDZPySlpZ3bT5S8UnwqSKufsWA2e1dV8e/1IW1mXU6CmBPoksMOZaLAXywnTJE0q8HMItYvdekhpkn+xN4=
X-Received: by 2002:a2e:be25:0:b0:2ff:56a6:2992 with SMTP id
 38308e7fff4ca-302544cd514mr44711561fa.37.1734430084365; Tue, 17 Dec 2024
 02:08:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212211459.125929-1-cgoettsche@seltendoof.de>
In-Reply-To: <20241212211459.125929-1-cgoettsche@seltendoof.de>
From: Takaya Saeki <takayas@chromium.org>
Date: Tue, 17 Dec 2024 19:07:52 +0900
Message-ID: <CAH9xa6cg2Qt9Bf0N-=R3p+__cO2Vh32rKNGg8E7uq0uL=gXvtg@mail.gmail.com>
Subject: Re: [RFC PATCH v2] libselinux: restore previous regex spec ordering
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I've tested this patch with my local Android. All tests passed and all files
seem to have the same labels. Thank you very much for the quick fix!
