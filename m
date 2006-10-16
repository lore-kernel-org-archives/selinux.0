Reply-To: <vyekkirala@TrustedCS.com>
From: "Venkat Yekkirala" <vyekkirala@TrustedCS.com>
To: "'Joshua Brindle'" <jbrindle@tresys.com>
Cc: <selinux@tycho.nsa.gov>, <jmorris@namei.org>, <sds@tycho.nsa.gov>
Subject: RE: SELinux Networking Enhancements
Date: Mon, 16 Oct 2006 09:55:08 -0500
Message-ID: <000401c6f133$13626740$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: 
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > While you still disagree, I think most of us believe that secmarks
> 
> Only there are no secmarks in the new design to begin with. The word
> is a holdover from the current secmark design.
> 
> > should be _local only_ enforcement, not peer labeling, an 
> > ipsec rule is
> > in no way a "peer",
> 
> Agreed. But I fail to see where having a "default" peer on a 
> netfilter rule/secpoint
> would hurt. FYI- this is how MLS implementations work. You 
> have an interface
> that you would label everything coming thru by default with "Secret".
> 
> Also, don't we deem all data on a filesystem that doesn't 
> support individual
> file labeling to be at the label it's mounted at?
> 
> > a remote socket is a peer and a peer should
> > represent that.
> 
> Sure. That's also allowed in secpoint.

If it would serve your needs any better, we can have getpeercon return only
a "true" (meaning external) peer like you like to call it. We can find
someother way to retrieve the default as well (for MLS). Is that better?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
