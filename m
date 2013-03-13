Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r2DHthKv008563
	for <selinux@tycho.nsa.gov>; Wed, 13 Mar 2013 13:55:46 -0400
Received: by mail-qe0-f45.google.com with SMTP id b4so768493qen.18
        for <selinux@tycho.nsa.gov>; Wed, 13 Mar 2013 10:55:41 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: "Langland, Blake" <blangland@integrity-apps.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
        "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Re: SELinux network labeling
Date: Wed, 13 Mar 2013 13:55:39 -0400
Message-ID: <3265214.svHSTcnaWD@sifl>
In-Reply-To: <DA8D339A60101247B36E202899B1C93A7C93C5@CHUNEX01.integrity-apps.com>
References: <DA8D339A60101247B36E202899B1C93A7C9378@CHUNEX01.integrity-apps.com> <2547229.Czz0AkDGmt@sifl> <DA8D339A60101247B36E202899B1C93A7C93C5@CHUNEX01.integrity-apps.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday, March 13, 2013 05:29:47 PM Langland, Blake wrote:
> Great, thank you guys for the clarification. Unfortunately I can't explain
> too much more about our specific configuration, but I think I am headed
> down the correct path now with the netlabel/CIPSO peer labeling.

If you have any questions, or run into any problems, don't hesitate to ask.

> Just a general question about the CIPSO labeling: Is there anything that
> SELinux does to prevent an adversary from modifying the CIPSO label while
> on the wire? From what I can tell one would have to rely on other security
> measures like authentication/encryption to prevent this.

No, CIPSO is a labeling only protocol.  This has both its advantages as well 
as its disadvantages; one of the disadvantages is that if the network traffic 
is traversing an untrusted network you need to add an additional layer of 
protection, however, one of the advantages is that you don't need to add that 
extra layer if the network is trusted (imagine the loopback interface).

The good news is that CIPSO works just fine in conjunction with standard 
IPsec.  You can use AH and/or ESP depending on your security requirements and 
the CIPSO label (stored as an IP header option) will be protected.

> I guess this may be a benefit of IPSec peer labeling since it provides
> authentication and encryption in addition to network labeling.

Yes, that is one of the benefits of using labeled IPsec, although due to a 
lack of any standard specification for Linux's implementation of labeled IPsec 
you can only use labeled IPsec to with other Linux systems running labeled 
IPsec.  Special care also needs to be taken to ensure that the SELinux 
policies are the same (or at least have the same semantic meaning for a given 
security label) between the two labeled IPsec endpoints.

The combination of CIPSO and standard IPsec is compatible with Linux systems 
as well as other CIPSO aware/compliant systems such as Solaris TX.

Once again, there are more pros/cons between the two that you should consider 
when building your solution.

> The reason I ruled that out IPSec labeling is that we are using Openswan for
> IPSec and it is my understanding after talking with Josh Brindle that
> labeling is not supported in Openswan. Are there any plans to bring labeled
> associations to Openswan?

I haven't tested it lately but my understanding is that the version of 
Openswan shipped with RHEL6 supports labeled IPsec.  I am unsure about other 
distributions.

-- 
paul moore
www.paul-moore.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
