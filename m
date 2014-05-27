Message-ID: <5384C19B.7040001@tycho.nsa.gov>
Date: Tue, 27 May 2014 12:47:23 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
MIME-Version: 1.0
To: Steve Lawrence <slawrence@tresys.com>,
 Dominick Grift <dominick.grift@gmail.com>
Subject: Re: secilc: in statement ordering limitations
References: <1400689802.5957.5.camel@x220.localdomain>
 <537F4A07.70403@tycho.nsa.gov> <1400855557.10370.4.camel@x220.localdomain>
 <537F6395.6000002@tresys.com>
In-Reply-To: <537F6395.6000002@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: selinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/23/2014 11:04 AM, Steve Lawrence wrote:
> On 05/23/2014 10:32 AM, Dominick Grift wrote:
>> On Fri, 2014-05-23 at 09:15 -0400, James Carter wrote:
>>
>>> Could you give me a little bit more information on what you are doing?
>>
>> Strange.. It is kind of hard for me to put it any other way.
>>
>> I have a short 5 minute video that demo's the issue:
>>
>> https://www.youtube.com/watch?v=hU_yVZJpAyM
>>
>> If you are not able to view the demo then i guess i will have to find
>> another way to explain it
>>
>
> I think this is an example of the core problem:
>
>    (in foo.bar
>      (type x))
>
>    (in foo
>      (block bar))
>
>    (block foo)
>
> So, an in-statement is inserting into a block that is created by another
> in-statement, so there's an order dependence.
>

So to fix this we need to split up the processing for "in", so that blocks and 
macros are processed first?

Jim

-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
