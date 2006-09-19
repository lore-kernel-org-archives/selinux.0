Subject: Re: ipsec, netlabels, secmark- How about a little usability?
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: James Antill <jantill@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Joshua Brindle <jbrindle@tresys.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1158252565.25629.111.camel@moss-spartans.epoch.ncsc.mil>
References: <45095092.6080603@redhat.com>  <45095E10.2020205@tresys.com>
	 <1158249777.8442.13.camel@code.and.org>
	 <1158252565.25629.111.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 19 Sep 2006 16:47:11 -0400
Message-Id: <1158698831.15306.27.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-09-14 at 12:49 -0400, Stephen Smalley wrote:
> On Thu, 2006-09-14 at 12:02 -0400, James Antill wrote:
> > On Thu, 2006-09-14 at 09:50 -0400, Joshua Brindle wrote:
> > > Daniel J Walsh wrote:
> > > > 1.  By default httpd has to be able to talk to itself in order to do 
> > > > gracefull shutdown,
> > > > service httpd graceful.
> > > >
> > > > So I end up adding a rule allowing httpd to name_connect to the 
> > > > httpd_port_t.    But I really only want to allow this for localhost.  
> > > > IE I don't want to allow my httpd to name_connect to other machines 
> > > > httpd ports?  I can't do this now.
> > > >
> > > you can with secmark can't you?
> > > iptables -I -p tcp -d localhost -s localhost -i lo --dport 80 -j SECMARK 
> > > --selctx system_u:object_r:httpd_client_packet_t
> > 
> >  This one rule, both allows httpd_t to connect to localhost:80 and
> > disallows it from connecting to anything-else:80 ?
> > 
> >  From the documentation --selctx just sets the "SELinux security
> > context" ... so you presumably _also_ need some bit of policy code that
> > says "httpd_t can only name_bind(?) with httpd_client_packet_t"?
> 
> The iptables rule only deals with labeling the packet with a type.  The
> policy deals with what domains can send/recv a given packet via allow
> rules like:
> 	allow httpd_t http_client_packet_t:packet { send recv };
> encapsulated in interfaces like:
> 	corenet_sendrecv_http_client_packet(httpd_t)
> 
> But the problem I see with the above example is that refpolicy already
> generates a netfilter contexts entry that maps _everything_ going to
> port 80 with http_client_packet_t, so we would need to delete that entry
> to make the above work, or use a different type
> (http_client_packet_lo_t) and only allow httpd_t to send it, not the
> generic http_client_packet_t.  All of which gets back to proper
> integration.
> 

I'm beginning to think that this integration is a mistake, which is one
of the reasons it has not been enabled in rawhide. The problems are:

1) This generates _many_ rules - most of which are unnecessary - that
are going to have an adverse effect on performance. This is made worse
by the fact they are mangle rules and will be run even if the other
iptables rules ultimately drop the packet.

2) The policy doesn't allow expressing the full iptables semantics (as
it probably shouldn't).

3) It is not clear how users should override the defaults - using
semanage has the disadvantage of forcing full iptables syntax into
semanage. Adding rules later with iptables means that some rules come
from the policy and some from iptables (it also leaves unused rules
further hurting performance).

Of course, leaving this all up to iptables is hard as well. I don't have
a good answer - all the management options we have evaluated so far have
serious drawbacks. Any suggestions?

> > 
> > > > 2.  I as a sysadm have setup a apache web site that allows connections 
> > > > from the outside and needs to connect to three mysql servers on my 
> > > > internal network. So I need to allow it to connect to those three 
> > > > machines on the internal network only.  How am I as the Sysadm going 
> > > > to set this up.
> > > >
> > > again, secmark
> > 
> >  Err, no. The requirement here is that:
> > 
> > 1. httpd_t on one machine is only allowed to connect to mysqld_t(?) on
> > one of these 3 machines.
> > 
> > ...AIUI secmark doesn't know the label of the proc. on the other
> > machines, even when using ipsec/netlabel.
> 

This brings up another problem with secmark / ipsec / netlabel. Secmark
will be labeling the packets with a derived type (e.g., mysql_packet_t)
while netlabel / ipsec will label them with the process type (mysql_t).
Assuming that the packet object class permissions are enforced with
netlabel / ipsec (is this true?), then how are we going to manage
policy?

One of the nice parts of separating the labeling from the enforcement is
that the policy shouldn't change. Currently, though, it looks like that
won't be the case.

> Yes, but you can label the output packet via secmark with one type if it
> is destined for the mysql port on one of the "good" machines and a
> different type otherwise, and only allow httpd_t to send the "good"
> type.   On the internal machines, you can ensure that only mysqld_t can
> bind to that port.  That doesn't really require a network labeling
> mechanism like ipsec or netlabel per se.
> 

Given the fact that for ipsec or netlabel to work correctly you must
have two trusted machines with similar or the same policies, what
advantage is there to labeling the packets? Why not just have
complimentary secmark configurations? Does this help with non-tcp
protocols?

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
