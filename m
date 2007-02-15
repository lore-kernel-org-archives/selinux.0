Date: Thu, 15 Feb 2007 14:12:50 -0500
Subject: Re: [RFC] Ability to allow undefined permissions and classes -v2
From: Chad Sellers <csellers@tresys.com>
To: Eric Paris <eparis@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>
CC: Joshua Brindle <jbrindle@tresys.com>, <selinux@tycho.nsa.gov>
Message-ID: <C1FA1AE2.1D29B%csellers@tresys.com>
In-Reply-To: <1171566336.18488.22.camel@localhost.localdomain>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 2/15/07 2:05 PM, "Eric Paris" <eparis@redhat.com> wrote:

> On Thu, 2007-02-15 at 13:46 -0500, Stephen Smalley wrote:
>> On Thu, 2007-02-15 at 13:33 -0500, Stephen Smalley wrote:
>>> On Wed, 2007-02-14 at 14:22 -0500, Joshua Brindle wrote:
>>>>> From: Eric Paris [mailto:eparis@redhat.com]
> 
>>>>> That is my point of question and lack of understanding.  Will
>>>>> the policy which is passed to the kernel have all of the
>>>>> policy for all of the system or only that for the kernel?
>>>>> The way I see both cases:
>>>>> 
>>>> 
>>>> Only for the kernel.
>>> 
>>> Actually, I thought you had found that the userspace security server
>>> isn't much of a win (and a definite cost) for current usage by e.g. the
>>> X server.  Which would suggest that we aren't likely to evict userspace
>>> policy from the kernel any time soon.
>> 
>> Just to clarify, I only mean the policy itself - the symbol definitions
>> for userspace classes and permissions should be removed from the kernel
>> headers ASAP, as it never needs to refer to them and we don't want to
>> impose validity checks on them within the kernel.
> 
> Ok so then I'm a little confused about the best way to proceed.  My
> current method determines 'unknown' by walking the kernel header
> definitions and then finding the differences in the policy definitions.
> If I continue to use that method all kernel security decisions will be
> affected by the new allow unknown stuff and that makes me happy.  But
> all userspace decisions won't be affected at all.  A security decision
> based on a class not defined in policy and not defined in the kernel
> headers will be 'denied.'  Same goes for a permission check not defined
> in policy or in the kernel headers.  Is this the desired behavior?  Or
> should unknown be 'everything the policy doesn't know irregardless of
> the kernel headers?'
> 
> Basically, should I walk the policy and find out everything it knows
> nothing about or should I continue to just walk the kernel headers and
> and only allow 'unknown' things that aren't quite the same between the
> kernel headers and the policy?
> 
Continue to walk the kernel headers. This way you'll allow permission checks
for things the kernel thinks should be there but aren't. Userspace will get
denials for missing things, as the kernel headers won't have userspace
permissions any more.

Plus I'm not sure how you would "walk the policy and find out everything it
knows nothing about," given that you have no way of knowing what it should
know about other than the kernel headers.

Chad Sellers 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
