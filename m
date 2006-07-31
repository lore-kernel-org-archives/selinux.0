Subject: RE: [PATCH 0/2] new and improved range_transition statements
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
        Darrel Goeddel <dgoeddel@TrustedCS.com>,
        SELinux List <SELinux@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B0158832AA2D@exchange.columbia.tresys.com>
References: 
	 <6FE441CD9F0C0C479F2D88F959B0158832AA2D@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Mon, 31 Jul 2006 10:13:04 -0400
Message-Id: <1154355184.26550.58.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-07-31 at 10:01 -0400, Joshua Brindle wrote:
> > From: Karl MacMillan [mailto:kmacmillan@mentalrootkit.com] 
> > 
> > On Mon, 2006-07-31 at 09:56 -0400, Stephen Smalley wrote:
> > > On Mon, 2006-07-31 at 09:07 -0400, Karl MacMillan wrote:
> > > > My biggest question is how to handle the format change. There are 
> > > > some other bug fixes awaiting a module format change (not certain 
> > > > about kernel format change) and it would be nice to 
> > include those in 
> > > > this format bump. Unfortunately there are not patches for those 
> > > > fixes at the moment.
> > > > 
> > > > Could we branch the code for a month or so for the other 
> > changes can 
> > > > be introduced or is the fix more critical? Do you think that this 
> > > > must go into RHEL 5 / FC6? Is it possible for the kernel 
> > changes to 
> > > > make it in time for 2.6.18 and if they don't will this be 
> > included in RHEL 5 / FC6?
> > > 
> > > It doesn't necessarily have to be in 2.6.18 to make RHEL5; consider 
> > > the MLSXFRM and NetLabel patches, which are being queued for 2.6.19 
> > > but IIUC will be back ported and included in RHEL5.
> > > 
> > 
> > I know. I'm trying to get a feel for whether this change is 
> > critical or the workarounds mentioned in the bug are 
> > sufficient for now. If it is not critical I'd rather batch 
> > some other format changes. Otherwise the change should go in 
> > and potentially be backported if it misses 2.6.18.
> 
> I don't think any kernel format changes are planned so the kernel patch
> can go forward and we can branch off the userland for the changes you
> are talking about 

The kernel change isn't useful without the format change though. The
current approach (which seems right) requires both the kernel and module
format change, correct?

> (which ones are those btw?).
> 

The ones that I can remember are:

- scoping fixes to allow permissions to be scoped. Ideally this would
add enough scoping information to allow the relaxation of some of the
ordering constraints.

- fixing avrule_block to correctly represent what is possible (removing
arbitrary branches)

- better handling of type->flavor (if needed)

- whatever is needed to support incremental linking

Do you have anything else?

Karl

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
