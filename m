Message-ID: <44FDAF9F.30901@hp.com>
Date: Tue, 05 Sep 2006 13:10:55 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>,
        Joy Latten <latten@austin.ibm.com>, latten@us.ibm.com,
        selinux@tycho.nsa.gov
Subject: Re: ipsec and getpeercon()
References: <36282A1733C57546BE392885C061859201512E8D@chaos.tcs.tcs-sec.com>
In-Reply-To: <36282A1733C57546BE392885C061859201512E8D@chaos.tcs.tcs-sec.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Venkat Yekkirala wrote:
>>>>What would you propose the proper behavior for when there is 
>>>>no xfrm or
>>>>node sid?
>>>
>>>The netif sid and in it's absense, the unlabeled init sid.
>>
>>I don't like using the default unlabeled sid, it implies that 
>>the packet
>>is not labeled when it is - just not with any TE information.
>  
> That's right. You would convey this by using the unlabeled init sid
> as the base sid, and replacing the mls portion with the cipso label.

See my above statement about not wanting to use the unlabeled sid
regardless of the MLS label because of it's implied meaning.  Using
unlabeled here doesn't seem (to me anyway) to be consistent with other
uses of the unlabeled sid.

>>I think that when you get down to it, in the absence of a xfrm or node
>>sid any TE value in the case of getpeercon() is going to be equally
>>"right" or "wrong" as they are all generated values in 
>>absence
> 
> TE is not really absent here. It's just not explicit in some cases, meaning
> it has the "unlabeled" label.

I think in the case of no xfrm or nodeif sid the TE information is truly
absent.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
