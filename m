Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9QIpUvv008968
	for <selinux@tycho.nsa.gov>; Thu, 26 Oct 2006 14:51:30 -0400
Received: from atlrel6.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9QInwW7010846
	for <selinux@tycho.nsa.gov>; Thu, 26 Oct 2006 18:49:58 GMT
Message-ID: <454103A5.5080902@hp.com>
Date: Thu, 26 Oct 2006 14:51:17 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@redhat.com>
Subject: Re: socket options ... again
References: <4540E083.2030304@hp.com>	 <1161881175.16681.239.camel@moss-spartans.epoch.ncsc.mil>	 <4540EEFF.4080606@hp.com> <1161885634.16681.274.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1161885634.16681.274.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Thu, 2006-10-26 at 13:23 -0400, Paul Moore wrote:
> 
>>Stephen Smalley wrote:
>>
>>>On Thu, 2006-10-26 at 12:21 -0400, Paul Moore wrote:
>>>
>>>
>>>>Thoughts on these options?  Can anyone else think of a better solution?
>>>
>>>ip_options_compile() checks CAP_NET_RAW for IPOPT_SEC, IPOPT_SID, and
>>>any unknown options.  Is there a reason to not do likewise for setting
>>>IPOPT_CIPSO from userspace (which you need to distinguish in some manner
>>>from your internal setting)?
>>
>>Ah ha ... thank you for the lightbulb moment.
>>
>>Adding CAP_NET_RAW in ip_options_compile() would solve the problem in a manner
>>which makes the most sense from an application point of view.  However, it does
>>present a problem in that potentially even applications without CAP_NET_RAW will
>>need to have a CIPSO options set by the kernel, as you noted in the comment
>>about distinguishing between NetLabel and applications.
>>
>>Right now the CIPSO code only makes use of ip_options_compile() in two places
>>(that I can think of): the first is when a packet enters the system via
>>ip_rcv_options() in ip_rcv_finish(), the second when a socket is created by an
>>application and cipso_v4_socket_setattr() is called.  I don't believe
>>CAP_NET_RAW should be an issue in the first case (please correct me if I'm
>>wrong) but it would cause problems in the second case.  Considering the blank
>>slate of a new socket and the very simple nature of the CIPSO code in
>>ip_options_compile() it may be the best option is to simply handle the
>>ip_options_compile() tasks directly in cipso_v4_socket_setattr().
>>
>>Does this sound reasonable?
> 
> To clarify, the existing capable checks in ip_options_compile() are only
> applied on the output processing (they check for a NULL skb), never on
> the input side.

Yep.

> It seems like your internal use of ip_options_compile() from cipso is
> overkill, since it then just calls back into your cipso code for the
> CIPSO option, right?  So just handling it directly within the cipso code
> makes sense to me.

Yes, you are right there is a lot of unnecessary stuff there; its a bit of a
holdover from the initial code which used ip_options_get().  The original
thought was that since it wasn't really a critical path it was probably better
to reuse what was there even if it was slower.

I'm working on a patch now which I should have out in a few hours.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
