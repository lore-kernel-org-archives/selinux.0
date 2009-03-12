From: Paul Moore <paul.moore@hp.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: Significance of the level on a port configuration
Date: Thu, 12 Mar 2009 11:24:27 -0400
Cc: Andy Warner <warner@rubix.com>, SELinux List <selinux@tycho.nsa.gov>
References: <49B7F893.9040706@rubix.com> <200903121107.27468.paul.moore@hp.com> <1236870566.22058.117.camel@localhost.localdomain>
In-Reply-To: <1236870566.22058.117.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200903121124.27596.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 12 March 2009 11:09:26 am Stephen Smalley wrote:
> On Thu, 2009-03-12 at 11:07 -0400, Paul Moore wrote:
> > On Wednesday 11 March 2009 01:47:19 pm Stephen Smalley wrote:
> > > On Wed, 2009-03-11 at 18:44 +0100, Andy Warner wrote:
> > > > Can someone give me a quick overview of the significance (i.e., the
> > > > MLS behavior) of the port level for SELinux.
> > > >
> > > > I am attempting to have two connection from untrusted hosts that are
> > > > statically labeled (with netlabelctl) one at high (s0) and one at low
> > > > (s1). Both connections will be made over the same port number. The
> > > > service accepting the connections runs at SystemHigh on Fedora 9 with
> > > > MLS policy. What difference does the level of the port make ? Assume
> > > > all TE rules are satisfied for the context of my question.
> > >
> > > I don't think the port level should make any difference.  Are there any
> > > MLS constraints defined on any of the permission checks that are based
> > > on port contexts?
> >
> > Using the new network access controls there is no specific check against
> > the port label, only the network interface and node (both of which just
> > recently had the MLS constraints added).
>
> name_bind/name_connect are still port-based, but there are no MLS
> constraints on them.

I got the impression that Andy was interested in port based MLS constraints in 
the context of per-packet access control.

> The older per-packet send_msg/recv_msg checks are only applied if
> compat_net=1.  send_msg has no MLS constraint.  recv_msg is included in
> the socket "read" ops MLS constraint for reasons unclear to me; that
> seems like a mistake.

I don't know of the reasoning behind that decision either, but this will be 
less of an issue in the future as the compat_net code will be going away soon.

-- 
paul moore
linux @ hp


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
