Received: from markus.defensec.nl (markus.defensec.nl [45.80.168.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377AF215F7D
	for <selinux@vger.kernel.org>; Mon, 18 Aug 2025 10:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.80.168.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755513787; cv=none; b=NAYBJ31Mw++8wbTUUasfiFeDhUSWb2d50qmty6+3caI8vGL1B2+c+DEwOqL8hzmpiQ77xviznfvI0hjTdgzUJbEPPtbEgDWSx/9N5+C5LeQ8Hyk9aG5JfztAliuAhEOjg79absYgv1jZxsTAsfEjeSLNQC5nf9f0p3DcVcnVF/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755513787; c=relaxed/simple;
	bh=FUF9IzW33zEhNJ51XBE7WVNbrDsBRH972hmAicDFW2o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AbZRVkeHcjzNMZSTyGIQeQWuyiT2bA6Ki7as6xnGSa1douMj3di447WWX9g3nD2MgLaI07CGVsaVE7pCLuamnrFRw2daDMECQJBDwCW1FN5SK7lMvKxsa1T8NEcoqEOWzrLDBvjMcOIxibheRyO+HV9Jrb6a0mursvOwf+n/ORo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=defensec.nl; spf=pass smtp.mailfrom=defensec.nl; dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b=BQN/LTCP; arc=none smtp.client-ip=45.80.168.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=defensec.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=defensec.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="BQN/LTCP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=defensec.nl;
	s=default; t=1755513784;
	bh=FUF9IzW33zEhNJ51XBE7WVNbrDsBRH972hmAicDFW2o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=BQN/LTCPTgKEAgQdKZdsjWqFO0Ftzh2O6bKMCHFH7Y/VoXeNg3B9y8LirwfAwSd97
	 k8w0J+NqfSCkhWUDfulWvPwJWsLmCW0dYky9GyZaO3QLg9n3MrWeFGGW0/HdD58mjK
	 L+mugOGRIGot3xVXxXABTxMGNa8QYLght08Z4Qns=
Received: from nimbus (nimbus.lan [IPv6:2a10:3781:2099::514])
	by markus.defensec.nl (Postfix) with ESMTPSA id 518FF1BB085;
	Mon, 18 Aug 2025 12:43:04 +0200 (CEST)
From: Dominick Grift <dominick.grift@defensec.nl>
To: Fei Shao <kabc005009@163.com>
Cc: selinux@vger.kernel.org
Subject: Re: [Help] how to compile te with checkpolicy.
In-Reply-To: <fc5583ce-8b27-4818-ae05-96e6332dd6a0@163.com> (Fei Shao's
	message of "Mon, 18 Aug 2025 18:20:32 +0800")
References: <8925af9c-2977-4acf-9b48-7f6ce3b280ec@163.com>
	<87ikilyn01.fsf@defensec.nl> <87ect9ymt0.fsf@defensec.nl>
	<fc5583ce-8b27-4818-ae05-96e6332dd6a0@163.com>
Date: Mon, 18 Aug 2025 12:43:04 +0200
Message-ID: <87a53wzz9j.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Fei Shao <kabc005009@163.com> writes:

> On 18/08/2025 17:57, Dominick Grift wrote:
>> Dominick Grift <dominick.grift@defensec.nl> writes:
>>
>>> BOBx <kabc005009@163.com> writes:
>>>
>>>> Hi all,
>>>>
>>>> These days I tried to compile te with tools named checkpolicy. I have
>>>> searched the process with google and chatgpt, and I followed the steps
>>>> they told me but I failed.
>>> Hi,
>>>
>>> checkpolicy is for monolithic policy. see below for modular policy:
>>>
>>>> The following is my te file,=C2=A0 cmd and response and other infomati=
on.
>>>>
>>>> My te file(my_policy.te):
>>>> ----------------------------------------------
>>> This is modular policy that should be compiled with checkmodule and then
>>> packaged with semodule_package:
>> Oops.
>> Actually I am wrong. This is reference policy.
>> I should be compiled with the reference policy makefile. I am not sure
>> what package provides this Makefile in ubuntu but probably package
>> selinux-policy-dev:
>>
>> https://packages.ubuntu.com/questing/all/selinux-policy-dev/filelist
>>
>> /usr/share/selinux/devel/Makefile
>>
>> So this should work:
>>
>> make -f /usr/share/selinux/devel/Makefile my_policy.pp
> I use this command generate pp file well.
>
>>> checkmodule -M -m my_policy.te -o my_policy.mod
> This command doesn't work. The response is :
> ----------------------------------------------------
> my_policy.te:1:ERROR 'Building a policy module, but no module
> specification found.
> ' at token 'policy_module' on line 1:

Yes the policy_module() macro is reference policy specific and
checkmodule does not understand reference policy.

For reference policy use the reference policy Makefile.

>
>
> checkmodule:=C2=A0 error(s) encountered while parsing configuration
> --------------------------------------------------
> It seems the articles from search engine are not wrong.
>
>
>>> semodule_package -o my_policy.pp -m my_policy.mod
>>> semodule -i my_policy.pp
>>>
>>> for more information see:
>>>
>>> man checkpolicy
>>> man checkmodule
>>> man semodule_package
>>> man semodule
>>>
>>>> policy_module(my_mypolicy, 1.0)
>>>>
>>>> # Define types
>>>> type my_type_t;
>>>> type my_type_exec_t, file_type;
>>>>
>>>> # Allow rules
>>>> allow my_type_t my_type_exec_t:file execute;
>>>> ----------------------------------------------
>>>>
>>>> The command:
>>>> ----------------------------------------------
>>>> sudo checkpolicy -M -o my_policy.pp my_policy.te
>>>> ----------------------------------------------
>>>>
>>>> The response=C2=A0 from command:
>>>> ----------------------------------------------
>>>> my_policy.te:1:ERROR 'syntax error' at token 'policy_module' on line 1:
>>>>
>>>>
>>>> checkpolicy:=C2=A0 error(s) encountered while parsing configuration
>>>> ----------------------------------------------
>>>>
>>>> OS information: 6.11.0-29-generic, ubuntu 24.10.
>>>>
>>>> Would you like help me to compile te with checkpolicy please? Or which
>>>> URL should I read please?
>>>>
>>>> Best regards
>>>>
>>>> BOBx
>>>>
>>>>
>>>>
>

--=20
gpg --locate-keys dominick.grift@defensec.nl (wkd)
Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
Dominick Grift
Mastodon: @kcinimod@defensec.nl
