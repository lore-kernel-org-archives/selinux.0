Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8MFp8FP023663
	for <selinux@tycho.nsa.gov>; Fri, 22 Sep 2006 11:51:08 -0400
Received: from atlrel6.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8MFoZ8R016815
	for <selinux@tycho.nsa.gov>; Fri, 22 Sep 2006 15:50:37 GMT
Message-ID: <4514065F.5040403@hp.com>
Date: Fri, 22 Sep 2006 11:50:55 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Cc: Joshua Brindle <jbrindle@tresys.com>, Stephen Smalley <sds@epoch.ncsc.mil>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>, latten@austin.ibm.com,
        jmorris@redhat.com, dwalsh@redhat.com,
        Darrel Goeddel <DGoeddel@TrustedCS.com>,
        Chad Hanson <chanson@TrustedCS.com>, selinux@tycho.nsa.gov
Subject: Re: Labeled networking packets
References: <36282A1733C57546BE392885C0618592015734F0@chaos.tcs.tcs-sec.com>
In-Reply-To: <36282A1733C57546BE392885C0618592015734F0@chaos.tcs.tcs-sec.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Venkat Yekkirala wrote:
>>>Ignoring the secmark issue for a moment ...
>>
>>there is no secmark issue, secmark isn't for labeling.
>  
> It IS FOR LABELING as far as MLS is concerned.

Perhaps we are just overloading the term "labeling".  It kinda sounds
like the non-MLS folks want to be able to distinguish between "remote
labeling", i.e. SA or NetLabel, and "local labeling", i.e. secmark.  I
realize that there are certain users who don't care to make that
distinction because they can put a certain level of trust in the
physical network configuration.  However, considering the flexibility of
SELinux in general I think any built-in assumption is going to upset
someone.  I think the best idea is to arrive at some sort of policy
abstraction which would allow either of the behaviors listed above.

For handling incoming packets this may mean that we keep all of the
packet labeling mechanisms separate, allowing each to have it's own
permission check.

For dealing with getpeercon() issues perhaps we only allow "remote
labeled" contexts to be reported by default, but if policy allows (yes,
we would need some sort of new allow rule or policy construct) the
"locally labeled" context could be used as a fallback.

I know it's not ideal for any one scenario, but I think it may be
flexibile enough to deal with all of them.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
