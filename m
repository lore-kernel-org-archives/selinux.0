Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k95IefDG029991
	for <selinux@tycho.nsa.gov>; Thu, 5 Oct 2006 14:40:41 -0400
Received: from twoface.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k95IdShL025663
	for <selinux@tycho.nsa.gov>; Thu, 5 Oct 2006 18:39:28 GMT
Message-ID: <452551B2.70307@tresys.com>
Date: Thu, 05 Oct 2006 14:40:50 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
CC: selinux@tycho.nsa.gov, redhat-lspp@redhat.com
Subject: Re: Networking policy patch
References: <45232276.2080105@trustedcs.com>
In-Reply-To: <45232276.2080105@trustedcs.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Venkat Yekkirala wrote:
> FYI- I have posted the following patches separate from this one.
>
> 1. A patch to address the "leask" issue. Once verified, it needs
> to be rolled in with James' patch and sent on after verification.
>
> 2. A fix for flow_in and flow_out where we were using the unlabeled
>    init sid. We would now use a new network_t with a range of (s0-s15...)
>    to allow for mls traffic to flow out/in, in the absence of explicit secmark
>    rules.
>
>
> The following is a sample patch for networking using the new controls
> in conjunction with secmark.
>
> NOTE FOR JOSHUA: This patch also defines the constraints to force context
> equality for association:sendto.
>
> I couldn't readily figure out where to stick these in, but these would
> help the system come up without any denials.
>
>   
Ok, this may be an unpopular email but I was going over how everything 
(sans netlabel) was working as of right now (as I understand it) and I 
came across some things that seem strange. Maybe my understanding is 
wrong...

Basically I was trying the most complex situation (which includes socket 
labels that are different from the domain).
spd 1 is  ipsec_spd_t.
domain 1 is pms_proxy_t
socket 1 is sysadm_t (via setsockcreatecon)
secmark 1 is pms_c_p_t

spd 2 is ipsec_spd2_t
domain 2 is inetd_t
socket 2 is pms_t
secmark 2 is pms_s_p_t

therefore SA 1 is pms_t and SA 2 is sysadm_t

So here are the rules I came up with
side1:
allow pms_proxy_t pms_c_p_t : packet { send recv }
 - straightforward, already how secmark works
allow sysadm_t pms_t : packet { flow_in flow_out }
 - don't understand this, pms_t isn't a packet object, why are we using 
the packet object class?
allow pms_proxy_t ipsec_spd_t : association { polmatch }
 - likewise, an spd isn't an association, maybe this class needs to be 
more generic
allow pms_proxy_t pms_t : association { sendto recvfrom }
 - Not sure if this one is right, is the source suppose to be the domain 
or the socket?

side2:
allow inetd_t pms_s_p_t : packet {send recv }
allow pms_t sysadm_t : packet { flow_in flow_out }
allow inetd_t ipsec_spd2_t : association { polmatch }
allow inetd_t sysadm_t : association { sendto recvfrom }


do these rules seem correct given the scenerio above?

If so there seems to be some object class confusion.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
