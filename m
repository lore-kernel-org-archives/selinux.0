From: "Langland, Blake" <blangland@integrity-apps.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: RE: MLS over loopback interface
Date: Thu, 10 Oct 2013 20:34:36 +0000
Message-ID: <DA8D339A60101247B36E202899B1C93AA919DF@CHUNEX01.integrity-apps.com>
References: <DA8D339A60101247B36E202899B1C93AA91986@CHUNEX01.integrity-apps.com>
 <5256F9D4.6080901@tycho.nsa.gov>
In-Reply-To: <5256F9D4.6080901@tycho.nsa.gov>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thanks for the replies. Here is an example of the AVC:

avc: denied { egress } for pid=2472 comm="java" saddr=192.168.25.102 src=60447 daddr=192.168.25.102 dest=8443 netif=lo scontext=user_s:user_r:user_java_t:s3 tcontext=system_u:object_r:lo_netif_t:s2 tclass=netif

(The opposite would be an ingress with user_java_t:s2 and lo_netif_t:s3)
Network peer labeling is netlabel.
Kernel Version: 2.6.32-279.el6.x86_64

I will try the suggestion of mls_net_write_within_range(), I'm still getting a hang of what uses the ranges have vs a single sensitivity.

Thanks again!
Blake




-----Original Message-----
From: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
Sent: Thursday, October 10, 2013 12:03 PM
To: Langland, Blake
Cc: selinux@tycho.nsa.gov
Subject: Re: MLS over loopback interface

On 10/10/2013 01:12 PM, Langland, Blake wrote:
> All,
> 
> I have two web servers running on an SELinux machine, one running at s2 and one at s3. Both webservers have two webapps each that are attempting to communicate over the loopback interface. The communication is strictly s2 <-> s2 and s3 <-> s3. The problem I am having is setting the MLS level of the loopback interface. If I have it set below s3, the s3 webapps cannot send over the interface; If I have it set higher than s2, the s2 webapps cannot receive over the interface. Any suggestions?

Can you clarify exactly what avc denials you are getting?
Kernel version?
network_peer_controls enabled or disabled?

I don't see a mlstrustedobject-like exemption in the netif constraints in refpolicy/policy/mls, so you can't just make the loopback netif type a mlstrustedobject to exempt it.

I do however see that if you apply mls_net_write_within_range() to the web server domains and if you put a range on the interface that covers both levels, then it should pass the mls constraint in policy/mls.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
