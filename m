Subject: Re: policycoreutils patch
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1177684208.15215.0.camel@localhost.localdomain>
References: <4630C59F.1070106@redhat.com>
	 <1177615134.3405.43.camel@localhost.localdomain>
	 <4631F19C.2090508@redhat.com>
	 <1177684208.15215.0.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 27 Apr 2007 11:10:39 -0400
Message-Id: <1177686639.3357.16.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-04-27 at 10:30 -0400, Karl MacMillan wrote:
> On Fri, 2007-04-27 at 08:50 -0400, Daniel J Walsh wrote:
> > Karl MacMillan wrote:
> > > On Thu, 2007-04-26 at 11:30 -0400, Daniel J Walsh wrote:
> > >   
> > >> This patch moves audit2why to /usr/bin to match audit2allow, since both
> > >> can be used from userspace.  Also moves sepolgen-ifget to /usr/sbin,
> > >> since this is not to be run by normal users.
> > >>
> > >>     
> > >
> > > sepolgen-ifgen can be run by a normal user and the output saved to an
> > > arbitrary file. audit2allow also has flags for reading the interface
> > > information from a non-default flag. So I think it should stay
> > > in /usr/bin.
> > >
> > > I merged the audit2why change to trunk, stable, and policyrep.
> > >
> > > Karl
> > >
> > >
> > >   
> > I guess the argument would be just because it can be run by a normal 
> > user,  should it be placed in /usr/bin?
> 
> That was my thinking.
> 
> >   I look at apps that are almost 
> > never run by normal users and tend to put them in /usr/sbin.  But 
> > overall I don't really care.  The only problem is that I have 
> > selinux-policy-devel package executes it in /usr/sbin.   So moving it 
> > back to /usr/bin would be a hassle.
> 
> I don't really care - anyone else have an opinion? Otherwise I can merge
> the move to sbin.

I have no strong opinion, but I think moving things around unnecessarily
leads to confusion and breakage and should be avoided.  And that these
kinds of changes should not be made in the Fedora packages _before_
being accepted upstream.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
