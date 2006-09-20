Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8K1ZboB029986
	for <selinux@tycho.nsa.gov>; Tue, 19 Sep 2006 21:35:37 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k8K1YeOn019495
	for <selinux@tycho.nsa.gov>; Wed, 20 Sep 2006 01:34:41 GMT
Message-ID: <45109ADE.8080402@tresys.com>
Date: Tue, 19 Sep 2006 21:35:26 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
CC: dwalsh@redhat.com, selinux@tycho.nsa.gov
Subject: Re: ipsec, netlabels, secmark- How about a little usability?
References: <36282A1733C57546BE392885C0618592015730E5@chaos.tcs.tcs-sec.com>
In-Reply-To: <36282A1733C57546BE392885C0618592015730E5@chaos.tcs.tcs-sec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Venkat Yekkirala wrote:
>> We have been having some meetings to discuss how we can use 
>> this stuff 
>> in the real world (IE Non MLS), and I think the current 
>> implementation 
>> is coming up short.  The discussions I have seen have talked 
>> about using 
>> getpeercon to look at the other end of the connections, but 
>> this is not 
>> in the spirit of SELinux where modification of the 
>> applications should 
>> not be necessary to secure the environment.
>>
>>     
>
>
> So, what happens if an externally labeled packet (e.g.: Labeled IPSec)
> comes in thru the above entry point? First of all, a check is made to
> see if a packet so labeled using IPSec (unlabeled if no IPSec) can
> "flow in" thru the "entry point". If it can, and if there's an
> IPSec label on the packet, a transition sid is computed between the
> "entry point" label and the IPSec label and the packet will be marked
> with this transition sid. The transition label will either be the IPSec
> label (default) or any other label as defined by SELinux policy transition
> rules.
>
>   
What if there are 2 external labels (ipsec and cipso) ?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
