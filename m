Message-Id: <200509231234.j8NCYiYs008523@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'Ivan Gyurdiev'" <ivg2@cornell.edu>
Cc: "'Stephen Smalley'" <sds@tycho.nsa.gov>, <selinux@tycho.nsa.gov>,
   <jbrindle@tresys.com>
Subject: RE: [ SEPOL/SEMANAGE ] Boolean record
Date: Fri, 23 Sep 2005 08:34:43 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <43320DE5.9080802@cornell.edu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov] On
> Behalf Of Ivan Gyurdiev
> Sent: Wednesday, September 21, 2005 9:50 PM
> To: Karl MacMillan
> Cc: 'Stephen Smalley'; selinux@tycho.nsa.gov; jbrindle@tresys.com
> Subject: Re: [ SEPOL/SEMANAGE ] Boolean record
> 
> 
> >Not certain what you mean - in the case of the policy server, the client
> >might be running on a different machine than the server. That means that
> >these functions would have to do some form of RPC using a wire protocol.
> You
> >can look at the old policy server snapshot to see this.
> >
> >
> I mean... the functions in *_record.h pack and unpack records, and don't
> do anything else of significance - they don't retrieve the record, or
> parse the record, or anything. As such, I don't see why you'd be using
> RPC on them - there's no reason for a client to be invoking those
> functions on a different machine.
> 
> 

There are 2 reasons:

1) To enforce access control on policy change, the policy server needs to
run in a separate process (not necessarily on another machine, but that
works as well). That means IPC/RPC by the client.

2) Eventually the goal is to be able to change policy on a group of machines
together. This likely requires running the client on separate machine from
the policy server.

Karl

------
Karl MacMillan
Tresys Technology
http://www.tresys.com

> 
> 
> 
> 
> 
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> the words "unsubscribe selinux" without quotes as the message.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
