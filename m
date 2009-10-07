Message-ID: <4ACCE272.1070303@manicmethod.com>
Date: Wed, 07 Oct 2009 14:48:18 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Paul Nuzzi <pjnuzzi@tycho.ncsc.mil>, selinux@tycho.nsa.gov
Subject: Re: [PATCH 1/3] libsepol: Add support for multiple target OSes
References: <1253031316.3209.116.camel@moss-stripedbass.epoch.ncsc.mil>	 <4AB0EF22.8070003@manicmethod.com>	 <1254233003.2466.59.camel@moss-stripedbass.epoch.ncsc.mil>	 <4ACB5247.4000304@manicmethod.com> <1254937078.2251.286.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1254937078.2251.286.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Tue, 2009-10-06 at 10:20 -0400, Joshua Brindle wrote:
>> Paul Nuzzi wrote:
>>> On Wed, 2009-09-16 at 09:58 -0400, Joshua Brindle wrote:
>> <snip>
>>> Thanks for your input.  Below is the updated patch for libsepol.
>>>
>> A quick look through looks good. I'd like to test it out a bit, do you
>> have a Xen policy somewhere I can use for testing?
>>
>> Also, I notice that this only lets you write out a "kernel" policy for
>> Xen, but it might be beneficial to write out a base policy for testing,
>> development, analysis, etc.
>
> The Xen Flask policy lives in the xen-unstable tree; Paul has a patch to
> update the Xen Flask module to support this new policy string identifier
> and the new ocontext records and to update the policy there, but you'd
> have to apply that patch to xen-unstable and build it.
>

I'll leave the Xen Flask Module part to you guys, I just wanted to build 
a Xen policy and do some poking around on it to see if it looks right.


> In terms of base policy, if you mean modular base policy, we'd have to
> introduce multiple string identifiers for it in the same way as the
> kernel policy format, and I couldn't see the benefit of doing that when
> the module format is going to be replaced in the not-too-distant future.
> And what precisely is the benefit of writing a base policy vs. a kernel
> policy now that policy.24 includes attribute names and preserves
> attributes in allow rules (aside from certain cases, like type set
> exclusion aka minus)?

That is fine, I was just thinking it is nicer to put a base module into 
setools than a kernel policy but there is a good chance that won't work 
anyway since setools won't know about the new ocontexts and might freak 
out (completely untested).

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
