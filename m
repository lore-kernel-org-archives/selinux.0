Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB88D36493F
	for <selinux@vger.kernel.org>; Mon, 17 Aug 2026 19:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786994223; cv=pass; b=bjeVULmNF8f6aFh/5sFOMj8Ak0IbfdJdRPevfI6Vbdcsudv2My+ZTySwMX1DcSiCuxtkbETithZ3EsbP945jDDtuAMkGxumQvyRPRxp5lnlHiHG2d7ohOKS20x+p1nHj8+K1xISWhLlRtZ6A8UD4RGeAMwt2kKgPtSLfBJxe9ko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786994223; c=relaxed/simple;
	bh=ctksfvN1qSWXktO3Fse/p+dn8jnarefwBHmuiO10eDg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=n8FNdpjVabf08GwKOypw63fRIIu6jPZqoL2h2bLZIUj10VJvZBwp8wnDB0S0k4czM4iow2gYIn78UBTL0gpWnJCkyNRZnz1hP2CuqbXj53fE7uh5nBpPndenYkrxERfJ/OtGU0VA6nkUiXuJGEv/T1yALt94bAsQcOY668VtTtw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jCmpuueg; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCmpuueg"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-836c718715fso45044917b3.0
        for <selinux@vger.kernel.org>; Mon, 17 Aug 2026 12:17:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786994221; cv=none;
        d=google.com; s=arc-20260327;
        b=sp2gnSupCtcSMQkNqIiPHLdq2ITvyz5XwgV5OUK/L1zp6REK9CLa/oZLNBpNKqK9bp
         w8Dqg5SLc/3dH1uDX3T/saBwZ7kqJhp4VQrWNHV4iGDkgvwnMPgm0WwYuOB7hqeWxP64
         aMnnCkynowB27cAkoQLllpakb4wgZgFgqrbF0PynDuY+d6NQcxMXbHbDlYDRirEDKhMz
         84syfL1H9wo2Q2cUOFFrLP/ALtFL9Zc56t1gjdRaZTE4VDIZhmnnmX9J6x3q9XiGzzpo
         tEsowlRL2dlnVHq29qO8oC9UU47yh5G4sKCWlXHuF7aRLOftJN5knSvlAthtMz43FbCt
         12Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=ctksfvN1qSWXktO3Fse/p+dn8jnarefwBHmuiO10eDg=;
        fh=l2l+BKIhep14i9a5yxIzwDvgNRHYkyJlbYDDp8LiW6o=;
        b=SXjuBybD17f56oJJkJyzVWZj9tsgBvxdGbsrRYYOhECxfOO1Mhu6ss5jWPQMfbSWfw
         d1zW3zrsi3p3954IwkZEdgb3sNnOC4sJMaV3sibfuWw2aDEnlLyJszWyVa8/ozhLC4qg
         2Xk76upmleMirxlYEMEvI5oeA62xZWZq5Yi5T1caYkPTLIZ87bYNHgp9EFmCQK5KKKEK
         icV5h8IrlgA/Fqe+9GygpwAe3gqBD5iRK93HAO7UjPnMfX0yeDzp46AWLYy/8G8JQueV
         S55YwP+RcFVcl/UX4JsIBUk0c/tYQEsykNj9HqxUeJO6Czm2ZdW3VSIOv+s52FAKk00j
         sxvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786994221; x=1787599021; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ctksfvN1qSWXktO3Fse/p+dn8jnarefwBHmuiO10eDg=;
        b=jCmpuueg1Kn149eSV/bQmklZlO1ESDdCqBonZ/KhPPcfFc2j2SM97eCceLXJKyT1UH
         iPFPu6CTkJEepGrnA2H98xKkxcyUFvMZlWsQ5npoW5956w/yp5by4XGpPQV3iJ/TM1um
         ppXVNzef8LeSJVZ8TU5oFLRGMWnHrYZRKQKrcYbUfttqJy4nQvePgTS3rzKPVfGAUwci
         5bDKwV6AcMK+n4ij6sV6AVVtS3DkzXFfYANr88As+R+yTijqZGuoCIPJPcRZxIYLvkpW
         EDrTA+UtJ1etNlO+SjEQIyAK+2M5uDtW7SPsCxNSLsa6C21zkeqtoIWlBv2oycDgAAHN
         kfFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786994221; x=1787599021;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ctksfvN1qSWXktO3Fse/p+dn8jnarefwBHmuiO10eDg=;
        b=mLhoHnzofkqYOGFqdb0pxX+0ZehcTv7isFYCGhRwRM8jrOAMFLG4wA8oCb1lBo8XGf
         L+CYzsaphmRN8z2ABWwK96ni3aLSbxYKbI515ViKdW9d8XHVzxXvk5vT3HYYEy7G4unY
         qRsJOUvaTiNaxMgy0uWiKMXOQbhkTVkEKUnWQoV5bGLZfuxAWU4xj95AM5B4LQ8TVhF6
         Ik8xwchvTQ5Rvo72f495fi4s+fqiJ7dH7cJKgNQMYE/sxp5Caa8Y4CWNUQV6BCwbM5ZY
         GyTdRxbK/xAyi9sh2JAH7DaNhDDMfjVNw5f2SE9YoctmBs3a17TVwdzoVees4KTLMehA
         oQNw==
X-Gm-Message-State: AOJu0YxFHZ2JCf681wXmKQ3w4wrr88CrQ4hccPnkb5F7j7tQz/NsU/gg
	8SHzAD2mDdm6C9S5JytsWXU6WJITfLtVSaSDh4JoPliU83QK+AQmOO/FAvbLOtrGC+m2+EWL6mt
	LI4ptKF4Fw2lEuwbyf9B+jeqmK2AwxPVWmgs=
X-Gm-Gg: AR+sD11BMYmDlY2g0OG1iU0JFDqma1arzqNpHWMBSGh/wUSs7dxZmgl8HrkANKI7Kj3
	TgYEK8VyiRIYdgHQBVnJY/Dp9Svf/H7PkYLpJrAMqvGkKs3yrgtIftt3W2UdUaB0N5oD7ZodI/s
	1sWJ1rVi9jVktxqtuWnq8aRgaAAMXO5EI47AXmDqAK06UH1TRR5K3ppB6J0SnLpbCKc6pRXhdAv
	vwrkkN4UKvlsQ4QMF0jKKaitVjZmwsF3MGO93EXMRyHnPLCQ+QQbfj+O4YFLfbhkgfSUxkH/aty
	qGgRimOr3pcaqvXcPLvF5c72oil+paFAZshyqcenNiVQEpmByhCurjHRZkBFV+tu27MffcDh4k0
	kw/U3GALfJw==
X-Received: by 2002:a05:690c:d1b:b0:814:4755:2b2b with SMTP id
 00721157ae682-8370ce2c33dmr98173847b3.3.1786994220697; Mon, 17 Aug 2026
 12:17:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: rushikesh ghatpande <rushikesh.ghatpande@gmail.com>
Date: Mon, 17 Aug 2026 12:16:49 -0700
X-Gm-Features: AcwNN1VfsZc7LO9S_RGDyNYvocVJ6FLXJlEw15LLsPLcDfeUzTOLpe88BD2La5U
Message-ID: <CAG94myvwFz_f2K8SLsfFv1xKDkdm_t6z0s75BLcE5Dn7OV2LBw@mail.gmail.com>
Subject: [RFC/Discussion] eBPF-based runtime permission auditing tool for
 SELinux policies
To: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi all,

I've been working on a small tool that uses eBPF to observe SELinux
AVC decisions at runtime and flag unused permissions within existing
allow rules. The idea is to help identify over-permissive policy that
audit2allow-style workflows tend to leave behind, since they only ever
add permissions and rarely surface which granted permissions are
actually exercised.

Repo:
https://github.com/rushigerrard8/selinux-policy-auditor

Briefly, how it works:

- Hooks into the LSM layer via eBPF (BCC) to observe AVC checks for a
given context, without modifying the running policy (no auditallow
needed)
- Aggregates observed permission usage over a monitoring window
against the policy's existing allow rules
- Reports the unused subset per rule, e.g. an app granted { read write
append create unlink open } on a file class where only { read open }
were ever exercised

I built this mainly to solve a problem I kept hitting in my own work
on distributed systems/networking (permission creep in service
policies over time), and it's been useful enough that I wanted to
bring it to this list for feedback, rather than just leave it as a
personal tool.

A few things I'd appreciate input on:

1. Whether this overlaps with existing tooling I'm not aware of (I
know setroubleshoot/audit2why cover related but not identical ground)
2. Whether there's interest in something like this living closer to
the userspace toolchain, or if it's better as a standalone project
3. Any gaps in my approach. I'm relying on kernel-level PID filtering
to keep overhead low, but I haven't stress-tested it against
high-throughput services yet

Thanks & regards,
Rushikesh Ghatpande
