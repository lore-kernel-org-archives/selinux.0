Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l32Eqtp5006810
	for <selinux@tycho.nsa.gov>; Mon, 2 Apr 2007 10:52:55 -0400
Received: from atlrel6.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l32Eqqd2002349
	for <selinux@tycho.nsa.gov>; Mon, 2 Apr 2007 14:52:52 GMT
From: Paul Moore <paul.moore@hp.com>
To: James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>
Subject: Re: secmark integration
Date: Mon, 2 Apr 2007 10:52:13 -0400
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>, selinux@tycho.nsa.gov,
        Joshua Brindle <method@manicmethod.com>,
        Daniel J Walsh <dwalsh@redhat.com>
References: <Line.LNX.4.64.0703191021480.22828@d.namei> <1175286309.20396.13.camel@localhost.localdomain> <Line.LNX.4.64.0703302201520.29742@d.namei>
In-Reply-To: <Line.LNX.4.64.0703302201520.29742@d.namei>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200704021052.13406.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday, March 30 2007 10:09:45 pm James Morris wrote:
> On Fri, 30 Mar 2007, Eric Paris wrote:
> > > Is this really needed as long as the distro provides a way to customize
> > > the iptables rules?
> >
> > It's not just that.  The reason a new table was proposed was because
> > people may want to iptables -F and flush their rules.  If the secmark
> > stuff is on the main tables (filter and nat) that people use it will get
> > blown away and there will be no automation of a boolean setting you talk
> > about later.
>
> I think there's also a good case for a separate table on the basis that
> the rules are part of a separate administrative realm (e.g. MAC, rather
> than DAC) and should be maintained separately.  We could also look at
> adding an LSM hook for rules being manipulated in this table (perhaps
> called 'security' to be more general).

I agree that if we add a new table it should be a generic security/lsm table.  
While presently only secmark would make use of it; the iptables in/out/fwd 
checks for externally labeled packets discussed most recently at the 
developer's summit could also make use of the same table for the same reasons 
as secmark.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
