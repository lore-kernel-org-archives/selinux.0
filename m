Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC68313CA99
	for <selinux@vger.kernel.org>; Mon,  3 Jun 2024 22:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717454321; cv=none; b=oDqUU90zc9ePteMzN0Nu5ibPbTov/jmsf/tDwXEozIeVmJ562GA1DqkUu/Ll0E5CtLS0T4Z8tHj14eZBbKVve29tTwDhKs2dbQOqvz2NzUXKOttAAUYbgsJ7AsjvGgpvwd2bX2yk6JATdqJk+5WgN6/RnOGKuEAVpAGblPoZxoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717454321; c=relaxed/simple;
	bh=ADQ686y0LUmppB8hKb1UqpO0JQXUA06qEhc0vs+CvAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g1NvGvvHn4H4umGs29xu2SVf7h5g3sUjHrnzPdz2ggtYStp1r4AipWMLrqarbhbPPe9bOIVJlQjcYbI6gSpBDAW2y9G6gGF6TzuLKdiG5dJnR/PGSSKhrleWO3H6jlYGQ8lXKfkcM52Nxo+ZODLRYHC/hC4chfvak507Ea6lcnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GlLbdUhx; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GlLbdUhx"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52b9d062526so1408705e87.3
        for <selinux@vger.kernel.org>; Mon, 03 Jun 2024 15:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1717454318; x=1718059118; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6K+BGd/sjVibNL1YxWnASTBR3LzmvEWN/LqVUKBH3Cg=;
        b=GlLbdUhxMOvfv07UbuQp52IzwdbLEpzUyMLKXMF+3Sd3FveyGQ9kiponRzzOcpMI6T
         emqgoJVIwu8WT9FqW+p07vqBAyXhgq+fwevyFcKUJiULsxWdobvwl8b48coCz7mCa9oe
         PdXEK+mV0+PmDWLF5beeySzOz0sai6fZmW68U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717454318; x=1718059118;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6K+BGd/sjVibNL1YxWnASTBR3LzmvEWN/LqVUKBH3Cg=;
        b=qkTHg72AXjzLwxiW+Hjbpvs9/ecJ4rNO8U2XU7fyCDsuWpzcjM6JVG7GThmWAjl93v
         xEMl4KgaFulgI9slB1qo1rABCaYjc1AVaZY+sC0hYwZsi+ujoC985HQHp+1ykqa7s+UR
         YCC4JYm1qiATX/2eiVHtqYcUSVr7DxrbSxF964SL4RrdcdFgAd7n3ZZEZA+kZ4AwSsQb
         cYrk7P6ruJibTiu2vXRTQ0fDKzO1qTDjiqGTa6iku1u40sMcrrHhSAXRXdyaQ6s2ahLb
         Xyq4m7zkw8onUy/P89vmIG8sFMpbJF6arqS6fvISztlz79jg+stHdCnbtQnulURcTXw6
         1b7g==
X-Forwarded-Encrypted: i=1; AJvYcCU7ujn7BgIEu94OgqxG1/0tsJlTefeMeSRZDIGyAq2DUban9eKHXwOUT1AqLeiQf7Rnk4CJjQpZblqydvCjU7LqY2uSdJ8/sw==
X-Gm-Message-State: AOJu0YxL4jyvR531+vfoZxr9qtVVsyQIGLmLImNa9sGaLHFvLvIgUTr4
	zJ8EJuU8WhDt6bh91Vgn96P77b7VAAcK73DuRFXvtRIYl0lAP0v00UxIGnG6io7gX1gwfR8ToK9
	p/PkQgQ==
X-Google-Smtp-Source: AGHT+IH+8RQxZjLwktzaGtNSJuYbDz+j3rCJH9+CbqhB3U0mcuBbiVy7UpuvMZzpU7pFnHWCeWSVyg==
X-Received: by 2002:a19:6a09:0:b0:523:91af:12d9 with SMTP id 2adb3069b0e04-52b89564084mr6380998e87.9.1717454317737;
        Mon, 03 Jun 2024 15:38:37 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b8bb9a86asm1123781e87.52.2024.06.03.15.38.37
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 15:38:37 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52b912198f1so3691341e87.0
        for <selinux@vger.kernel.org>; Mon, 03 Jun 2024 15:38:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVV8tGi0M0Ilh/MH+3ap6gLyTgwoXYShKdIAW6AVN3kvqnVmM6HNMtgi2reAH2twMQuggCCKjLq90Jep99N/UOhdVbgz8QnXw==
X-Received: by 2002:a05:6512:159a:b0:52b:9f37:3ec2 with SMTP id
 2adb3069b0e04-52b9f373f5fmr1374809e87.11.1717454316895; Mon, 03 Jun 2024
 15:38:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240602023754.25443-1-laoar.shao@gmail.com> <20240602023754.25443-3-laoar.shao@gmail.com>
 <20240603172008.19ba98ff@gandalf.local.home> <CAHk-=whPUBbug2PACOzYXFbaHhA6igWgmBzpr5tOQYzMZinRnA@mail.gmail.com>
 <20240603181943.09a539aa@gandalf.local.home> <CAHk-=wgDWUpz2LG5KEztbg-S87N9GjPf5Tv2CVFbxKJJ0uwfSQ@mail.gmail.com>
 <20240603183742.17b34bc3@gandalf.local.home>
In-Reply-To: <20240603183742.17b34bc3@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 3 Jun 2024 15:38:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg4WVUkXD1LMz2jFf9eY=p83SWSM0b4rcP34SshkgFoxw@mail.gmail.com>
Message-ID: <CAHk-=wg4WVUkXD1LMz2jFf9eY=p83SWSM0b4rcP34SshkgFoxw@mail.gmail.com>
Subject: Re: [PATCH 2/6] tracing: Replace memcpy() with __get_task_comm()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Yafang Shao <laoar.shao@gmail.com>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, audit@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	bpf@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Jun 2024 at 15:36, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> It's actually a 4 byte meta data that holds it.

Ok, much better.

> Note, I've been wanting to get rid of the hard coded TASK_COMM_LEN from the
> events for a while. As I mentioned before, the only reason the memcpy exists
> is because it was added before the __string() logic was. Then it became
> somewhat of a habit to do that for everything that referenced task->comm. :-/

Ok, as long as it's an actual improvement, then ack.

            Linus
