Subject: RE: Labeled networking packets
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        Chad Hanson <chanson@TrustedCS.com>,
        Darrel Goeddel <DGoeddel@TrustedCS.com>, dwalsh@redhat.com,
        jmorris@redhat.com, latten@austin.ibm.com,
        Paul Moore <paul.moore@hp.com>, Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <36282A1733C57546BE392885C0618592015735C9@chaos.tcs.tcs-sec.com>
References: <36282A1733C57546BE392885C0618592015735C9@chaos.tcs.tcs-sec.com>
Content-Type: text/plain
Date: Mon, 25 Sep 2006 10:59:26 -0400
Message-Id: <1159196366.3450.13.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-09-22 at 17:55 -0400, Venkat Yekkirala wrote: 
> > On Fri, 2006-09-22 at 13:23 -0400, Venkat Yekkirala wrote:
> > > OK, here's what we will do:
> > > 
> > > 1. We will have getpeercon() fail if there's no labeled-SA.
> > > 
> > > 2. We will do a getdatacon() or something similar to retrieve the
> > >    secmark (as reconciled in the proposed reconciliation 
> > logic, of course).
> > > 
> > > Comments?
> > 
> > I think that just moves the problem.
> 
> We put a design doc out 3 months or so back (alerting selinux list
> at least 2 times 
> http://marc.theaimsgroup.com/?l=linux-netdev&m=115136637800361&w=2),
> thought got the buy in, and went ahead and implemented
> it.
> 

I've been loosely following this, but had not looked closely until two
weeks ago when we tried to sit down and figure out how we were going to
use all of this new stuff to accomplish our goals.

I know it is frustrating to get delayed feedback, but I hope that it
will ultimately result in something better.

> What baffles me is that people even had problems using secmark as it
> currently exists, just a few days back. It tells me people look at what
> has come along, and THEN find (lack of) uses for it.
> 
> Let's go back to the drawing board, first of all define the problems
> we are trying to solve, and come up with a design.

Thinking about this over the weekend, it seems to me that we are still
talking around the problem a bit. We essentially have 2 goals:

    1) Packet labeling - assigning labels to the _data_ transferred
       over the network. Secmark does only this and - from what I can 
       tell - this has been the primary motivation for Netlabel and 
       ipsec.

    2) Domain (process) context transmission - essentially, making 
       getpeercon work for non-local sockets. The important thing here 
       is that this is separate and distinct from the label of the 
       packet. getpeercon (which is not just a poorly named function - 
       the semantic is intentional and useful) should return the full 
       context of the process on the other end of the network 
       connection.

There have been various suggestions about how to reconcile these two
goals, essentially via encoding additional data via range and type
transitions. I believe that this _will never work_. It is not possible
to recover the domain context fully from the packet label - if nothing
else the user and role will be lost (e.g., a data label would likely use
object_r), which is unacceptable for the imagined uses of getpeercon.

The choices I see are:

    1) Leave netlabel and ipsec as packet labeling _only_. Somehow 
       reconcile / prioritize the various packet labels.

    2) Make netlabel and ipsec transmit the sending domain context 
       _only_. Somehow reconcile the various domain labels.

    3) Allow ipsec to transmit 2 contexts or designate that Netlabel 
       passes 1 kind of remote label and ipsec transmits the other 
       (e.g., netlabel labels the packet while ipsec transmits the 
       sending domain context).

The primary drawbacks I see to 1 are that getpeercon will not work for
remote sockets and the current reconciliation schemes require divergent
policies depending upon the labeling mechanisms employed.

The problem with 2 is that it doesn't allow the sending machine to pass
information that it has about the label of the packet - this is probably
a large loss for MLS, but is also problematic for TE (e.g., my bind
example - only bind knows whether a packet is part of a zone transfer or
not).

3 is the most flexible but is probably the most complicated. It also
probably requires the most rewriting.

Just a general note - I think that multiple packet labeling mechanisms
cooperating is going to be difficult for users to understand and debug -
if we get users used to writing secmark rules with iptables it will be
surprising if those simply stop working for hosts that use labeled ipsec
(which is the current default). The notion that we need to have multiple
policies is going to make things difficult for distributors and users
(and is an unacceptable solution in my view). I think we need to focus
more on what the resulting policies will look like and what the
writing / debugging /setup process will look like for users.

Thanks,

Karl




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
