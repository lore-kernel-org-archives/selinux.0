Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8LFsOAa016548
	for <selinux@tycho.nsa.gov>; Thu, 21 Sep 2006 11:54:24 -0400
Subject: RE: Labeled networking packets
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <jbrindle@tresys.com>, Paul Moore <paul.moore@hp.com>,
        latten@austin.ibm.com, jmorris@redhat.com, dwalsh@redhat.com,
        Darrel Goeddel <DGoeddel@TrustedCS.com>,
        Chad Hanson <chanson@TrustedCS.com>, selinux@tycho.nsa.gov
In-Reply-To: <36282A1733C57546BE392885C0618592015732E3@chaos.tcs.tcs-sec.com>
References: <36282A1733C57546BE392885C0618592015732E3@chaos.tcs.tcs-sec.com>
Content-Type: text/plain
Date: Thu, 21 Sep 2006 11:55:43 -0400
Message-Id: <1158854143.7748.130.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-09-21 at 11:01 -0400, Venkat Yekkirala wrote:
> > I agree about what getpeercon should return, even to the point of
> > returning nothing or error if only secmark is being used.
> 
> And why should that be the case? Everything has a label on a MAC system
> and why should apps care about the configuration (explicit IPSec label
> Vs. implicit via secmark)?
<snip>
> You will want to deal with only 1 label at the app level, and it should be
> the label that was used in determining whether the socket could read
> the skb or not.
> 
> Can you give any examples on where differentiation is needed?

Callers of getpeercon() expect it to return a subject label that they
can use in a call to e.g. avc_has_perm() as the source/subject context
or setexeccon() or (shudder) setcon().  If it returns
httpd_client_packet_lo_t, then the caller is going to run into trouble
upon trying to use the context as a subject label.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
