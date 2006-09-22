Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8MG7LfS024453
	for <selinux@tycho.nsa.gov>; Fri, 22 Sep 2006 12:07:21 -0400
Received: from atlrel6.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8MG6p3K019296
	for <selinux@tycho.nsa.gov>; Fri, 22 Sep 2006 16:06:51 GMT
Message-ID: <45140A35.7000308@hp.com>
Date: Fri, 22 Sep 2006 12:07:17 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Cc: Joshua Brindle <jbrindle@tresys.com>, Stephen Smalley <sds@epoch.ncsc.mil>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>, latten@austin.ibm.com,
        jmorris@redhat.com, dwalsh@redhat.com,
        Darrel Goeddel <DGoeddel@TrustedCS.com>,
        Chad Hanson <chanson@TrustedCS.com>, selinux@tycho.nsa.gov
Subject: Re: Labeled networking packets
References: <36282A1733C57546BE392885C0618592015734F8@chaos.tcs.tcs-sec.com>
In-Reply-To: <36282A1733C57546BE392885C0618592015734F8@chaos.tcs.tcs-sec.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Venkat Yekkirala wrote:
>>>You can always have getpeercon return a "domain" by turning out a
>>>domain (a unlabeled_t one?) in the non labeled-ipsec case.
>>
>>The only thing I don't like about this is that it starts giving
>>types/domains implicit meaning that is not defined by policy.
> 
> I don't know what you are talking about here. I was saying you
> could turn out a "true domain" using transitions.

Well, as I understand it right now types/domains have no inherent
meaning; they are given defined through their use in the policy.  Having
the kernel return "unlabeled_t" to signify a special case starts giving
"unlabeled_t" inherent meaning.  Maybe it's not a big deal as I guess
"unlabeled_t" will always have a certain conotation about it but I still
think sending an error is much cleaner.

Applications that depend on getpeercon() could check for the error and
substitute "unlabeled_t".

>> I know we
>>sort of do that already with some of the MLS attributes
> 
> Examples?

Look at all of the "mls*" attributes defined in mls.te and how they are
used in the MLS constraints file.

>>Plus, what if the remote domain was honestly running in "unlabeled_t"?
>>Stupid, yes, but possibile I imagine.
>  
> unlabeled_t anywhere is unlabeled. It doesn't matter how it came to be
> unlabeled_t.

No, not always, see the comments above.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
