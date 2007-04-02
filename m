Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l32EtQ18006981
	for <selinux@tycho.nsa.gov>; Mon, 2 Apr 2007 10:55:26 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l32EtMkc012179
	for <selinux@tycho.nsa.gov>; Mon, 2 Apr 2007 14:55:23 GMT
Subject: Re: secmark integration
From: Eric Paris <eparis@parisplace.org>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: James Morris <jmorris@namei.org>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>, selinux@tycho.nsa.gov,
        Joshua Brindle <method@manicmethod.com>
In-Reply-To: <46111709.9060402@redhat.com>
References: <Line.LNX.4.64.0703191021480.22828@d.namei>
	 <1175284031.3602.24.camel@localhost.localdomain>
	 <1175286309.20396.13.camel@localhost.localdomain>
	 <Line.LNX.4.64.0703302201520.29742@d.namei>  <46111709.9060402@redhat.com>
Content-Type: text/plain
Date: Mon, 02 Apr 2007 10:55:18 -0400
Message-Id: <1175525718.20396.46.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-04-02 at 10:45 -0400, Daniel J Walsh wrote:
> James Morris wrote:
> > On Fri, 30 Mar 2007, Eric Paris wrote:
> >
> >   
> >>> Is this really needed as long as the distro provides a way to customize
> >>> the iptables rules?
> >>>       
> >> It's not just that.  The reason a new table was proposed was because
> >> people may want to iptables -F and flush their rules.  If the secmark
> >> stuff is on the main tables (filter and nat) that people use it will get
> >> blown away and there will be no automation of a boolean setting you talk
> >> about later.
> >>     
> >
> > I think there's also a good case for a separate table on the basis that 
> > the rules are part of a separate administrative realm (e.g. MAC, rather 
> > than DAC) and should be maintained separately.  We could also look at 
> > adding an LSM hook for rules being manipulated in this table (perhaps 
> > called 'security' to be more general).
> >
> > Note that there may be tools which parse /proc/net/ip_tables_names when 
> > flushing (which the LSM hook would possibly help with in terms of stopping 
> > MAC policy from being modified without the correct authorization).
> >
> > It still may be difficult to sell upstream, so we'd need more feedback 
> > from the distro folk possibly after some experimentation.
> >
> >
> > - James
> >   
> 
> I like karl suggestion.  service iptables stop , flips boolean that says 
> all domains support unlabeled_t:packet.  service iptables start turns 
> that off.
> 
> Currently there is a boolean in Rawhide allow_unlabeled_packets.
> 
> tunable_policy(`allow_unlabeled_packets',`
>         kernel_sendrecv_unlabeled_association(domain)
>         corenet_sendrecv_unlabeled_packets(domain)
> ')
> These lines endup generating these rules
>         allow domain unlabeled_t:packet { send recv };
>         allow domain $1 unlabeled_t:association { sendto recvfrom };
> 
> This boolean defaults to true.
> 
> 
> I think as soon as FC7 ships we can start experimenting in Rawhide and 
> build a couple of scripts/modules that people could use to take 
> advantage of secmark.

Good idea.  Can anyone help me come up with any way in which we can use
secmark 'by default' and gain any greater protections than we already
have with name_{bind,connect}

Seems to me that port number is the only thing we can label based on for
everyone out of the box.  Any more complex labeling scheme is going to
require network specific information, right?

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
