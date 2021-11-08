Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FDEAC433EF
	for <selinux@archiver.kernel.org>; Mon,  8 Nov 2021 20:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 347A8610F8
	for <selinux@archiver.kernel.org>; Mon,  8 Nov 2021 20:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237949AbhKHUqU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 8 Nov 2021 15:46:20 -0500
Received: from linux.microsoft.com ([13.77.154.182]:58330 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbhKHUqT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 8 Nov 2021 15:46:19 -0500
Received: from [192.168.1.10] (pool-173-66-191-184.washdc.fios.verizon.net [173.66.191.184])
        by linux.microsoft.com (Postfix) with ESMTPSA id 80B9620B416B;
        Mon,  8 Nov 2021 12:43:34 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 80B9620B416B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1636404215;
        bh=intHCA440e18iYTRKBk1v8jxUaI4AlosqexAZ8MExG4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LX/jGu8gNZ4z0g/EGTkdxmgilVJ3kBj3odKB8I5rq5PkmEAoWwjkLfUj0V2AGg/HX
         iP3eYp/XQOrbaqMpmdvYLWhUlnV0HlVycFrm1iT5pB4h7LHrnE/w2ju9dT6fHVM1Jo
         H0VpeIr44p0Pc0xwvXfJgupW04cbZZuC/h69jWfQ=
Message-ID: <3e770d7e-945e-1a41-fe9e-c220d3550ca9@linux.microsoft.com>
Date:   Mon, 8 Nov 2021 15:43:33 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [RFC] Cascade: a high level SELinux policy language
Content-Language: en-US
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@linux.microsoft.com>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        Chris PeBenito <pebenito@ieee.org>
References: <7d775f7f-1377-edde-8474-ba2126256852@linux.microsoft.com>
 <CAP+JOzQ8V2r8Dzh7xoWYwq3nhwW7KciMoB5EoTiuvjEwJHGQwQ@mail.gmail.com>
From:   Daniel Burgener <dburgener@linux.microsoft.com>
In-Reply-To: <CAP+JOzQ8V2r8Dzh7xoWYwq3nhwW7KciMoB5EoTiuvjEwJHGQwQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/5/2021 3:19 PM, James Carter wrote:
> On Thu, Nov 4, 2021 at 2:14 PM Daniel Burgener
> <dburgener@linux.microsoft.com> wrote:
>>
>> We have been working over the past few months on a new high level
>> language for specifying SELinux policy, in line with the original intent
>> of CIL, to enable the creation of high level languages that compile into
>> CIL.
>>
> 
> If you ever feel like CIL doesn't quite do what you need or that it
> doesn't work as expected, please let me know.

Absolutely.  So far, CIL has worked great for what I need.  I'll 
definitely contribute or reach out if I run into issues though.  I 
hope/expect that the overall development will exercise some CIL corner 
cases that may not have gotten a lot of use in the past, although that 
remains to be seen.

> 
>> Our objective is to create a language that enables the efficient
>> creation of useful abstractions by policy experts while enabling those
>> abstractions to be easily usable by non-experts who may contribute to
>> portions of the policy.
>>
>> The design is heavily influenced by Object Oriented principles, with a
>> goal of enabling the efficient creation of type hierarchies and
>> eliminating boilerplate through the use of inheritance.  The use of
>> "virtual" types, (which compile into attributes) allows both attribute
>> like behavior, and also the creation of inherited member functions,
>> allowing for interfaces as in refpolicy without the redundant
>> boilerplate.  Another key feature is "resource association" which makes
>> explicit the connections between domains and associated types such as
>> tmp files.  This feature allows for common patterns (such as setting up
>> a tmp file with a domain transition rule and manage access) to be done
>> automatically behind the scenes, minimizing the chance of mistakes and
>> allowing policy developers to focus more on security decisions.
>>
> 
> I realize that many of my questions below will be answered with
> "future work", so don't feel like you need to explain in great detail
> if that is the case.
> 
> How different is the inheritance in Cascade as compared to CIL.
> Obviously, in CIL it is not required, where in Cascade it is a very
> important part. There is also the use of "this" in Cascade.

I definitely have less CIL expertise than you, so please correct me if I 
have anything inaccurate about CIL.  I don't think there are any 
fundamental differences/incompatibilities between CIL inheritance and 
Cascade inheritance, at least not in the big picture.  They're both 
generally aiming at solving a similar problem in a similar manner.  They 
both inherit rules and create name mangled derived types for children. 
In contrast to CIL, Cascade intermingles attributes and inheritance.  So 
if I inherit from a parent, I automatically have an attribute for all 
children that I can reference elsewhere.  Cascade inheritance is also 
used to check function arguments.  So I can have a function that only 
takes children of the foo type and will throw a compiler error if used 
otherwise.  I don't *think* CIL has something similar to that?

I think one of the bigger distinctions (across the board, but including 
inheritance) is that syntactic sugar is an explicit non-goal of CIL, and 
an explicit goal of Cascade. Our objective is to make inheritance easier 
to use and natural feeling for developers who are familiar with object 
oriented programming languages.  I'll leave it up to others to decide 
whether we've succeeded there, and/or whether we can succeed there as we 
continue to develop.

> 
> It seems like Cascade is resolving all of its inheritance before
> writing out the CIL. My guess is that inheritance is such a core part
> of Cascade that using CIL's inheritance would make no sense. Is that
> true? Or did you just not like the way CIL does it?

This was mostly just around the centrality of the inheritance feature to 
Cascade.  It seemed like we'd have more flexibility doing that one by 
hand so to speak.  Our overall goal was to avoid reimplementing things 
that CIL already does, and just compile into the underlying CIL feature. 
  It's entirely possible that we could have/could in the future make 
more use of CIL's inheritance functionality.  That would be a win in 
terms of interoperability.  Inheritance of non-virtual types is on my 
TODO list, and when I get to that, I'll do some more in depth digging on 
whether we can lean more into existing CIL functionality here, which 
might make that use case easier.  That said, doing name mangling in our 
code rather than leaving it to CIL allows us the ability to have more 
control over applying things like annotations.  Annotations aren't used 
yet to their full potential, but my hope is that they can ultimately be 
used to provide a set of "debug symbols" consumed by audit2cascade and 
other tooling, in order to improve automated response to detected AVC 
denials, and policy discoverability for non-experts trying to understand 
said denials.  I *think* that as we aim to continue down that path, 
having full control over the list of types in the policy from inside the 
Cascade compiler will be important.

> 
> I was surprised that casc only take a single file. Do you expect the
> policies to be simple enough to do in one file?

Future work.  The library backend supports it, but I haven't updated the 
front end yet.

> 
> Since there is only one file, I guess there is no concept of modules
> for Cascade? And this means there is no need for something like an
> optional block because all of the policy would be compiled at once?

Future work.  Our primary internal use case that we hope to migrate for 
Cascade for involves compiling policies for multiple systems from the 
same repo, so we'll definitely need module support.  In particular the 
ability to mix and match groups of modules easily is important to us. 
What I'd like to do is add new `system {}` and `module {}` blocks that 
integrate naturally with everything else, and add options to casc to 
support easily building multiple systems.  On our existing refpolicy 
based setup, we have to do a lot of shell script processing to get 
everything to work well, and it's challenging to maintain.

In terms of optional blocks, Chris and I have argued about optional a 
few times, and part of the reason there's nothing about optional so far 
is because we'd like to solicit community feedback there.  My personal 
view is that explicitly marking statements as optional is tedious and 
error prone.  But I don't have a really slam dunk "clearly better" 
solution to propose yet at this point.  I have a few ideas, but they all 
need to be more thoroughly thought out and there are some holes and 
issues to address.  I viewed this feature as non-essential for an 
initial proof of concept, and am glad that we can have design 
discussions about it in the open.

So in short, yes, I think the ability to differentiate that certain 
rules are required for a module to work and others are optional is 
definitely needed.  But I'm not yet set on what the best way to do that 
is.  One key goal here is that a developer of a component should be able 
to add policy with fairly minimal knowledge of SELinux.  I'd prefer it 
if most of the time they could do the right thing without knowing about 
optional, but I'm not yet sure what the best/cleanest way to achieve 
that will be.

> 
> It looks like classes, mls statements, and sids are all automatically
> created in CIL. Is there a way to specify these things in Cascade or,
> since these things are almost always the same, are these low-level
> details something Cascade is not worried about.

Yes, currently these things are all hard-coded in CIL.  My goal in 
general is to have sensible defaults for people who don't care, but 
allow override for people who do.  So where I'd like to get to in the 
long term is to continue to define these things in code, but allow 
policy developers or either modify the defaults, or completely override 
them with their own implementations.  That's future work.

> 
> What about roles and users. I see the keywords, but how are they going to work?

Future work.  The overall goal would be for users who say "I don't need 
UBAC" or "I don't need RBAC", then they could just get something with 
automatic users and roles, like as in Android, with zero effort.  But we 
definitely want fully featured UBAC and RBAC support available for those 
who need it.

> 
> Thanks for letting us know about this work. It looks interesting.
> Jim

Thanks!  Thanks for your feedback/questions.

> 
> 
> 
>> The core language functionality is written as a library, which will
>> hopefully enable the easy creation of associated tooling and plugins
>> that build on top of that library.  It is our hope that this
>> architecture will assist an expansion of available tooling to aid policy
>> developers in their work.
>>
>> This is still a very early prototype and so some functionality may be
>> missing or incomplete, but we wanted to make what we have so far
>> available for community feedback and discussion as we continue development.
>>
>> You can find the code and associated documentation at
>> https://github.com/dburgener/cascade
>>
>> I hope this is something that people will find useful and welcome
>> feedback and contributions as we aim towards the goal of enabling
>> smoother policy development.
>>
>> -Daniel

