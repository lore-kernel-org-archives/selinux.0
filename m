Received: from dd44826.kasserver.com (dd44826.kasserver.com [85.13.151.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC992F2A
	for <selinux@vger.kernel.org>; Mon,  7 Apr 2025 19:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.13.151.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744054344; cv=none; b=hmR1X7X5MII0QBBD/VcEJiN/MaGzf0M8TMHmbzo4kVj0RJUR8ak1sqIrW8Jq1DEhut+XcS5LsUcMr1iODueexucnJMzqs9erIu9cU8lh9mO2B8F9T/NLYMamneCtn0QPFkUzV+vbvPvoaY8hgnejmMo5BW8r1Hp4qc4etEDmESI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744054344; c=relaxed/simple;
	bh=Nj8LsUafAMX4zd0Ma+Q8AI+ihcBbQYXk3TMWUGS4u5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OlYa9e0NVSsqDRoZfZTBzb7rZUNQAvmgAgkAHxOvaB/PyQNIzsof/pfM2iCexEBRpAcXe9OymK+9ou+8nSQ//lVBs6GuVh+GvYfyP6p5YCRZP9nkCGRFq5scP7+A2WgwwcCG5dnal8X+B0196TfZYZi3HtDWu7BSI5DS0aTdqKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=o1oo11oo.de; spf=pass smtp.mailfrom=o1oo11oo.de; dkim=pass (2048-bit key) header.d=o1oo11oo.de header.i=@o1oo11oo.de header.b=V39lihdo; arc=none smtp.client-ip=85.13.151.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=o1oo11oo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=o1oo11oo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=o1oo11oo.de header.i=@o1oo11oo.de header.b="V39lihdo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o1oo11oo.de;
	s=kas202503061048; t=1744054339;
	bh=Qrjh0etYsbPrBUhV0KKDjim8/woc9ejld4LtTNHfOPg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=V39lihdo1PmcOl7a/7U+P0+KKiMumogi/j7cM7TKhGLdOR60lY4EPIlEuDlssfVOQ
	 tJItXk5uS7xj0Yi77td3mSdMozLQw8LQeeodNk2+DN8OlzbiiFkh8PC61cbjoZ6VcB
	 hDyu0Eg1VarirJMTBFbNpVCo3R56USeubCLZqiVdy9j7x1Rm608mlKti5a84uAjW0V
	 74l2yx+cM/m5ueoFhch4xlQs+BawPgFKlQOuKzhzgIiij6tvuGDEMEffkLieUfmQzt
	 UU+5301cUohPOOhRLkk2iFQC+Y75teeXMNFtDw9TxCu83QfIMMj/9pPt2hwl5KmkH8
	 LFbjSQVKu7NcQ==
Received: from [192.168.178.23] (p5dd100e0.dip0.t-ipconnect.de [93.209.0.224])
	by dd44826.kasserver.com (Postfix) with ESMTPSA id 2891AB6E004B;
	Mon,  7 Apr 2025 21:32:19 +0200 (CEST)
Message-ID: <a23f13c1-3127-4915-ab32-5080bed789aa@o1oo11oo.de>
Date: Mon, 7 Apr 2025 21:32:18 +0200
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: AVC reclamation strategy questions
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org
References: <ed009068-754c-428f-8ef3-3b79dc9ec8b3@o1oo11oo.de>
 <CAEjxPJ4333bqBye1iV90hopdqwzzXQ4Mn0rBP41qUocBSLPBfQ@mail.gmail.com>
 <baa1be5e-765c-4526-bc3d-d5e4306acb4f@o1oo11oo.de>
 <CAEjxPJ6_OY+NgMNYNJWahzgCNciucT5DFhs3jLmW3Do7BMrjDA@mail.gmail.com>
From: Lukas Fischer <kernel@o1oo11oo.de>
In-Reply-To: <CAEjxPJ6_OY+NgMNYNJWahzgCNciucT5DFhs3jLmW3Do7BMrjDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -

On 07.04.25 21:10, Stephen Smalley wrote:
> On Mon, Apr 7, 2025 at 2:58 PM Lukas Fischer <kernel@o1oo11oo.de> wrote:
>>
>> On 07.04.25 18:14, Stephen Smalley wrote:
>>> On Mon, Apr 7, 2025 at 10:54 AM Lukas Fischer <kernel@o1oo11oo.de> wrote:
>>>> This message [3] from last year though states:
>>>>
>>>>> The current logic prunes the least recently used bucket
>>>>
>>>> Which in my understanding only works if "used" means "reclaimed from".
>>>>
>>>> Is this understanding correct or am I missing something?
>>>
>>> I think you are right. Apologies for mis-stating it in the previous email.
>>
>> No worries, thank you for the quick confirmation.
>>
>>> Patches to improve upon it would certainly be considered.
>>
>> I do not think I will be able to contribute anything meaningful in the near
>> future, sorry, but I will keep it in mind.
>>
>> Some background for why I am asking about the AVC, which I considered already
>> adding to the first mail: I am currently writing (or did already write) an LSM
>> in Rust as part of my master's thesis. For that, SELinux serves as comparison,
>> in structure and for the upcoming performance evaluation. To describe the
>> caching functionality correctly in the thesis, I was unsure if I grasped the
>> code correctly, which is why I asked.
>>
>> Also, for the performance evaluation I do expect my implementation to of course
>> be slower than SELinux, since it is by far not as optimized, the question is
>> more by how much, since my policy semantics are quite different.
>>
>> And no, the intent is not to upstream the Rust LSM, but I will probably publish
>> it. Maybe a much more cleaned up future version of the bindings, should there
>> ever be a need for them.
> 
> Ok, if you should release it, you might want to post a link to the
> linux-security-module@vger.kernel.org mailing list.

Yes, I was planning to do that.

> Might want to consider using the BPF-LSM as an alternative to writing
> your own native kernel code.
I have not looked at that in depth, and by now it's a little late to use it,
since the LSM itself is already done (as done as an initial implementation for a
thesis can be). Thanks for the suggestion though, I might need to still mention
that as an option/alternative in the thesis.

Thanks,
Lukas

