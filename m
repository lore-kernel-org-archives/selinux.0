Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DFE1E502
	for <selinux@vger.kernel.org>; Thu, 28 Aug 2025 15:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756394045; cv=none; b=H6N60reabgmLZ05sFSSz/Oba8pFpSV1vx0LCXOLUiU08QF8NKWDfgC/mYZ7+kSDLMUTrB4v1Q1MdepDEFUTCt8PtEML85AWnAiYW4JuLWCuGlPktnv1aJL8PioqkX/yI4s4SIn4DdGD/d5hXB8uZOvgjhNvRJ0ggqIEawli527g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756394045; c=relaxed/simple;
	bh=++s62hW7OBa0l+4/DpAnC9LOKmBOE+6VWqOSbmKKErg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cw6JZQiT4VkeNojiuEChvcUCnRkKAvlwU240D9/Aps65TJ6BbMxGwbsODyM83OlGiU+Rf94bEcmGbCeB0deOvOx3ZsVIKTtTxvfc4qjXndOAd5kZj6DywQWTDacQDvjWbTiHBv8Qp9ipZZhIJRt9X5SLM33nOebN9qOK10c3dsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o7v6t2XX; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o7v6t2XX"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3ea8b3a64b5so9284465ab.2
        for <selinux@vger.kernel.org>; Thu, 28 Aug 2025 08:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756394043; x=1756998843; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9QjH1nYmKuaK8/vbNAhIt79YgVpoGEuS/iGXFW67apM=;
        b=o7v6t2XXcmsdJ9PvXz6sq1LELwGJIPDcC+OFMrSpvqCSXDJCIcyX0uKC8E93T+2MI/
         paxBzbZpCk3qvwS1cm6ZH/w9o5wvMrIqqs9hBU2NlgnAEWIGlqGbuUxLCKeWD9UZ/jwP
         jjP4IulU691KFB4K10YElE6OmhYhzgYOwK+4fM6hy6n8Noj2Zy08CrHr/OLaywuzaxL/
         EaG4AWMnTPDzz+IIVoM8ecYoSybSn/1BBB3lNzTRZLjx6ST6N+CLdNIgoL8CxPGvFakL
         SQuM4FruKJpvqHJ54ZmHgxXeG7C/pXPBg3bFM5g/Fhk2ZDK+UWCh2ei2po8DgZCM0dFz
         GcSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756394043; x=1756998843;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9QjH1nYmKuaK8/vbNAhIt79YgVpoGEuS/iGXFW67apM=;
        b=trN3XUyx2TCy/E21I5waeijvTFSwYO1x2aRPSoWwweEQrMxN3d2Nw9i3u7l7YpIxei
         ARko1X/KwveqO7YeJzNqX8KV9Dztwkw5630goEkRZ6KtYNtJpYe2AwJ9emE7III5ZsNj
         /DZQiZk7Ib2tumExR2gN1nQSZCWOvOTKjjVY0ecTUB8LKhf6GFR9lOayw4wDmKyLpqIA
         AHXZnNctz7or48WAw/UISZGG7pZuF3fdKz5IAJw8qL1pazGngD82T3VQ/y8dB9Y+3gL7
         HVRY/5q3gGuEaPjqwf5l7QuB/ATJbhx5Ei5w7NlRHTpdU+npDzHhRB3+FZCkYhBvG+vZ
         a7kw==
X-Forwarded-Encrypted: i=1; AJvYcCXnHA4HhomHU2haF7rK8EwyjsJDXe+w6LahhMXlmVzK8zHcPrM/AY6sh/AYBaDR7KTJKr7qQKQe@vger.kernel.org
X-Gm-Message-State: AOJu0YzLPft5rkHWvn4WODSy7Mrp33EOxidjSkh51SfZ87Ktnh1uSDFv
	y8AYgwH6nwlFmr0J5+/LpCE4OjbiHkGA7SeQ4KVyzs18Zyh9c/MdVJFP0cwr4vYAuQ==
X-Gm-Gg: ASbGnctrCfBDSw+9hith3NJH0aHLhhcEKdUhzytHFjGptTZfZoytS4pLcsu/TBZXQ+5
	YGDk1xLC4px7JNH8hPGMlvuYGSq8Pbzc2LUA1H8ZxVRZM4StAkKPf1X4WlM1HTwujWw424NpTCS
	hniC9JCFyFUW5vKuajgb1myFCo94gF0IHFImftw21WJ9pbbeuMU3duSlZPXQ4/K21/9sRrUVtFU
	LNBECof7tqHs6YbD982HQfA4cZmAVluwyy9fgRxv0LVERua79E3ZKrbTUyvL8sLJc3EQzSFseob
	cllkBakVYnMGL8yWxUtq+zo9pPRSg4B5Bk0dj8Y5E749TY281vfoXftz/oCWP5nFVIxA3td1ayo
	wNrqSHwn1NgIYxbUFVGHTldgi7TD8q3ketobdntzKps8mmx8kcmTWiR5v8xERlKlnRJvPYY287T
	kr
X-Google-Smtp-Source: AGHT+IHIYBXQTGiCww/PFnxj0YWLbLCi2wzmsjMIYDw9X9C2ummK1XtPh0NkG5nHEbdzSuIpZ0lSCA==
X-Received: by 2002:a05:6e02:1b08:b0:3e9:eec4:9b71 with SMTP id e9e14a558f8ab-3e9eec49eedmr327588045ab.28.1756394043133;
        Thu, 28 Aug 2025 08:14:03 -0700 (PDT)
Received: from google.com (189.227.72.34.bc.googleusercontent.com. [34.72.227.189])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3ea4c75cfd7sm108783375ab.22.2025.08.28.08.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 08:14:02 -0700 (PDT)
Date: Thu, 28 Aug 2025 15:13:59 +0000
From: Neill Kapron <nkapron@google.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>,
	kernel-team@android.com, linux-kernel@vger.kernel.org,
	selinux@vger.kernel.org
Subject: Re: [PATCH v2 1/2] selinux: enable per-file labeling for functionfs
Message-ID: <aLByN-OSeVTLdStd@google.com>
References: <20250827222224.1648500-1-nkapron@google.com>
 <CAEjxPJ4QKnzgoSYgfy8+CqjRigEbW7=B5t4fO4djbO5GnLtCOg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEjxPJ4QKnzgoSYgfy8+CqjRigEbW7=B5t4fO4djbO5GnLtCOg@mail.gmail.com>

On Thu, Aug 28, 2025 at 09:08:48AM -0400, Stephen Smalley wrote:
 
> This isn't actually a multi-patch series for the kernel, so don't use
> the patch 1/2, patch 2/2 notation since that confuses b4 (it tries to
> pull in the 2nd patch for libsepol and unsurprisingly that won't apply
> to the kernel). Not sure that warrants re-posting (defer to Paul).

Whoops, I will send separate patches as v3.

Thanks,
Neill

