Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9AFtoEQ020007
	for <selinux@tycho.nsa.gov>; Tue, 10 Oct 2006 11:55:50 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k9AFtBTb012590
	for <selinux@tycho.nsa.gov>; Tue, 10 Oct 2006 15:55:11 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: Denials from newest kernel
Date: Tue, 10 Oct 2006 11:55:42 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B015884442D5@exchange.columbia.tresys.com>
In-Reply-To: <1160489274.20774.56.camel@sgc>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        "Venkat Yekkirala" <vyekkirala@TrustedCS.com>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: Christopher J. PeBenito 
> 
> On Mon, 2006-10-09 at 19:40 -0400, Venkat Yekkirala wrote:
> > 
> > > 
> > > So I guess maybe this is getting the target from the 
> outgoing port 
> > > (which is probably 80) and then the source from the local port 
> > > (which
> > 
> > No, the "source" here is whatever domain the packet is 
> carrying at the 
> > point it hits the secmark rule that specifies the target.
> 
> I don't think this is a desired behavior for a couple 
> reasons.  First, this means that every domain that has access 
> to a specific packet, for example, http_client_packet_t, but 
> not to client_packet_t, will have to dontaudit the 
> client_packet_t access.  Thats a lot of dontauditing, and 
> also it will cover up legitimate denials on client_packet_t.  
> Second, this will cause permissive to have a different 
> behavior than enforcing.
> This makes development in permissive more difficult, since 
> you'll get spurious denials that you wouldn't get in enforcing.
> 

I (think) understand what is happening technically, everytime you hit a
secmark rule the label gets set on the skbuff which triggers an access
check. Subsequent secmark rules trigger an access check between the old
label and the new one (I still suspect this should be a different
permission), but it is still very unintuitive to me, and I'd imagine
pretty much everyone else.

(reading your email that just arrived..) 
You really think that you can tell millions of users that they have to
use iptables in James' way, with hundreds or thousands of chains and
they'll buy it? That is not how iptables is normally used, noone who
currently uses iptables is going to like it.. 


Anyway, the real issue I have is that I was under the impression that
flow_out was a permission between a packet type and an association, to
indicate that the packet type can flow out the association type. This
makes sense and is very useful, so that we can bind very specific
properties of packets to ipsec associations. 

I just don't get why there are denials on flow_in and flow_out that have
no association in either the source or target, how does flow_out make
sense for a secmark changing because it hit more than 1 iptables rule? 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
