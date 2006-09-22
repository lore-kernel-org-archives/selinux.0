Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8MFUgES022793
	for <selinux@tycho.nsa.gov>; Fri, 22 Sep 2006 11:30:42 -0400
Received: from atlrel6.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8MFU98R013953
	for <selinux@tycho.nsa.gov>; Fri, 22 Sep 2006 15:30:11 GMT
Message-ID: <4514019B.3080103@hp.com>
Date: Fri, 22 Sep 2006 11:30:35 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Cc: Joshua Brindle <jbrindle@tresys.com>, Stephen Smalley <sds@epoch.ncsc.mil>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>, latten@austin.ibm.com,
        jmorris@redhat.com, dwalsh@redhat.com,
        Darrel Goeddel <DGoeddel@TrustedCS.com>,
        Chad Hanson <chanson@TrustedCS.com>, selinux@tycho.nsa.gov
Subject: Re: Labeled networking packets
References: <36282A1733C57546BE392885C0618592015734E7@chaos.tcs.tcs-sec.com>
In-Reply-To: <36282A1733C57546BE392885C0618592015734E7@chaos.tcs.tcs-sec.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Venkat Yekkirala wrote:
>>bah, fair enough :\. I guess the reason I was objecting was 
>>because the
>>objects seem *very* different. standard object and subject transitions
>>seem pretty intuitive (I'm in a domain, i execute something, I'm in a
>>new domain or directories containing files guiding 
>>transitions. packets
>>and associations are totally separate and used for totally different
>>things. And the other problem was that I don't even know if we were
>>*trying* to derive a subject label or not, some of the examples I've
>>seen floating around indicate that others don't either.
>  
> You can always have getpeercon return a "domain" by turning out a
> domain (a unlabeled_t one?) in the non labeled-ipsec case.

The only thing I don't like about this is that it starts giving
types/domains implicit meaning that is not defined by policy.  I know we
sort of do that already with some of the MLS attributes but I think it's
worth trying to avoid.

Plus, what if the remote domain was honestly running in "unlabeled_t"?
Stupid, yes, but possibile I imagine.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
