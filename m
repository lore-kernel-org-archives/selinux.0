Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n2S3XJvD001636
	for <selinux@tycho.nsa.gov>; Fri, 27 Mar 2009 23:33:19 -0400
Received: from smtp110.prem.mail.sp1.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with SMTP id n2S3TKcf029093
	for <selinux@tycho.nsa.gov>; Sat, 28 Mar 2009 03:29:20 GMT
Message-ID: <49CD9A7D.6070207@schaufler-ca.com>
Date: Fri, 27 Mar 2009 20:33:17 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Jarrett Lu <Jarrett.Lu@sun.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, labeled-nfs@linux-nfs.org,
        nfs-discuss@opensolaris.org, selinux@tycho.nsa.gov, nfsv4@ietf.org
Subject: Re: [Labeled-nfs] [nfsv4] New MAC label support Internet Draft posted
 to IETF	website
References: <1232651815.24537.15.camel@moss-terrapins.epoch.ncsc.mil>	<49C9F0E1.1040202@sun.com> <20090325163317.GV9992@Sun.COM>	<49CB4A18.3090709@sun.com> <20090326150934.GR9992@Sun.COM>	<49CBFB94.6030408@sun.com> <20090327001102.GU9992@Sun.COM>	<1238158539.15207.6.camel@localhost.localdomain>	<1238160162.15207.19.camel@localhost.localdomain> <49CD06E7.6030802@sun.com>
In-Reply-To: <49CD06E7.6030802@sun.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Jarrett Lu wrote:
> Stephen Smalley wrote:
>   
>> On Fri, 2009-03-27 at 08:55 -0400, Stephen Smalley wrote:
>>   
>>     
>>> On Thu, 2009-03-26 at 19:11 -0500, Nicolas Williams wrote:
>>>     
>>>       
>>>> On Thu, Mar 26, 2009 at 03:03:00PM -0700, Jarrett Lu wrote:
>>>>       
>>>>         
>>>>> CALIPSO spec doesn't tie a DOI with a particular label encoding. For 
>>>>>         
>>>>>           
>>>> CALIPSO is very specific about label domination -- that means that
>>>> having any application protocol w/ labeling above IP requires that we be
>>>> able to determine whether an application-level label is dominated by a
>>>> CALIPSO label, and the rules given are MLS with Bell-LaPadula.
>>>>
>>>> Perhaps that does not mean that we must adopt MLS and Bell-LaPadula at
>>>> the application layer, but it certainly seems like the easiest path,
>>>> particularly if we can also represent DTE that way.
>>>>       
>>>>         
>>> You can't represent Type Enforcement via MLS/BLP; TE is strictly more
>>> expressive than BLP, not the other way around.  It also has no inherent
>>> notion of dominance; the access matrix is explicitly defined and may
>>> include intransitive relationships, which are required for integrity
>>> goals and guaranteed invocation.
>>>     
>>>       
>> Also, in the case of SELinux and FMAC, the security context is more than
>> just a domain/type; it contains all of the security attributes relevant
>> to the security policy model, which in the case of the example security
>> server includes a user identity, a role, a domain/type, and a MLS range
>> (optionally just a single MLS level in the degenerate case where low ==
>> high).  But as far as the protocols are concerned, the entire security
>> context is just an opaque string.
>>
>>   
>>     
>
> I agree with your statements on TE vs. MLS/BLP. The problem we try to 
> solve is whether a DOI field + an opaque string is sufficient to solve 
> the interoperability problem.

It is not. Two SELinux systems of the same version of the same
operating system may have different and incompatible policies.
Domains with the exact same name, intended for the exact same
purpose, may include MLS on one and MCS on the other, have
identical on wire representation of the labels, and still not
inter operate in any sane way. The same is true for Smack, where
the label Fish can be treated very differently on two adjacent
boxes. Any system that relies on opaque data is going to
have this problem, which is why the 1980's attempt at CIPSO
went down in flames.

>  My opinion is that it's insufficient as it 
> doesn't take the "how to interpret MAC attribute agreement among all 
> communicating peers" into account. The current proposal seems to assume 
> when a node sees a DOI value of 5, it knows how to interpret the opaque 
> field. This may not be true. In MLS, one also needs to know which agreed 
> upon label encoding file to use in order to interpret label in the 
> opaque filed. I believe the same is true for TE -- one needs to know the 
> security policy being used in order to correctly interpret security 
> context string in the opaque field. DOI + opaque field doesn't say which 
> label encoding scheme or which security policy.
>   

Common label encoding isn't sufficient either. Consider two
computers, one encoded for DoD labels and the other for DoE
labels. Both use SECRET, and any attempt to translate between
the two will undoubtedly match them up even though they are
very different. The Mitre encoding scheme doesn't solve the
problem either, which is evident by the fact we're still
discussing the issue today.

What will work is the real question. The only notion I've seen
that really addresses the issue has been rejected many times
for the simple reason that it's too hard to administer. It
requires that each system have a map of all labels that it
expects to see from a given peer and their corresponding local
representations. Whoever figures out a reasonable way to go
about doing this gets a beer from me.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
