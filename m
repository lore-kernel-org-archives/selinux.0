Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n1DMONYN023278
	for <selinux@tycho.nsa.gov>; Fri, 13 Feb 2009 17:24:23 -0500
Received: from sca-es-mail-1.sun.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n1DMOKAu015310
	for <selinux@tycho.nsa.gov>; Fri, 13 Feb 2009 22:24:21 GMT
Received: from fe-sfbay-10.sun.com ([192.18.43.129])
	by sca-es-mail-1.sun.com (8.13.7+Sun/8.12.9) with ESMTP id n1DMOKYK005819
	for <selinux@tycho.nsa.gov>; Fri, 13 Feb 2009 14:24:20 -0800 (PST)
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Received: from conversion-daemon.fe-sfbay-10.sun.com by fe-sfbay-10.sun.com
 (Sun Java(tm) System Messaging Server 7.0-3.01 64bit (built Dec 23 2008))
 id <0KF000D00ZFR7900@fe-sfbay-10.sun.com> for selinux@tycho.nsa.gov; Fri,
 13 Feb 2009 14:24:20 -0800 (PST)
Date: Fri, 13 Feb 2009 14:24:16 -0800
From: Glenn Faden <Glenn.Faden@sun.com>
Subject: Re: [refpolicy] [PATCH] refpolicy: Add missing network related
 MLSconstraints
In-reply-to: <200902131702.10467.paul.moore@hp.com>
To: Paul Moore <paul.moore@hp.com>
Cc: chanson@TrustedCS.com, selinux@tycho.nsa.gov
Message-id: <4995F310.30307@sun.com>
References: <20090212211531.619341973@hp.com>
 <200902131544.42460.paul.moore@hp.com> <4995E83B.1040003@sun.com>
 <200902131702.10467.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Paul Moore wrote:
> On Friday 13 February 2009 04:38:03 pm Glenn Faden wrote:
>   
>> Paul Moore wrote:
>>     
>>> Why were network objects not subject to privilege overrides in
>>> legacy/traditional MLS systems?
>>>
>>> I ask because I think we are best off keeping the MLS constraints as
>>> consistent as possible.  If there is a sound reason for avoiding policy
>>> overrides for just the network controls than perhaps we should consider
>>> "fixing" the rest of the constraints and not just the new ones.
>>>       
>> I can provide a bit of history about some legacy systems. In Trusted
>> Solaris 8 there was a privilege, net_mac_read, that allowed a server to
>> accept connections from clients with labels it didn't dominate. In order
>> to reply, the server either needed to set the socket label to match the
>> incoming client's label, or assert the privilege net_reply_equal. There
>> was no corresponding net_mac_write privilege, because privilege programs
>> were expected to use the network API to set their socket labels
>> appropriately.
>>     
>
> Thanks, that is good to know.
>
>   
>> In Solaris Trusted Extensions, neither the net_mac_read, net_mac_write,
>> nor net_repy_equal privileges are implemented. It was viewed as a
>> weakness in Trusted Solaris that MAC could be overridden by privilege.
>> Instead, the administrator (who configures the system network policy)
>> can enumerate multilevel network ports, and appropriately privileged
>> services can bind to them.
>>     
>
> I assume by multilevel network ports you are talking about port 
> polyinstantiation and not a single (in every sense of the word) port that 
> allows a range of labels?
>   
Our terminology is different. Polyinstantiated ports are virtualized so 
that a single-level instance appears to exist at each label. Multilevel 
ports are TCB objects which can be used by privileged subjects to accept 
packets within an explicitly enumerated range of set of labels, 
determined by the administrator.
> If we assume polyports then I agree that it makes perfect sense to try and 
> work around the MLS constraints.  I wonder about some privileged apps but I 
> would need to think about that some more.
>   
An example of such a privileged application is Xorg.
>   
>> Since MLS constraints are relatively new to UNIX, there isn't a
>> compatibility requirement that the superuser should be able to override
>> it. So don't provide any more rope than you need to.
>>     
>
> Well, the MLS constraints aren't all that new to SELinux and several already 
> exist in the networking space (the patch above didn't create any new ones, 
> just used the existing constraints).  As I understand it, the SELinux 
> constraints are also quite different from the TSOL/TX privileges; I'll concede 
> that they are both rope, but I think the lengths are quite different ;)
>   
Agreed.
> Perhaps I'm missing something but I'm pretty sure that without any form of 
> polyports (I highly doubt we will see these anytime soon) we are going to 
> need/want network MLS constraint overrides.
>
>   
You'll need overrides, but probably not based on Posix capabilities.

--Glenn


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
