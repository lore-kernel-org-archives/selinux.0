Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s3MJiubK029942
 for <selinux@tycho.nsa.gov>; Tue, 22 Apr 2014 15:44:56 -0400
Message-ID: <5356C6AA.5030009@tresys.com>
Date: Tue, 22 Apr 2014 15:44:42 -0400
From: Steve Lawrence <slawrence@tresys.com>
MIME-Version: 1.0
To: Dominick Grift <dominick.grift@gmail.com>
Subject: Re: [secilc] typeattributeset with "and" expression does not work
References: <1398189362.16991.6.camel@x220.localdomain>	
 <5356BD03.40501@tresys.com> <1398195193.16991.12.camel@x220.localdomain>
In-Reply-To: <1398195193.16991.12.camel@x220.localdomain>
Content-Type: text/plain; charset="UTF-8"
Cc: selinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/22/2014 03:33 PM, Dominick Grift wrote:
> On Tue, 2014-04-22 at 15:03 -0400, Steve Lawrence wrote:
>> On 04/22/2014 01:56 PM, Dominick Grift wrote:
>>> (type foo)
>>> (typeattribute bar)
>>> (typeattribute baz)
>>> (typeattributeset bar (and baz foo))
>>>
>>> It compiles but neither bar, nor baz gets associated with type foo
>>>
>>
>> This is because 'and' is similar to the set intersection of baz and foo.
>> But baz is empty, so the intersection of baz and foo is nothing,
>> resulting in nothing being added to the bar attribute.
>>
>> You probably want the union of baz and foo? Replacing 'and' with 'or'
>> would make it so bar would be associated with foo and everything
>> associated with baz.
> 
> Impressive, what i am looking for is actually very simple.
> 
> I just want to know how i can associate more than a single type
> attribute to a specified type in a single statement, that is possible.
> 
> (type foo)
> (typeattribute bar)
> (typeattribute baz)
> 
> The equivalent of:
> 
> (typeattributeset bar foo)
> (typeattributeset baz foo)
> 
> In a single statement instead of two
> 

Unfortunately, there is no way to associate a single type/attribute with
multiple attributes in a single statement. CIL is a pretty verbose language.

>>> Also, i still have that weird boolean issue where, even though sesearch
>>> shows the rules are loaded and enabled, SELinux still blocks the access
>>
>> I think we actually fixed this about an hour ago. Give it a shot, let us
>> know if it's actually fixed.
> 
> Nice, i will try with up-to-date secilc tomorrow
> 
>> Thanks for the feedback!
>> - Steve
>>
>>
> 
> 
