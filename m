Subject: Re: [PATCH] checkpolicy: Fix bug in handling type declaration in
 optional block.
To: Dominick Grift <dac.override@gmail.com>, James Carter
 <jwcart2@tycho.nsa.gov>,
 Stephen Smalley <sds@tycho.nsa.gov>, <selinux@tycho.nsa.gov>
References: <1484772829-15960-1-git-send-email-jwcart2@tycho.nsa.gov>
 <02cc173e-2a1a-3e7c-5de8-639b82585610@gmail.com>
 <1484846495.28584.13.camel@tycho.nsa.gov>
 <4d2eb68b-2fd1-c638-5d97-4dd6e92c80ff@gmail.com>
 <ba5c64b3-ae89-15a8-0b02-c5d5dc36b7eb@tycho.nsa.gov>
 <8fa28cc4-923b-7f9f-2dc5-2f431bfdc5fd@gmail.com>
From: Steve Lawrence <slawrence@tresys.com>
Message-ID: <cb19eb9c-6aaf-451a-55ca-6d92a31437a8@tresys.com>
Date: Fri, 20 Jan 2017 12:14:07 -0500
MIME-Version: 1.0
In-Reply-To: <8fa28cc4-923b-7f9f-2dc5-2f431bfdc5fd@gmail.com>
Content-Type: text/plain; charset="windows-1252"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 01/20/2017 10:29 AM, Dominick Grift wrote:
> On 01/20/2017 04:16 PM, James Carter wrote:
>> On 01/19/2017 04:22 PM, Dominick Grift wrote:
>>> On 01/19/2017 06:21 PM, Stephen Smalley wrote:
>>>> On Wed, 2017-01-18 at 21:58 +0100, Dominick Grift wrote:
>>>>> On 01/18/2017 09:53 PM, James Carter wrote:
>>>>>>
>>>>>> Nicolas Iooss discovered that requiring a type in an optional block
>>>>>> after the type has already been declared in another optional block
>>>>>> results in a duplicate declaration error.
>>>>>>
>>>>>
>>>>> from what i have been told and from experience, types cannot,
>>>>> reliably,
>>>>> be declared in optional blocks.
>>>>
>>>> If true, that is likely a linker issue rather than a checkpolicy issue.
>>>> But that would make optionals rather useless if true.
>>>
>>> Let me present it in a different way then:
>>>
>>> Should one be able to, reliably, "blockinherit" in optionals?
>>>
>>> This is the commit in dssp1 where i hit the dead-end with declaring
>>> types in optionals:
>>>
>>> https://github.com/DefenSec/dssp-contrib/commit/45236da4030f0a541c26753e13a91f69411d022e
>>>
>>>
>>> I asked slawrence to have a look at the policy, and he indicated to me
>>> that blocks cannot be inherited in optionals.
>>>
>>> The compiler accepts it but the policy becomes inconsistent
>>>
>>
>> By inconsistent, do you mean that an the binary policy produced is not
>> valid, or something else?
> 
> I used the word inconsistent because i actually forgot the details (it
> has been more than a year since I made this change and I tried hard to
> put this behind me, thinking that this was a fundamental limitation
> rather than a "bug").
> 
> I suspect the following:
> 
> Rules end up in the policy but they aren't actually recognized/enforced.
> 
> Either the above or:
> 
> Rules do *not* end up in the policy even though they are specified.
> 
> Maybe slawrence remembers what the issue exactly was (added to recipients)
> 

After digging through some past emails and discussions, I think part of
the issue is that things just start to get tricky and difficult to deal
with if you allow blockinherits (and for similar reasons blocks/macros)
in optionals.

For example, say you had something like this:

(optional foo
  (block b
    (blockinherit c)
   )
   ...
)

(block d
  (blockinherit b))


If something in optional foo fails, then the entire block b goes away.
So does that mean the blockinherit b in block d goes away too? Or does
that stay? Removing it could be potentially tricky since we need to
remove tree nodes that have been copied (we don't currently where things
are copied to), and that removal might have side effects. This is a
similar reason why we don't allow macros in optionals. Once they've been
called, it becomes difficult to remove them if the macros go away. Not
impossible, but difficult.

And since blockinherits can pull in blocks, you're essentially allowing
blocks inside optionals if you allow blockinherits inside optionals. So
this is likely the reason for not allowing blockinherits in optionals.
They can pull in blocks and macros, which aren't allowed to be optional.

I agree that supporting optional blocks/macros/blockinherits/etc would
probably be really nice, but things get difficult pretty fast.
Re-resolve when optionals fail is a messy bit of code. Figuring out the
right thing to do and when isn't obvious or easy.

Now, we could add in some restrictions that make the changes less
difficult (maybe), like blocks cannot be inside optionals, or
blockinherits inside optionals cannot inherit blocks that contain other
blocks. But again, that's still kindof a pain to implement and those are
probably restrictions that you'd end up running into eventually anyways.
So it would be best to just really figure out how to make it all work.
I'm sure it can work, it's just not an easy problem to solve and takes
time to figure out.

- Steve
