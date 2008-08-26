Subject: Re: [PATCH] Revised Patch for local nodecon support in semanage
	(was: Adding local nodecon's through semanage)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Christian Kuester <c.kuester@tarent.de>
Cc: selinux@tycho.nsa.gov, Joshua Brindle <method@manicmethod.com>,
        Daniel J Walsh <dwalsh@redhat.com>, Paul Moore <paul.moore@hp.com>
In-Reply-To: <1219352376.4200.91.camel@moss-spartans.epoch.ncsc.mil>
References: <486CD88E.2000406@tarent.de>
	 <1215450682.27975.108.camel@moss-spartans.epoch.ncsc.mil>
	 <48733DCF.3000808@tarent.de>
	 <1215520245.27975.231.camel@moss-spartans.epoch.ncsc.mil>
	 <1217333603.20373.158.camel@moss-spartans.epoch.ncsc.mil>
	 <48A3DF80.4060905@tarent.de>
	 <1219352376.4200.91.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 26 Aug 2008 09:37:53 -0400
Message-Id: <1219757873.2721.201.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-08-21 at 16:59 -0400, Stephen Smalley wrote:
> On Thu, 2008-08-14 at 09:32 +0200, Christian Kuester wrote:
> > Stephen Smalley schrieb:
> > 
> > Hi List,
> > 
> > > On Tue, 2008-07-08 at 08:30 -0400, Stephen Smalley wrote:
> > >> On Tue, 2008-07-08 at 12:13 +0200, Christian Kuester wrote:
> > >>>> Other tidbits on the semanage patch that I noticed:
> > >>>> - semanage node -l was broken, requires additional argument that has
> > >>>> been added to the list methods subsequently.  Also would be nice to
> > >>>> support locallist/-C option.
> > >>>> - semanage node -p option should take a string rather than an integer
> > >>>> and map it to the proper symbolic constant for ipv4/ipv6.
> > >> Please be sure to test each of the nodeRecords methods.
> > > Are you still pursuing getting this cleaned up and merged?
> > 
> > Sorry, it took some time. The revised patch for nodecon support in
> > the semanage tool is attached.
> > 
> > It now takes strings as arguments for the ip protocol. list/locallist
> > work as expected and output is more readable. I also made changes for
> > the semanage.8 man page.
> 
> semanage node -lC appears to list all of the entries rather than only
> the local modifications (i.e. the ones in the nodes.local file).
> Compare with semanage fcontext -lC or port -lC.
> 

Ok, this turned out to be trivial - just needed to pass the localist
value to the get_all() call. Fixed and committed, thanks.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
