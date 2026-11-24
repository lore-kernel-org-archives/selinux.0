Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795564150;
	b=0fUnQcNowPcykCD0hPNotktd9PPPP+FSk+6RFarjKKU2F0Ne2z9kg+hd6GU7IcS9nqXk
	 x2jkI00XMpNu8zvB4149pa9+3uXloJFPFr+oYNFxxaBwTaX/sPScyKFf7TjTN+4g/gjOM
	 7oErfW6qWL+Ja7WETvFGWjF96/BRXOAVXUGH5DVqW0WJ8gktXmSishNvtytqWCJ2V0Tgf
	 xFtdQtlmDh3mJQZ0f9cfDEGKw6nT39TFg+JjchiMjhEnfS8oROLrNN30Gj8GQygeoLJ67
	 NMHiaxQBVwc+gqrM6f40hBiS2CxkPpmU41yMRyegUYaDgiGSVY8l2SGGMaygjBk0gbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795564150;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=lKDulksU0CH8kWxQ0HqONqWmjOATVYmG6DnvF0rQk9k=;
	b=Df01HCrWPj0Q3n4nrHlyeIFmA1p3p9yVy60+ZJBob5EbtGfuritfBcOjC+yewkVM1LSw
	 /MlGV0vlauKUrfziVM8ypgF4yPwx17F7r4iEi7stkLlVXOL9on1t/jamDbItqcCHiTfjo
	 YRpmNGxvJ4LBDzl1EjcjBcSijuOw4iUjMxuCkmpHb2PGS35QT+dDBn/9E4Q7N83tSgwXG
	 uvJMCeXLPEVhTxxXnUeTxs+4Fw3puo9BeOekLr0/ScBgpX0dn6BZE6+w87wkzm+57Hiyx
	 boj4Z/Oh0iwlc+pu906GwuSYAmZp5C8qiuwpqjwtTg1216p9TYdeytx8VtvP/iMgyWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IlpI7jOH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2371606A31E;
	Tue, 24 Nov 2026 23:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IlpI7jOH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A1521F000CA;
	Tue, 24 Nov 2026 23:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795564149;
	bh=lKDulksU0CH8kWxQ0HqONqWmjOATVYmG6DnvF0rQk9k=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=IlpI7jOHHg6tzDJtT7dUsw9yL6fpvZ9HKK1m6TkLc2LiZZ3UD8SsdCYQOPTGUoh4Z
	 NipXRVpiqDCGW1FPX4Aj+JWvOWuaH7yh47kJrzJMMgWYxRGBiXlzu1T/MZUWUC4g0W
	 vMNK/n0rsVJnt4+MwUB+9ab95GUxpkKWlaQFELGgsxYF/A92uqHyYjG81QXhlUvaqv
	 UyJ18+lF5X1JslR+TZbpCj/oUXLo5lcdp3gbMbe0ryI4vzplir4QZl2zv7zCVHIKE6
	 KKnfsBtZ25FkDGwWmWDCI+A50sHcwbB23XU+Xd+0/5dBGydMv0HgkDtdDiR3r5CDs1
	 IEQtda9ZYTz+A==
Content-Type: multipart/mixed; boundary="===============2510359726493679342=="
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <fd2115bde2e78440a8c28b057e22f7a7a3064cb74e9030b92ee2f4498ea6046a@mail.kernel.org>
In-Reply-To: <20261124-work-exec-update_lock-v1-18-e489035395b8@kernel.org>
References: <20261124-work-exec-update_lock-v1-18-e489035395b8@kernel.org>
Subject: Re: [PATCH RFC 18/19] vfork: wake up the parent once the child has left the mm
From: bot+bpf-ci@kernel.org
To: brauner@kernel.org,jannh@google.com
Cc: torvalds@linux-foundation.org,linux-fsdevel@vger.kernel.org,acme@kernel.org,linux-perf-users@vger.kernel.org,bpf@vger.kernel.org,selinux@vger.kernel.org,kees@kernel.org,linux-mm@kvack.org,linux-security-module@vger.kernel.org,apparmor@lists.ubuntu.com,david@kernel.org,brauner@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 24 Nov 2026 23:49:07 +0000 (UTC)

--===============2510359726493679342==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> vfork: wake up the parent once the child has left the mm

TL;DR: Commit message only: it cites "[1]" for the 2.5.56 change but has no
matching link; the review asks for the history.git URL to be added.

>     vfork: wake up the parent once the child has left the mm
>
>     A task that called vfork() sleeps until the child has released the mm in
>     mm_release(). But exec_mmap() releases the old mm, then waits for
>     exec_update_lock and only then switches to the new mm. And exit_mm()
>     releases the mm and only then drops it. So the parent is woken up while
>     the child is still on its mm.
>
>     It wasn't meant to be that way. When mm_release() was added in 2.2 it
>     was called after the task had been switched away from the mm. exec only
>     moved it in front of the switch in 2.5.56 because deactivate_mm() and
>     the write to the child tid address need the old mm (cf. [1]).
>
>     The release has to stay where it is as it can sleep in a page fault for
>     as long as userspace likes. So take the wakeup out of mm_release(). Wake
>     up the parent in exec_mmap() once the task has switched to its new mm
>     and in exit_mm() once it has dropped the mm.
>
>     While at it, fix the comment above mm_release(). It hasn't been called
>     after the mm was removed from the task since 2.5.56.
>
>     Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

This isn't a bug, but the changelog cites "(cf. [1])" for the 2.5.56 change
that moved mm_release() in front of the mm switch, and there is no
"[1]: https://..." line or Link: tag anywhere in the message.

The previous commit in the series, d0c33c04297e ("exit: don't take the mmap
lock in exit_mm()"), uses the same "(cf. [1])" form and does end with a
"[1]: https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/..."
line.

Could the history.git link for the 2.5.56 change be added here as well?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/45508356147
--===============2510359726493679342==--
