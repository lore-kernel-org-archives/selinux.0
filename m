Received: from markus.defensec.nl (markus.defensec.nl [45.80.168.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA8F23183F
	for <selinux@vger.kernel.org>; Mon, 18 Aug 2025 09:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.80.168.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755511055; cv=none; b=FcyS0FtHc1fIgcWLKeV/F5aBccixu+I81nIzk83GexwrAAiSKQ5K8FlseT5Og93/fTfRVYOCKPGTTl6IjZ8vdp3Q8iIrlJy8Hi9IVWdJ9X6xind/VWC90BdPfZbbZmpxKdN95Vy2gnO4fgOaTk9V66x0w3Qz2b3SiI+yh7gGiS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755511055; c=relaxed/simple;
	bh=3qPu0FQtXH4ewNKVZwCmalw5FOscLiBVTkyWliP35jM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KZ6qybg15Oh4c3XymKGrVXBRwuo8DHRwlnaY2BPP7Ylay18rE6v727/i+hUaw24W+VRNVAwtfp7Z2KAk1TLT09z6RGleLjT8P5d6SzpmbCjyajmbX6bqeAo/04775Y9iRQF1eUePIAQbdltj2c3rjSGEbDHWBkr7AVzw84tNgJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=defensec.nl; spf=pass smtp.mailfrom=defensec.nl; dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b=E5iYcd/b; arc=none smtp.client-ip=45.80.168.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=defensec.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=defensec.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="E5iYcd/b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=defensec.nl;
	s=default; t=1755511051;
	bh=3qPu0FQtXH4ewNKVZwCmalw5FOscLiBVTkyWliP35jM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=E5iYcd/boiS7DK+plN36FpdmPFjmStcBO+5/9bglOAvcyLZho4Bn7awGShzna9qor
	 cTCos199Unq6FlDVOlMogZyscAKf5n42ERgnOLi38Ws+DpmV8fScJTAgOEkulzJPre
	 EX151qA/qm+OElnO1RJA+34aiwJzlAFRBOhl4wNc=
Received: from nimbus (nimbus.lan [IPv6:2a10:3781:2099::514])
	by markus.defensec.nl (Postfix) with ESMTPSA id 6F9081BB07F;
	Mon, 18 Aug 2025 11:57:31 +0200 (CEST)
From: Dominick Grift <dominick.grift@defensec.nl>
To: BOBx <kabc005009@163.com>
Cc: selinux@vger.kernel.org
Subject: Re: [Help] how to compile te with checkpolicy.
In-Reply-To: <87ikilyn01.fsf@defensec.nl> (Dominick Grift's message of "Mon,
	18 Aug 2025 11:53:18 +0200")
References: <8925af9c-2977-4acf-9b48-7f6ce3b280ec@163.com>
	<87ikilyn01.fsf@defensec.nl>
Date: Mon, 18 Aug 2025 11:57:31 +0200
Message-ID: <87ect9ymt0.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dominick Grift <dominick.grift@defensec.nl> writes:

> BOBx <kabc005009@163.com> writes:
>
>> Hi all,
>>
>> These days I tried to compile te with tools named checkpolicy. I have
>> searched the process with google and chatgpt, and I followed the steps
>> they told me but I failed.
>
> Hi,
>
> checkpolicy is for monolithic policy. see below for modular policy:
>
>>
>> The following is my te file,=C2=A0 cmd and response and other infomation.
>>
>> My te file(my_policy.te):
>> ----------------------------------------------
>
> This is modular policy that should be compiled with checkmodule and then
> packaged with semodule_package:

Oops.
Actually I am wrong. This is reference policy.
I should be compiled with the reference policy makefile. I am not sure
what package provides this Makefile in ubuntu but probably package
selinux-policy-dev:

https://packages.ubuntu.com/questing/all/selinux-policy-dev/filelist

/usr/share/selinux/devel/Makefile

So this should work:

make -f /usr/share/selinux/devel/Makefile my_policy.pp

>
> checkmodule -M -m my_policy.te -o my_policy.mod
> semodule_package -o my_policy.pp -m my_policy.mod
> semodule -i my_policy.pp
>
> for more information see:
>
> man checkpolicy
> man checkmodule
> man semodule_package
> man semodule
>
>> policy_module(my_mypolicy, 1.0)
>>
>> # Define types
>> type my_type_t;
>> type my_type_exec_t, file_type;
>>
>> # Allow rules
>> allow my_type_t my_type_exec_t:file execute;
>> ----------------------------------------------
>>
>> The command:
>> ----------------------------------------------
>> sudo checkpolicy -M -o my_policy.pp my_policy.te
>> ----------------------------------------------
>>
>> The response=C2=A0 from command:
>> ----------------------------------------------
>> my_policy.te:1:ERROR 'syntax error' at token 'policy_module' on line 1:
>>
>>
>> checkpolicy:=C2=A0 error(s) encountered while parsing configuration
>> ----------------------------------------------
>>
>> OS information: 6.11.0-29-generic, ubuntu 24.10.
>>
>> Would you like help me to compile te with checkpolicy please? Or which
>> URL should I read please?
>>
>> Best regards
>>
>> BOBx
>>
>>
>>

--=20
gpg --locate-keys dominick.grift@defensec.nl (wkd)
Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
Dominick Grift
Mastodon: @kcinimod@defensec.nl
