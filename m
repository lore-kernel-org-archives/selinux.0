Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3CHphfW002173
	for <selinux@tycho.nsa.gov>; Thu, 12 Apr 2007 13:51:43 -0400
Received: from tcsfw4.tcs-sec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3CHpdh9014791
	for <selinux@tycho.nsa.gov>; Thu, 12 Apr 2007 17:51:40 GMT
Reply-To: <vyekkirala@TrustedCS.com>
From: "Venkat Yekkirala" <vyekkirala@TrustedCS.com>
To: "'Paul Moore'" <paul.moore@hp.com>,
        "Joshua Brindle" <method@manicmethod.com>
Cc: "Venkat Yekkirala" <vyekkirala@tcsfw4.tcs-sec.com>,
        "John Wan" <J.Wan@mbs.edu>, <selinux@tycho.nsa.gov>,
        <jmorris@namei.org>
Subject: RE: Would the SELinux  act as a TippingPoint IPS to block the nasty Trojan traffic?
Date: Thu, 12 Apr 2007 12:51:08 -0500
Message-ID: <000101c77d2b$27209160$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <200704111332.04613.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > How does this work into the idea we had during the summit 
> about SELinux
> > having its own table? The table would presumably be a 
> mangle table for
> > labeling but could it also be a filter table? I'm not clear 
> on what is
> > possible in netfilter.
> 
> I'm not a netfilter expert myself, although I'm learning more 
> and more about 
> it each day.  I don't see how this couldn't fit into the proposed 
> LSM/SELinux/security table in fact I think I mentioned 
> something like this at 
> one point (although, maybe it was just to myself).

To share some preliminary thoughts on this, we might be able to have
the security table have 2 built-in chains, say, secmark and secfilter,
and have these chains traversed at the appropriate points as in the
following example for the INPUT case:

...
mangle PREROUTE
security SECMARK
filter INPUT
security SECFILTER
...

It's also conceivable that we might, in fact, have two tables (secmark
and secfilter), all things considered.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
