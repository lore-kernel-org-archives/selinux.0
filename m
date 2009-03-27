MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Date: Fri, 27 Mar 2009 10:03:35 -0700
From: Jarrett Lu <Jarrett.Lu@sun.com>
Subject: Re: [Labeled-nfs] [nfsv4] New MAC label support Internet Draft posted
 to IETF	website
In-reply-to: <1238160162.15207.19.camel@localhost.localdomain>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, labeled-nfs@linux-nfs.org,
        nfs-discuss@opensolaris.org, nfsv4@ietf.org
Message-id: <49CD06E7.6030802@sun.com>
References: <1232651815.24537.15.camel@moss-terrapins.epoch.ncsc.mil>
 <49C9F0E1.1040202@sun.com> <20090325163317.GV9992@Sun.COM>
 <49CB4A18.3090709@sun.com> <20090326150934.GR9992@Sun.COM>
 <49CBFB94.6030408@sun.com> <20090327001102.GU9992@Sun.COM>
 <1238158539.15207.6.camel@localhost.localdomain>
 <1238160162.15207.19.camel@localhost.localdomain>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Fri, 2009-03-27 at 08:55 -0400, Stephen Smalley wrote:
>   
>> On Thu, 2009-03-26 at 19:11 -0500, Nicolas Williams wrote:
>>     
>>> On Thu, Mar 26, 2009 at 03:03:00PM -0700, Jarrett Lu wrote:
>>>       
>>>> CALIPSO spec doesn't tie a DOI with a particular label encoding. For 
>>>>         
>>> CALIPSO is very specific about label domination -- that means that
>>> having any application protocol w/ labeling above IP requires that we be
>>> able to determine whether an application-level label is dominated by a
>>> CALIPSO label, and the rules given are MLS with Bell-LaPadula.
>>>
>>> Perhaps that does not mean that we must adopt MLS and Bell-LaPadula at
>>> the application layer, but it certainly seems like the easiest path,
>>> particularly if we can also represent DTE that way.
>>>       
>> You can't represent Type Enforcement via MLS/BLP; TE is strictly more
>> expressive than BLP, not the other way around.  It also has no inherent
>> notion of dominance; the access matrix is explicitly defined and may
>> include intransitive relationships, which are required for integrity
>> goals and guaranteed invocation.
>>     
>
> Also, in the case of SELinux and FMAC, the security context is more than
> just a domain/type; it contains all of the security attributes relevant
> to the security policy model, which in the case of the example security
> server includes a user identity, a role, a domain/type, and a MLS range
> (optionally just a single MLS level in the degenerate case where low ==
> high).  But as far as the protocols are concerned, the entire security
> context is just an opaque string.
>
>   

I agree with your statements on TE vs. MLS/BLP. The problem we try to 
solve is whether a DOI field + an opaque string is sufficient to solve 
the interoperability problem. My opinion is that it's insufficient as it 
doesn't take the "how to interpret MAC attribute agreement among all 
communicating peers" into account. The current proposal seems to assume 
when a node sees a DOI value of 5, it knows how to interpret the opaque 
field. This may not be true. In MLS, one also needs to know which agreed 
upon label encoding file to use in order to interpret label in the 
opaque filed. I believe the same is true for TE -- one needs to know the 
security policy being used in order to correctly interpret security 
context string in the opaque field. DOI + opaque field doesn't say which 
label encoding scheme or which security policy.


Jarrett

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
