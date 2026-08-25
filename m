Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C9948382F
	for <selinux@vger.kernel.org>; Tue, 25 Aug 2026 13:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787665652; cv=pass; b=TU+YBtk+r4HToXD08x7lKpKUjDVwhcn1d+NTsw0iyFDNX9mk65wHBG8KGEx4bocm80SpUzSbVWr2+o4LbeIhxmI71RG73G91UdK62s9lJqfTnYiiy+5+o6NAmJlvGXEYsnIJY60Tr1HFaQmnAt8gIWIdik3h8UwJazU20LGD0HA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787665652; c=relaxed/simple;
	bh=f27C2IG9jxEp5m5m+A45U94PwUHYq9WXQ+b1ZTPnZCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=svsh0rI1gusSq2970tishkDN6Nm1BQ/J9g0Y5BFvfMWlhrB4YJxiNPrc6RfH+z5mHVj3Z666eyjzghxlKaMcGwSHZrxWjgOLos8bfWqY5i1RqKJM6BKW8J0/yphWpxFSF2QEbrV9rxYsgq/WJ9cKM8bTMKDB9rI+DoQCgpEN2dI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pQfCLGzK; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pQfCLGzK"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ccdf36f63dso123275ad.0
        for <selinux@vger.kernel.org>; Tue, 25 Aug 2026 06:47:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787665650; cv=none;
        d=google.com; s=arc-20260327;
        b=Ldtc9s3OcWXyH4H6F7mRvkEOIdGBNXHgdhvyuYgAwcgT8xi0LWOQXYcTKU09Ab3rfb
         dwHH0WuPLxU09TF1RJQFCEyvAfC1WtWt1/LjzJcmjJSreOcjod4qyrLFSn3Z899QW+vj
         BtDVBXrj577K15RS+GeG7cKUhJr4O3uwKdQ5dqSOzMQ0IY3ZG86cLywHsu0J2nZge2eo
         UqAAYCorm4m6/xHTsPbWH9mxC466I5YPT+ThKQ0RiuWWq5PzEx9zy40gUcOPBzXaMqOh
         lvCXXpRKy0Xu7qJOV/MH20jfhU6qlTpL/NC1B4SYsdJ6ewOAGAoN81U/ubn2HPwHbltJ
         mG7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f27C2IG9jxEp5m5m+A45U94PwUHYq9WXQ+b1ZTPnZCY=;
        fh=VmUlVutm5eZda8dn/sbTlzQvWAmM6QVZUQmYFj2j4hw=;
        b=SsCf/PeVuX0JpsfMwoUVTvp7ezN/i2/3c+RJNjXiC0Qwh1DLQUeYMMDCniN5Ty+qoL
         d8YywjPdcHNX/BlpwGkPatwiZwaBPVBFpI6CzQTf8j/nl80O4pSB3GMGTRw/s0ItbLKP
         CQMIcZQejhYclAaaloMFfUKcuFDiVNKfaHkQrYTXBiGYlgfLQIHmelT0ujmz8BOzGVV/
         YlXxEYO15d7LVA3nmuNLV9GvAkR2RNNdMW66uOQbl5M+4ZRCr4ye9z0n1ivPT5nJFK/O
         +hUSO2N8uUlQBC4HbPNkYFAVYDIkRlr/wQbqITusOx64noiGZw72zq/UiUV31e3gRGp/
         9r+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787665650; x=1788270450; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f27C2IG9jxEp5m5m+A45U94PwUHYq9WXQ+b1ZTPnZCY=;
        b=pQfCLGzKXbJopNI4+KcVgfsQq1F8p0CjJtsfYdHWRAQkL5eRP+32k1FD8Jt1lDOdKI
         5h0Rspo6RfZObUsE0agFw1NLNHW4HgwVFS/eLezGlS6iW+QeBLLkBaF1up1/qNX57b1M
         oIN3sNEwjYmpkPyNRewHCOhrFGcRVNT94tU9GKJPZeJ2E17RLhVgnBngdEsmaIUwcP3m
         4tGr/g5DrgibwEsm16Tws6a3TcMgyDK7oT2GmfhDqtf2y9lRrIVvcA6/hxhMaHqFCQqV
         yrXQl3Nazf9w87Sxuvi5dcawq6JSLQA7OkOFgns3kHO6bxXFQGmapNRQahbg4i1Zux3j
         b0jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787665650; x=1788270450;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f27C2IG9jxEp5m5m+A45U94PwUHYq9WXQ+b1ZTPnZCY=;
        b=qq/vD9pGK1pJjPliOO4jdIBCy0SMJm3TJLpuYvTrWNvfPE+lqRnC4znU8A79IsOQVj
         NZdCobPbWKaR98BZrupk8luTID2I/htJ+N8NvVQM9Lv0rUg4s5u7KmyZVLZUEWiY9QBR
         vUzWu7o1c37y0QowxDthjHKP1y3oXgBbblDjL0V5nHwMosnn3JkHElNWXjjYnYaKEaKl
         5AJh7c5VTfos1UpG1Jw6S8YJhw0RpjnGCzaE89xzvzdsvWF0ImxkzQI8eYSEYZhrOEHY
         DIJSO4ECHOAthlae68bFHSmvgLOqtSVsB11aT1uzYHRzflQAaoRSSOk/GU1JblRRB/YT
         +P+A==
X-Forwarded-Encrypted: i=1; AHgh+RoWG9SP2PchfayDeTv2DfT7kdU+KswjBwdw4Ff6+65gygvZyVN+43WmbAYAPMjxqoGv+uXLbvcM@vger.kernel.org
X-Gm-Message-State: AFuF++nat7PlnXbnCBj2Pia/h5qGtlAKMqQM6K/1UQn56tTB4Vlt5pW5
	iffeL3ChNmf82STZr0ufGUeRxW3A36K0gQCFBcLBVYKovoj8GFCIkMpUd7XzQjgntc71I6J4lmE
	NqQ6KM3+NVPyS2HpLxAxWFlBUce41b250BXdBnhTt
X-Gm-Gg: AR+sD10NYvEeb5IgjEBrK0lOzUpxF/NOBDYbCz4zmEmc9bjiV/stIyO8lwxMdULRSa8
	xQZX89gqn448+EJAx2pjHSveRrjxEHB9nEEonf6ho4FxnPAmSHKT9KoawQyOUWu7L4XGow4ISd1
	pNu+b/9ch3iD8VvqinFtjI39KDfs4v1gm015upMuxBX3PpZpYuvld2dzx4c8O1sLAraNYggNqTn
	7FN0Th74br0IvvyQvFhupj6+/hNByUAJOD90Bnv0MlQ5qVUI//JryrOXqgI0yCp59ZqgkctSuK7
	leVp/2GYy1m5pWs4A9WpMV9CD8KG+Iq3wyKh2dpg7/cFcYl921nZPGDkm+owRglwxuPTHIiJpVG
	leEGHmh9zhLlr4UWkv2H1NoltrZuuiw==
X-Received: by 2002:a17:902:c394:b0:2c7:b1e7:501e with SMTP id
 d9443c01a7336-2d6e0833465mr5727505ad.3.1787665649437; Tue, 25 Aug 2026
 06:47:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818-selinux-pokemem-v1-0-90cd2357ee05@google.com>
 <20260818-selinux-pokemem-v1-2-90cd2357ee05@google.com> <20260825-passt-semmel-primitiv-37712c04e6c6@brauner>
In-Reply-To: <20260825-passt-semmel-primitiv-37712c04e6c6@brauner>
From: Jann Horn <jannh@google.com>
Date: Tue, 25 Aug 2026 15:46:50 +0200
X-Gm-Features: AcwNN1WZJkxp4obi4wAiUHBJBjq7knCxVUW1syYekpF7g7n4ms28g-sCd7iZ7lk
Message-ID: <CAG48ez22J6tYZv6cG0TEoUFBrbhtWh6BHrZYBWuD-ee1hVr4ZA@mail.gmail.com>
Subject: Re: [PATCH 2/3] proc: query LSMs for introspective mem access (if PROC_MEM_FORCE_ALWAYS)
To: Christian Brauner <brauner@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Jeff Xu <jeffxu@google.com>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>, 
	selinux@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@kernel.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 3:13=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> On Tue, Aug 18, 2026 at 09:51:06PM +0200, Jann Horn wrote:
> > If the system is running with PROC_MEM_FORCE_ALWAYS, LSMs currently hav=
e no
> > good opportunity to block a process from overwriting read-only code in =
its
> > own address space through FOLL_FORCE writes via /proc/self/mem.
> > The security_ptrace_access_check() LSM hook is bypassed when a process
> > opens /proc/self/mem because this is considered "introspection".
>
> Useful. I ran into this issue just yesterday in:
>
> https://github.com/systemd/systemd/pull/43511
>
> Btw, it's kinda annoying that PTRACE_POKE{TEXT,DATA} still allows foll
> force writes even if PROC_MEM_FORCE_NEVER is enabled. So ideally there'd
> also be a hook for that option.

You need either /proc/$pid/mem or PTRACE_POKETEXT for installing
software breakpoints. I think if you want to completely block
FOLL_FORCE through ptrace, you're probably in a scenario where ptrace
should either be blocked completely, or at least restricted to
mostly-read-only operations?

> The other thing - though not directly FOLL_FORCE related - is that
> process_vm_writev() isn't subject to any security restrictions other
> than seccomp filtering either.

It does go through mm_access() and ptrace_may_access() unless the
access is same-MM, so it can be blocked by LSMs like Yama.
