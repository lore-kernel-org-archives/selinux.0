Message-ID: <4CF54635.4080707@tresys.com>
Date: Tue, 30 Nov 2010 13:45:09 -0500
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: jwcart2@tycho.nsa.gov
CC: Dominick Grift <domg472@gmail.com>, selinux@tycho.nsa.gov
Subject: Re: analysing optional policy
References: <201011262055.01924.russell@coker.com.au>	 <1291131374.1328.25.camel@moss-lions.epoch.ncsc.mil>	 <4CF52A19.6070704@gmail.com> <1291140706.1328.47.camel@moss-lions.epoch.ncsc.mil>
In-Reply-To: <1291140706.1328.47.camel@moss-lions.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 11/30/10 13:11, James Carter wrote:
> On Tue, 2010-11-30 at 17:45 +0100, Dominick Grift wrote:
> On 11/30/2010 04:36 PM, James Carter wrote:
>>>> On Fri, 2010-11-26 at 20:55 +1100, Russell Coker wrote:
>>>>> I'm having a problem with optional policy not being used when I think it 
>>>>> should.
>>>>>
>>>>> Is it possible to use apol to get information on optional policy for .pp files 
>>>>> so I can try to work out why it doesn't get enabled?
>>>>>
>>>>>                 unconfined_run_to(depmod_t, depmod_exec_t)
>>>>>
>>>>> In the Debian policy I have the above in an optional section of base.pp but 
>>>>> for reasons that I don't understand it's not being loaded (both tests and 
>>>>> running apol on policy.24 show this).
>>>>>
>>>>> I've inspected the contents of base.conf and they appear to be OK.
>>>>>
>>>>> Any suggestions of other tools to analyse this will be appreciated.
> 
>> This may not be applicable here but do double check the module. I have
>> experienced similar issues where optional policy blocks were not loaded,
>> without any errors shown.
> 
> Not being defined is not an error in an optional block, it just means
> the optional block is not to be used.
> 
> It is expected that there will be a lot of unused optional blocks if
> only some modules are being used.  Reporting everything not defined
> would not be helpful in this case.
> 
> This behavior of silently removing optional blocks can, however, cause
> real errors to be missed.

At first I was going to suggest an extra-verbose or a debug mode on the
toolchain to help on this, but I suspect that identifying the block in a
useful fashion wouldn't be possible.  When resolving the blocks, is
there even any reference to the module it comes from?  Beyond that,
there probably aren't line numbers either, so it couldn't have messages
like "block disabled: optional beginning on line 123 from foo.pp."

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
