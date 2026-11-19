Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795061637;
	b=myLjm0lyJPiz8A0gnT4ycJvwln7YO1ihLYxl+VksiL/ONvufqzakpwSCyQhJ3+AVVmZI
	 Ze78ZrRcdcYwrpduUcmqOcblc7FtEY5tuu57JDQmpcMgxsSTXF/o4XegCsUAxosufX+MM
	 5AYPwc4IAHhMTd0+ZFyITSz2MVw2gwhm9J2RfKKSq6sOGfDxLtJYvMAoyyvLXvGv5Gxkj
	 7fr3P7h+OO/I5fTvz7E4A/Ynw2j7Twc+k/f7ni09REzBrQMzv2QtQsoRDBCmVRa+zASGn
	 o4Wyyys8dSNttVDYBDct3xx3jYBLkzifS4yqgg+1Q1OfwAkN5ItpokkmE9bUloDLD9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795061637;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6xHQcePfPsfOtmHz0oWZJi5ErHHY5noBAB/h+hvuj6k=;
	b=oqAhJCbO+sLlP26UIbhRMjLRtBT7Rfwv9JsDKqeUK63/jNRlARS5XJQgFfjQ7HvOAB07
	 lt8d/SW4d/6eDsyvhTldFSQ/+4dBs7mpUJOKFzUBwjkYco0WT1TdFUB0jrH97bfSe1tud
	 k7SbhMM0oXjDWgyJCDuko9eTglk3yCldx+j/3xlm5INJQXxHhLyPEZ9L2NuPJFYK8yor7
	 IsSoLEkcMd6L9ZM/9rtVxVdo7Wi6RNHydqBEEMonssQEo+KKhTNt/ALqjx/0ECinLRW96
	 DTFLtxmhWUpTJIHLPpjAQXsG8/XNuwa6IfIQAALsibBdpzB4sC+wYWZIhQNZ/NOYRpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JzsBiHXM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E543B606A320;
	Thu, 19 Nov 2026 04:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JzsBiHXM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A931F000C4;
	Thu, 19 Nov 2026 04:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795061636;
	bh=6xHQcePfPsfOtmHz0oWZJi5ErHHY5noBAB/h+hvuj6k=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=JzsBiHXMvPdKVXHjvuoD5rtYtzoUW1FycEojubze8z+aqZJCOGyEqc723YACLnGmX
	 PrIvcPfoUAvFaRGlxypS/v1gaf7PQM81eRfNXuqfDR/ZhM7DCcrf3CQwX8HFcSAmr3
	 0BfDPCyOAYF9gKewzfXnYVxQnwscXokAR6nDOtRTs0ALK3k/P3GvrDtIpSsRSAStpt
	 DsSv1HwwcoBnNBXRSJOTMkegmOMMOGAXRM+tAXjvFRi0tqE3kVZtr/+Zd5q8ieN1hi
	 F0Wdw6q6s1yHVTB5yyAIgxr2Iy4HkP8DB+hRGmRKioOy7gXHUXerrJEug20W1QKH6m
	 O+s4HRjofT9wA==
Message-ID: <sashiko-outbox-222436@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/2] selftests/bpf: Verify task_setscheduler LSM hook
 parameters
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261119040705.684987-3-atomlin@atomlin.com>
References: <20261119040705.684987-1-atomlin@atomlin.com>
 <20261119040705.684987-3-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 04:13:55 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

> Extend the BPF LSM selftest to attach to the task_setscheduler hook and
> exercise scheduling policy updates via sched_setscheduler(), parameter
> updates via sched_setparam() and sched_setattr() with
> SCHED_FLAG_KEEP_POLICY, CPU affinity changes via sched_setaffinity(),
> and child timer slack updates via /proc/[pid]/timerslack_ns. Verify that
> the hook observes the expected sched_attr and cpumask arguments across
> each path, including the resolved scheduling policy and effective
> SCHED_FLAG_RESET_ON_FORK state for parameter-only updates as well as
> NULL pointers when an argument does not apply, and that returning -EPERM
> denies each operation.
>=20
> Also add verifier test cases confirming that dereferencing the nullable
> attr or in_mask parameters without an explicit NULL check is rejected by
> the BPF verifier.
>=20
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119040705.6849=
87-1-atomlin@atomlin.com?part=3D2

