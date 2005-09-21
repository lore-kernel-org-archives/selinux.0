Message-Id: <200509211833.j8LIXGYs013694@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'Ivan Gyurdiev'" <ivg2@cornell.edu>
Cc: "'Stephen Smalley'" <sds@tycho.nsa.gov>, <selinux@tycho.nsa.gov>,
   <jbrindle@tresys.com>
Subject: RE: [ SEPOL/SEMANAGE ] Boolean record
Date: Wed, 21 Sep 2005 14:33:16 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <4331A852.9070005@cornell.edu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Ivan Gyurdiev [mailto:ivg2@cornell.edu]
> Sent: Wednesday, September 21, 2005 2:37 PM
> To: Karl MacMillan
> Cc: 'Stephen Smalley'; selinux@tycho.nsa.gov; jbrindle@tresys.com
> Subject: Re: [ SEPOL/SEMANAGE ] Boolean record
> 
> 
> >Just a note - there is a working policy server right now
> >(sepolicy-server.sf.net has the latest release). That is why these
> >functions, at the very least, need to be indirected through the
> >semanage_handle_t function pointers so different versions can be plugged
> in
> >for the remote implementation.
> >
> >
> These functions should be implemented exactly the same way, regardless
> of backend of the policy.
> Those are data structure wrappers. They provide virtually no
> functionality other than accessors for the data
> in the structure.
> 

Not certain what you mean - in the case of the policy server, the client
might be running on a different machine than the server. That means that
these functions would have to do some form of RPC using a wire protocol. You
can look at the old policy server snapshot to see this.

Karl

------
Karl MacMillan
Tresys Technology
http://www.tresys.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
