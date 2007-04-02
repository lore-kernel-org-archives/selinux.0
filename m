Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l32HHnu2015417
	for <selinux@tycho.nsa.gov>; Mon, 2 Apr 2007 13:17:49 -0400
Received: from mx2.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l32HHlss021454
	for <selinux@tycho.nsa.gov>; Mon, 2 Apr 2007 17:17:47 GMT
Subject: Re: secmark integration
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: Eric Paris <eparis@parisplace.org>, Daniel J Walsh <dwalsh@redhat.com>,
        James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov,
        Joshua Brindle <method@manicmethod.com>
In-Reply-To: <1175526952.14681.44.camel@sgc>
References: <Line.LNX.4.64.0703191021480.22828@d.namei>
	 <1175284031.3602.24.camel@localhost.localdomain>
	 <1175286309.20396.13.camel@localhost.localdomain>
	 <Line.LNX.4.64.0703302201520.29742@d.namei>  <46111709.9060402@redhat.com>
	 <1175525718.20396.46.camel@localhost.localdomain>
	 <1175526952.14681.44.camel@sgc>
Content-Type: text/plain
Date: Mon, 02 Apr 2007 13:15:20 -0400
Message-Id: <1175534120.5433.2.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-04-02 at 15:15 +0000, Christopher J. PeBenito wrote:
> On Mon, 2007-04-02 at 10:55 -0400, Eric Paris wrote:
> > 
> > Good idea.  Can anyone help me come up with any way in which we can use
> > secmark 'by default' and gain any greater protections than we already
> > have with name_{bind,connect}
> > 
> > Seems to me that port number is the only thing we can label based on for
> > everyone out of the box.  Any more complex labeling scheme is going to
> > require network specific information, right?
> 
> Right.  Refpolicy already can create a set of iptables rules based on
> the ports defined in the policy, but its not currently shipped (which
> was decided at the summit).
> 

I don't think that there are particularly good restrictions that we can
do out of the box. I think that we should instead focus on making it
fairly easy to do customization with some documentation / recipes that
people can follow.

To that end, Chris / Dan, can you comment on my policy example? What I
posted doesn't exactly work now and I would like to know what the
suggested method for allowing almost all network facing daemons to
receive unlabeled_t packets is going to be.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
