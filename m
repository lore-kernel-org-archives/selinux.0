Subject: RE: [PATCH 3/3] Separate local file
	contextsinto	file_contexts.local
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B0158832B368@exchange.columbia.tresys.com>
References: 
	 <6FE441CD9F0C0C479F2D88F959B0158832B368@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Wed, 16 Aug 2006 08:41:06 -0400
Message-Id: <1155732066.18911.4.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-08-15 at 19:42 -0400, Joshua Brindle wrote:
> > From: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
> > 
> > On Mon, 2006-08-14 at 10:38 -0400, Stephen Smalley wrote:
> > > On Sat, 2006-08-12 at 09:21 -0400, Joshua Brindle wrote:
> > > > Stephen Smalley wrote:
> > > > > On Fri, 2006-08-11 at 09:34 -0400, Christopher J. 
> > PeBenito wrote:
> > 
> > Patch below restores the errors to being fatal, with 
> > exceptions being granted for an ENOENT for 
> > file_contexts.local (optional), seusers (was already 
> > non-fatal and optional), and netfilter_contexts (may not 
> > exist in all policies, e.g. legacy ones and ones that are 
> > using compat_net=1).
> > Acceptable to all parties?
> > 
> 
> I'm happy with this but does it fix the permission problem? I thought
> the motivation behind the patch was to be able to install the policy
> when the policy didn't allow copying of some files? ENOENT will just
> check if it doesn't exist won't it?

I decided that it wasn't adequate justification, since:
a) the same kind of permission problem could occur on the kernel policy
file too, at which point we have to go permissive to recover,
b) such a denial would reflect a bug in policy, and there is no general
way to recover from bugs in policy without going permissive,
c) all such issues would presumably be caught and resolved in
development and never hit a production system.

So if everyone is satisfied with the patch, I'll go ahead and commit it.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
