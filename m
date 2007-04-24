Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3OMVa9J017674
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 18:31:36 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l3OMVZPI004271
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 22:31:35 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 12/33] libsemanage: basic serialization
Date: Tue, 24 Apr 2007 18:31:34 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B01588A71AE3@exchange.columbia.tresys.com>
In-Reply-To: <1177449381.3428.0.camel@localhost.localdomain>
References: <20070423213455.741326000@tresys.com> <20070423213731.972575000@tresys.com> <1177449381.3428.0.camel@localhost.localdomain>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Karl MacMillan" <kmacmillan@mentalrootkit.com>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: Karl MacMillan [mailto:kmacmillan@mentalrootkit.com] 
> 
> On Mon, 2007-04-23 at 17:35 -0400, jbrindle@tresys.com wrote:
> > plain text document attachment (semanage.serialize.diff) 
> This is the 
> > serialization infrastructure for libsemanage.
> > 
> 
> We have talked about this in the past, but I think the 
> duplication between libsemanage and libsepol should be 
> removed. This is just ridiculous.
> 

We haven't figured out how to remove it. There are lots of objects that
are only in semanage (fcontext, seuser, etc) and many that are in sepol
(user, boolean, etc). We could do serialization of all sepol types (we
are going to do that anyway for the new policy rep) and remove that
stuff from libsemanage (I thought that was the plan anyway), for now
this is how we did it. Hopefully that'll change. Both libraries are
going to have to have serialization/unserialization infrastructure in
any case.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
