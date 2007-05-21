Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4LG7Mgs003115
	for <selinux@tycho.nsa.gov>; Mon, 21 May 2007 12:07:22 -0400
Received: from web36606.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l4LG7M9R013506
	for <selinux@tycho.nsa.gov>; Mon, 21 May 2007 16:07:22 GMT
Date: Mon, 21 May 2007 09:07:21 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: Question on networking accesses
To: Paul Moore <paul.moore@hp.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200705211122.25948.paul.moore@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <598964.83843.qm@web36606.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Paul Moore <paul.moore@hp.com> wrote:

> On Monday, May 21 2007 9:48:52 am Casey Schaufler wrote:
> > I have what I hope is a fairly straitforward question on the SELinux
> > networking model. Let's pretend that I have a process A that sends a
> > UDP packet P to a second process B. From the viewpoint of access control
> > is this:
> >
> >     - process A writing to process B
> >     - process B reading from process A
> >     - process A creating packet P, and process B reading packet P
> >
> > some combination of the above, or something else entirely?
> 
> >From 10,000 feet up in the air that sounds roughly about right.  Although if
> 
> you are talking about labeled networking it can be a bit more involved, 
> especially if you are using labeled IPsec.
> 
> Can you be a bit more specific?

How about if I throw out an example. The evaluation team loved this
one back in '92.

I have a tic-tac-toe server that does little but maintain a tic-tac-toe
board. It allows two connections, one for the "X" player and one for the
"O" player. Player X invokes the tictacclient program, which sends a
UDP packet to tictacserver. The client may be local or remote. What
access control decisions are made, where, and using what information?

The decision may be different if it's seen as a write from tictacclient
to tictacserver than if it's seen as a read from tictacclient by
tictacserver. The decision may have another outcome entirely if the
packet is treated as a named object that is created by tictacclient.

So, what should the creator of this tic-tac-toe system expect on an
selinux system? Will the access decision be based on a write from the
client, a read by the server, the attribues associated with a packet
object, or something else entirely?

Historical MLS systems treated the access as a write by the client to
the server (well, the server's socket) but the MLS rules typically
limited the communications to matching labels. SELinux is much more
likely to encounter a situation where the client might be able to write
to the server but the server might not be allowed to read the client
(or the other way around). It may matter if it is a read or a write.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
