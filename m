Subject: Re: [RFC][PATCH] libselinux: Namespacing
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1178827922.3504.141.camel@moss-spartans.epoch.ncsc.mil>
References: <1178827922.3504.141.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 10 May 2007 16:31:01 -0400
Message-Id: <1178829062.24335.86.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-05-10 at 16:12 -0400, Stephen Smalley wrote:
> libselinux presently lacks proper namespacing of its functions.  This
> patch is just for comment on an approach to gradually fixing that
> problem, starting with just a trivial example for a single function.
> The idea is to switch over the real function to being properly
> namespaced, provide an alias under the old name in the symbol table for
> binary compatibility, and make the old name a macro in the public
> headers that expands to the new name so that source rebuilds against the
> new library will start using the new name.  Then at some point in the
> future, we drop the old name macro from the source API, forcing an
> update to external sources to build against newer headers, while leaving
> the alias present in the symbol table as long as we need compatibility
> with existing binaries.  Thoughts?
> 

Sounds good to me - will this impact the python bindings? If we do have
to change the bindings we should take as an opportunity to fix the
namespace issues there. For example, bo reason to have
selinux.selinux_booleans_path - should be changed to
selinux.booleans_path.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
