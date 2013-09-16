Message-ID: <5236F230.1040804@tycho.nsa.gov>
Date: Mon, 16 Sep 2013 07:57:36 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Dominick Grift <dominick.grift@gmail.com>
CC: Joshua Brindle <brindle@quarksecurity.com>,
        selinux <selinux@tycho.nsa.gov>
Subject: Re: Is this a bug in sesearch, or ...?
References: <1379263465.20256.6.camel@d30>  <5235E660.2040602@quarksecurity.com> <1379316937.6787.15.camel@d30>
In-Reply-To: <1379316937.6787.15.camel@d30>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 09/16/2013 03:35 AM, Dominick Grift wrote:
> On Sun, 2013-09-15 at 12:54 -0400, Joshua Brindle wrote:
>> Dominick Grift wrote:
>>> I was explaining the concept of (type) attributes using the domain type
>>> attribute as an example on IRC, and a sharp person embarrassed me by
>>> noting that the following rule returns nothing where he would have
>>> expected something:
>>>
>>> sesearch -A -d -s domain -c process -p fork
>>>
>>> Why does this not return anything? Is is because the target is "self"?
>>
>> "self" is resolved by the compiler, it isn't present in the kernel binary.
>>
>> You specified -d "do not search for type's attributes" and then gave an 
>> attribute as the source. I'm not sure what the intended behavior was but 
>> excluding the -d gave me back a large set of rules.
> 
> The result i expected would have been the exact (direct) rule as
> specified in the policy:
> 
> allow domain self : process fork;
> 
> So not the large list that one gets without the -d option because that
> is not the direct rule

direct means "granted to an individual type, not via attribute".  So it
omits any rules written in terms of attributes.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
