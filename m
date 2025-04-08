Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B812B182B4;
	Tue,  8 Apr 2025 05:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744089754; cv=none; b=MRrTt/u86H2PSuYlpadVgEctk7JQFigllWyg3rMcpWRRCQa9mEOESD3Zq1UBTUgZB/otdAnI2jgInN0PFyTBn/WdjHyJ325wFzJJr4R/PXoLaUGF4DzGi5YBJB8JNDvbaA4x2OVrYIUVCxACdr4CfmXqV2CWZ2mHxMIKH9GuToc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744089754; c=relaxed/simple;
	bh=XiFwbhdjCAItYZz/lswqYrQrQDt6NvsYVox52mWgNzU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=qzFdXTDQ0lJ/ov1z+KvpsDEIlpxLUTVSHASGtUEEmYKjWebC4gZvprTOUcmGm9dSuTop4DH1m+xM3DU03iOR4JSz84PwzeRERYiGdcmFtufQfhuyCsnd05BnT2vG5yGffjmN0CmO3gjasdBJ5W3uo0Vzl1/Q1HtBSV1SAnW1FLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=RnDqdlxg; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="RnDqdlxg"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac25d2b2354so943245766b.1;
        Mon, 07 Apr 2025 22:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1744089751; x=1744694551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XiFwbhdjCAItYZz/lswqYrQrQDt6NvsYVox52mWgNzU=;
        b=RnDqdlxg1tmdoZmOtAN7LswaGyxQg6Gs+FCc+t4RaGz3WPM3qqJ7eBIEK4m0amSwH9
         B/h/mRoh/c3BR6UA/jN5J8945CDThOvaRQxX9Y0+L+l76rWK7ZBtvbNUQ0+vPW1kEfT5
         RpvJkT3bhtlTwpr0doxdUJXyALqVoi0fkj34OpbLnl22V/RqPYnURyF8KcaODRxUyXiB
         bgBMn8RFSQUp7vQxtvAuznsQ3CnbAEwGDDOGqlZtiR01ueisvS6gIzLnBYS+6vz1jz34
         1QAqkn74lAfZiMJjt/uc7QD7r05SqIiTIo+gvuygrXPN8EOnmk80/zAT5hMadeYi6xIs
         e6gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744089751; x=1744694551;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XiFwbhdjCAItYZz/lswqYrQrQDt6NvsYVox52mWgNzU=;
        b=qpQ4FnkLP166E0/RFyfNynxULMUzyRRh/oAlKvFLrwCf9TLQPyd4FYcK0aPgBRqr92
         z0xhquqCQ7NtekX2uEIKBsLO0DlodadSYmu3yDX+chg9ObFYl54TyEK7KHIs6dJbjk2U
         26ds1MJEmYDQOT2SPJ7Y5UMPoWUmzh+6yMoSOlnKCyarZW5QbeQcWrtOUtYwldpNAuCK
         9GZ/nh3u/cSgnHr9/r9LN3dnnnhOmJhZEhV6hVVLuxCBAD1dtUQ4e4xrBhAoMOzLgnFO
         BipbukaQ2AHNGRVunWCXLZL3X3/6kRHO9lkdMtinyU3eMBJKCLX+YYvlLmykrIawcopN
         G5Hw==
X-Forwarded-Encrypted: i=1; AJvYcCUJUDSCOEXD5nAM4PhAdQFo8QWRUutcX6nz6dO/FLvhgcYnwpbShy8Txi0HgvrFNHARzZKlu+1aWIvPMn9I1121zR23MjQ=@vger.kernel.org, AJvYcCWHSFW/OSEwjD90MXpRmZ0X8Amav0rjF1pTJDyc/GXt2AqcnzGyLxRN5vAdKS5IngadCHXPAN9asA==@vger.kernel.org, AJvYcCXAc9sXiT78C0M1DbYvP3/wAYWZ1s0N5MOf55/aCCcThFju2jj/nOUCxr3n7E1BMkXQtVw0g3Lz@vger.kernel.org
X-Gm-Message-State: AOJu0YzSDRpWxCmESxUWtGO+mVbmjJzcY34+9hEe4xaLwx2f5HNeJsRB
	ardQCMh6lgTswm0bh8dvs5AB/SS6ui3zfKsghp4jpG/v+8ah8HCk
X-Gm-Gg: ASbGncv7OgFhdP03ODmZSvqKN6Yw83f8klZ+RYpvMg7UyHiV85qvXm6EQWgb5ahWs8g
	5yZKfFSvfxS7e137Z2sdamyLbVNFmk7FhdW/m9Q4Qt6Mo5s5VZI75ZvOfhxu1+/3n6s+RRJRwdB
	4bpjQMIEIIpxVMXhUL7XB52u1uuGPByxIgOP/AKcicl2ef3V64vhJaK6xxnIf+eHDtK+g0sYvq9
	43NRm8bm2jjefHNVBUY80MxJO85DdpYQ5cWtIIUtbQA0FKw826aItpZa8EpyjYlzKzVBgavGPvB
	LuTtDqv6m/f/48PCM3dDFVkDCPsnEI1gYq5M4j4VQ7kUu2s=
X-Google-Smtp-Source: AGHT+IGSvNtmq0eLJB5hn8SJfZZ9eU1CTjmP9vPX0rD0YREBhckQesrZzTdCeWLZV4/nD51yGMs3TA==
X-Received: by 2002:a17:907:d8c:b0:ac7:b366:c331 with SMTP id a640c23a62f3a-ac7d6e951e8mr1337386166b.53.1744089750537;
        Mon, 07 Apr 2025 22:22:30 -0700 (PDT)
Received: from [127.0.0.1] ([90.187.240.197])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac807a5b212sm281185566b.56.2025.04.07.22.22.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Apr 2025 22:22:30 -0700 (PDT)
Date: Tue, 8 Apr 2025 07:22:27 +0200 (GMT+02:00)
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, selinux@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Casey Schaufler <casey@schaufler-ca.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Message-ID: <cd8c8f91-336d-4dd2-b997-4f7581202e64@googlemail.com>
In-Reply-To: <CAHC9VhQCS-TfSL4cMfBu2GszHS8DVE05Z6FH-zPXV=EiH4ZHdg@mail.gmail.com>
References: <20250407231823.95927-1-kuniyu@amazon.com> <20250407231823.95927-3-kuniyu@amazon.com> <CAHC9VhQCS-TfSL4cMfBu2GszHS8DVE05Z6FH-zPXV=EiH4ZHdg@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 2/4] net: Retire DCCP.
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <cd8c8f91-336d-4dd2-b997-4f7581202e64@googlemail.com>

Apr 8, 2025 03:35:15 Paul Moore <paul@paul-moore.com>:

> On Mon, Apr 7, 2025 at 7:19=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>>
>> DCCP was orphaned in 2021 by commit 054c4610bd05 ("MAINTAINERS: dccp:
>> move Gerrit Renker to CREDITS"), which noted that the last maintainer
>> had been inactive for five years.
>>
>> In recent years, it has become a playground for syzbot, and most changes
>> to DCCP have been odd bug fixes triggered by syzbot.=C2=A0 Apart from th=
at,
>> the only changes have been driven by treewide or networking API updates
>> or adjustments related to TCP.
>>
>> Thus, in 2023, we announced we would remove DCCP in 2025 via commit
>> b144fcaf46d4 ("dccp: Print deprecation notice.").
>>
>> Since then, only one individual has contacted the netdev mailing list. [=
0]
>>
>> There is ongoing research for Multipath DCCP.=C2=A0 The repository is ho=
sted
>> on GitHub [1], and development is not taking place through the upstream
>> community.=C2=A0 While the repository is published under the GPLv2 licen=
se,
>> the scheduling part remains proprietary, with a LICENSE file [2] stating=
:
>>
>> =C2=A0 "This is not Open Source software."
>>
>> The researcher mentioned a plan to address the licensing issue, upstream
>> the patches, and step up as a maintainer, but there has been no further
>> communication since then.
>>
>> Maintaining DCCP for a decade without any real users has become a burden=
.
>>
>> Therefore, it's time to remove it.
>>
>> Removing DCCP will also provide significant benefits to TCP.=C2=A0 It al=
lows
>> us to freely reorganize the layout of struct inet_connection_sock, which
>> is currently shared with DCCP, and optimize it to reduce the number of
>> cachelines accessed in the TCP fast path.
>>
>> Note that we leave uAPI headers alone for userspace programs.
>>
>> Link: https://lore.kernel.org/netdev/20230710182253.81446-1-kuniyu@amazo=
n.com/T/#u #[0]
>> Link: https://github.com/telekom/mp-dccp #[1]
>> Link: https://github.com/telekom/mp-dccp/blob/mpdccp_v03_k5.10/net/dccp/=
non_gpl_scheduler/LICENSE #[2]
>> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
>
> Adding the LSM and SELinux lists for obvious reasons, as well as Casey
> directly since he maintains Smack and I don't see him on the To/CC
> line.
>
> For those that weren't on the original posting, the lore link is below:
> https://lore.kernel.org/all/20250407231823.95927-1-kuniyu@amazon.com
>
>> diff --git a/security/selinux/include/classmap.h b/security/selinux/incl=
ude/classmap.h
>> index 04a9b480885e..5665aa5e7853 100644
>> --- a/security/selinux/include/classmap.h
>> +++ b/security/selinux/include/classmap.h
>> @@ -127,8 +127,6 @@ const struct security_class_mapping secclass_map[] =
=3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { "key",
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { "view", "read",=
 "write", "search", "link", "setattr", "create",
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NULL =
} },
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { "dccp_socket",
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { COMMON_SOCK_PERMS, "=
node_bind", "name_connect", NULL } },
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { "memprotect", { "mmap_zero"=
, NULL } },
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { "peer", { "recv", NULL } },
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { "capability2", { COMMON_CAP=
2_PERMS, NULL } },
>
> A quick question for the rest of the SELinux folks: the DCCP code is
> going away, so we won't be performing any of the access checks listed
> above, and there will be no way to get a "dccp_socket" object, but do
> we want to preserve the class/perms simply to quiet the warning when
> loading existing policies?

Isn't the kernel just warning about missing clssses/permissions? If policie=
s still define dccp_socket I think the kernel treats it as user space class=
, like dbus.

> Personally I'm not too bothered by those warnings, I see them fairly
> regularly for a few classes/perms on my test systems, but thought it
> was worth having a quick discussion on this one since it is a bit
> different.
>
> --
> paul-moore.com

