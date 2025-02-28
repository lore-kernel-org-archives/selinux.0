Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC66D819
	for <selinux@vger.kernel.org>; Fri, 28 Feb 2025 04:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740717323; cv=none; b=EsVRikwoMPZxSd2rQRXYjEprld/DVsSU/9tfv4ibdRN/ers2oGRZZ7FXigiXdVvJHh4vKfGL0XLObYbPVDKHDxD8UcY9f+LZ+DqqizZzkzf6A6Oh9VxSuiYRUhgH5KcvzWodTIVfIJiN67olZTN3wGcqQRpdTO7rHNYHv4+CnB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740717323; c=relaxed/simple;
	bh=yP90KD9+CRJuHMbdeepo9UxP1ry0oJtxTbf/m+nv+KE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r8z3T3HccguFTMk1OyiRl4qwU7nSxx7yJfzYBGqFeXrQOIewVuvnTASLS52wzzTdu4AIjRhYAxivAZDFKW1SwYIBE5OFb7tfGWSL2pOkKbk0AvgGfSQDuqhS9l+xML+7IgO0AQ3axmaRpRruKZrM/hryS77ZKPTlB2dZ7g/kxHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EVMBq6xn; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EVMBq6xn"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-307c13298eeso20616921fa.0
        for <selinux@vger.kernel.org>; Thu, 27 Feb 2025 20:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740717320; x=1741322120; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yP90KD9+CRJuHMbdeepo9UxP1ry0oJtxTbf/m+nv+KE=;
        b=EVMBq6xnCugOr8b/JJTvw0exUV8SkkM8JgWLi2wTofa/Q0Ea29ZDf3LnD3wIYW43LM
         HwMP/bOljDn8gr82/2ItjpnZh5k10a/q+55Pt0EU3ySiPWpMmkBCC1tmFfFAdOeXg1Ch
         CMJDKZlwsQ/BoAHzfpQMsMOwyENu6kcVOBmW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740717320; x=1741322120;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yP90KD9+CRJuHMbdeepo9UxP1ry0oJtxTbf/m+nv+KE=;
        b=e+rsGpwHcl/pfJndChvZCj58Yc91DXlIuU+xv4ZI/oe6iud+9VM37RGcqRHgFBYZk2
         ffe/jVoU2YZ4Fw55sNOPBSvJrkbTo+vDZmGdapQuVs+QB/eFM2W/YJ0NQAMVH7PtpXr+
         IQI/bcv6k9yZ6eMJ6qdlpuR8FSolTvp7Vi1FzaLCX67BZmF+stqxfXUIFGz9pKXjB/v8
         OxA78UhE7u1I/8Y9P4ToniwWjx/jnC+LL8CbJ2VVl7aMOadQXmPbZ1qGbXhkBz6nLQDz
         hmf5edTHpRMYMMF2GJIAZczIhCKo8vs4tfy+61/6FUfZdRgZ8PMOb7Pg5ta+nubmKTW1
         Mm+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVn5ALMsrXT4oi3XBp2lgXuAd2tjsv/Ak27ddMU8WiAznXvF18I3D286+zdAGkSaWapS8j6EiQA@vger.kernel.org
X-Gm-Message-State: AOJu0YzqtCO710BAnIWVQWj90pGWN5yWUwvPVa7lmx2su+o/iiS36AQ/
	wKnlvXzJLlLQdOkZSl3fEZGEOGGGugW1ztiOLkkTvcUYaunB1bAzJyAJM5Iu5nTRUUlEEuB0tg1
	lG2h3V3tbCgbMJNWPZUIV+NEA/3A3ZAM0vwQ=
X-Gm-Gg: ASbGncvX8Ps+uxaH4AkQCQ6hxfsHN6loVN/tApNF2/XMOhhFxvxj+OiEZfIturD8KfH
	VHz98JXdy8GMe6r1tgNwF+7lFihzaA+vjcRZbfEzn/jnH0Kg08i8eJ553m46AcM1Y+5sxEhMvOc
	BPwlLjS6CIyukTcb4xvKsWKqI1l3Zn9PCwHxOP
X-Google-Smtp-Source: AGHT+IElxauQfBzM1tCTNoFNkHzmXVmCmQ5xy5gh05HCDVZl8us0Ea0quzw4porhzOERz0Uzix18Vcy/RWswBOYoXZ0=
X-Received: by 2002:a2e:3208:0:b0:30b:9a2d:a50b with SMTP id
 38308e7fff4ca-30b9a2daa2dmr898851fa.16.1740717319874; Thu, 27 Feb 2025
 20:35:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210115551.1225204-1-takayas@chromium.org> <7ae30862-13ef-4875-a4fc-dff60c4c27b6@linux.microsoft.com>
In-Reply-To: <7ae30862-13ef-4875-a4fc-dff60c4c27b6@linux.microsoft.com>
From: Takaya Saeki <takayas@chromium.org>
Date: Fri, 28 Feb 2025 13:35:08 +0900
X-Gm-Features: AQ5f1Jo4A7LeOZmd9S-eYzQpm99TUy1rxFfszlymrZr7dFfNfgpcwKRKV9EpECE
Message-ID: <CAH9xa6fLoj0XOz-ju913BojNB1_6-BaBBKSjCSHsrYs6pjcmoA@mail.gmail.com>
Subject: Re: [PATCH] selinux: support wildcard match in genfscon
To: Daniel Burgener <dburgener@linux.microsoft.com>
Cc: Paul Moore <paul@paul-moore.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	=?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Nick Kralevich <nnk@google.com>, Jeffrey Vander Stoep <jeffv@google.com>, Junichi <uekawa@chromium.org>, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Daniel,

Yes, I'm going to send a follow-up patch. I was tied up with other
tasks for a while. Let me send a follow-up patch shortly.
