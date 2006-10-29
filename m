Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9T6lwtf028010
	for <selinux@tycho.nsa.gov>; Sun, 29 Oct 2006 01:47:58 -0500
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9T6l9F5006912
	for <selinux@tycho.nsa.gov>; Sun, 29 Oct 2006 06:47:10 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Michael Graffam <michael.graffam@gmail.com>
Subject: Re: New to SELinux -- any suggestions?
Date: Sun, 29 Oct 2006 16:47:54 +1000
Cc: selinux@tycho.nsa.gov
References: <1162086080.2566.16.camel@endless> <200610291601.19715.russell@coker.com.au> <1162101958.2580.10.camel@endless>
In-Reply-To: <1162101958.2580.10.camel@endless>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200610291747.57640.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sunday 29 October 2006 17:05, Michael Graffam <michael.graffam@gmail.com> 
wrote:
> > If however a file could have multiple types then such analysis would be
> > impossible unless you also had rules determining which pairs of contexts
> > might be applied to one file (in which case every permitted pair of
> > contexts could be mapped to a single context in the current SE Linux
> > system for the same result).
>
> OK, that makes perfect sense. I had figured that multiple contexts would
> be allowed, to prevent the possible need of expanding the number of
> required 'base' contexts. But, I can certainly see your point about the
> difficulty of analyzing all possible combinations.

There are many types used in SE Linux, the number you see in the targeted 
policy is a small part of what is in the strict policy.

Also recently (FC5 and above) the MLS features of SE Linux have been used.  
With separate mechanisms for protecting confidentiality and integrity a 
smaller number of types is needed (previously types were used for 
confidentiality as well).

> Thanks again for your help. Would you happen to know if there is a
> document somewhere which gives a general overview of the structure of
> the SELinux mechanisms, maybe with some details on the common contexts
> and so forth?

Some of this is documented in the Fedora wiki.

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
