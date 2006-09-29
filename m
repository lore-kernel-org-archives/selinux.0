Message-ID: <36282A1733C57546BE392885C061859201573D58@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: Paul Moore <paul.moore@hp.com>, Stephen Smalley <sds@tycho.nsa.gov>
Cc: James Morris <jmorris@namei.org>, Joshua Brindle <method@gentoo.org>,
        Venkat Yekkirala <vyekkirala@TrustedCS.com>, netdev@vger.kernel.org,
        selinux@tycho.nsa.gov, kmacmillan@mentalrootkit.com
Subject: RE: [PATCH 7/7] secid reconciliation-v03: Enforcement for SELinux
Date: Fri, 29 Sep 2006 12:09:44 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > Fine with me, unless Venkat has an immediate use case for such
> > transitions in the flow_in case (but I think this is mostly 
> my fault for
> > suggesting transitions a while ago).

I don't have a use case currently.

> 
> Unless I'm confusing something, there still may be a need for 
> transitions
> if we want to support both IPsec and NetLabel labeling on the same
> connection.
> If we don't support transitions and allow both labeling methods on the
> same connection we'll need to decide how to handle resolving the two -
> maybe use a transition is this one case?

Since CIPSO doesn't do full contexts currently, it would be just a
matter of an additional flow_in check. The base sid used here would
be the current secmark at that point (which will be the xfrm sid
if xfrm was used). So, no transitions needed here currently.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
