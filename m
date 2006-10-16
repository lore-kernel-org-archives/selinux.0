Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9GEC7nm020715
	for <selinux@tycho.nsa.gov>; Mon, 16 Oct 2006 10:12:07 -0400
Received: from tcsfw4.tcs-sec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9GEAj0e019046
	for <selinux@tycho.nsa.gov>; Mon, 16 Oct 2006 14:10:45 GMT
Reply-To: <vyekkirala@TrustedCS.com>
From: "Venkat Yekkirala" <vyekkirala@TrustedCS.com>
To: "'Christopher J. PeBenito'" <cpebenito@tresys.com>,
        "Venkat Yekkirala" <vyekkirala@tcsfw4.tcs-sec.com>
Cc: "'James Morris'" <jmorris@namei.org>, "'Paul Moore'" <paul.moore@hp.com>,
        <selinux@tycho.nsa.gov>,
        "'Karl MacMillan'" <kmacmillan@mentalrootkit.com>,
        "Joshua Brindle" <jbrindle@tresys.com>
Subject: RE: Denials from newest kernel
Date: Mon, 16 Oct 2006 09:11:47 -0500
Message-ID: <000101c6f12d$04bee700$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <1161004590.5980.186.camel@sgc>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> I strongly disagree with this.  It is a replacement for the
> port/node/netif basic networking controls.

Which is what I mentioned as well. It's "narrow" however, in that,
it doesn't address the problem of general flow-control, of which,
controls on forwarded traffic are an important part.

>  Its vastly 
> superior because
> it provides the expressiveness of netfilter so you can have 
> combinations
> of ports, nodes, and netifs (and other netfilter things if you want).

Fully agreed with you here.

> 
> I can see how the flow controls can do something for the forwarding
> case, but in my opinion doesn't do anything for the regular input and
> output cases.

It does do EVERYTHING that secmark does in terms of expressing the
security goals applicable to regular input and ouput cases. Can you
show me an example where this isn't the case?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
