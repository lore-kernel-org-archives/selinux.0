Message-ID: <53D79E6D.8000202@tresys.com>
Date: Tue, 29 Jul 2014 09:15:25 -0400
From: Steve Lawrence <slawrence@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, Joshua Brindle
 <brindle@quarksecurity.com>
Subject: Re: [RFC] [PATCH] libsemanage: Skip policy module re-link when only
 setting booleans.
References: <53D28DBB.8000905@tycho.nsa.gov>
 <53D2B3ED.2070102@quarksecurity.com> <53D2B4DA.7090504@redhat.com>
 <53D2B64F.5020004@tycho.nsa.gov> <53D2B83A.3010302@quarksecurity.com>
 <53D2BA1F.3010608@tycho.nsa.gov>
In-Reply-To: <53D2BA1F.3010608@tycho.nsa.gov>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: SELinux-NSA <SELinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 07/25/2014 04:12 PM, Stephen Smalley wrote:
> On 07/25/2014 04:04 PM, Joshua Brindle wrote:
>> Stephen Smalley wrote:
>>> Effectively it would be another copy of the kernel policy file, just one
>>> that is generated before merging local customizations (booleans, users,
>>> ports, nodes, interface), so that we can take that kernel policy, read
>>> it into a policydb, and mutate it rather than having to re-link the
>>> modules to generate another one.  Would allow us to avoid module
>>> re-linking on all non-module semanage changes IIUC.  Could be
>>> compressed; just means you have to pay the cost of uncompressing it
>>> before using it in libsemanage.
>>>
>>
>> On my Fedora 20 system a linked policy is 32 meg, bzip2 linked policy is
>> 768k.
> 
> I wasn't going to bother with saving the current linked policy, just a
> copy of the kernel policy before merging local customizations.  There is
> no linked policy in cil (on #integration) so basing anything on it is
> likely not a good idea, and by writing out the kernel policy before
> merging, we end up with something that is smaller and more readily
> usable on the next transaction.
> 

This is correct. CIL does not generate a linked policy, so in order for
this change to be compatible with the CIL integration we would have to
store the kernel policy.

Also, this patch looks good to me.

- Steve
