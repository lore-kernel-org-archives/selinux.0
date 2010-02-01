Subject: Re: [PATCH] Allowing MLS->non-MLS and vice versa upon policy reload
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Guido Trentalancia <guido@trentalancia.com>
Cc: selinux@tycho.nsa.gov, eparis@parisplace.org, jmorris@namei.org
In-Reply-To: <201002011825.o11IPhsu011947@vivaldi36.register.it>
References: <201002011825.o11IPhsu011947@vivaldi36.register.it>
Content-Type: text/plain
Date: Mon, 01 Feb 2010 14:15:30 -0500
Message-Id: <1265051730.12435.246.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2010-02-01 at 19:25 +0100, Guido Trentalancia wrote:
> Stephen,
> 
> thanks very much for your last comment. I always forgot to talk about that, despite my intention was to discuss it... It's just that there were many tiny details to discuss.
> 
> > ocontexts[OCON_ISID] is a list of initial SIDs and their 
> > contexts. Your current code takes the MLS range from 
> > whatever happens to be the first entry in the list and uses 
> > that for all of the contexts.
> 
> At the beginning I was scanning for "unlabeled" in oc->u.name with
> strcmp(), but then I wasn't sure about adding extra complexity to the
> code and I left that out waiting for your comments.
> 
> At present, for the latest reference policy the first initial SID is
> "kernel", which surely isn't the best match, but as I already told you
> I was waiting for some feedback on details.
> 
> I will introduce your piece of code (assuming there is always going to
> be an entry for SECINITSID_UNLABELED in the list).
> 
> By the way, is there any drawback in loading the initial SIDs again
> from security_load_policy() using the appropriate function that you
> mentioned ?

policydb_load_isids() is only called from security_load_policy() in the
initial policy load case (!ss_initialized) to initially populate the SID
table from the policy.

In the policy reload case, we instead clone the existing SID table,
convert the entries, and ignore the initial SID entries in the policy
file.  If you were to try to call policydb_load_isids() as is, you'd end
up duplicating SID entries with the cloned table, which should yield an
EEXIST error from sidtab_insert().  I suppose you could call
policydb_load_isids() first, change clone_sid() to skip initial SIDs,
and change convert_context() to skip initial SIDs.

As I recall, we didn't support reloading them at runtime because:
a) They were only to support system initialization in the first place,
and
b) We couldn't really guarantee that any changes to them would be
retroactively applied, and
c) We don't really support dynamic extension of them.

We don't presently support any changes to the set of initial SIDs other
than their contexts; see the third item under:
http://selinuxproject.org/page/Kernel_Development

Support for dynamic discovery of classes and permissions is in 2.6.33.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
