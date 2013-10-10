Message-ID: <525710C7.2010901@tycho.nsa.gov>
Date: Thu, 10 Oct 2013 16:40:39 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: "Langland, Blake" <blangland@integrity-apps.com>
CC: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Re: MLS over loopback interface
References: <DA8D339A60101247B36E202899B1C93AA91986@CHUNEX01.integrity-apps.com> <5256F9D4.6080901@tycho.nsa.gov> <DA8D339A60101247B36E202899B1C93AA919DF@CHUNEX01.integrity-apps.com>
In-Reply-To: <DA8D339A60101247B36E202899B1C93AA919DF@CHUNEX01.integrity-apps.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 10/10/2013 04:34 PM, Langland, Blake wrote:
> Thanks for the replies. Here is an example of the AVC:
> 
> avc: denied { egress } for pid=2472 comm="java" saddr=192.168.25.102 src=60447 daddr=192.168.25.102 dest=8443 netif=lo scontext=user_s:user_r:user_java_t:s3 tcontext=system_u:object_r:lo_netif_t:s2 tclass=netif
> 
> (The opposite would be an ingress with user_java_t:s2 and lo_netif_t:s3)
> Network peer labeling is netlabel.
> Kernel Version: 2.6.32-279.el6.x86_64
> 
> I will try the suggestion of mls_net_write_within_range(), I'm still getting a hang of what uses the ranges have vs a single sensitivity.

So, then you also need to make the interface ranged rather than
single-level, e.g. s2-s3 or s0-s15:c0.c1024 if you want it to cover
everything.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
