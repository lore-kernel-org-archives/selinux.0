Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E289C433EF
	for <selinux@archiver.kernel.org>; Tue,  9 Nov 2021 18:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7251C6103B
	for <selinux@archiver.kernel.org>; Tue,  9 Nov 2021 18:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242164AbhKISTh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Nov 2021 13:19:37 -0500
Received: from linux.microsoft.com ([13.77.154.182]:49564 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242160AbhKISTh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Nov 2021 13:19:37 -0500
Received: from [192.168.1.10] (pool-173-66-191-184.washdc.fios.verizon.net [173.66.191.184])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4245220ABAF3;
        Tue,  9 Nov 2021 10:16:50 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4245220ABAF3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1636481810;
        bh=JCRfDY9pgBcN9iXP+g73lIk/QyFgNS4sO4MvMBd16O8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Mv8/FLTomZbie0sL8+mmxbe6GFg1XIG4aHXRWIliRL+tdQH8oYLTCABuQCd0LE95K
         aObbObOcnhrlfwHJWlgYBnJyiPD7xg+6v3vwUX1P1P2lBS7WeTjzUit/aVMdpD8WTH
         a/1X5KlgktvVXHGzqqWGEYpSeSnt7nR3bq//QvKQ=
Message-ID: <33962ce0-24a6-7041-ea4c-8b63fe44a4ea@linux.microsoft.com>
Date:   Tue, 9 Nov 2021 13:16:49 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [RFC] Cascade: a high level SELinux policy language
Content-Language: en-US
To:     Karl MacMillan <karl@bigbadwolfsecurity.com>
Cc:     James Carter <jwcart2@gmail.com>,
        SElinux list <selinux@vger.kernel.org>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@linux.microsoft.com>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        Chris PeBenito <pebenito@ieee.org>
References: <7d775f7f-1377-edde-8474-ba2126256852@linux.microsoft.com>
 <CAP+JOzQ8V2r8Dzh7xoWYwq3nhwW7KciMoB5EoTiuvjEwJHGQwQ@mail.gmail.com>
 <3e770d7e-945e-1a41-fe9e-c220d3550ca9@linux.microsoft.com>
 <CA+EEuAhzFYQhLMXKgAOy_bzhdJV3a0Rqp9YSSot16+e32Vhv6Q@mail.gmail.com>
From:   Daniel Burgener <dburgener@linux.microsoft.com>
In-Reply-To: <CA+EEuAhzFYQhLMXKgAOy_bzhdJV3a0Rqp9YSSot16+e32Vhv6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/9/2021 11:03 AM, Karl MacMillan wrote:
> Daniel,
> 
> I'll just say - thanks for including me. It's interesting to see your 
> work. I've got some comments below inline.
> 
> On Mon, Nov 8, 2021 at 3:43 PM Daniel Burgener 
> <dburgener@linux.microsoft.com <mailto:dburgener@linux.microsoft.com>> 
> wrote:
> 
> 
>     I definitely have less CIL expertise than you, so please correct me
>     if I
>     have anything inaccurate about CIL.  I don't think there are any
>     fundamental differences/incompatibilities between CIL inheritance and
>     Cascade inheritance, at least not in the big picture.  They're both
>     generally aiming at solving a similar problem in a similar manner. 
>     They
>     both inherit rules and create name mangled derived types for children.
>     In contrast to CIL, Cascade intermingles attributes and
>     inheritance.  So
>     if I inherit from a parent, I automatically have an attribute for all
>     children that I can reference elsewhere. 
> 
> 
> That's certainly interesting and I see the appeal. I'll be curious to 
> see how that works out long term. I think one of the reasons that CIL 
> inheritance was separate from that originally was because attributes are 
> not great at expressing access access within a set of types that is 
> private vs they should all have interrelated access. I apologize for not 
> having looked at your proposed language closely enough to know the 
> semantics in detail (I read through the documentation, but was not able 
> to understand how some cases would work).
> 
> For example, let's say you have a "base class" for all services that can 
> be started by init, can write to the logging facilities (syslog / 
> journal), and have a pid file. The challenge that I see in that case is 
> that upon inheritance, the children sometimes get access to the 
> resources of the parents (i.e., init can exec them and they can still 
> write to syslog / journal), but sometimes they get _copies_ of the 
> resources with distinct access that is separated in the children (the 
> pid files).
> 
> That's hard to express with attributes and I think it's different from 
> normal object-oriented programming in some ways. Maybe you can express 
> it with static members vs instance members, but then it feels like you 
> need to "instantiate" the types vs this declarative language?

I agree that this is a challenge.  I *think* our model handles it 
cleanly, although we haven't had the "stress test" that implementing a 
full system policy in it will undoubtedly provide and I'd be surprised 
if we don't come across some interesting scenarios we haven't given 
enough thought to.

A lot of this is handled with the @associate annotation which allows for 
automatic deriving and access of the child.  In your example, I would do 
something like:

virtual resource init_pid {
	@associated_call
	fn use_init_pid(domain source) {
		this.manage(source);
	}
}

@associate([init_pid])
virtual domain init_daemon_domain {
	syslog.write(); // defined elsewhere
}

domain my_service inherits init_daemon {}

The key thing here with respect to what we're discussing is that when we 
inherit from init_daemon_domain we get a *copy* of all of 
init_daemon_domain's associated resources, and the @associated_call hook 
is called for each child on the copy.  So in this situation, my_service 
would inherit the syslog permissions (and the init domain elsewhere 
could reference all init_daemon_domains), but in terms of the policy 
that becomes unique to each child, that is defined in the 
@associated_call annotated function (and there can be multiple such 
functions if you desire), and it's called under the hood for all the 
children.

This conversation has also reminded me that we intended to have an 
@noinherit annotation for things that wouldn't be passed on to the 
children.  For example, there may be scenarios where it's beneficial to 
have init_daemon_domain associate with a resource and have the children 
*not* get copies of such a resource.  That particular feature got lost 
in the shuffle, so I may need to loop back on it.

Even without that though, I think the association mechanism here hits 
the key points on this challenge, and covers at least the common cases 
pretty cleanly.  Let me know if you think something is missing here.

> 
> Maybe you handle all of this?
> 
> 
>     In terms of optional blocks, Chris and I have argued about optional a
>     few times, and part of the reason there's nothing about optional so far
>     is because we'd like to solicit community feedback there.  My personal
>     view is that explicitly marking statements as optional is tedious and
>     error prone.  But I don't have a really slam dunk "clearly better"
>     solution to propose yet at this point.  I have a few ideas, but they
>     all
>     need to be more thoroughly thought out and there are some holes and
>     issues to address.  I viewed this feature as non-essential for an
>     initial proof of concept, and am glad that we can have design
>     discussions about it in the open.
> 
>     So in short, yes, I think the ability to differentiate that certain
>     rules are required for a module to work and others are optional is
>     definitely needed.  But I'm not yet set on what the best way to do that
>     is.  One key goal here is that a developer of a component should be
>     able
>     to add policy with fairly minimal knowledge of SELinux.  I'd prefer it
>     if most of the time they could do the right thing without knowing about
>     optional, but I'm not yet sure what the best/cleanest way to achieve
>     that will be.
> 
> 
> Optional blocks have, in practice, been a huge source of errors I 
> believe.
 > [snip]

I agree pretty much 100% with everything you've said here about the 
usage and historical limitations of optional.  Thanks for the added 
historical context from before my time.

On the topic of packaging, I'll admit that I'm sparse on details without 
an actual implementation at this point, so the packaging aspect of 
Cascade is currently vaporware, but my hope is that an integrated 
packaging and build system framework, inspired by rust's cargo can solve 
a lot of the packaging problems much more cleanly (by inserting optional 
blocks for install order problems during compilation rather than in 
source for example).

I like the suggestion of a question mark operator for optional policy 
quite a bit.  Although I'm really interested in exploring whether it's 
possible to just treat the entirety of it as a policy level dependency 
resolution problem.  Basically annotate with modules a particular module 
depends on vs which are optional - the distinction being that the 
optional marking is done at the module level rather than the 
rule/interface call level.  That might be less heavy-weight and error 
prone to use while still providing the needed flexibility.

> Anyway - forgive me crashing in with all of my opinions. I hope my 
> background on the problems of optionals might at least be helpful.

Opinions are what I'm seeking. :)  And yes, I think all of your thoughts 
here are quite helpful.  I think the attributes concern is a good one 
that we aimed to address, and can continue to refine as needed, and the 
optional thoughts are extremely helpful, since as I mentioned in my 
prior e-mail, the overall support for differentiating which policy is 
required and which is optional is a must-have in my view, but how 
exactly to specify it in a way that is clear is somewhat challenging and 
subjective.  Added info on historical context and use cases is a 
valuable input to that discussion.

-Daniel
