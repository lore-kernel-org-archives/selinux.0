Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9095B2857E2
	for <selinux@vger.kernel.org>; Thu, 21 Aug 2025 14:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755787459; cv=none; b=C1X33xxasYenvujfwY4fejYLQifXesebGdZFXcIJms7vTiM4q/xZXrgbwnxkO3oW+Z0aUeN5/Jg1ID1OgDHOflQLMIiF7nqxIPFbGCeMfD8zJywtdZEdL19O3FANCQ2pfMr+/xiGDzYCl6FWmcosi+UFxUjSUMZ7TQnfkKvwxaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755787459; c=relaxed/simple;
	bh=YO1gVdvZhKpLWYfzBCY1eHOYqhJMZZdgk8siPgvrWmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MbPXFk/TUNdjcbsh+CPxLyn+PR8Ml0heZTjpOvvHfvt+564OUDlnu0Jelz6fHcqyUcf7GpSl74QIuFlfaFaY+rBkp8kF9KfWviIXyeMnUudAvplxD9t5RK01bldn21G1GaJYD6O3Wc1a/ESqOzPYBwLnfGdKrmzN7FW1ByeCt0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=OgnlIfLZ; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="OgnlIfLZ"
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 684E73F7C3
	for <selinux@vger.kernel.org>; Thu, 21 Aug 2025 14:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1755787453;
	bh=jzTYLKjkL9ZMt1fp4vgtxFLWayh8S/XgPzEY+xF6xb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=OgnlIfLZogkeotojhrNjvga3CEq7CfXD5OqPcVUpc7ioPt3HC9uhMH50XAC5fl9zd
	 tF5Dj25EjGUZOQohNrtZwL2Je5EzEZFJ+5D/RK5inG6stfWdVQHNJoy96WM8ig5e6e
	 5JlOFMce+5WeGdcItmVKVTcEbbN2vlKZkEY0NInwIkUrWd1Dc1paIBpkFPjI2Lw9t2
	 6kuqQR4NvsoA7KSorp5ifWi4xyuwYSZwzJMm/i42ZErOFpJ9fjk/43Z5FsnHj6Lcs7
	 O20dwpQQyg3yBw317AWsULmIxz+Fu9abT2smNxtaGmPEDzgSfb2Tuc9Qe0mDr+e516
	 zKejUtWimrPVg==
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-324e318d628so1293904a91.3
        for <selinux@vger.kernel.org>; Thu, 21 Aug 2025 07:44:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755787452; x=1756392252;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jzTYLKjkL9ZMt1fp4vgtxFLWayh8S/XgPzEY+xF6xb8=;
        b=xAM2Vd9nQBpAPvifLh0479R56kVRJ4mSmGu5nmKy4dd3cyUXLypkhZQeUTxhq+VJjA
         SRPHEijwgkaq+P6iknzcQRNgOGTkF0/3600mseX3mBoTlip77G3xsqyDH+o4uJ6c6yN+
         1xd0vDgDjLLccMOb6CsM2V/kPsGrGzmL8bWcXy5Mvqyhj3VmcQV557pYTHTo2k1mdHzS
         IrW2MocEDv9HqyPKqRpsBAISnciawseYBJjXrvPFHNR8vMw/avPHsXGeV/3Ueb8F9aam
         sjIuW2r7+XmTp/X1fynh7gUHxmGyBS/dRjVeBlRuc0BY6nxD7eiOcNLMy+xJdmVdIk+J
         87ww==
X-Forwarded-Encrypted: i=1; AJvYcCVr38L877TJMkdSAGve5WQ+ztyBoWmQl+L1WggzfFV9VXRKSmL7S286jlDXtxsQK7VChu/Ixy3J@vger.kernel.org
X-Gm-Message-State: AOJu0YyC/zi2+nxTttSjo4SqwAJWXiGIT1BAPBu7xwisbiN3MnKu0acR
	HlR8bFgdt/oo1LWugID9x4HbZwvIJ8kBlfG15vVBMwfa0ovzhWnI48DXNuIq5/QVrnkD8tKc0zd
	3bWfhRpUgh+UOlxlVMbwXlL5+e65fMHsAIJMHMNKG5dP47IvY/TF7nG9je11gp7b0BYWTIAi9wS
	o=
X-Gm-Gg: ASbGncuQHA3lWmO29eRP9oH8EXK7eEOvkV19GZ3il7dI0Dk/fVKboRDgKtJnv5VnjqJ
	ewI8WHVObjdYWlNIUtLnm2Lz7gBWXBA3n3bgDeAJ54JcFq5JF0xdb3rY2XW5qLmHCAfPLcXeqG2
	qCK+w8RbYiIdyd8CB1YDFi+Z/MCp0ZATDWUzZVX7zNPaqg25J9ghvikjb0oi80aQIPbbk6uCbLm
	TYTiL5PPtG01e875RTrEETXReV0mhSHNrI8VypfaDw73QaJdGd3K/e3Irkhk8jtn/XD72oaXzFz
	5Ew5O23XWmFospwjIyfoEegmQkQ2Ugz9RQVELTvqOINIyY7IkBKsuw==
X-Received: by 2002:a17:902:fc8d:b0:235:e76c:4362 with SMTP id d9443c01a7336-245febf8e0cmr35918635ad.18.1755787451730;
        Thu, 21 Aug 2025 07:44:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGahWwApq0i4t6A4LoiarZetMIHjxOK7/oM7/tt2XrZewjao2+hzBcsjI/PmdvRAYWGoeVhdQ==
X-Received: by 2002:a17:902:fc8d:b0:235:e76c:4362 with SMTP id d9443c01a7336-245febf8e0cmr35918215ad.18.1755787451170;
        Thu, 21 Aug 2025 07:44:11 -0700 (PDT)
Received: from [192.168.192.85] ([50.39.98.232])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-245ed33df68sm57932305ad.21.2025.08.21.07.44.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 07:44:10 -0700 (PDT)
Message-ID: <aa5833f7-3ece-4d20-b49d-4d5dbaf8628c@canonical.com>
Date: Thu, 21 Aug 2025 07:44:09 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: LSM namespacing API
To: "Dr. Greg" <greg@enjellic.com>, Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
 Stephen Smalley <stephen.smalley.work@gmail.com>
References: <CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com>
 <20250821112011.GA31850@wind.enjellic.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20250821112011.GA31850@wind.enjellic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/21/25 04:20, Dr. Greg wrote:
> On Tue, Aug 19, 2025 at 10:56:27AM -0400, Paul Moore wrote:
> 
>> Hello all,
> 
> Good morning, I hope the day is going well for everyone.
> 
>> As most of you are likely aware, Stephen Smalley has been working on
>> adding namespace support to SELinux, and the work has now progressed
>> to the point where a serious discussion on the API is warranted.  For
>> those of you are unfamiliar with the details or Stephen's patchset, or
>> simply need a refresher, he has some excellent documentation in his
>> work-in-progress repo:
>>
>> * https://github.com/stephensmalley/selinuxns
>>
>> Stephen also gave a (pre-recorded) presentation at LSS-NA this year
>> about SELinux namespacing, you can watch the presentation here:
>>
>> * https://www.youtube.com/watch?v=AwzGCOwxLoM
>>
>> In the past you've heard me state, rather firmly at times, that I
>> believe namespacing at the LSM framework layer to be a mistake,
>> although if there is something that can be done to help facilitate the
>> namespacing of individual LSMs at the framework layer, I would be
>> supportive of that.  I think that a single LSM namespace API, similar
>> to our recently added LSM syscalls, may be such a thing, so I'd like
>> us to have a discussion to see if we all agree on that, and if so,
>> what such an API might look like.
>>
>> At LSS-NA this year, John Johansen and I had a brief discussion where
>> he suggested a single LSM wide clone*(2) flag that individual LSM's
>> could opt into via callbacks.  John is directly CC'd on this mail, so
>> I'll let him expand on this idea.
>>
>> While I agree with John that a fs based API is problematic (see all of
>> our discussions around the LSM syscalls), I'm concerned that a single
>> clone*(2) flag will significantly limit our flexibility around how
>> individual LSMs are namespaced, something I don't want to see happen.
>> This makes me wonder about the potential for expanding
>> lsm_set_self_attr(2) to support a new LSM attribute that would support
>> a namespace "unshare" operation, e.g. LSM_ATTR_UNSHARE.  This would
>> provide a single LSM framework API for an unshare operation while also
>> providing a mechanism to pass LSM specific via the lsm_ctx struct if
>> needed.  Just as we do with the other LSM_ATTR_* flags today,
>> individual LSMs can opt-in to the API fairly easily by providing a
>> setselfattr() LSM callback.
>>
>> Thoughts?
> 
> There has been an adage that traces back to the writings of George
> Santayana in 1905 that seems relevant:
> 
> "Those who cannot remember the past are condemned to repeat it."
> 
> To that end, some input from more than a decade of our work on this
> issue.  Some of our reflections below are relevant to issues being
> covered in downstream components of this thread, particularly by John
> in the last few hours.
> 
> We have had code on the table for three years with respect to the
> problem of generic namespacing of security policy/model/architecture,
> whatever one chooses to call it.
> 
> For everyone's reference, here are the URL's to the patch series:
> 
> V1:
> https://lore.kernel.org/linux-security-module/20230204050954.11583-1-greg@enjellic.com/T/#t
> 
> V2:
> https://lore.kernel.org/linux-security-module/20230710102319.19716-1-greg@enjellic.com/T/#t
> 
> V3:
> https://lore.kernel.org/linux-security-module/20240401105015.27614-1-greg@enjellic.com/T/#t
> 
> V4:
> https://lore.kernel.org/linux-security-module/20240826103728.3378-1-greg@enjellic.com/T/#t
> 
> We started this work about 13-15 years ago.  We initially described
> our work and the need for it, 10 years ago almost to this day.  See
> our 2015 paper at the Linux Security Summit in Seattle.
> 
> James Morris and Casey were in the first row, Stephen and a co-worker
> from the NSA were in the second row, to the speakers left.
> 
> If one spends some time looking under the hood, TSEM is in large part
> about providing a generic framework for running multiple, independent
> and orthogonal security frameworks/policies/architectures, whatever
> one chooses to call these entities.
> 
> The reason that we argue that TSEM is a generic framework, is that in
> our internal work, we have ported the major LSM's, including the IMA
> infrastructure, to run in isolated namespaces as plugins for TSEM's
> notion of Trusted Modeling Agents (TMA's).  We also have ongoing work
> that enables Kubernetes to dispatch workloads, using whatever LSM
> based security policy that container developers desire for their
> workloads.
> 
> Suffice it to say, we have howed a lot of ground on the issues
> surrounding this, including issues surrounding production deployment
> of this type of technology.
> 
> In our initial implementation, circa 2015, we adopted the approach of
> using a CLONE_* flag and wired the implementation of security
> namespaces into the rest of the namespace infrastructure.
> 
> During COVID, we re-architected the entire implementation and moved to
> using a control file in the pseudo-filesystem that TSEM implements, we
> have never looked back on this decision.
> 
> TSEM security workloads are a poster child for security namespaces
> that require a number of different setup parameters.  A command verb
> syntax with key=value pairs, written to a pseudo-file, has proven
> itself to be the most flexible approach when setting up security
> workloads.
> 
> With respect to namespace transition, we trigger the transition of a
> process to a new namespace (unsharing) when the process issues the
> request via the control file.  This has proven to be, at once, the
> most straight forward and least security prone approach.
> 
> The other major, and thorny issue, is the notion of another process
> 'entering' a security namespace.  There are a ton of open issues to be
> considered with this, the approach that we took that has worked well
> to date, is the notion of a 'trust orchestrator' that has
> responsibility for controlling the namespace.  Any manipulations or
> control of the namespace are conducted through the orchestrator
> process.
> 
> If anyone chooses to look at our implementation, you will find that we
> 'bless' the orchestrator process, at the time of namespace creation,
> with access to the security namespace context control structure for
> the namespace being created.  The orchestrator is the only entity that
> can access the security state of the namespace, other than processes
> within the namespace itself.
> 
> This significantly narrows the scope of vulnerability with respect to
> who or what can manipulate a security namespace.  There are a number
> of thorny issues, that we have not seen anyone mention, that surface
> with respect to allowing entry into a security namespace by an
> arbitrary process.  Believe me when I say we have found a number of
> them by accident and incident.
> 
indeed, this has to be tightly controlled. Much more so than just
creating a namespace. And its not just the "security/LSM" namespace
but the entire context around it. That is whether or not you can
step into say the mount namespace separate from the security/LSM
namespace it was created with.

Each and everyone of those opens potential attack surface. Even if you
if it turns out to be safe, you have to carefully evaluate each
potential combination.

> So big picture.
> 
> Over a decade of experience with these issues, suggests that Paul's
> premise that most of these issues are best left to specific LSM's that
> elect to implement namespacing, is correct.
> 
> The challenge is that this situation ends up being all or nothing.
> 
> The actual amount of code involved in unsharing a namespace is so
> trivial, in comparison to the work involved with setting up and
> maintaining state information for a security namespace context, that
> it seems to make little sense to implement this support at the level
> of the LSM infrastructure itself.
> 
actually I think that is pretty much the goal, just a minimal thin
layer that provides the hooks and maybe an LSM blob object for the
individual LSMs to do their thing.

Instead of each LSM implementing their own interface there is a common
one for container orchastrators to use to make the request.

> If the decision is made to provide generic namespace support, other
> than a request to create a namespace, it will rapidly become a
> slippery slope with respect to the amount of infrastructure needed to
> address the complexities associated with every security model being
> different from every other.
> 
yep, this is really just about a thin common API, and minimal
infrastructure around the existing system namespacing calls (clone,
ushare, setns).

> The caveat to this is if our notion of a 'trust orchestrator' would be
> deemed to have merit.  In that case, an LSM based namespace separation
> architecture would provide a common point for the orchestrator to be
> 'blessed' with access to control of a namespace.
> 
A trust orchestrator isn't necessarily needed. Each LSM can manage its
own trust within its policy. A trust orchestrator becomes more necessary
when you are trying to namespacing without the LSMs themselves
participating in the decision around namespacing. Which admittedly has
largely been the current situation.

> The other open issue is whether or not a separate capability should be
> implemented that allows the creation of a new security namespace.  If
> one paws through our TSEM submissions, one will see that we proposed
> such a capability bit.
> 
Its not needed if individual LSMs are making decisions around namespacing
based on policy. In fact in that case it can even be harmful. Per LSM
policy would be finer grained, where a capability becomes this shared
flag that lacks context. Examples abound in the kernel where we have
a cap check without context and then a more context based security
check.

Where the capability might be useful is wehn LSMs aren't dealing with
the namespacing request directly.

> Casey noted, rather emphatically, that no new capabilities were going
> to be implemented in Linux, particularly for what was described as a
> 'toy' project.  He indicated that CAP_MAC_ADMIN was the canonical
> capability that should be used for manipulating LSM's.
> 
I disagree with the reuse of CAP_MAC_ADMIN, if there is going to be
a capability around this it should be distinct from MAC_ADMIN and
MAC_OVERRIDE, as it very much has different semantics.

> We will be very interested in seeing how a discussion around this
> evolves, as 'escaping' from an existing security context to a new one
> is an extremely critical operation from a security perspective, if one

yes. I might have mentioned just how much I dislike setns().

> stands back and looks at the issue objectively.  If the concept of a
> 'security orchestrator' is embraced, it would make perfect sense for
> the orchestrator to drop CAP_SEC_NS, or whatever it would be called,
> and retain CAP_MAC_ADMIN in order to manage the namespace.
> 
> So lots of issues to consider; thorny, political and otherwise, on
> multiple fronts.
> 
>> paul-moore.com
> 
> Have a good day.
> 
> As always,
> Dr. Greg
> 
> The Quixote Project - Flailing at the Travails of Cybersecurity
>                https://github.com/Quixote-Project
> 

