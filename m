Subject: Re: ipsec and getpeercon()
From: Joshua Brindle <jbrindle@tresys.com>
To: Paul Moore <paul.moore@hp.com>
Cc: Joy Latten <latten@austin.ibm.com>, latten@us.ibm.com,
        vyekkirala@TrustedCS.com, sds@tycho.nsa.gov, selinux@tycho.nsa.gov
In-Reply-To: <200609042332.34493.paul.moore@hp.com>
References: <200609011947.k81JlxUF020293@faith.austin.ibm.com>
	 <44F895EF.5070706@hp.com>
	 <1157373781.6716.8.camel@twoface.columbia.tresys.com>
	 <200609042332.34493.paul.moore@hp.com>
Content-Type: text/plain
Date: Tue, 05 Sep 2006 07:58:04 -0400
Message-Id: <1157457484.15886.12.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-09-04 at 23:32 -0400, Paul Moore wrote:
> On Monday 04 September 2006 8:43 am, Joshua Brindle wrote:
> > On Fri, 2006-09-01 at 16:19 -0400, Paul Moore wrote:
> > > Joy Latten wrote:
> > > > Yes, that is coming from netlabel. In
> > > > selinux_socket_getpeersec_stream() if the socket is tcp_socket class,
> > > > we call the cipso routine
> > > > first, selinux_netlbl_socket_getpeersec_stream(). I have not
> > > > thoroughly examined the cipso code, but at a glance I assumed
> > > > if cipso is enabled and its maps set up, this will come back with
> > > > something. If it doesn't come back with anything, I assumed
> > > > that meant cipso is either disabled or its maps not set up.
> > > > According to code, if nothing comes back from cipso, then
> > > > selinux_socket_getpeer_stream() is called which will look
> > > > for a xfrm on the dst. And if there is one, then use the security
> > > > context from the xfrm. Otherwise, return error.
> > > >
> > > > hmmm... this makes me wonder if Joshua had cipso enabled and that is
> > > > why it looks like getpeercon was not honoring the ipsec labels...
> > >
> > > A simple 'dmesg | grep NetLabel' will answer that question.
> > >
> > > I'll work on this and post something next week.  Unfortunately, the fix
> > > is not immediately obvious.
> >
> > Right, so I do have NetLabel running (didn't know that it shipped on in
> > Fedora kernels already)..
> >
> > There were no maps set up, it looks like all I had was the unlabeled
> > module.
> 
> That is what caused the problem then.  You don't need to have anything 
> actively configured, just having NetLabel built into the kernel and activated 
> will cause the bug.  If you feel like spinning your own kernel you can try 
> the patch I posted last Friday, it should fix the bug.
> 
> > This getpeercon() overloading seems to be a problem, how can an
> > application react reasonably if the label it gets when it calls
> > getpeercon() could come from multiple objects and have multiple
> > meanings?
> 
> It may be a problem right now but I think it is more of an issue of 
> reconciling the different network labeling systems.  The good news is that 
> work is ongoing to deal with this.
> 
> > To me getpeercon() means the context of the domain on the other side,
> > granted the implementation has been the socket context which, until now,
> > was always the domain on the other side. With the ability to label
> > sockets and with ipsec socket labeling and NetLabel (domain?) labeling
> > perhaps getpeercon() should be refactored into 2 functions, getpeercon()
> > and getsocketcon()?
> 
> I'm not sure that solves anything, all it does it make it the applications 
> problem as now the app developer has to have knowledge of the underlying 
> network labeling.  I think the best solution is to let the network labeling 
> reconciliation work take place, let the bugs get shaken out, and go from 
> there.
> 

I don't know, how are you really going to be able to reconcile multiple
labels on the underlying network connection? You don't think application
developers should be able to get the one they really want? 

Either way getpeercon() currently gets the context of the socket which I
don't think is expected by application developers, either when it is on
a local machine or with network labeling.

On the other hand using the socket label locally at least implements a
kind of IPC impersonation that flask specifies and can be very useful to
object managers, which is why I think the application developer should
be able to get the context that is actually interesting to them. Perhaps
a version that takes a class value that way one could get the
association context, the tcp socket (netlbl), process (actual remote
domain) and so on.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
