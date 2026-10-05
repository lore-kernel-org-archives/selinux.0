Received: from mail-yx2-f39.google.com (mail-yx2-f39.google.com [74.125.224.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7694A4839
	for <selinux@vger.kernel.org>; Mon,  5 Oct 2026 14:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791211332; cv=pass; b=BVDnDchLS5R+H0twVg4EPrE/zFW3J3TgR71qbs2eX5Y0HQFVAQnBJfFEsPca1FtyRuBbu7a+3ar8gLe00a6ZSzugwz7v0I7b98uy5DxKshWVrDi2RV6tP1T0KqG/7v2TGLZhapP6vkO4q9s+r1ICEguQz5QKHF0QcoECNQxL1IQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791211332; c=relaxed/simple;
	bh=zh4rd+EA8ZAJPDE0M5fiLZP32NOx5uRjooDyK4NVgms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mKzvjuM+aumQOC1pstvWteuiLOeOqis5Xgol0Qwg+CwnLXQHL/NvhfeWC06CpT0iz1CT9TfPfybMZF3cVhS18o2Phtv8EM9s7oIoeFtVOoc2P39DhiSId42NIUwkedG605qj+WBcEnl6iYVvdt13XwkuaxcxzQqz4b3+zLM+uH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tM8MoflZ; arc=pass smtp.client-ip=74.125.224.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tM8MoflZ"
Received: by mail-yx2-f39.google.com with SMTP id 956f58d0204a3-6755aad8a98so922323d50.1
        for <selinux@vger.kernel.org>; Mon, 05 Oct 2026 07:41:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791211312; cv=none;
        d=google.com; s=arc-20260327;
        b=d7lZO9nZ+wTz713+2PeoW8iRVuG8tAMIQuwv9jtDMxNzDCwOcZCe3x2MB/n31x75O/
         PKcYMtEzteSA9y+nYA+d9bVE6p3DuN7/4qznqEr9a1ikhLbrdLGtQeXTKoCjBWmNYfBo
         s0X6mHhFWU/wvsTwddfaYxVLojf/+9T8rkqRVyaDrUKqWTa+0m3iJw07+m7CsQ3+6D2H
         GCEW4+xLQzb5IoNZ+Qd0G817Sq1ElmRpb5zbfr+STafjhvCB3Cxh+MrgIUgkbqWmvT2Q
         d/0054VIm5ujPT8bpmN+WTWwPDS/oTPUAexA+4+zQhrXuB+clckLv8MhkUhpZzm5OiM+
         ptuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9WZyq3SJEXr+2Jl5iE76y6KWO0wbgmKoBwYU+jo7Wyc=;
        fh=0aauTkkY9gdUQEDRq122+k97CIOHX8c9tFrxWuWhTo8=;
        b=OxwNpbpgwOqgbt0jNnB11aBbAHMo7MaPKGBDIrHW5WvppdNMcsdV0tT9qJTGSgh5uN
         AzJvIzNpVvjD2voBFPz9GO6GvgmQZfpXqsF963dM03RKe4JSWhkyxGFVcQqyntRcE4o1
         Uh3PL6hW6CXhiq+ojnXhWpvluaIb/2E5f5LeDzVZu24mJrMFcThsv4PlGUdVZOpr0kwM
         Uk16N+L72O8vspSi6CTmS1uvrkmbP1fJD87xpEkxiENDMsEf9Uav41LBJ+GE49L2SQLo
         aHqns+DuBqWDrnaxnpR0sd/bgbuCaQyVB7qD8RGt/7Mm4OAGQX/Aqbv4dvzt3SKkXVXJ
         WklA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791211312; x=1791816112; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9WZyq3SJEXr+2Jl5iE76y6KWO0wbgmKoBwYU+jo7Wyc=;
        b=tM8MoflZB1KVoy2IT2sjbVod1zF+LjLiQc0NQkepawGw2QEwKvp+qQcDv8o7Nt92ol
         TojgGvQIUEhE96o8VnzZEECXzpl1haoHihbyEqPZtyfokS/mZW02ZU4lR4aMacmJ4RRx
         zOkvwdLB19G+6zVOudD53XcGYtR3T0A6aWnrUf+BwuKcpXYS5fumbFMXoGSPyekx3v0C
         VuSeVuXWkb9DQ7ldRcnLCTzHhM8oXR1HL0qxlRTbxYpTXQC5sliX9SXVjJqgbKGRyy3p
         3e9buUCYQ+cv58lXQ8AgVZROc4vYMpMiyP+Xbu8XUrEFwvRFm9/MoECPivKXlr2Ek7YZ
         rJmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791211312; x=1791816112;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9WZyq3SJEXr+2Jl5iE76y6KWO0wbgmKoBwYU+jo7Wyc=;
        b=d49aWL9MEY1Uhdtl79zloSJDuUWuYWAy+ffqm9qWvvYe3zP8GbTbkronm/6gqCnX35
         NmE2hviFLchaGtBAYYf9GO9d5594gnmArqaDZZ6daMmZLe2woC+OLs3LwFslPjmyhWLL
         vSXBrOqh11sQ0HCGtOPl1s1lZ3snWrR/t3MULagP23QrScfvAAGcSvPAETq43DiRrF0B
         AP/tA1D8pqIJJaUrcbb4R01EyV6f/zhAro90O4yLxDjeYvRCCQwVPo9AY88A8KOQakhF
         pWKrBPu6NA3S+9mxKbvwU8BUl6O3wH1flg6i4bqrlhtu9Li8WoZxaMGcoZeEd2u08bU8
         ijgA==
X-Forwarded-Encrypted: i=1; AKwUvBwl+9nPWCyWHvYtL+OgKpf++VO8subjYvrPXCH2jAtrcKHURiou3rDn0itKIikwqttsyg/X3KJE@vger.kernel.org
X-Gm-Message-State: AFq9FYIcC2ch942ewpqAMZJ0Fr+atp5HxoV6oG2fGUqCi/w40rDZjID8
	ihRI40btce+RX1O30hEfdUzS93V1f/nwUbdb3Ah+WDSGQNjgeG8wyg+3Ooh0DB3x7jRTdd+Oi2i
	QzqDMAaMEncqy3mGab17KmMQvo2nIsoxqXI1l
X-Gm-Gg: AYBFou1PY0EI7nUgH3MRt4bD4R2hYdZ/MFc9nCkfWXY9/iLnwUIy96JiQacmM7Bnqj2
	oB4iKOXK8iURi92MqdYPsg+77M6XXDs17AaPqLuciAfKMwzWtDnIHCImL2IQuLbt/wsZqMJSSQN
	+YzIWuD3DowtnxSv/C8b/UNOyqdMb7/xZ2xZ5JreaPnSc54ZF4zGgDR+vciN+X+fRBHFreAaw6m
	21cMPdGu5ge9AIlcTwmnw5gVfMJIWBhS0HvnDt05rKL2o3Id0z3wBMIfHSUIaxnl6QE3nlMto7c
	wlUXwPYyAO3FLFuxiIXyiAbBB1zCdgLARD0JEQOdbkY/8/pt9kC4treK
X-Received: by 2002:a05:690e:11cc:b0:671:70d1:d6d6 with SMTP id
 956f58d0204a3-677ac14a747mr4062711d50.72.1791211312012; Mon, 05 Oct 2026
 07:41:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ6Ria-P6quOcjwkGSGdEyFRVCiJ0b+mwsd=LXGR5oW-Cg@mail.gmail.com>
 <20261005133120.2552484-1-bgrech@redhat.com>
In-Reply-To: <20261005133120.2552484-1-bgrech@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 5 Oct 2026 10:41:40 -0400
X-Gm-Features: AclHuK89273wnaIyE8XrHG6M2WfmfBsybIhWMETRF2a1ROp74MDnXYSuGWjELZw
Message-ID: <CAEjxPJ4KY+E58gPPqvaKW_cBY=j3OAq+XU4BU=SYD+MUAoCyog@mail.gmail.com>
Subject: Re: [PATCH] tests: make IPv6 subtests optional on IPv4-only systems
To: Brian Grech <bgrech@redhat.com>
Cc: jonderka@redhat.com, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2026 at 9:31=E2=80=AFAM Brian Grech <bgrech@redhat.com> wrot=
e:
>
> Skip or adapt IPv6-dependent subtests (inet_socket, extended_socket_class=
,
> sctp) when the system has no usable IPv6 on loopback, instead of
> assuming ::1 and ip6tables always work.
>
> - Add tests/has_ipv6, checking /proc/net/if_inet6 and disable_ipv6
>   sysctls.
> - Gate IPv6-only cases behind $test_ipv6 and adjust test counts.
> - inet_socket/server.c falls back to AF_INET when IPv6 is absent.
> - Split IPv6 firewall rules into nftables-ipv6.load, invoked only when
>   has_ipv6 succeeds.
> - Select address family via has_ipv6 before entering confined test
>   domains, rather than probing IPv6 from inside them: that probe can
>   itself be denied by policy, silently selecting IPv4 while the runner
>   keeps executing IPv6-only cases.
>
> Co-developed-by: Jan Onderka <jonderka@redhat.com>
> Signed-off-by: Jan Onderka <jonderka@redhat.com>
> Signed-off-by: Brian Grech <bgrech@redhat.com>
> ---

For future reference, normally one would add a "v2" (or "v3", "v4",
...) to the subject line and put a short changelog after the "---"
before the diffstat describing what changed from the previous version.
No need to re-spin this one though.

Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
