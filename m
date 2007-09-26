Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l8QDJLE6000323
	for <selinux@tycho.nsa.gov>; Wed, 26 Sep 2007 09:19:21 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l8QDJJ8B005310
	for <selinux@tycho.nsa.gov>; Wed, 26 Sep 2007 13:19:20 GMT
Message-ID: <46FA5C3F.6010202@manicmethod.com>
Date: Wed, 26 Sep 2007 09:18:55 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Paul Moore <paul.moore@hp.com>
CC: James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov
Subject: Re: [RFC PATCH 0/2] Series short description
References: <20070925203856.13699.90782.stgit@flek.americas.hpqcorp.net> <200709251838.58272.paul.moore@hp.com> <46F9C1C6.7090709@manicmethod.com> <200709252312.46945.paul.moore@hp.com>
In-Reply-To: <200709252312.46945.paul.moore@hp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Paul Moore wrote:
> On Tuesday 25 September 2007 10:19:50 pm Joshua Brindle wrote:
>   
>> It seems like we've gotten versioning of the policy wrong if this sort
>> of thing is necessary (two separate, slightly related version numbers).
>>     
>
> I don't think it's necessary to have these two version numbers, as Eric 
> pointed out earlier the existing policy version would work.  While I don't 
> have my "History of SELinux" book in front of me right now to know the 
> original intent of the policy version number, it appears to have been used to 
> signify policy capabilities on more than one occasion.
>
>   

Yes.

>> A while back someone (I can't remember if it was me or not) suggested a
>> bitmap of policy capabilities that would be determined at compile time
>> (eg., does this policy have conditional expressions? turn that bit on.
>> Does this policy use class foo? turn that bit on, etc). Why is your
>> version scheme better than something like that?
>>     
>
> Well, like I said earlier, forget the versioning scheme I proposed.  However, 
> for the sake or argument one advantage that I can see to a version number or 
> a capability bitmap (it would most likely need to be an ebitmap to allow for 
> future growth) is that it is much easier/quicker to check in the security 
> server.  Comparing two integers is much faster then checking for a single bit 
> in an ebitmap.
>
>   

Meh, optimizations are easy.

int reconcile_peersids = ebitmap_get_bit(pol->capability_map, PEERSID_BIT);

do this at policy read time for anything that needs fast comparisons.

> That said, I agree that your idea of a policy capability bitmap is interesting 
> and would allow a lot of flexibility.  I'm just not sure the implementation 
> would be practical, but then again, you have much more experience in the 
> policy compiler/toolchain than I do.
>
>   

Alot more practical than the policy version comparisons that are there 
now (and once again, this strangeness with stacking of capabilities, 
ipv6 implies boolean support, fine grained netlink classes imply ipv6 
support, etc)


>>> Eric suggested using the policy version to achieve the same thing; if no
>>> one objects to using the policy version number for this purpose I'm more
>>> than happy to use it.
>>>       
>> The more we use the policy version number for things like this the worse
>> the reader (and compiler) get. I agree with the idea of having something
>> separate, I just don't think another version number is the answer.
>>     
>
> Ideally we would be able to speed up both the security server and the 
> compiler/parser, but if I had to pick only one I would choose to speed up the 
> security server.
>
> >From what I can see the policy version number has been abused several times to 
> signify new capabilities within the policy.  Using the policy version to 
> signal a shift in the network access controls seems like an acceptable thing 
> to me based on this history.  However, I understand your concerns that this 
> is an _abuse_ of the policy version concept and continuing down this road is 
> only going to cause more and more problems in the policy compiler/parser.  
> The capability bitmap is initially attractive but I fear it will introduce 
> too much additional overhead in the security server.
>
> I'm not quite sure where this leaves us, but I would like to work towards 
> resolving this somehow ...
>   

Its been abused like that many times, and it may again. One benefit of 
the bitmap is that it would allow us to turn off features we aren't 
using, even if the format supports it. For example, if I'm building a 
real time system without conditional policy wouldn't it be nice to not 
waste time checking the conditional avtab? Or if its non-mls we could 
just skip checking those constraints altogether.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
