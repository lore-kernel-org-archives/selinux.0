Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n2RIut3h023244
	for <selinux@tycho.nsa.gov>; Fri, 27 Mar 2009 14:56:55 -0400
Received: from sca-es-mail-2.sun.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n2RIuhps019257
	for <selinux@tycho.nsa.gov>; Fri, 27 Mar 2009 18:56:43 GMT
Received: from fe-sfbay-09.sun.com ([192.18.43.129])
	by sca-es-mail-2.sun.com (8.13.7+Sun/8.12.9) with ESMTP id n2RIug4g012413
	for <selinux@tycho.nsa.gov>; Fri, 27 Mar 2009 11:56:42 -0700 (PDT)
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Received: from conversion-daemon.fe-sfbay-09.sun.com by fe-sfbay-09.sun.com
 (Sun Java(tm) System Messaging Server 7.0-5.01 64bit (built Feb 19 2009))
 id <0KH600000HREW700@fe-sfbay-09.sun.com> for selinux@tycho.nsa.gov; Fri,
 27 Mar 2009 11:56:42 -0700 (PDT)
Date: Fri, 27 Mar 2009 11:56:41 -0700
From: Jarrett Lu <Jarrett.Lu@Sun.COM>
Subject: Re: [nfsv4] [Labeled-nfs] New MAC label support Internet Draft posted
 to IETF	website
In-reply-to: <20090327172632.GA9992@Sun.COM>
To: Nicolas Williams <Nicolas.Williams@Sun.COM>
Cc: labeled-nfs@linux-nfs.org, nfs-discuss@opensolaris.org,
        selinux@tycho.nsa.gov, nfsv4@ietf.org
Message-id: <49CD2169.3080209@sun.com>
References: <1232651815.24537.15.camel@moss-terrapins.epoch.ncsc.mil>
 <49C9F0E1.1040202@sun.com> <20090325163317.GV9992@Sun.COM>
 <49CB4A18.3090709@sun.com> <20090326150934.GR9992@Sun.COM>
 <49CBFB94.6030408@sun.com> <20090327001102.GU9992@Sun.COM>
 <1238158539.15207.6.camel@localhost.localdomain>
 <1238160162.15207.19.camel@localhost.localdomain> <49CD06E7.6030802@sun.com>
 <20090327172632.GA9992@Sun.COM>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Nicolas Williams wrote:
> On Fri, Mar 27, 2009 at 10:03:35AM -0700, Jarrett Lu wrote:
>   
>> I agree with your statements on TE vs. MLS/BLP. The problem we try to 
>> solve is whether a DOI field + an opaque string is sufficient to solve 
>> the interoperability problem. My opinion is that it's insufficient as it 
>> doesn't take the "how to interpret MAC attribute agreement among all 
>> communicating peers" into account. The current proposal seems to assume 
>> when a node sees a DOI value of 5, it knows how to interpret the opaque 
>> field. This may not be true. In MLS, one also needs to know which agreed 
>> upon label encoding file to use in order to interpret label in the 
>> opaque filed. I believe the same is true for TE -- one needs to know the 
>> security policy being used in order to correctly interpret security 
>> context string in the opaque field. DOI + opaque field doesn't say which 
>> label encoding scheme or which security policy.
>>     
>
> What would you add or remove on the wire to solve this problem?  My
> guess: a registry of per-DOI rules, like CALIPSO does.  I don't think a
> registry of DOI rules is strictly necessary for NFS (though I can see
> how it helps in the case of IP), but I certainly don't object.
>   

I don't yet see a good way to solve this problem using bits on the wire. 
The agreement on what label encodings or security policy to use seems 
better solved in an out of band manner. For example, on a (secure) 
website, you can say "download this label encoding file or configure 
your MAC system with this policy and use DOI number 5. Then we can talk".

BTW, CALIPSO with IP module has the same issue. While the spec talks a 
lot about how a CALIPSO  system should behave, CALIPSO can't tell its 
peers to use a particular label encoding. That's done outside CALIPSO.

I believe it's still worthwhile to request adding a DOI + an opaque 
field in NFSv4 protocol. The spec should be clear that other 
arrangements need to be made before interoperability can take place.

Once we decouple DOI from how the opaque field should be interpreted, 
it's possible for NFSv4 to use CALIPSO DOI. For example, DOD can reserve 
DOI 1000 through 1005. It can then decide that 1000 is only used by MLS 
systems with a particular label encoding; and 1004 is for TE systems 
configured with a particular secular security policy. As long as all 
systems using these DOIs agreeing to that, they can communicate with 
each other. But the agreement happens outside NFSv4 protocol itself. I 
understand this is different from the public internet where all you need 
is an IP address to communicate. But this is how MAC systems are used, I 
believe.

CALIPSO spec has considerations in how routers can support DOI and MLS 
labels. I don't believe that affects or harms NFSv4 in anyway, as 
routers won't look at NFSv4 stuff.


Jarrett


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
