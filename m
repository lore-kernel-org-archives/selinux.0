Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l8Q2KB7J020165
	for <selinux@tycho.nsa.gov>; Tue, 25 Sep 2007 22:20:11 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l8Q2K9YZ025228
	for <selinux@tycho.nsa.gov>; Wed, 26 Sep 2007 02:20:09 GMT
Message-ID: <46F9C1C6.7090709@manicmethod.com>
Date: Tue, 25 Sep 2007 22:19:50 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Paul Moore <paul.moore@hp.com>
CC: James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov
Subject: Re: [RFC PATCH 0/2] Series short description
References: <20070925203856.13699.90782.stgit@flek.americas.hpqcorp.net> <Xine.LNX.4.64.0709251525260.26141@us.intercode.com.au> <200709251838.58272.paul.moore@hp.com>
In-Reply-To: <200709251838.58272.paul.moore@hp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Paul Moore wrote:
> On Tuesday 25 September 2007 6:28:48 pm James Morris wrote:
>   
>> On Tue, 25 Sep 2007, Paul Moore wrote:
>>     
>>> This patchset has two patches in it which I would like to get some
>>> feedback on.  The first patch adds a functionality/compatability version
>>> number to the policy so that we can add new functionality to the kernel
>>> which would lie dormant until the correct policy was loaded - it is not
>>> intended to replace Eric's undefined classes/perms work but to compliment
>>> it.
>>>       
>> Can you explain the expected usage scenarios for this?
>>     
>
> The one example that springs immediately to mind is the two separate checks 
> for peer labels (one for NetLabel, one for labeled IPsec) in 
> selinux_sock_rcv_skb().  As discussed on the list, we would like to move to a 
> single check for the peer label.  Unfortunately, this runs into problems with 
> backwards compatibility with people using old policy on new kernels.  The 
> idea here was that the kernel would have code for both types of access 
> control and depending on the policy loaded it would select which type of 
> access control to use.
>
>   
>> We already have versioning of policy, and will have the ability to reject,
>> ignore or enforce unknown elements, so why do we need this and how would
>> it typically be used?
>>     

It seems like we've gotten versioning of the policy wrong if this sort 
of thing is necessary (two separate, slightly related version numbers). 
A while back someone (I can't remember if it was me or not) suggested a 
bitmap of policy capabilities that would be determined at compile time 
(eg., does this policy have conditional expressions? turn that bit on. 
Does this policy use class foo? turn that bit on, etc). Why is your 
version scheme better than something like that? Granted we'd have a 
limited number of bits (or an ebitmap). I don't know how well this would 
work in practice, conditional policy, for example, still changes to 
policy binary format so the reader needs to know that and read the 
additional avtab.

It might serve to make the format a little more flexible though, instead 
of having policy format changes stack on top of each other the 
functionality bitmap would be checked to see if it should read, for 
example, the additional MLS bits. Right now even if MLS is turned off 
the mls parts of the reader are called just because the policy version 
is above POLICYDB_VERSION_MLS, and not because mls is really enabled in 
the policy. This is true for basically all the format versions we 
currently support.

This might be really hard to support previous versions of policy on 
newer kernels but I think its certainly worth thinking about.

Just for reference, the first bitmap entries would be:
conditional policy,
ipv6 support in network contexts,
separate netlink classes,
new mls support,
compressed avtab support,
new mls rangetrans support;

I think a functionality bitmap would cover those all fine, if the newer 
netlink classes are present and used that bit would flip on and the 
hooks would use them, if it's off the hooks would use the old netlink 
class. If the avtab compression bit is on the reader would read the 
reverse attr lookup tables, if not it wouldn't, etc.

> Eric suggested using the policy version to achieve the same thing; if no one 
> objects to using the policy version number for this purpose I'm more than 
> happy to use it.
>
>   

The more we use the policy version number for things like this the worse 
the reader (and compiler) get. I agree with the idea of having something 
separate, I just don't think another version number is the answer.

>> Should we instead start thinking about versioning each permission & class?
>> i.e. create a fully versioned interface
>>     
>
> This question nags at me, but I keep ignoring it because I fear that a fully 
> versioned avc interface would be overkill in the majority of cases and only 
> serve to slow down the access checks.
>   

I don't think it solves the problem, of the versions I've listed the 
only one this might help with is the netlink object classes.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
