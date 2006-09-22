Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8MGLIEW025078
	for <selinux@tycho.nsa.gov>; Fri, 22 Sep 2006 12:21:18 -0400
Received: from atlrel8.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8MGKk3K021540
	for <selinux@tycho.nsa.gov>; Fri, 22 Sep 2006 16:20:48 GMT
Message-ID: <45140D78.2070500@hp.com>
Date: Fri, 22 Sep 2006 12:21:12 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Cc: Joshua Brindle <jbrindle@tresys.com>, Stephen Smalley <sds@epoch.ncsc.mil>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>, latten@austin.ibm.com,
        jmorris@redhat.com, dwalsh@redhat.com,
        Darrel Goeddel <DGoeddel@TrustedCS.com>,
        Chad Hanson <chanson@TrustedCS.com>, selinux@tycho.nsa.gov
Subject: Re: Labeled networking packets
References: <36282A1733C57546BE392885C061859201573506@chaos.tcs.tcs-sec.com>
In-Reply-To: <36282A1733C57546BE392885C061859201573506@chaos.tcs.tcs-sec.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Venkat Yekkirala wrote:
>>Venkat Yekkirala wrote:
>>>>>Do you have a scenario where one might want both labeling 
>>>>
>>>>schemes at the
>>>>
>>>>
>>>>>same time? Note that if you need netlabel (legacy os on the 
>>>>
>>>>other side)
>>>>
>>>>
>>>>>and you also want ipsec for integrity then the isakmp 
>>>>
>>>>negotiation would
>>>>
>>>>
>>>>>not include a context and netlabel would be used.
>>>>
>>>>Honestly, I can't think of why you would want to use both SA and
>>>>NetLabel labeling on the same connection - that's just stupid :)
>>>
>>>I can think of ALL Secret and its compartments using one SA
>>>for example (a very realistic one).
>>
>>If you have NetLabel carrying the MLS label why would you want to make
>>your life complicated by using SA labeling as well?
>  
> It's not a matter of complicated or not. Unless you make sure both
> are NOT used at the same time, you *must* make you they work like
> they are supposed to (cipso falling in the rage of the SA) if/when
> they are used together.

See my comments in my other mail about treating the socket as the
communication endpoint, not the SA.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
