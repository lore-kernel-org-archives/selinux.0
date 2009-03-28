Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n2S5q6Qx008896
	for <selinux@tycho.nsa.gov>; Sat, 28 Mar 2009 01:52:06 -0400
Received: from smtp101.prem.mail.sp1.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id n2S5q50S003900
	for <selinux@tycho.nsa.gov>; Sat, 28 Mar 2009 05:52:05 GMT
Message-ID: <49CDBB04.8090002@schaufler-ca.com>
Date: Fri, 27 Mar 2009 22:52:04 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Glenn Faden <Glenn.Faden@sun.com>
CC: Jarrett Lu <Jarrett.Lu@sun.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        labeled-nfs@linux-nfs.org, nfs-discuss@opensolaris.org,
        selinux@tycho.nsa.gov, nfsv4@ietf.org
Subject: Re: [Labeled-nfs] [nfsv4] New MAC label support Internet Draft posted
 to IETF	website
References: <1232651815.24537.15.camel@moss-terrapins.epoch.ncsc.mil> <49C9F0E1.1040202@sun.com> <20090325163317.GV9992@Sun.COM> <49CB4A18.3090709@sun.com> <20090326150934.GR9992@Sun.COM> <49CBFB94.6030408@sun.com> <20090327001102.GU9992@Sun.COM> <1238158539.15207.6.camel@localhost.localdomain> <1238160162.15207.19.camel@localhost.localdomain> <49CD06E7.6030802@sun.com> <49CD9A7D.6070207@schaufler-ca.com> <49CDB2B6.7090509@sun.com>
In-Reply-To: <49CDB2B6.7090509@sun.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Glenn Faden wrote:
> Casey Schaufler wrote:
>> Jarrett Lu wrote:      
>>> I agree with your statements on TE vs. MLS/BLP. The problem we try
>>> to solve is whether a DOI field + an opaque string is sufficient to
>>> solve the interoperability problem.
>>>     
>>
>> It is not. Two SELinux systems of the same version of the same
>> operating system may have different and incompatible policies.
>> Domains with the exact same name, intended for the exact same
>> purpose, may include MLS on one and MCS on the other, have
>> identical on wire representation of the labels, and still not
>> inter operate in any sane way. The same is true for Smack, where
>> the label Fish can be treated very differently on two adjacent
>> boxes. Any system that relies on opaque data is going to
>> have this problem, which is why the 1980's attempt at CIPSO
>> went down in flames.
>>   
> Casey I agree with you up to the last sentence. CIPSO was invented in
> the early 90's 

Nope. Gary Winnegar (spelling?) had proposals out to TSIG by 1987.
That version was rejected out of hand.

> and is still in use today by multiple vendors.

The current version differs in that it is less flexible than
the original, and that is precisely aimed at IETF acceptability.

> CALIPSO is essentially an IPv6 version of CIPSO.
>
> I think your point is that neither CIPSO nor CALIPSO can be used to
> represent SELinux security contexts. If so, that should be obvious.

Actually, no. Either can be, provided the machines on both ends
have identical policy. The point is that you can't count on it
based on the information available.

>
> Your assertion that it is required for the client and server  to have
> the same policies and OS versions is generally true, although each
> system would be expected to refuse to deal with any types that is
> doesn't understand. The opportunity for misunderstanding seems likely.
> I have an additional concern how different systems, like SELinux and
> Solaris with FMAC will handle each other's security contexts. Even if
> their policies use the same types, roles, MLS labels, etc, the
> implementation details, like privileges vs. capabilities, will
> probably differ.
>>  
>>>  My opinion is that it's insufficient as it doesn't take the "how to
>>> interpret MAC attribute agreement among all communicating peers"
>>> into account. The current proposal seems to assume when a node sees
>>> a DOI value of 5, it knows how to interpret the opaque field. This
>>> may not be true. In MLS, one also needs to know which agreed upon
>>> label encoding file to use in order to interpret label in the opaque
>>> filed. I believe the same is true for TE -- one needs to know the
>>> security policy being used in order to correctly interpret security
>>> context string in the opaque field. DOI + opaque field doesn't say
>>> which label encoding scheme or which security policy.
>>>       
>>
>> Common label encoding isn't sufficient either. Consider two
>> computers, one encoded for DoD labels and the other for DoE
>> labels. Both use SECRET, and any attempt to translate between
>> the two will undoubtedly match them up even though they are
>> very different. The Mitre encoding scheme doesn't solve the
>> problem either, which is evident by the fact we're still
>> discussing the issue today.
>>
>> What will work is the real question. The only notion I've seen
>> that really addresses the issue has been rejected many times
>> for the simple reason that it's too hard to administer. It
>> requires that each system have a map of all labels that it
>> expects to see from a given peer and their corresponding local
>> representations. Whoever figures out a reasonable way to go
>> about doing this gets a beer from me.
>>
>>   
> In ancient times (the 1990s), trusted systems used to try to
> interoperate using the TSIX protocol. For those who want the history
> lesson here are the SGI and Sun docs:
>
> http://techpubs.sgi.com/library/tpl/cgi-bin/getdoc.cgi?coll=0650&db=man&fname=/usr/share/catman/a_man/cat7/trusted_networking.z
>
>
> http://docs.sun.com/app/docs/doc/816-1048/6m7gaddhs?a=view
>

Think IPSEC designed by people who thought B2 and CMW were good ideas.

> Sun dropped support for TSIX after all the other vendors withdrew from
> the market. The TSIX implementation was a mess, but it attempted to
> map one vendor's security attributes, e.g. privileges, into its own
> notion, e.g. capabilities. Labels were sent as strings and translated
> into local formats, as well. We sort of got it to work with Digital's
> MLS system, but everybody eventually fell back to CIPSO.

Yup.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
