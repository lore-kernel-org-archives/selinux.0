Date: Mon, 28 Mar 2005 19:27:14 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, selinux@tycho.nsa.gov,
   fedora-selinux-list@redhat.com
Subject: Re: Desktop apps interoperability
Message-ID: <20050328182714.GG3430@lkcl.net>
References: <1111985855.1514.70.camel@cobra.ivg2.net> <20050328100449.GC3430@lkcl.net> <1112016992.2914.19.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1112016992.2914.19.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Mar 28, 2005 at 08:36:32AM -0500, Stephen Smalley wrote:
> On Mon, 2005-03-28 at 11:04 +0100, Luke Kenneth Casson Leighton wrote:
> > On Sun, Mar 27, 2005 at 11:57:35PM -0500, Ivan Gyurdiev wrote:
> > 
> > > There can't be more than one file_type_auto_trans on the same folder
> > > type (right?). 
> > 
> >  bizarrely, no.
> > 
> >  i believe this issue was raised some months ago, with the
> >  "alternative file context" thing.
> > 
> >  if file_type_auto_trans also took an executable [domain] as an
> >  additional argument, i believe you stand a chance of achieving
> >  what you seek.
> 
> file_type_auto_trans() is based on the domain of the creating process,
> the type of the parent directory, and optionally the class of the new
> file.  

 brain-lapse.  of course it is.  duh.

> [description of how to make programs security-aware]

 so the issue ivan describes _can_ be solved.

 ... question: in what ways do you ensure that a security-aware
 compromised program is only allowed to create certain filetypes?

 is it to do with using compute_av()?

 l.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
