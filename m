Subject: Re: The problem with TUN/TAP devices
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Moore <paul.moore@hp.com>
Cc: Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov
In-Reply-To: <200907011119.11108.paul.moore@hp.com>
References: <200906301734.31986.paul.moore@hp.com>
	 <7e0fb38c0907010801n7516d4e3ib5f11716a0bf6293@mail.gmail.com>
	 <1246460811.13464.182.camel@moss-pluto.epoch.ncsc.mil>
	 <200907011119.11108.paul.moore@hp.com>
Content-Type: text/plain
Date: Wed, 01 Jul 2009 11:42:19 -0400
Message-Id: <1246462939.13464.185.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-07-01 at 11:19 -0400, Paul Moore wrote:
> On Wednesday 01 July 2009 11:06:51 am Stephen Smalley wrote:
> > On Wed, 2009-07-01 at 11:01 -0400, Eric Paris wrote:
> > > On Wed, Jul 1, 2009 at 9:44 AM, Stephen Smalley<sds@tycho.nsa.gov> wrote:
> > > > On Tue, 2009-06-30 at 17:34 -0400, Paul Moore wrote:
> > > >
> > > > Wouldn't it be a bug if they didn't match?  So I'd add the sk_alloc()
> > > > hook, set the label/SID for the sock there, and remove the setting of
> > > > the sock label/SID from post_create.  And then just add a BUG_ON to
> > > > post_create to assert that the inode SID should be the same as the sock
> > > > SID and if they don't match something has gone wrong.
> > >
> > > I've got a system all set up to test anything you want/have/need....
> > > Maybe this afternoon I'll even give this suggestion a try just to see
> > > what happens, the networking hooks are ummmm, special?
> >
> > Wait - we already have a sk_alloc_security hook.
> 
> Yep, this is where we would set the sock's label/SID.
> 
> > And IIRC, we don't set the SID/label there because that can happen when a
> > new connection sock is created, and thus outside of process context.
> 
> This gets back to my original comments about "ugliness".  New incoming 
> connection sockets should get labeled correctly before use through the 
> inet_conn_request() and inet_csk_clone() hooks.  While admittedly, there is 
> the potential for the sock to be labeled incorrectly immediately after 
> allocation, but this is not very different from what we have today (sock is 
> initially labeled with unlabeled_t).

unlabeled_t is easily noticeable in denials (as in this case) and
correctly reflects the state of the socket - it isn't yet labeled.
Setting the sid from the task sid of some random task that happens to be
referenced by current when the new connection is initiated seems a
little more prone to danger if it happens to not get set by the other
hooks later.

> 
> I'll put something together and post an RFC this afternoon, the patch should 
> be relatively small.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
