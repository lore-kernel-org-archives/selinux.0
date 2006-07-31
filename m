Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6VCkBP2016481
	for <selinux@tycho.nsa.gov>; Mon, 31 Jul 2006 08:46:11 -0400
Received: from tcsfw4.tcs-sec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k6VCk0kX001696
	for <selinux@tycho.nsa.gov>; Mon, 31 Jul 2006 12:46:01 GMT
Message-ID: <36282A1733C57546BE392885C0618592013E80CA@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: Paul Moore <paul.moore@hp.com>
Cc: David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        selinux@tycho.nsa.gov, sds@epoch.ncsc.mil, jmorris@redhat.com,
        pratt@argus-systems.com
Subject: RE: [PATCH 2/7] NetLabel: core network changes
Date: Mon, 31 Jul 2006 08:43:50 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> The NetLabel patch allows administrators to assign specific a CIPSO 
> DOI/configuration to each LSM "domain".  Blindly using the 
> CIPSO tag that the 
> remote host sends could violate the administrator's NetLabel 
> configuration.  
> 
> The current patch reads the CIPSO tag off the child socket, 
> translating the 
> tag according to the CIPSO DOI configuration to arrive at the 
> correct/desired 
> LSM  security attributes.  These LSM security attributes and 
> the "domain" are 
> then used to set the NetLabel on the socket.  In the case 
> where everyone is 
> well behaved this should have no effect on the socket IP 
> options and the 
> packets sent across the wire.  However, in the case of a 
> not-nice remote host 
> the outgoing CIPSO tag may change to match the administrators desired 
> settings.

I wonder if waiting till accept isn't too late though. Perhaps this
should be done when the openreq is created so the syn-ack and such
will go out with the right tag?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
