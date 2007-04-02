Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l32HUI9d016058
	for <selinux@tycho.nsa.gov>; Mon, 2 Apr 2007 13:30:18 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l32HUGss024748
	for <selinux@tycho.nsa.gov>; Mon, 2 Apr 2007 17:30:17 GMT
Subject: Re: secmark integration
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Joshua Brindle <method@manicmethod.com>
Cc: James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>,
        Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov
In-Reply-To: <46113A09.4040607@manicmethod.com>
References: <Line.LNX.4.64.0703191021480.22828@d.namei>
	 <1175284031.3602.24.camel@localhost.localdomain>
	 <1175286309.20396.13.camel@localhost.localdomain>
	 <Line.LNX.4.64.0703302201520.29742@d.namei>  <46111709.9060402@redhat.com>
	 <1175525718.20396.46.camel@localhost.localdomain>
	 <Line.LNX.4.64.0704021215020.8213@d.namei>
	 <46113A09.4040607@manicmethod.com>
Content-Type: text/plain
Date: Mon, 02 Apr 2007 13:28:02 -0400
Message-Id: <1175534882.5433.17.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-04-02 at 13:14 -0400, Joshua Brindle wrote:
> James Morris wrote:
> > On Mon, 2 Apr 2007, Eric Paris wrote:
> >
> >   
> >> Seems to me that port number is the only thing we can label based on for
> >> everyone out of the box.  Any more complex labeling scheme is going to
> >> require network specific information, right?
> >>     
> >
> > For gateways & externally facing systems, we could use types for the 
> > interfaces, e.g. external_netif, internal_netif and have a loadable module 
> > or something which differentiates between internal and external traffic.
> >
> >   
> Unfortunately it isn't nearly this easy. If your security goal was just 
> to differentiate internal and external traffic it would work fine but 
> you'd be losing all granularity of port based access control. To do this 
> with the refpolicy model of labeling based on service ports you'd have 
> to replicate the entire corenetwork module with internal and external 
> types and then fix all the service domains to be able to use the 
> appropriate ones. I just don't think this scales.
> 

I think that controlling port binding plus separating the traffic with
secmark will be sufficient in most cases. There is no advantage to
replicating the port binding rules with secmark (except perhaps with
protocols that connect to random ports like nis or ftp).

I'd also suggest that corenetwork should be used primarily for the
name_[bind/connect] checks and push the rest of the network controls
into secmark rules and custom modules. That reduces the number of
iptables rules by default and reduces the customization needed in
corenetwork.

Again, pushing secmark labeling into the selinux policy destroys the
flexibility we gain with secmark and becomes a management nightmare.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
