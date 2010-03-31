Subject: Re: [PATCH] Add implicit lib requirements to LDLIBS
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Eamon Walsh <ewalsh@tycho.nsa.gov>, SELinux List <selinux@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <4BB34C5C.7030309@tresys.com>
References: <1269983319-10453-1-git-send-email-jbrindle@tresys.com>
	 <4BB28AA1.9060508@tycho.nsa.gov>  <4BB34C5C.7030309@tresys.com>
Content-Type: text/plain
Date: Wed, 31 Mar 2010 11:15:49 -0400
Message-Id: <1270048549.19608.163.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2010-03-31 at 09:21 -0400, Joshua Brindle wrote:
> Eamon Walsh wrote:
> > On 03/30/2010 05:08 PM, Joshua Brindle wrote:
> >> Fedora 13 changed their linker behavior to not link indirect libraries.
> >> See information at: http://fedoraproject.org/wiki/UnderstandingDSOLinkChange
> >>
> >
> > I skimmed over semodule.c and setsebool.c and I didn't see any
> > references to bzip2 or ustr symbols.  My reading of the article suggests
> > the below fix should only be needed if that were the case.  Most likely
> > I missed them?
> >
> 
> The link above is confusing. The change was made so that people who 
> _did_ use eg., libxml but didn't explicitly link against it would have 
> to do so even if other libraries they link against already did.
> 
> In our case it means that anything libsemanage needs semodule and 
> setsebool will also need to link against explicitly.
> 
> Here is another page about the "feature":
> http://fedoraproject.org/wiki/Features/ChangeInImplicitDSOLinking
> 
> The summary pretty much covers it I think:
> ""Change DSO-linking semantics of the gcc compiler. Previously calls to 
> the linker (ld) from gcc would result in dangerous default behaviour 
> where ld would attempt to implicitly satisfy link requirements. The 
> proposed change will prevent ld from automatically searching in the 
> dependencies of linked objects.""
> 
> > Without this patch, do you get the linker error that says to add them?
> >
> 
> Yes. It complains about missing bz2 and ustr symbols on my F13 system.

This doesn't seem right to me either, and I don't quite understand why
Dan wouldn't have encountered it already if it was an issue.

As I read it, the change in behavior should only affect the program if
the program makes calls to symbols in the library and was previously
implicitly getting a dependency through another library.  But if the
program makes no calls to the library in question, it shouldn't need to
link against it.

I think something is wrong with the way we are building libsemanage.
Maybe this has something to do with our use of -z,defs there.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
