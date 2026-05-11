Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E060382F18
	for <selinux@vger.kernel.org>; Mon, 11 May 2026 20:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778531308; cv=pass; b=pcMkuMLwn52yFILloc6cT7CFDP8YnvludVqPB7sS6C5hiJ2uv+MhsXdw2M5/1ORl2CvbhYwHUU3ofh/o8YIaTfl8e1upWJ1l3lfsNSNXqXqS2ZSNwv09jf4QwxPtKt50gYyEhLKuMTjyiaRM/+mrNFsKbnhkbMm8Gc8TTkm2yQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778531308; c=relaxed/simple;
	bh=hTbYoner07O2PP3jB6etyoj2SkkDIbMpdGA9ETgA8QU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZOzVe/H30Zb8VX8fArt0umkbYzrGBnWezYKpb7HK/WN+qJ7QH6fvjRdvBhYUVI9/qMD3X9mekRriTFV+BbbddZy7G+3RTfFH3do8I/CNkKi7uXAvFjNBZyuPEWtwtGOywpuTwXheLvhsBM0zxbU3GIXKAfXvDBzHobtlzfV0hIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Pqf2D/XX; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Pqf2D/XX"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-bd2087858c4so105272266b.0
        for <selinux@vger.kernel.org>; Mon, 11 May 2026 13:28:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778531305; cv=none;
        d=google.com; s=arc-20240605;
        b=a7W/bMrI081E2r4LSg4LU7WoFzb46VBkoT7puvHYCmTUWYGg28IwNqyZnohEgUBKN1
         YwkevvKldkfJ0406Cc6POrNQAeuC+a4RAolqO6ZBJAb9hzSmBmM+8Iceut2FeQiOBiGv
         pf09O7Z47Tqbq0jOol+t5oVLLxyrWBS1OAHek5i7kDFAYj2wnXR5VfxpaFGkRAfyGj8Y
         vi4Di9mtbr1+qwlMPqUpTwBK6KAGcKapZ9pfFt6xBpS5j0aMfh01nz12Ynw2Qz07tEZj
         vZrqPF1RrhQKC77qgXPCMqp6tDR3k3RapX9Yk/k1vg3nvdZsgPnTfvMa7zM3I4qAfG2E
         wbzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ecxYhhOsIWnMbGYp6OiuSoqJt7k54RRM2T4m9yuOxg8=;
        fh=cphAygbAAO2q6gjk6l7l7CcXV8C1iAPRhazXkgmZAAA=;
        b=aWD223ImJyhQnrKk4aRui+8jE79J6UWvT7p1mlRRnEUzAqkQwDqxPC5wn9uYx0O4ek
         Ex6u+EP0Ov917JYkA5EgPmWaf4dEbNlRdyGnP38fqk+N2jj1BxCJCnhiccYPH3b8ZdvX
         /gNJ0iyh0CfHAOCCxdpsb2XCWoaMiClcrvbJEWXZSBDCoi1ql9ATCWpDhXgigCxl2LM9
         VH4sEqPXc/NiXkgZg3ivPxBRrpFnYZWQPpTzy6mz4qI/dkS5x8Bl4dqNznryVmvK1Nf8
         iAG4WXNtUVUmSQF6ybQV8dxPAxuNP+KJ5iy+OAQs57IQ3G3zyxqLrbRMWqD98lvdxEIu
         y6iw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778531305; x=1779136105; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ecxYhhOsIWnMbGYp6OiuSoqJt7k54RRM2T4m9yuOxg8=;
        b=Pqf2D/XXkXoZWPZHQqMY9IBZsTPIzZc2s8hRWTLCIWWh/mCQNnoBCNusWpQOqSxv/M
         30btj8h0UrFnnMsiDnTkMr4mTshByweR1IFq8Cw7xpE5sbpgMjkfIWAIe6bmq2ud60M/
         lWdAm5DtQkIVu7LGk2lBHjld6eiUve2zjik9wv5Je1M48kL8miY1mC8QuCNlg0QUT9c4
         nSZfVBr2RZcJneAM++otv/6PpeB69KFfmV763eRrDzCDclvTtsgmy9FVK0C37xUfOBDB
         +8oxIhRLfsmOVYrtt2u1RAsjRCaJUQTwAW04tUyadp67+w3b8/KYFC5imeXFdAPE+sCl
         n2Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778531305; x=1779136105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ecxYhhOsIWnMbGYp6OiuSoqJt7k54RRM2T4m9yuOxg8=;
        b=p6sk8bH5c8NbQekvLW/0gd90lKQOtXxoekKhM1/is5FHN9j4lx+mRz6lAu7NIMe4dn
         ftwNkaBUXLj8qaTo0Rzu8RSbbA4G+VljQwHDfaXA6a5fpK+lsNbE2M+klt2m1hiXJBu7
         ML7e/blD8sDEm/85LePyz/x+OKLG1CCmHFCDziMfyt/lOtZGbr9qmCrMbH2yb8ICKWm6
         bKAeLO/DehNP7AeU9/wsebqn7J1xT1gJnCIoHdkzCS/5X/Gj+pbMana89PleC2fA3eCs
         k5+WahGieMRylDkkYxVnzdUpx4S8eQeMxfZolufR+NaOpt89imFnckHcOJeAHgxOwYMH
         d+0A==
X-Forwarded-Encrypted: i=1; AFNElJ/5LVzgkDLqHlPHzbtDZ9zhHhLZxMAdrbP3Jlyatz9txFvrpbBlSyX7QuuDmsjCf0LFWEzqSyRC@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2isx/jAI6wucf5a94EpHXNyCFWWCNenxo6pav7Mn0igCa8m7C
	3o3/L6f7B75HDTBu5zrh1lNLeSi4O38Ocscsd5oWpKhIc5PksztjYfsFLu/sHWZ7ksVGjBB/S8k
	9N+MAaBEl1bE3BmdhBQ5ai26z1m8ZQpdeT3hFKheF
X-Gm-Gg: Acq92OF2i6xwgMWC2AS+IY2liE3GI9+NE7XSFDftWuXdj0OGdYPHVsWJsJQMfk44GI5
	cdtaJ+BMXnFTFDE8Vgu9IZ+1Sknz9S4bY5H3NodXMsAHSE6JurhS8THWg3pMXb4g4G7Cd0dWswM
	Qk39FZ5exSmzTG3Zhj96ISXOq7Kn3cPcaCt5bfwAefR/WX5goNCR9tcArWT/1imWkBQPzmPtxuB
	ovsonsJlazCWPiHxQPsCMSApgLHbQBTXzlMoRiqTl4HWcZhdYuDclkc5avy0BfuW8EBb4Q0faAh
	0QzB13F8Sd20+6SSkg==
X-Received: by 2002:a17:907:782:b0:bba:5bc9:534a with SMTP id
 a640c23a62f3a-bcaac45410dmr950342666b.31.1778531304034; Mon, 11 May 2026
 13:28:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260509213803.968464-1-atomlin@atomlin.com> <20260509213803.968464-4-atomlin@atomlin.com>
In-Reply-To: <20260509213803.968464-4-atomlin@atomlin.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 11 May 2026 16:28:09 -0400
X-Gm-Features: AVHnY4IuuqYYRw63FqWoEIYPWMqlZqNzlszYso7NSfFe-A6xx0Cnf7u9P8UUKq4
Message-ID: <CAHC9VhQthq7y2akbQSdJwBEex1MQYWG49wcJK3b8gSQuQ_d1cQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] security: Expand task_setscheduler LSM hook to
 include CPU affinity mask
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: tsbogend@alpha.franken.de, jmorris@namei.org, serge@hallyn.com, 
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, stephen.smalley.work@gmail.com, 
	casey@schaufler-ca.com, longman@redhat.com, tj@kernel.org, hannes@cmpxchg.org, 
	mkoutny@suse.com, chenridong@huaweicloud.com, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	kprateek.nayak@amd.com, omosnace@redhat.com, kees@kernel.org, neelx@suse.com, 
	sean@ashe.io, chjohnst@gmail.com, steve@abita.co, mproche@gmail.com, 
	nick.lange@gmail.com, cgroups@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 9, 2026 at 5:38=E2=80=AFPM Aaron Tomlin <atomlin@atomlin.com> w=
rote:
>
> At present, the task_setscheduler LSM hook provides security modules
> with the opportunity to mediate changes to a task's scheduling policy.
> However, when invoked via sched_setaffinity(), the hook lacks
> visibility into the actual CPU affinity mask being requested.
> Consequently, BPF-based security modules are entirely blind to the
> target CPUs and cannot make granular access control decisions based on
> spatial isolation.
>
> In modern multi-tenant and real-time environments, CPU isolation is a
> critical boundary. The inability to audit or restrict specific CPU
> pinning requests limits the effectiveness of eBPF-driven security
> policies, particularly when attempting to shield isolated or
> cryptographic cores from unprivileged or compromised tasks.
>
> This patch expands the security_task_setscheduler() hook signature to
> include a pointer to the requested cpumask. Because this is a shared
> hook used for multiple scheduling attribute changes, call sites that do
> not modify CPU affinity are updated to safely pass NULL.
> To protect against unverified dereferences, the parameter is annotated
> with __nullable in the LSM hook definition, ensuring the BPF verifier
> mandates explicit NULL checks for attached eBPF programs.
>
> This change updates all in-tree security modules (SELinux and Smack) to
> accommodate the new parameter mechanically, whilst providing BPF LSMs
> with the necessary context to enforce strict affinity policies.
>
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
> ---
>  arch/mips/kernel/mips-mt-fpaff.c | 30 +++++++++++++++++-------------
>  fs/proc/base.c                   |  2 +-
>  include/linux/lsm_hook_defs.h    |  3 ++-
>  include/linux/security.h         | 11 +++++++----
>  kernel/cgroup/cpuset.c           |  4 ++--
>  kernel/sched/syscalls.c          |  4 ++--
>  security/commoncap.c             |  7 +++++--
>  security/security.c              | 11 ++++++-----
>  security/selinux/hooks.c         |  3 ++-
>  security/smack/smack_lsm.c       | 11 +++++++++--
>  10 files changed, 53 insertions(+), 33 deletions(-)

I haven't looked too closely at this patch yet, but based on a quick
glance, can you help me understand why it is included with the other
two patches in one patchset?  The other two patches look like stable
level kernel bug fixes, while this patch introduces functionality to
an existing LSM hook; one of these is not like the others :)

Unless there is something critical that I'm missing here, I would
suggest splitting this patch out from the other two bugfixes for
separate handling.  If there is a patch dependency issue you can
always mention that in the cover letter.

--=20
paul-moore.com
