Subject: Re: Kernel oops on fc6 with non-mls policy
From: Eric Paris <eparis@redhat.com>
To: Paul Moore <paul.moore@hp.com>
Cc: Joshua Brindle <jbrindle@tresys.com>, selinux@tycho.nsa.gov,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        James Morris <jmorris@namei.org>
In-Reply-To: <200702011940.19460.paul.moore@hp.com>
References: 
	 <6FE441CD9F0C0C479F2D88F959B015887BA64D@exchange.columbia.tresys.com>
	 <1170361225.6447.23.camel@localhost.localdomain>
	 <200702011940.19460.paul.moore@hp.com>
Content-Type: text/plain
Date: Thu, 01 Feb 2007 19:50:19 -0500
Message-Id: <1170377419.6447.25.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-02-01 at 19:40 -0500, Paul Moore wrote:
> On Thursday 01 February 2007 3:20 pm, Eric Paris wrote:
> > On Thu, 2007-02-01 at 14:58 -0500, Joshua Brindle wrote:
> > > There seems to be a kernel oops on non-mls policies with the fc6 kernel.
> > > It appears that netlabel is the culprit but I couldn't immediately track
> > > down the issue, the mls functions all seem to be returning if mls is
> > > disabled. The oops and ksymoops output is available at
> > > http://pastebin.com/872996.
> > >
> > > I have seen another that isn't there that happens on unix_stream_connect
> > > and oopses in security_sid_mls_copy->ebitmap_cpy.
> > >
> > > Is this a known issue?
> >
> > http://marc2.theaimsgroup.com/?l=selinux&m=116920292206962&w=2
> >
> > I believe.
> >
> > Will get fixed in FC7 when the kernel gets new enough to pick it up from
> > upstream.  Will not get fixed in RHEL5 until U1.
> 
> Sorry, I hit send on the other email too soon ...
> 
> I also pushed this to the 2.6.19-stable tree and I received mail this Tuesday 
> that it has been queued up for the next stable release.  Does FC pull updated 
> stable kernels (i.e. will this get fixed before FC7)?

Yes they do.  I meant FC6.  (but it will work in 7 too)

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
