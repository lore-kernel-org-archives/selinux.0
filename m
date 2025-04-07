Received: from dd44826.kasserver.com (dd44826.kasserver.com [85.13.151.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9997221931E
	for <selinux@vger.kernel.org>; Mon,  7 Apr 2025 18:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.13.151.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744052340; cv=none; b=GZMbn4PTUvQ36W8nWz6EbytIv0UfQ21GgqXxeE1BupmxVg1fojMOb7pu7hMOJDCZOsrpnExRDc6a8T3hKqoUbLwJWgQuzpxoeESoOaoydYB131ZrUMESP9z3+36/243WA4sC22ElxGrcZzpv+ZvORoBDxkp5YvNOGmCwETFA/xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744052340; c=relaxed/simple;
	bh=82hBGAUyPk0+izSkv5kmB2vf8hd29JyNbVl3/KSnFT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uS8WzAqd8nOAiIqoU2dVKYc8oxyQ9IBCjjSv+29HfsPufku4YNFu7i5hBUtVxXjGO1l7s5i5GNIG60V4Osmb129FMvq7llhYtvlw6faLPVoN+bYQWfSoeUoKXGg5cLvgGnnXReGTmiztbn07STR71fIj23SFNZ7kxvWycNsqXoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=o1oo11oo.de; spf=pass smtp.mailfrom=o1oo11oo.de; dkim=pass (2048-bit key) header.d=o1oo11oo.de header.i=@o1oo11oo.de header.b=kvYt4Zzf; arc=none smtp.client-ip=85.13.151.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=o1oo11oo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=o1oo11oo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=o1oo11oo.de header.i=@o1oo11oo.de header.b="kvYt4Zzf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o1oo11oo.de;
	s=kas202503061048; t=1744052332;
	bh=LWGk+S6sCbe1qZ2AGU/CCDtyj/POni8EZdYFZpbRLDo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kvYt4Zzf/x8pxviRUORqb6ue89/yyzZTIZVbD7wwtCDBD9CHxnBaM4gNFTNHajjGa
	 MzHHHPd7rkuarndBF5WHQp/0V4Q0QERgThUaiLGAsfAE4B0/K6MaRoxcj4LvgW8Kly
	 0+JAzHuhiYOlqHfTGqrT+DppcX8zdK3ly8CZc9YPUki7gTZYfFwGIK79IkXB//zhHs
	 99CrTKTppqADMkOne8L1mSchtW1i6PZbCRG18BVsvTjeDESCYmUQAPm+gPnlZlxXlZ
	 5m9MM7iuFhE/tHZFiRIr+A+vRTOtz+rI7EaEwgYn5eeWe6vmKb8QbGqQz+igh2WFKu
	 a+kpJMecaDpFA==
Received: from [192.168.178.23] (p5dd100e0.dip0.t-ipconnect.de [93.209.0.224])
	by dd44826.kasserver.com (Postfix) with ESMTPSA id 77F40B6E007C;
	Mon,  7 Apr 2025 20:58:52 +0200 (CEST)
Message-ID: <baa1be5e-765c-4526-bc3d-d5e4306acb4f@o1oo11oo.de>
Date: Mon, 7 Apr 2025 20:58:51 +0200
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
From: Lukas Fischer <kernel@o1oo11oo.de>
In-Reply-To: <CAEjxPJ4333bqBye1iV90hopdqwzzXQ4Mn0rBP41qUocBSLPBfQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: /

On 07.04.25 18:14, Stephen Smalley wrote:
> On Mon, Apr 7, 2025 at 10:54 AM Lukas Fischer <kernel@o1oo11oo.de> wrote:
>> This message [3] from last year though states:
>>
>>> The current logic prunes the least recently used bucket
>>
>> Which in my understanding only works if "used" means "reclaimed from".
>>
>> Is this understanding correct or am I missing something?
> 
> I think you are right. Apologies for mis-stating it in the previous email.

No worries, thank you for the quick confirmation.

> Patches to improve upon it would certainly be considered.

I do not think I will be able to contribute anything meaningful in the near
future, sorry, but I will keep it in mind.

Some background for why I am asking about the AVC, which I considered already
adding to the first mail: I am currently writing (or did already write) an LSM
in Rust as part of my master's thesis. For that, SELinux serves as comparison,
in structure and for the upcoming performance evaluation. To describe the
caching functionality correctly in the thesis, I was unsure if I grasped the
code correctly, which is why I asked.

Also, for the performance evaluation I do expect my implementation to of course
be slower than SELinux, since it is by far not as optimized, the question is
more by how much, since my policy semantics are quite different.

And no, the intent is not to upstream the Rust LSM, but I will probably publish
it. Maybe a much more cleaned up future version of the bindings, should there
ever be a need for them.

Thanks,
Lukas

>> [3]:
>> https://lore.kernel.org/selinux/CAEjxPJ7QqEG+wyQfuPeDu0JqvjRCvbtVzZ6qtzwc-YwGz=mLjQ@mail.gmail.com/

