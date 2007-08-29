Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7T40iVg031754
	for <selinux@tycho.nsa.gov>; Wed, 29 Aug 2007 00:00:44 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l7T40huv023597
	for <selinux@tycho.nsa.gov>; Wed, 29 Aug 2007 04:00:43 GMT
Message-ID: <46D4EF5F.5070904@manicmethod.com>
Date: Wed, 29 Aug 2007 00:00:31 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: shahbaz khan <shazalive@gmail.com>
CC: selinux@tycho.nsa.gov
Subject: Re: Policy server
References: <7b740b700708281439p39da575alcb3b3abba43461ef@mail.gmail.com>
In-Reply-To: <7b740b700708281439p39da575alcb3b3abba43461ef@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

shahbaz khan wrote:
> Hi,
>  
> I need to know if PMS is in a condition that it can be run as a policy 
> server fro remote clients. Secondly, cant find the policy.conf in my 
> /etc as the makefile points. Should I be checking the access rights?
>

The PMS prototype currently can talk over the network but after some 
conversation about upstreaming the code we've decided that the 
upstreamed version won't be a long running server that answers to 
network communication, it will be an on-demand server that will run from 
libsemanage (probably). This decision was made because it is believed 
now that access control on the policy and network distribution of the 
policy are different problems that are better handled by different means.

About pms.conf, I'm not sure, you can grab it out of the tree, I'm not 
sure why it wasn't installed (it should be in /etc/selinux anyway).


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
