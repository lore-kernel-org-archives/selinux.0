Message-ID: <5140BA30.9020802@tycho.nsa.gov>
Date: Wed, 13 Mar 2013 13:41:04 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: "Langland, Blake" <blangland@integrity-apps.com>
CC: Paul Moore <paul@paul-moore.com>,
        "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Re: SELinux network labeling
References: <DA8D339A60101247B36E202899B1C93A7C9378@CHUNEX01.integrity-apps.com> <514080E7.8020602@tycho.nsa.gov> <2547229.Czz0AkDGmt@sifl> <DA8D339A60101247B36E202899B1C93A7C93C5@CHUNEX01.integrity-apps.com>
In-Reply-To: <DA8D339A60101247B36E202899B1C93A7C93C5@CHUNEX01.integrity-apps.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 03/13/2013 01:29 PM, Langland, Blake wrote:
> Great, thank you guys for the clarification. Unfortunately I can't explain too much more about our specific configuration, but I think I am headed down the correct path now with the netlabel/CIPSO peer labeling.
>
> Just a general question about the CIPSO labeling: Is there anything that SELinux does to prevent an adversary from modifying the CIPSO label while on the wire? From what I can tell one would have to rely on other security measures like authentication/encryption to prevent this. I guess this may be a benefit of IPSec peer labeling since it provides authentication and encryption in addition to network labeling. The reason I ruled that out IPSec labeling is that we are using Openswan for IPSec and it is my understanding after talking with Josh Brindle that labeling is not supported in Openswan. Are there any plans to bring labeled associations to Openswan?

You can always use regular IPSEC to protect the packet (including its 
CIPSO label).  Labeled IPSEC is only required if you want to convey the 
entire security context to the peer.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
