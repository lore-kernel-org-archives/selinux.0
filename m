Message-ID: <4552A9AC.3060708@hp.com>
Date: Wed, 08 Nov 2006 23:08:12 -0500
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: vyekkirala@TrustedCS.com
Cc: "'James Morris'" <jmorris@namei.org>, netdev@vger.kernel.org,
        selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: Re: [PATCH 2/3] mlsxfrm: Various fixes
References: <000501c70342$83b9df70$cc0a010a@tcssec.com>
In-Reply-To: <000501c70342$83b9df70$cc0a010a@tcssec.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Venkat Yekkirala wrote:
>>>Fix SO_PEERSEC for tcp sockets to return the security context of
>>>the peer (as represented by the SA from the peer) as opposed to the
>>>SA used by the local/source socket.
>>
>>What about the case of a localhost TCP connection not using
>>xfrm labeling?
>>
>>Joe Nall raised this as an important requirement.
> 
> Yes. We need to come up with some new ideas on this (the failed
> secid-recon patchset sought to do this using the secmark field
> on the skb).

You mentioned in an earlier thread that it may be possibile to enable XFRM for
localhost via a sysctl variable; I would think this would make the most sense.
I understand there is a performance hit due to IPsec being used, but I think
this solution offers a few advantages:

1. Functionality is available right now, no additional kernel changes needed
2. No special handling for localhost, I tend to like the idea of having
consistent behavior for all addresses/interfaces

Besides the performance penalty of IPsec and the untested nature of this
solution is there some gotcha here which would prevent this from working?

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
