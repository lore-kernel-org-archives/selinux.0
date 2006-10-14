Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9E04174020540
	for <selinux@tycho.nsa.gov>; Fri, 13 Oct 2006 20:04:01 -0400
Received: from tcsfw4.tcs-sec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9E02fo6019665
	for <selinux@tycho.nsa.gov>; Sat, 14 Oct 2006 00:02:41 GMT
Reply-To: <vyekkirala@TrustedCS.com>
From: "Venkat Yekkirala" <vyekkirala@TrustedCS.com>
To: "Venkat Yekkirala" <vyekkirala@tcsfw4.tcs-sec.com>,
        "'Christopher J. PeBenito'" <cpebenito@tresys.com>
Cc: <selinux@tycho.nsa.gov>, <redhat-lspp@redhat.com>
Subject: RE: DOCUMENTATION OF SECID RECONCILIATION AND FLOW CONTROL FOR POLICY WRITERS
Date: Fri, 13 Oct 2006 19:03:29 -0500
Message-ID: <001801c6ef24$2f2edfa0$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: 
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > turns into:
> > 
> > allow unlabeled_t network_t:packet flow_in;
> 
> as it happens currently.
> 
> > allow unconfined_t unlabeled_t:packet flow_in;
> 
> as it happens currently.

Well, as: allow unconfined_t unlabeled_t:packet recv;

> 
> > allow unconfined_t unlabeled_t:packet flow_out;
> 
> Not needed since we have a check against network_t
> as mentioned next.
> 
> > allow unlabeled_t network_t:packet flow_out;
> > 
> > which seems more correct to me and is clearer and more consistent.
> 
> which, after all said and done is what in fact is (should be) 
> happening.
> 
> But the fights in the earlier part still hold true, which 
> makes me wonder
> where did you/I get off the track?
> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
