Message-ID: <4E5D2EA1.2070607@tresys.com>
Date: Tue, 30 Aug 2011 14:40:33 -0400
From: Steve Lawrence <slawrence@tresys.com>
MIME-Version: 1.0
To: Richard Haines <richard_c_haines@btinternet.com>
CC: <jwcart2@tycho.nsa.gov>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: SELinux Common Intermediate Language Update
References: <1314634446.62996.YahooMailClassic@web87002.mail.ird.yahoo.com>
In-Reply-To: <1314634446.62996.YahooMailClassic@web87002.mail.ird.yahoo.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

It actually means you need a valid range component. If you build a
binary policy without the --mls flag, it just doesn't write any of the
mls information to the binary. As Jim said, this is just required so as
to minimize special cases.

If you don't want to have to specify the range every time you create a
context, you can create a named levelrange with only one category and
sensitivity and use that in contexts, for example:

(category c0)
(categoryorder (c0))
(sensitivity s0)
(dominance (s0))
(sensitivitycategory s0 (c0))
(levelrange default ((s0 (c0)) (s0 (c0))))

(context context1 (unconfined_u unconfined_r unconfined_t default))

This is similar to the way the gen_context statement in refpolicy works,
which just discards the range when not building an mls policy.

Also, if you get the simple CIL policy working, we'd love to see it.

- Steve

On 08/29/2011 12:14 PM, Richard Haines wrote:
> Does this mean that I need to declare the range components as nulls, for example:
> 
> (context context1 (unconfined_u  unconfined_r  unconfined_t (() ())))
> 
> or is CIL only for generating MCS/MLS policy.
> 
> What I've been trying to do is generate a simple policy based on 'mdp' in CIL and thought I would use secilc to generate the binary. However I found that secilc only supports generating MCS/MLS policy (although I hacked it enough to generate contexts as in the example above).
> 
> Richard
> 
> --- On Thu, 25/8/11, James Carter <jwcart2@tycho.nsa.gov> wrote:
> 
>> From: James Carter <jwcart2@tycho.nsa.gov>
>> Subject: Re: SELinux Common Intermediate Language Update
>> To: "Richard Haines" <richard_c_haines@btinternet.com>
>> Cc: "Steve Lawrence" <slawrence@tresys.com>, "SELinux" <selinux@tycho.nsa.gov>
>> Date: Thursday, 25 August, 2011, 17:46
>> On Thu, 2011-08-25 at 17:10 +0100,
>> Richard Haines wrote:
>>> I've been trying to generate a context for a non-mls
>> policy but keep getting the following error:
>>>
>>> Building Parse Tree...
>>> Building AST from Parse Tree...
>>> Invalid context (line: 12)
>>> Failed to fill context, rc: -1
>>> cil_gen_context failed, rc: -1
>>> Failed to process node
>>> cil_tree_walk failed, rc: -1
>>> Failed to build ast, exiting
>>>
>>> I've tried various formats of 'context' but all
>> failed. One example:
>>> ( context context1 ( unconfined_u unconfined_r
>> unconfined_t ))
>>>
>>> I see plenty of mls context examples in the test files
>> but no non-mls.
>>> Could you let me know the correct format please.
>>>
>>
>> You always need to specify MLS current and clearance levels
>> in CIL. The
>> idea behind CIL is that we want a good foundation for
>> building
>> higher-level languages and tools, so we want minimize the
>> special cases
>> in the language syntax. Refpolicy already uses
>> gen_context() for
>> contexts, so just think of CIL as having gen_context()
>> built in.
>>
>> -- 
>> James Carter <jwcart2@tycho.nsa.gov>
>> National Security Agency
>>
>>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
