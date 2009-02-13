Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n1DLcCwS013068
	for <selinux@tycho.nsa.gov>; Fri, 13 Feb 2009 16:38:12 -0500
Received: from sca-es-mail-1.sun.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n1DLc8Au004737
	for <selinux@tycho.nsa.gov>; Fri, 13 Feb 2009 21:38:08 GMT
Received: from fe-sfbay-09.sun.com ([192.18.43.129])
	by sca-es-mail-1.sun.com (8.13.7+Sun/8.12.9) with ESMTP id n1DLc6kn000799
	for <selinux@tycho.nsa.gov>; Fri, 13 Feb 2009 13:38:07 -0800 (PST)
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Received: from conversion-daemon.fe-sfbay-09.sun.com by fe-sfbay-09.sun.com
 (Sun Java(tm) System Messaging Server 7.0-3.01 64bit (built Dec 23 2008))
 id <0KF000M00X6PQU00@fe-sfbay-09.sun.com> for selinux@tycho.nsa.gov; Fri,
 13 Feb 2009 13:38:06 -0800 (PST)
Date: Fri, 13 Feb 2009 13:38:03 -0800
From: Glenn Faden <Glenn.Faden@sun.com>
Subject: Re: [refpolicy] [PATCH] refpolicy: Add missing network related
 MLSconstraints
In-reply-to: <200902131544.42460.paul.moore@hp.com>
To: Paul Moore <paul.moore@hp.com>
Cc: chanson@TrustedCS.com, refpolicy@oss.tresys.com, selinux@tycho.nsa.gov
Message-id: <4995E83B.1040003@sun.com>
References: <20090212211531.619341973@hp.com>
 <170D6ABBBA770349AA49582A86FCED15BA0199@HAVOC.tcs-sec.com>
 <200902131544.42460.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Paul Moore wrote:
> On Friday 13 February 2009 02:36:17 pm chanson@trustedcs.com wrote:
>   
>> Traditionally network objects in a MLS system are not usually subject to
>> the usual privilege overrides. I would propose something like the below:
>>
>> mlsconstrain { netif } { egress ingress }
>> 	((( l1 dom l2 ) and ( l1 domby h2 )) or
>> 	 ( t1 == mlsnetflow ));
>> mlsconstrain { node } { recvfrom sendto }
>> 	((( l1 dom l2 ) and ( l1 domby h2 )) or
>> 	 ( t1 == mlsnetflow ));
>> mlsconstrain { packet } { forward_in forward_out }
>> 	((( l1 dom l2 ) and ( l1 domby h2 )) or
>> 	 ( t1 == mlsnetflow ));
>>
>> "mlsnetflow" would be a new attribute useful for special cases like
>> unlabeled_t or kernel_t.
>>     
>
> Why were network objects not subject to privilege overrides in 
> legacy/traditional MLS systems?
>
> I ask because I think we are best off keeping the MLS constraints as 
> consistent as possible.  If there is a sound reason for avoiding policy 
> overrides for just the network controls than perhaps we should consider 
> "fixing" the rest of the constraints and not just the new ones.
>   
I can provide a bit of history about some legacy systems. In Trusted 
Solaris 8 there was a privilege, net_mac_read, that allowed a server to 
accept connections from clients with labels it didn't dominate. In order 
to reply, the server either needed to set the socket label to match the 
incoming client's label, or assert the privilege net_reply_equal. There 
was no corresponding net_mac_write privilege, because privilege programs 
were expected to use the network API to set their socket labels 
appropriately.

In Solaris Trusted Extensions, neither the net_mac_read, net_mac_write, 
nor net_repy_equal privileges are implemented. It was viewed as a 
weakness in Trusted Solaris that MAC could be overridden by privilege. 
Instead, the administrator (who configures the system network policy) 
can enumerate multilevel network ports, and appropriately privileged 
services can bind to them.

Since MLS constraints are relatively new to UNIX, there isn't a 
compatibility requirement that the superuser should be able to override 
it. So don't provide any more rope than you need to.

--Glenn

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
