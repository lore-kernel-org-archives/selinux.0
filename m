Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEEB1E51EF
	for <selinux@vger.kernel.org>; Sat,  6 Sep 2025 02:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757124099; cv=none; b=I0A37/uIdTf3n9giwcPh4ZO6+A4/GNQVqT85aUFxUktNOwLUTDbYFkMshaHWmPdDXi7J5UjgUVpf5ZsHOAuP9VsTrVlFKMthj0Ui4WnB1kKlmJrFvsEQuQu8bGpK448879pCfS4KQGWNxmE5ghdHYIMOetSAe9BcOWbNHEMLGfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757124099; c=relaxed/simple;
	bh=KRnj9ex/sC6X+OVD5aoePfuDSsHiPCjRhMlcvFhe9Wg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mrdbNhRN/5rHNVUJ7UjaB9lrSpjR7de+ZdA1vqx9MEfSFaqfuUmTOktvBwSXAoX6asUjzo+0JJuD4hP6bpF6SmfYfK0Uzcs8GsnDQyNwZdyzj6zR43/IeHgic7FNVWYMO5NVpQTf5bj740yOiSDtNnidoARw0sdKAVVCU41oZTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=PVJZ0zeR; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="PVJZ0zeR"
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C8B803F148
	for <selinux@vger.kernel.org>; Sat,  6 Sep 2025 02:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1757124087;
	bh=h60wxlVR6LuYGXZcIV6vEzN1haroACPEr/9PN6TD6bI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=PVJZ0zeRCQaXEqsXbm8m/hcCMq5MpxY7iosqAZPiYpHlwrYnG3bOx0dNcTNN8lind
	 Dp5rvZDaPAY6xwrRVAUjSBEzsH+JYbZOInozWjEmKIEJNNPVuyWcWqfb8TmNvJHPh/
	 LSPy/cwDvN6NsGKFgHNeeh6PEfGjuuOBlYTmav1wJfmIbIdSPUINCuh1IYUErAdios
	 wHsNKnIropdb9gdSGLnwTpkAefvHyLpmTmkOXAfyKNo8EFCVMWN6Z1fkp1h6Q8KFCM
	 aHyJptQGcq6BWAYzaLWlZLXkxS7aBvraAL2d8tTgrCtN4HJASM1Qsr9H/FBbHuuIQK
	 5tcnkGPrNePaw==
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3276af4de80so3843896a91.1
        for <selinux@vger.kernel.org>; Fri, 05 Sep 2025 19:01:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757124086; x=1757728886;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h60wxlVR6LuYGXZcIV6vEzN1haroACPEr/9PN6TD6bI=;
        b=qNUyolHIaFNoNI7Pn7nSSTbU+6QkV1pml+/FRQg13P1MdrQ1/EvNIpcAr3pLvCeNdH
         ThYoboJdVN/Lb0GZ6sxc7eCBdoatWMoXrKeqTgXtW6yrC6uOgEyohW7an5kYEWEVXMGW
         T0QFwTZVZmS3WOnPKWndg+oY+WhIOHzpwtYj067l2lHeIJU8KXa/Vnc3INGVLS2bIk4h
         /DZ+8VZ5ExSbU5zJYhZZ/Mx+K6hpbKLnLjFcXsBCkLe+ywY5K8jhJLsC5U6wkuSsNVhG
         rIfI6kPRLBoH9Muzq8ewtEJ7lHmqfCakW30OMIZyqdnFTnnPKjH5EgVVVoNDkqusntH8
         Pc+g==
X-Forwarded-Encrypted: i=1; AJvYcCUJ/gcq0hqvIacY4dEm+hZuSDnb5NjjRmRMFUE7I8WGKOKGhIZVrSpxDHbqsJhSCA31sgo74ozl@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf/I5YNfXKNVtGmZ24Kkx6B5UlNn2qWmE5mn47yAGAZFk63AFA
	dfVeej92zlw0Yt72YWP6b0r3yQaB/ingFpLhpoMTM/WHwF3VCE5E0HDW8nRQh4p+CVzKZjoI4Ln
	x0GK+gJRThWooK4rZoYGURbUxPlX8hf+Tow9oZBOPVPws+u8Sqc/UGHwesUR+WMRsJmQFYRkpNj
	o=
X-Gm-Gg: ASbGncue9WOT/NsMA6GN5kfVf+T61HVq6QSnr9l1ZphBKpksH5FjAlfVnrLEQO3Zu4O
	7kcdgQdKRoj3OswIxQhj8oq4L2NXWRyT4h8Ct3fL2uj2Olsk4x7epfzPvL5QeDk5ApL2Z8fQq4q
	lbyoB/JZvORP/ztpHGHKFYIpqYfbaMR0RgWFPCAcw6sO9L7mIQmxWTefbFAGngBECcTEv2O9n4H
	mDj9HtiFqZtFy1BTZLIbZm/bs93LwbUbiWtQpGQAcX26p9sB7EJDks401mWPK2bz4SXOps8YYWY
	zOoKXf0lDQ761gMsNR+thbAVmdxkZB+AuZToKQeTMuZntK9yxAltmQ==
X-Received: by 2002:a17:90b:3fc8:b0:328:a89:3dc8 with SMTP id 98e67ed59e1d1-32d43f19a21mr1043452a91.14.1757124086278;
        Fri, 05 Sep 2025 19:01:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsE+/xTOktuZMKLiu9U/sAZyrMlNgWhiyYK4ioBlyuGxDiUrsPWVX9O1AvjQPB5E9nQ4F/KQ==
X-Received: by 2002:a17:90b:3fc8:b0:328:a89:3dc8 with SMTP id 98e67ed59e1d1-32d43f19a21mr1043387a91.14.1757124085531;
        Fri, 05 Sep 2025 19:01:25 -0700 (PDT)
Received: from [192.168.192.85] ([50.47.129.42])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b4fa1f21415sm8263496a12.18.2025.09.05.19.01.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 19:01:25 -0700 (PDT)
Message-ID: <96326155-1d4f-4df9-9394-ecc196463c57@canonical.com>
Date: Fri, 5 Sep 2025 19:01:24 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: LSM namespacing API
To: "Dr. Greg" <greg@enjellic.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
 selinux@vger.kernel.org
References: <CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com>
 <CAEjxPJ5EvR+2fboLu_nBGZu+ZVUpX4KM6xdPUqDErCmw=iA37g@mail.gmail.com>
 <67e72960-c985-48e1-aaeb-a4286cc8508f@canonical.com>
 <aKcskclwVVe1X4kP@mail.hallyn.com>
 <6c69fc81-32a7-442c-8c7f-992eda9c2d18@canonical.com>
 <20250901160102.GA9179@wind.enjellic.com>
 <fc3aadf1-9598-4fc2-bdb9-290df425b5d8@canonical.com>
 <20250905221456.GA1206@wind.enjellic.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20250905221456.GA1206@wind.enjellic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/5/25 15:14, Dr. Greg wrote:
> On Tue, Sep 02, 2025 at 03:55:39AM -0700, John Johansen wrote:
> 
> Hi, I hope the week has gone well for everyone.
> 
I wish, *sigh*

>> On 9/1/25 09:01, Dr. Greg wrote:
>>> On Thu, Aug 21, 2025 at 07:57:11AM -0700, John Johansen wrote:
>>>
>>> Good morning, I hope the week is starting well for everyone.
>>>
>>> Now that everyone is getting past the summer holiday season, it would
>>> seem useful to specifically clarify some of the LSM namespace
>>> implementation details.
>>>
>>>> On 8/21/25 07:26, Serge E. Hallyn wrote:
>>>>> On Thu, Aug 21, 2025 at 12:46:10AM -0700, John Johansen wrote:
>>>>>> On 8/19/25 10:47, Stephen Smalley wrote:
>>>>>>> On Tue, Aug 19, 2025 at 10:56???AM Paul Moore <paul@paul-moore.com>
>>>>>>> wrote:
>>>>>>>>
>>>>>>>> Hello all,
>>>>>>>>
>>>>>>>> As most of you are likely aware, Stephen Smalley has been working on
>>>>>>>> adding namespace support to SELinux, and the work has now progressed
>>>>>>>> to the point where a serious discussion on the API is warranted.  For
>>>>>>>> those of you are unfamiliar with the details or Stephen's patchset, or
>>>>>>>> simply need a refresher, he has some excellent documentation in his
>>>>>>>> work-in-progress repo:
>>>>>>>>
>>>>>>>> * https://github.com/stephensmalley/selinuxns
>>>>>>>>
>>>>>>>> Stephen also gave a (pre-recorded) presentation at LSS-NA this year
>>>>>>>> about SELinux namespacing, you can watch the presentation here:
>>>>>>>>
>>>>>>>> * https://www.youtube.com/watch?v=AwzGCOwxLoM
>>>>>>>>
>>>>>>>> In the past you've heard me state, rather firmly at times, that I
>>>>>>>> believe namespacing at the LSM framework layer to be a mistake,
>>>>>>>> although if there is something that can be done to help facilitate the
>>>>>>>> namespacing of individual LSMs at the framework layer, I would be
>>>>>>>> supportive of that.  I think that a single LSM namespace API, similar
>>>>>>>> to our recently added LSM syscalls, may be such a thing, so I'd like
>>>>>>>> us to have a discussion to see if we all agree on that, and if so,
>>>>>>>> what such an API might look like.
>>>>>>>>
>>>>>>>> At LSS-NA this year, John Johansen and I had a brief discussion where
>>>>>>>> he suggested a single LSM wide clone*(2) flag that individual LSM's
>>>>>>>> could opt into via callbacks.  John is directly CC'd on this mail, so
>>>>>>>> I'll let him expand on this idea.
>>>>>>>>
>>>>>>>> While I agree with John that a fs based API is problematic (see all of
>>>>>>>> our discussions around the LSM syscalls), I'm concerned that a single
>>>>>>>> clone*(2) flag will significantly limit our flexibility around how
>>>>>>>> individual LSMs are namespaced, something I don't want to see happen.
>>>>>>>> This makes me wonder about the potential for expanding
>>>>>>>> lsm_set_self_attr(2) to support a new LSM attribute that would support
>>>>>>>> a namespace "unshare" operation, e.g. LSM_ATTR_UNSHARE.  This would
>>>>>>>> provide a single LSM framework API for an unshare operation while also
>>>>>>>> providing a mechanism to pass LSM specific via the lsm_ctx struct if
>>>>>>>> needed.  Just as we do with the other LSM_ATTR_* flags today,
>>>>>>>> individual LSMs can opt-in to the API fairly easily by providing a
>>>>>>>> setselfattr() LSM callback.
>>>>>>>>
>>>>>>>> Thoughts?
>>>>>>>
>>>>>>> I think we want to be able to unshare a specific security module
>>>>>>> namespace without unsharing the others, i.e. just SELinux or just
>>>>>>> AppArmor.
>>>>>>
>>>>>> yes which is part of the problem with the single flag. That choice
>>>>>> would be entirely at the policy level, without any input from userspace.
>>>>>
>>>>> AIUI Paul's suggestion is the user can pre-set the details of which
>>>>> lsms to unshare and how with the lsm_set_self_attr(), and then a
>>>>> single CLONE_LSM effects that.
>>>
>>>> yes, I was specifically addressing the conversation I had with Paul at
>>>> LSS that Paul brought up. That is
>>>>
>>>>    At LSS-NA this year, John Johansen and I had a brief discussion where
>>>>    he suggested a single LSM wide clone*(2) flag that individual LSM's
>>>>    could opt into via callbacks.
>>>>
>>>> the idea there isn't all that different than what Paul proposed. You
>>>> could have a single flag, if you can provide ancillary information. But
>>>> a single flag on its own isn't sufficient.
>>>
>>> If one thing has come out of this thread, it would seem to be the fact
>>> that there is going to be little commonality in the requirements that
>>> various LSM's will have for the creation of a namespace.
> 
>> yes
> 
> Given that and the conversations to date, the open question may be
> whether there needs to be a common 'LSM namespace' infrastructure at
> all or just punt everything to LSM's that choose to implement
> namespaces.
> 
>>> Given that, the most infrastructure that the LSM should provide would
>>> be a common API for a resource orchestrator to request namespace
>>> separation and to provide a framework for configuring the namespace
>>> prior to when execution begins in the context of the namespace.
> 
>> hrmmm, certainly a common API. Any task could theoretically use the API
>> it doesn't have to be a resource orchestrator, but I suppose you could
>> call it such.
> 
> No argument that any task could call for separation.
> 
> We seem to be dancing around the notion that the primary use, nee
> demand, for a security namespace will be to allow container specific
> security policies.  In that scenario, the resource orchestrator or
> container runtime will be what is requesting a specific security
> model to be implemented in a namespace.
> 
no that is one use of them.

AppArmor is using namespaces for sub-confinement/priv sep They are also
used for tiered policy restrictions, and global black listing, and
unprivileged user and application policy.

>> I also dont know that we need to provide a framework for configuring
>> the namespace prior to when execcution begins in the context of the
>> namespace. It might be a nice to have, but configuring of LSMs is
>> very LSM specific.
>>
>> We don't even have a common LSM policy load interface atm, though there
>> is a proposal. Configuration is a step beyond that. Would it be nice
>> to have, sure. Are we going to get that far, I don't know.
> 
> At least for model based LSM's, the configuration needs to occur
> before execution within the namespace begins in order to avoid
> possible races with respect to the security policy that gets effected.
> 
depends on what you mean by configuration. There might be some config
of the namespace, but policy doesn't necessarily need to be loaded.
In both the unprivileged user and unprivileged application policy
cases, policy needs to be loaded after the the namespace is entered.

You can even split the container/orchastrator case, where LXD emulating
a system, will want to load the system policy as part of the OS boot
processes.

Where the docker/k8s/sandboxing use case have an orchestrator sandbox
app setup policy before hand.

> Casey advocates for the use of lsm_set_self_attr(2), which has the
> advantage of a common API and is probably sufficient if an LSM elects
> to provide a generic management interface.
> 
yeah that or something similar seems to be the way to go

> The system call is currently not namespace aware so the challenge will
> be how to direct the configuration payload to the correct namespace.
> 
yes

> Given that limitation, it seems highly probably that individual LSM's
> will implement configuration/policy management via their various
> pseudo-filesystem implementations that will grow awareness for the
> namespace context that the commands are being issued for.
>
possible. But ideally if we get it right they can expand the syscall
instead of an fs interface.

An fs interface has lots of problems like needing to be available within
a given namespace. If we want to be nesting namespaces (which we do),
then mounting custom FSes into the namespace is extra setup, and things
like proc may not even be available, depending on how the container is
being setup. 
>>> The first issue to resolve would seem to be what namespace separation
>>> implies.
>>>
>>> John, if I interpret your comments in this discussion correctly, your
>>> contention is that when namespace separation is requested, all of the
>>> LSM's that implement namespaces will create a subordinate namespace,
>>> is that a correct assumption?
> 
>> No, not necessarily. The task can request to "unshare/create" LSMs
>> similar to requesting a set of system namespaces. Then every LSM,
>> whether part of the request or not get to do their thing. If every
>> LSM agrees, then a transition hook will process and each LSM will
>> again do its thing. This would likely be what was requested but its
>> possible that an LSM not in the request will do something, based on
>> its model.
>>
>> In the end usespace gets to make a request, each security policy is
>> responsible for staying withing its security model/policy.
> 
> This approach seems contrary to what Casey is advocating for in our
> conversations, but perhaps we misunderstand what he is saying.
> 
Maybe, its not what I am getting from him, but I could be misunderstanding
as well.

> Casey indicated that no other LSM should be able to deny the ability
> of another LSM to create a namespace.
> 
correct, at least in isolation. However if it is tied to other namespace
creation, say at clone/unshare, an LSM should be able to deny that and
have the whole set fail.

That is an individual LSM can deny the creation of other non-LSM
namespaces that are happening at the same time. This may affect the
creation of other LSM namespaces, but any given individual LSM is
not denying another LSM from creating a namespace.



> As we noted in our exchange with him, this seems to violate the
> current LSM model where all of the LSM's need to agree that an event
> should be allowed, or it fails.
> 

there is good reason for it. Experience has shown forcing each LSM to
update policy for the policy of another LSM is problematic. Allowing
each LSM to manage itself based on its own policy while the rest of
the events are allow or fail, is very practical.

>>> It would seem, consistent with the 'stacking' concept, that any LSM
>>> with namespace capability that chooses not to separate, will result in
>>> denial of the separation request.  That in turn will imply the need to
> 
>> Not necessarily. They could allow and choose not to transition. Or
>> they could not create a namespace but update some state.
> 
>>> unwind or delete any namespace context that other LSM's may have
>>> allocated before the refusal occurred.
> 
>> The request does need to be split into a permission hook and a
>> transition hook similar to exec. If any LSM in the permission hook
>> denies, the request is denied. If any LSM in the transition hook
>> fails again the request will fail, and the LSMs would get their
>> regular clean up hook called for the object associated.
> 
> See above, the open question seems to be whether or not there is
> agreement that any LSM can generically deny the creation of namespace
> creation.
> 
> Again, we may misunderstand Casey on this issue.
> 

Its not about what an individual LSM is allowed but what is happening
at the system level. If system events are moving with the LSM event
the system event is fair game.

Even if we are talking individual LSM updates a two hook model may be
needed when taking into account the constraints of creds, and non-LSM
permission checks.

>>> This model also implies that the orchestrator requesting the
>>> separation will need to pass a set of parameters describing the
>>> characteristics of each namespace, described by the LSM identifier
>>> that they pertain to.  Since there may be a need to configure multiple
>>> namespaces there would be a requirement to pass an array or list of
>>> these parameter sets.
> 
>> yes it will require a list/array see lsm_set_self_attr(2)
> 
> Again, the issue is making this system call namespace aware.
> 
sure or another similar syscall. I don't think we are saying that it
has to be lsm_set_self_attr. More that it provides an example of how
to do this. It could be that it can be extended, it could be it turns
out that doing a new call that is similar but meets the constraints
is needed.

>>> There will also be a need to inject, possibly substantial amounts of
>>> policy or model information into the namespace, before execution in
>>> the context of the namespace begins.
> 
>> Allowing for this and requiring this are two different things. Like
>> I said above we don't even currently have a common policy load
>> interface.  Configuration is another step beyond policy load.
> 
> It would seem the most straight forward path is to simply punt this to
> the LSM's itself.  If nothing else, it reduces the issues that
> everyone needs to agree on.
> 
Yes, configuration requirements are definitely a per LSM thing.

>>> There will also be a need to decide whether namespace separation
>>> should occur at the request of the orchestrator or at the next fork,
> 
>> Or allow both, but yes a decision needs to be made
> 
> Again, allow both at the discretion of the LSM.
> 
sure

>>> the latter model being what the other resource namespaces use.  We
>>> believe the argument for direct separation can be made by looking at
>>> the gymnastics that orchestrators need to jump through with the
>>> 'change-on-fork' model.
> 
>> Looking at current system namespacing we have clone/unshare which
>> really or on fork. setns enters existing namespaces.
>>
>> We either need to create new variants of clone/unshare or potentially
>> have an LSM syscall that setups addition parameters that then are
>> triggered by clone/unshare. If going the latter route then its just
>> a matter whether the LSM call returns a handle that can be operated
>> on or not.
> 
> We will find that current namespace semantics are challenging with
> respect to being a good model for LSM namespaces.
> 
> Current namespaces focus on managing a single resource.  In contrast,
> as we have seen in our discussions, an 'LSM namespace' involves
> multiple resources, each with their own specific requirements.  On top
> of that we have the complication of 'stacking' where anything that
> happens will be the composite of what all the LSM's agree on, some of
> which may be in the root namespace and some of which may be in
> subordinate namespaces.
> 
its easy to see why people call security people crazy :)

> The notion of a process entering a security namespace, aka setns, will
> be interesting.  It would seem that this will require callbacks to
> every LSM that is participating in the namespace.  Presumably all of
> the references to LSM security contexts will need to be suspended and
> replaced with references to the context(s) for the security namespace
> that is being entered.
> 
yes setns from a security pov is problematic.

> With respect to managing this effectively, we would advocate for a
> 64-bit global counter that gets incremented on each successful LSM
> namespace creation event.  That would provide a unique handle for the
> namespace that will never wrap.
> 

uhmmm, a unique container id? Well I guess that is one way to guarantee
this will never happen.

>>> Case in point, it would seem realistic that a process with sufficient
>>> privilege, may desire to place itself in a new LSM namespace context
>>> in a manner that does not require re-execution of itself.
> 
>> yes, but it is questionable whether security policy should allow that.
>> At the very least security policy should be consulted and may deny
>> it.
> 
> What we are talking about here is the need to support a process
> requesting to run in an alternate LSM namespace without forking.
> 
sure, I support allowing a process to ask

> The question of whether this should be allowed will be regulated by
> whatever composite security policy is operational, the same as would
> be the case with the switch on fork model.
> 
>>> With respect to separation, the remaining issue is if a new security
>>> capability bit needs to be implemented to gate namespace separation.
>>> John, based on your comments, I believe you would support this need?
> 
>> No, I don't think a capability (as in posix.1e) per say is needed. I
>> think an LSM permission request is.
> 
> Once again, that seems inconsistent with what Casey is advocating.
> 
> Although I'm sure he is happy that a new capability bit is not in the
> offing... :-)
> 

not at all. I think the distinction is the LSM hook is asking the LSM
that is being asked to be namespaced. That is each LSM is consulted about
itself.

>>>> You can do a subset with a single flag and only policy directing things,
>>>> but that would cut container managers out of the decision. Without a
>>>> universal container identifier that really limits what you can do. In
>>>> another email I likend it to the MCS label approach to the container
>>>> where you have a single security policy for the container and each
>>>> container gets to be a unique instance of that policy. Its not a perfect
>>>> analogy as with namespace policy can be loaded into the namespace making
>>>> it unique. I don't think the approach is right because not all namespaces
>>>> implement a loadable policy, and even when they do I think we can do a
>>>> better job if the container manager is allowed to provide additional
>>>> context with the namespacing request.
>>>
>>> In order to be relevant, the configuration of LSM namespaces need to
>>> be under control of a resource orchestrator or container manager.
> 
>> No, the must be under the control of the LSMs.
> 
> I think we are talking past one another.
> 
quite possibly

> Configuration was perhaps a poor choice of vernacular, we were
> referring to policy or model load.
> 
which is one part of configuration. Its conceivable that an LSM could
have nobs to turn beyond policy

> As we mentioned in our exchange with Casey, the expection for all of
> this from the user community will be to allow resource orchestrators
> to run a workload under the constraints of a specific security policy.
> 
sure that is the expectation of the container community. Its just not
the only use.

> Where policy should be probably plural.
> 
> Stephen even notes this on the slides that are linked from his GitHub
> selinuxns site.
> 
>>> What we hear from people doing Kubernetes, at scale, is a desire to be
>>> able to request that a container be run somewhere in the hardware
>>> Resource pool and for that container to implement a security model
>>> specific to the needs of the workload running in that container.  In a
>>> manner that is orthogonal from other security policies that may be in
>>> effect for other workloads, on the host or in other containers.
> 
>> sure, assuming the host policy allows it. Otherwise it is just a host
>> policy by-pass, which can not be allowed. K8s people have a specific
>> use case, they need to configure the host for that use case. They can
>> not expect that use case to work on host that has been configured
>> for say an MLS security constraint.
> 
> Given that the concept of LSM stacking is overlaid on top of
> namespaces, the result of all this will be security policies that will
> be very interesting to reason about, particularly if multiple levels
> of namespacing are allowed.
> 
"interesting"*TM* indeed

> The other issue will be potential performance issues for LSM's that
> choose to chase permissions all the way back up to the root namespace.
> We've heard continuous suggestions that every pointer de-reference
> is problematic from a performance perspective.
> 
oh it is, the perforamance people can get snippy about just a few
cycles. Ultimately that is just the cost of stacking policy. The
more layers you add the higher the cost.

AppArmor is already working towards a jit of policy that will be able
to flatten stacked policy, so the cost is can be pushed back to the
same as non-stacked. That however comes with the cost of increased
memory use, and it will only deal with the AppArmor part of the
whole stack.

> So, lots of issues to consider in all of this.
> 
> Have a good weekend.
> 
> As always,
> Dr. Greg
> 
> The Quixote Project - Flailing at the Travails of Cybersecurity
>                https://github.com/Quixote-Project

