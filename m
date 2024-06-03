Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2975313C809
	for <selinux@vger.kernel.org>; Mon,  3 Jun 2024 21:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717450952; cv=none; b=Tkt0/N46IKglBNF/Vt0PX6pK9k4Ma1Y1wxj1zY5csj0Zs9sU0DLXdJPrxUJo47b9TWMo6k8iVQY0ui3FP4XbQyyoy0bx25c6xjKhtt1ctF7Bvl2rC3YKSVY/YyEEzVlHBQq90WNHB3RYbjJgaXFWSq5Cbw18UhoCN+nNSTxtpWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717450952; c=relaxed/simple;
	bh=t2+3hpTAkuvcywD1/Fq+cZAsXxs3N6zMjhMfwGrJHIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fd2ClzfMrCWQ0CJBGDDRxY3ms3zxnHvZ0DPZluubXNPBBJfBg/dCRxxb56+IYkLuyQelX1Mhvu31c00nCuOLsPudRWIN4AAuFBnDqaOTGb1vkbCy4S9Nv+umxiRLBieYll4RclMtneUbTX0Kw2UeouDfJ2KWZsZqhRQCQ8VJHBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=N1eI4ZhZ; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="N1eI4ZhZ"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a6267778b3aso436310866b.3
        for <selinux@vger.kernel.org>; Mon, 03 Jun 2024 14:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1717450949; x=1718055749; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R+C9bWbF6JQXXqqT/WHs93C1W49YzDnZgVk3vpecOx4=;
        b=N1eI4ZhZlPjf68UnhLGKgEctRtMjOntNIkVhWbizskPmuiRECFIehLROdwxyzTQ9AH
         S9cP0MBrkfaqe7srvrEyx01OYady8bCw+zGe0+e6RweNuBb176fwD8b5ZT0cNBTt5D0R
         vn7DjORx+6oRGzNKhQi4sA6ri3UvO20Z+ast4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717450949; x=1718055749;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R+C9bWbF6JQXXqqT/WHs93C1W49YzDnZgVk3vpecOx4=;
        b=k8Z3F52ghKUfMrO5q7WoKNzOwcRwD49IDiAwFy2H3ZxHTDf3YS30uAwLSqvSSW7lCi
         dxgjQQGKWLQeCnGUhALwwvMHQ06jqX1qArEUiCFeT1ttylp/kpqfrsRTcxp/I8m5USyF
         O2Dm+ok49oDMTue0T7I3gbBGzsTM0pEht9PDiU5aLQW7JLyUlMciWgq3eRU9wBk3rEr6
         jJPVEehRonasexDS/WWtxVMRrwLTR49zNFz50dCO8mD1jUih2hYNyGxbg5sv6io/m10f
         z3+hkdTJhexZeg/EkXSLHOpDI3UMMz1Xm971oZbFtU1tan16AFmM793modNkwsUh59HA
         4YJg==
X-Forwarded-Encrypted: i=1; AJvYcCW4H5ZBfKM3I6XhsuUYN5AVE+ZVfvxfrW6cHY9WvBdrbE/FNCrF6j09fxw8wgw7fnOfff/lhhWBg9FsVH1jGh5/v5yj4DZfPA==
X-Gm-Message-State: AOJu0YwY3ATevCP7odmrVh4GZrlPffnHiWek5o2OxM1vSCMdrt8V3qb0
	A2l/Wf+hTidnrzNJHfHRFh3WxHzExRFGY+zWlftnAafocXoXGbZlTOwOxFWnyZwuTY0eNqxi3D6
	eFaU=
X-Google-Smtp-Source: AGHT+IEoG6VIVYS3oE9vxJTwluugo7rEuHnfKkFpfLzHbR+HlyLQpgvMBLeCxCYDu8vsbEAuXfhdcg==
X-Received: by 2002:a17:906:e948:b0:a68:98fe:f779 with SMTP id a640c23a62f3a-a6898fef87emr544787266b.43.1717450949409;
        Mon, 03 Jun 2024 14:42:29 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68ea36329fsm310950366b.165.2024.06.03.14.42.27
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 14:42:27 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a683868f463so434675866b.0
        for <selinux@vger.kernel.org>; Mon, 03 Jun 2024 14:42:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXCyugGxiSDDOqE/qf5RIfvNnvKSJ/2jJPRVSlnlK7Cnfe5otNgeGf+1aZ9Iks/FgT4TTovSOuJ87c+4RNiTWDVWbyE27F1MA==
X-Received: by 2002:a17:907:9482:b0:a68:c6c1:cd63 with SMTP id
 a640c23a62f3a-a68c6c1d466mr478691866b.13.1717450947222; Mon, 03 Jun 2024
 14:42:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240602023754.25443-1-laoar.shao@gmail.com> <20240602023754.25443-3-laoar.shao@gmail.com>
 <20240603172008.19ba98ff@gandalf.local.home>
In-Reply-To: <20240603172008.19ba98ff@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 3 Jun 2024 14:42:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=whPUBbug2PACOzYXFbaHhA6igWgmBzpr5tOQYzMZinRnA@mail.gmail.com>
Message-ID: <CAHk-=whPUBbug2PACOzYXFbaHhA6igWgmBzpr5tOQYzMZinRnA@mail.gmail.com>
Subject: Re: [PATCH 2/6] tracing: Replace memcpy() with __get_task_comm()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Yafang Shao <laoar.shao@gmail.com>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, audit@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	bpf@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Jun 2024 at 14:19, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> -               __array(        char,   comm,   TASK_COMM_LEN   )
> +               __string(       comm,   strlen(comm)            )

Is this actually safe is 'comm[]' is being modified at the same time?
The 'strlen()' will not be consistent with the string copy.

Because that is very much the case. It's not a stable source.

For example, strlen() may return 5. But by the time  you then actually
copy the data, the string may have changed, and there would not
necessarily be a NUL character at comm[5] any more. It might be
further in the string, or it might be earlier.

                  Linus
