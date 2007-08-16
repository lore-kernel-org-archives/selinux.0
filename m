Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7GKOjIQ026457
	for <selinux@tycho.nsa.gov>; Thu, 16 Aug 2007 16:24:45 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l7GKOiYY025737
	for <selinux@tycho.nsa.gov>; Thu, 16 Aug 2007 20:24:44 GMT
Message-ID: <46C4B276.3000009@manicmethod.com>
Date: Thu, 16 Aug 2007 16:24:22 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: shahbaz khan <shazalive@gmail.com>
CC: selinux@tycho.nsa.gov
Subject: Re: TE for networked resources
References: <7b740b700708161147q1ce955d4ha64320547ac81663@mail.gmail.com>
In-Reply-To: <7b740b700708161147q1ce955d4ha64320547ac81663@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

shahbaz khan wrote:
> I was curious while reading Brindle et al paper on enhancing selinux 
> policy for network domain that do we really need TE for these remote 
> resources. Can't we just do with IBAC and RBAC? We can let the local 
> subjects handle the TE with their own types with respect to the IBAC 
> and RBAC of remote subject. This might be what they call equivalence 
> mechanism. The problems associated with TE are too tough for 
> selinux and current network controls to handle. The solutions will 
> cost too much.
>  
Like Steve said, we want to be able to bind executable code to domains 
most of the time. However, the scheme we proposed leaves the translation 
layer vague intentionally. There is nothing that prevents you from 
making a translation server that only uses IBAC and RBAC.  One potential 
use of this is interacting with non-TE security systems.

> Is there any progress on this work. Let me know because I have also 
> working on this and might be able to assist.

Not as of late. We have the iptools patches in svn but other than that 
nothing much has happened.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
