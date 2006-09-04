Subject: Re: ipsec and getpeercon()
From: Joshua Brindle <jbrindle@tresys.com>
To: Paul Moore <paul.moore@hp.com>
Cc: Joy Latten <latten@austin.ibm.com>, latten@us.ibm.com,
        vyekkirala@TrustedCS.com, sds@tycho.nsa.gov, selinux@tycho.nsa.gov
In-Reply-To: <44F895EF.5070706@hp.com>
References: <200609011947.k81JlxUF020293@faith.austin.ibm.com>
	 <44F895EF.5070706@hp.com>
Content-Type: text/plain
Date: Mon, 04 Sep 2006 08:43:01 -0400
Message-Id: <1157373781.6716.8.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-09-01 at 16:19 -0400, Paul Moore wrote:
> Joy Latten wrote:
> > Yes, that is coming from netlabel. In selinux_socket_getpeersec_stream()
> > if the socket is tcp_socket class, we call the cipso routine
> > first, selinux_netlbl_socket_getpeersec_stream(). I have not
> > thoroughly examined the cipso code, but at a glance I assumed
> > if cipso is enabled and its maps set up, this will come back with
> > something. If it doesn't come back with anything, I assumed
> > that meant cipso is either disabled or its maps not set up. 
> > According to code, if nothing comes back from cipso, then 
> > selinux_socket_getpeer_stream() is called which will look 
> > for a xfrm on the dst. And if there is one, then use the security
> > context from the xfrm. Otherwise, return error.
> >  
> > hmmm... this makes me wonder if Joshua had cipso enabled and that is why
> > it looks like getpeercon was not honoring the ipsec labels... 
> > 
> 
> A simple 'dmesg | grep NetLabel' will answer that question.
> 
> I'll work on this and post something next week.  Unfortunately, the fix
> is not immediately obvious.
> 

Right, so I do have NetLabel running (didn't know that it shipped on in
Fedora kernels already)..

There were no maps set up, it looks like all I had was the unlabeled
module. 

This getpeercon() overloading seems to be a problem, how can an
application react reasonably if the label it gets when it calls
getpeercon() could come from multiple objects and have multiple
meanings? 

To me getpeercon() means the context of the domain on the other side,
granted the implementation has been the socket context which, until now,
was always the domain on the other side. With the ability to label
sockets and with ipsec socket labeling and NetLabel (domain?) labeling
perhaps getpeercon() should be refactored into 2 functions, getpeercon()
and getsocketcon()?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
