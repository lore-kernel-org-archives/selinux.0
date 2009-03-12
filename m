Subject: Re: Significance of the level on a port configuration
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Moore <paul.moore@hp.com>
Cc: Andy Warner <warner@rubix.com>, SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <200903121107.27468.paul.moore@hp.com>
References: <49B7F893.9040706@rubix.com>
	 <1236793639.14649.67.camel@localhost.localdomain>
	 <200903121107.27468.paul.moore@hp.com>
Content-Type: text/plain
Date: Thu, 12 Mar 2009 11:09:26 -0400
Message-Id: <1236870566.22058.117.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2009-03-12 at 11:07 -0400, Paul Moore wrote:
> On Wednesday 11 March 2009 01:47:19 pm Stephen Smalley wrote:
> > On Wed, 2009-03-11 at 18:44 +0100, Andy Warner wrote:
> > > Can someone give me a quick overview of the significance (i.e., the
> > > MLS behavior) of the port level for SELinux.
> > >
> > > I am attempting to have two connection from untrusted hosts that are
> > > statically labeled (with netlabelctl) one at high (s0) and one at low
> > > (s1). Both connections will be made over the same port number. The
> > > service accepting the connections runs at SystemHigh on Fedora 9 with
> > > MLS policy. What difference does the level of the port make ? Assume
> > > all TE rules are satisfied for the context of my question.
> >
> > I don't think the port level should make any difference.  Are there any
> > MLS constraints defined on any of the permission checks that are based
> > on port contexts?
> 
> Using the new network access controls there is no specific check against the 
> port label, only the network interface and node (both of which just recently 
> had the MLS constraints added).

name_bind/name_connect are still port-based, but there are no MLS
constraints on them.

The older per-packet send_msg/recv_msg checks are only applied if
compat_net=1.  send_msg has no MLS constraint.  recv_msg is included in
the socket "read" ops MLS constraint for reasons unclear to me; that
seems like a mistake.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
