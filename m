Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8MFu0Jr023934
	for <selinux@tycho.nsa.gov>; Fri, 22 Sep 2006 11:56:00 -0400
Received: from atlrel9.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8MFtT8R017296
	for <selinux@tycho.nsa.gov>; Fri, 22 Sep 2006 15:55:30 GMT
Message-ID: <45140789.8080207@hp.com>
Date: Fri, 22 Sep 2006 11:55:53 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Cc: Joshua Brindle <jbrindle@tresys.com>, Stephen Smalley <sds@epoch.ncsc.mil>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>, latten@austin.ibm.com,
        jmorris@redhat.com, dwalsh@redhat.com,
        Darrel Goeddel <DGoeddel@TrustedCS.com>,
        Chad Hanson <chanson@TrustedCS.com>, selinux@tycho.nsa.gov
Subject: Re: Labeled networking packets
References: <36282A1733C57546BE392885C0618592015734F3@chaos.tcs.tcs-sec.com>
In-Reply-To: <36282A1733C57546BE392885C0618592015734F3@chaos.tcs.tcs-sec.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Venkat Yekkirala wrote:
>>Good point.  We could always have getpeercon() error out if 
>>both SA and
>>NetLabel labels are present.  It may not be ideal, but it's safe.
>  
> No need to error out since no transitions are needed. The current
> expected uses for cipso are a. all by itself, b. in conjunction
> with ipsec. In the latter case, we do an additional check to make
> sure the cipso label can come thru the ipsec tunnel/transport.

The comments below apply here as well.

>>>Do you have a scenario where one might want both labeling 
>>
>>schemes at the
>>
>>>same time? Note that if you need netlabel (legacy os on the 
>>
>>other side)
>>
>>>and you also want ipsec for integrity then the isakmp 
>>
>>negotiation would
>>
>>>not include a context and netlabel would be used.
>>
>>Honestly, I can't think of why you would want to use both SA and
>>NetLabel labeling on the same connection - that's just stupid :)
> 
> I can think of ALL Secret and its compartments using one SA
> for example (a very realistic one).

If you have NetLabel carrying the MLS label why would you want to make
your life complicated by using SA labeling as well?  I just don't
understand why the duplication is necessary.  Since this example is only
dealing with MLS, why not just use NetLabel and if you can't trust the
physical link layer, i.e. you need IPsec protection, just run unlabeled
IPsec.  This will allow you to talk to both SELinux and legacy Trusted
OSs without problem, and it allows you the flexibility of offloading the
IPsec processing to some sort of bump-in-the-wire solution which could
yield significant performance advantages.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
