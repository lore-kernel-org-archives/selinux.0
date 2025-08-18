Received: from markus.defensec.nl (markus.defensec.nl [45.80.168.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C813230F54C
	for <selinux@vger.kernel.org>; Mon, 18 Aug 2025 09:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.80.168.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755511082; cv=none; b=b+Pu9jmy3eJyHZRGO9kAUUoQIQGbjNUxCawUXLykoHcYwMfoyH+W+bM87YvruLcxTSHYmO/D/TSjkJeVsPSEd8QMuxqa9bQ0UteKmagn7eBWGY2l1S4c3VLsglMZ6rXUxTfKev1K0lv72iRJNNYqly80b0C+2cIEPNHIdCYFYpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755511082; c=relaxed/simple;
	bh=5GGMt3shzw2rI49biQAOQCU7/kOfGFLIUky9EGQY5bw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nhcoGZYcPuveUHxhMga+O3nS9UGli0ioDH92QgOd+6XgWH03NpN39C4ILNwzRgzZsLoqqQf8N0xLImI0HcEDNJCkdNy8sBLlI+zbJujyzwRgm92Q0KyFq8xOrWUnxVbLA1yUWK7kl9ME42u/2xTssNvre3G+gueCtuQf3/nb8Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=defensec.nl; spf=pass smtp.mailfrom=defensec.nl; dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b=IoWC2zGK; arc=none smtp.client-ip=45.80.168.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=defensec.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=defensec.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="IoWC2zGK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=defensec.nl;
	s=default; t=1755510798;
	bh=5GGMt3shzw2rI49biQAOQCU7/kOfGFLIUky9EGQY5bw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=IoWC2zGKB6XjpUtkTUB2r0O2t5kk9G9zJkEX/1Ncgg7z6+I/35isr1u413uosS+M1
	 DPOEb5zNK36tH9kbwpGOtVli3UCo6UXdBKuJbGwQ+n8qrxZ5Xiljq/qDqOPhcfLQSQ
	 fv6PQkBDDA9u/mr3oAiiiHGeLApLViKojAlZdurQ=
Received: from nimbus (nimbus.lan [IPv6:2a10:3781:2099::514])
	by markus.defensec.nl (Postfix) with ESMTPSA id 9F3901BB07D;
	Mon, 18 Aug 2025 11:53:18 +0200 (CEST)
From: Dominick Grift <dominick.grift@defensec.nl>
To: BOBx <kabc005009@163.com>
Cc: selinux@vger.kernel.org
Subject: Re: [Help] how to compile te with checkpolicy.
In-Reply-To: <8925af9c-2977-4acf-9b48-7f6ce3b280ec@163.com> (BOBx's message of
	"Mon, 18 Aug 2025 16:01:04 +0800")
References: <8925af9c-2977-4acf-9b48-7f6ce3b280ec@163.com>
Date: Mon, 18 Aug 2025 11:53:18 +0200
Message-ID: <87ikilyn01.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

BOBx <kabc005009@163.com> writes:

> Hi all,
>
> These days I tried to compile te with tools named checkpolicy. I have
> searched the process with google and chatgpt, and I followed the steps
> they told me but I failed.

Hi,

checkpolicy is for monolithic policy. see below for modular policy:

>
> The following is my te file,=C2=A0 cmd and response and other infomation.
>
> My te file(my_policy.te):
> ----------------------------------------------

This is modular policy that should be compiled with checkmodule and then
packaged with semodule_package:

checkmodule -M -m my_policy.te -o my_policy.mod
semodule_package -o my_policy.pp -m my_policy.mod
semodule -i my_policy.pp

for more information see:

man checkpolicy
man checkmodule
man semodule_package
man semodule

> policy_module(my_mypolicy, 1.0)
>
> # Define types
> type my_type_t;
> type my_type_exec_t, file_type;
>
> # Allow rules
> allow my_type_t my_type_exec_t:file execute;
> ----------------------------------------------
>
> The command:
> ----------------------------------------------
> sudo checkpolicy -M -o my_policy.pp my_policy.te
> ----------------------------------------------
>
> The response=C2=A0 from command:
> ----------------------------------------------
> my_policy.te:1:ERROR 'syntax error' at token 'policy_module' on line 1:
>
>
> checkpolicy:=C2=A0 error(s) encountered while parsing configuration
> ----------------------------------------------
>
> OS information: 6.11.0-29-generic, ubuntu 24.10.
>
> Would you like help me to compile te with checkpolicy please? Or which
> URL should I read please?
>
> Best regards
>
> BOBx
>
>
>

--=20
gpg --locate-keys dominick.grift@defensec.nl (wkd)
Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
Dominick Grift
Mastodon: @kcinimod@defensec.nl
