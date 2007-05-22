Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4MEuJeC016425
	for <selinux@tycho.nsa.gov>; Tue, 22 May 2007 10:56:19 -0400
Received: from web36614.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l4MEuIRP015526
	for <selinux@tycho.nsa.gov>; Tue, 22 May 2007 14:56:18 GMT
Date: Tue, 22 May 2007 07:56:18 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: Question on networking accesses
To: Steve G <linux_4ever@yahoo.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <827038.22839.qm@web51509.mail.re2.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <497871.6976.qm@web36614.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Steve G <linux_4ever@yahoo.com> wrote:

> 
> >I guess with SELinux you could think of it as the following:
> >
> > - process A (subject) writes to socket A1 (object)
> > - socket A1 (subject) sends packet to compat_net/SECMARK (object)
> >
> >    packet traverses the ether (real magic)
> >
> > - socket B1 (subject) receives the packet via int/ext labels (object)
> > - process B (subject) receives the data via socket B1 (object)
> 
> I think this is missing the access control decisions. First, the sender has
> to be
> in a domain that allows a connect/sendto, the connection between domains must
> be
> allowed by policy, and the receiver has to be in a domain that allows
> listen/recvfrom. This is omitting any DAC restrictions, capability
> requirements,
> and IPTables rules which have first vote on denying the activity. The access
> control is mostly at the entry points to the transaction and not on a packet
> by
> packet basis (except perhaps udp where every packet is an entry point to the
> transaction).

The nut of my question, which I think Paul has answered, is about
the subtle distintion between A writing to B and B reading from A.
There sure is a lot of sophistication involved in the process, and
it looks as if A thinks it is writing and B thinks it is reading.
That implies an intermediate object for A to write and B to read.
As I noted before, models with insubstantial objects have been frowned
upon in the past. Y'all may be better positioned to argue in their
favor than I was back in '95 an '02.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
