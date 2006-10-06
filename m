Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k96Aks3o020359
	for <selinux@tycho.nsa.gov>; Fri, 6 Oct 2006 06:46:54 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k96AjfQx012839
	for <selinux@tycho.nsa.gov>; Fri, 6 Oct 2006 10:45:42 GMT
Message-ID: <45263417.8050602@tresys.com>
Date: Fri, 06 Oct 2006 06:46:47 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
CC: selinux@tycho.nsa.gov, redhat-lspp@redhat.com
Subject: Re: Networking policy patch
References: <45232276.2080105@trustedcs.com> <452551B2.70307@tresys.com>
In-Reply-To: <452551B2.70307@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> <snip>

> Ok, this may be an unpopular email but I was going over how everything 
> (sans netlabel) was working as of right now (as I understand it) and I 
> came across some things that seem strange. Maybe my understanding is 
> wrong...
>
> Basically I was trying the most complex situation (which includes 
> socket labels that are different from the domain).
> spd 1 is  ipsec_spd_t.
> domain 1 is pms_proxy_t
> socket 1 is sysadm_t (via setsockcreatecon)
> secmark 1 is pms_c_p_t
>
> spd 2 is ipsec_spd2_t
> domain 2 is inetd_t
> socket 2 is pms_t
> secmark 2 is pms_s_p_t
>
> therefore SA 1 is pms_t and SA 2 is sysadm_t
>
> So here are the rules I came up with
> side1:
> allow pms_proxy_t pms_c_p_t : packet { send recv }
> - straightforward, already how secmark works
> allow sysadm_t pms_t : packet { flow_in flow_out }
> - don't understand this, pms_t isn't a packet object, why are we using 
> the packet object class?
Er, I totally messed this up, it should have been
allow pms_t pms_c_p_t : packet { flow_in flow_out } which has the 
correct object class, not sure what I was thinking
> allow pms_proxy_t ipsec_spd_t : association { polmatch }
> - likewise, an spd isn't an association, maybe this class needs to be 
> more generic
this one still applies but its an aesthetic thing and I suppose noone is 
going to want to rename the object class
> allow pms_proxy_t pms_t : association { sendto recvfrom }
> - Not sure if this one is right, is the source suppose to be the 
> domain or the socket?
>
This is domain, right?



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
