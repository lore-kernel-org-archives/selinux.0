Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k94J4n9u028310
	for <selinux@tycho.nsa.gov>; Wed, 4 Oct 2006 15:04:49 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k94J4DUx019863
	for <selinux@tycho.nsa.gov>; Wed, 4 Oct 2006 19:04:14 GMT
Message-ID: <452405C8.6080002@redhat.com>
Date: Wed, 04 Oct 2006 15:04:40 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: James Morris <jmorris@namei.org>
CC: Eric Paris <eparis@parisplace.org>, redhat-lspp@redhat.com,
        vyekkirala@TrustedCS.com, paul.moore@hp.com, selinux@tycho.nsa.gov,
        Linda Knippers <linda.knippers@hp.com>
Subject: Re: [redhat-lspp] Re: RHEL5 Kernel with labeled networking
References: <1159834998.28144.115.camel@localhost.localdomain> 	<452282F2.1000107@hp.com>	<1159890356.28144.136.camel@localhost.localdomain> <Pine.LNX.4.64.0610031207260.21081@d.namei>
In-Reply-To: <Pine.LNX.4.64.0610031207260.21081@d.namei>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Morris wrote:
> On Tue, 3 Oct 2006, Eric Paris wrote:
>
>   
>> I think there is going to need to be a policy change that I'm actually
>> talking with Dan about as I type this e-mail.  I think we  need
>>
>> allow $1 unlabeled_t:packet { flow_in flow_out };
>>
>> to be added to policy to allow things to work as they did.  I'll post
>> again as soon as we have a policy that appears to let normal networking
>> work in enforcing.
>>     
>
> We need this policy in rawhide before the kernel patches are merged 
> upstream, so we can note the required policy version associated with the 
> patches.  We've do not want to kill Andrew Morton's box again with this 
> kind of thing.
>
>
> - James
>   
selinux-policy-2.3.18-2 has this policy.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
