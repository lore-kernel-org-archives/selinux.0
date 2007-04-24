Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3OMdTMP018030
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 18:39:29 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3OMdRps020435
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 22:39:28 GMT
Subject: RE: [PATCH 12/33] libsemanage: basic serialization
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B01588A71AE3@exchange.columbia.tresys.com>
References: <20070423213455.741326000@tresys.com>
	 <20070423213731.972575000@tresys.com>
	 <1177449381.3428.0.camel@localhost.localdomain>
	 <6FE441CD9F0C0C479F2D88F959B01588A71AE3@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Tue, 24 Apr 2007 18:39:27 -0400
Message-Id: <1177454367.3428.35.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-04-24 at 18:31 -0400, Joshua Brindle wrote:
> > From: Karl MacMillan [mailto:kmacmillan@mentalrootkit.com] 
> > 
> > On Mon, 2007-04-23 at 17:35 -0400, jbrindle@tresys.com wrote:
> > > plain text document attachment (semanage.serialize.diff) 
> > This is the 
> > > serialization infrastructure for libsemanage.
> > > 
> > 
> > We have talked about this in the past, but I think the 
> > duplication between libsemanage and libsepol should be 
> > removed. This is just ridiculous.
> > 
> 
> We haven't figured out how to remove it. There are lots of objects that
> are only in semanage (fcontext, seuser, etc) and many that are in sepol
> (user, boolean, etc).

We should move this into libsepol. I actually think that would make the
library split clearer.

>  We could do serialization of all sepol types (we
> are going to do that anyway for the new policy rep) and remove that
> stuff from libsemanage (I thought that was the plan anyway), for now
> this is how we did it. Hopefully that'll change. Both libraries are
> going to have to have serialization/unserialization infrastructure in
> any case.

Why? Just have a generic way to serialize lists (and perhaps name /
value pairs) in libsepol and all of the code falls out of libsemanage.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
