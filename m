Subject: Re: [PATCH] libsemanage: Add Ruby Bindings
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: "David P. Quigley" <dpquigl@tycho.nsa.gov>,
        Joshua Brindle <method@manicmethod.com>, selinux@tycho.nsa.gov
In-Reply-To: <4A033383.3070508@redhat.com>
References: <1241708115-30840-1-git-send-email-dpquigl@tycho.nsa.gov>
	 <4A03161A.60206@manicmethod.com>
	 <1241716271.6624.1.camel@moss-terrapins.epoch.ncsc.mil>
	 <4A03264D.8070201@redhat.com>
	 <1241721308.6452.148.camel@localhost.localdomain>
	 <4A033383.3070508@redhat.com>
Content-Type: text/plain
Date: Thu, 07 May 2009 15:21:40 -0400
Message-Id: <1241724100.6452.165.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2009-05-07 at 15:16 -0400, Daniel J Walsh wrote:
> On 05/07/2009 02:35 PM, Stephen Smalley wrote:
> > On Thu, 2009-05-07 at 14:19 -0400, Daniel J Walsh wrote:
> >> On 05/07/2009 01:11 PM, David P. Quigley wrote:
> >>> On Thu, 2009-05-07 at 13:10 -0400, Joshua Brindle wrote:
> >>>> David P. Quigley wrote:
> >>>>> From: David P. Quigley<dpquigl@moss-guppy.epoch.ncsc.mil>
> >>>>>
> >>>>> This patch adds a SWIG specification file for ruby bindings for libsemanage.
> >>>>> The spec file is almost identical to the python SWIG file with the exception
> >>>>> that all list generating typemaps have been removed and the python related
> >>>>> functions have been replaced with the corresponding ruby ones. Finally the
> >>>>> Makefile is modified to be able to build the new bindings. Something to note is
> >>>>> that on 64-bit systems ruby.h might be found somewhere under /usr/lib64 instead
> >>>>> of /usr/lib so LIBDIR=/usr/lib64 will be needed to build the ruby bindings from
> >>>>> source.
> >>>> What is going to be using these bindings?
> >>> I currently have several Facter addons for Puppet that make use of them.
> >>> We are looking into what can be done to expand Puppet's ability to
> >>> effectively manage systems with SELinux.
> >>>
> >>> Dave
> >>>
> >>>
> >>> --
> >>> This message was distributed to subscribers of the selinux mailing list.
> >>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> >>> the words "unsubscribe selinux" without quotes as the message.
> >> My concern with doing this patch is that we end up with puppetd being
> >> able to manage selinux policy directly rather then executing semanage
> >> command.  But for now puppetd needs to run as an unconfined domain.
> >
> > I don't think we gain much by such separation, as puppetd will run in a
> > single domain (so even with policy access control in libsemanage, we
> > would still end up allowing puppetd_t to make any desired policy
> > changes) and it would control all the inputs to semanage.
> >
> > Forcing it to use a helper utility rather than being able to directly
> > use the interface will just make error handling and reporting more
> > awkward and will make it slower (as motivated the bindings for
> > libselinux, right?).  There is no real trust boundary there.
> >
> Well when I first wrote system-config-selinux, I used the libsemanage 
> python bindings and ended up with a Huge X Windows application that 
> needed full access to semanage functionality.  I understand the 
> motivation, but I still would like to break semanage functionality up so 
> that I could allow a domain to only set booleans for example (Or 
> particular booleans)

Yes, it definitely makes sense for GUI apps to run a small privileged
helper in a separate domain.  It isn't as clear in the case of puppetd.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
