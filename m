Subject: Re: [PATCH] libsepol/checkpolicy: Add support for multiple target
 OSes
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Chad Sellers <csellers@tresys.com>
Cc: Joshua Brindle <method@manicmethod.com>, pjnuzzi <pjnuzzi@tycho.ncsc.mil>,
        selinux@tycho.nsa.gov
In-Reply-To: <C6D54298.AAB22%csellers@tresys.com>
References: <C6D54298.AAB22%csellers@tresys.com>
Content-Type: text/plain
Date: Tue, 15 Sep 2009 13:18:56 -0400
Message-Id: <1253035136.18198.10.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-09-15 at 13:09 -0400, Chad Sellers wrote:
> On 9/14/09 3:33 PM, "Stephen Smalley" <sds@tycho.nsa.gov> wrote:
> 
> > On Mon, 2009-09-14 at 15:07 -0400, Joshua Brindle wrote:
> >> On 09/14/2009 09:22 AM, pjnuzzi wrote:
> >>> Add support for multiple target OSes to libsepol and checkpolicy, where
> >>>    
> <snip> 
> >>> Solaris (e.g. "SolFlask") will be introduced later using this new target
> >>> mechanism if needed.  The same support can easily be extended for other
> >>> OSes.
> > 
> >> This is a fairly large patch, it might take a while to get through it.
> >> Splitting it up would have been helpful.
> > 
> > Sorry - based on Chad's earlier comment in response to another patch
> > that a complete single patch against the selinux tree was fine, and
> > given that this does form a single logical change against a single
> > repository, I recommended keeping it as a single patch.
> > 
> Sorry if I created confusion. I was just meaning splitting on component
> (libsepol, checkpolicy, etc.) was unnecessary. Splitting into logical pieces
> is still preferred, and I have a hard time believing that a patch this large
> could not be split into logical pieces.

It was one logical change - adding support for multiple target OSes,
where the Xen support represented the first new target.  In any event,
the patch was just re-posted split along component boundaries.  But note
that one of the reasons for such splitting in the Linux kernel case is
because different subsystems have different maintainers there.  In the
case of the selinux userland tree, there is one repo and one set of
maintainers for the entire tree, so it isn't clear that this is needed.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
