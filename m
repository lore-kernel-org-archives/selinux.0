Subject: Re: [PATCH] Allowing MLS->non-MLS and vice versa upon policy reload
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Guido Trentalancia <guido@trentalancia.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1265137391.3114.114.camel@moss-pluto.epoch.ncsc.mil>
References: <1265120566.3003.5.camel@tesla.lan>
	 <1265129074.3114.20.camel@moss-pluto.epoch.ncsc.mil>
	 <1265135281.3003.68.camel@tesla.lan>
	 <1265137391.3114.114.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 02 Feb 2010 14:11:00 -0500
Message-Id: <1265137860.3114.116.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2010-02-02 at 14:03 -0500, Stephen Smalley wrote:
> On Tue, 2010-02-02 at 19:28 +0100, Guido Trentalancia wrote:
> > Stephen,
> > 
> > did you mean something like the code below when mentioning about the
> > initial SID issue ? I remember you mentioned about matching oc->sid[0]
> > with the argument key of convert_context, so we can first scan for the
> > "unlabeled" SID and copy the MLS range only (as done in the previous
> > patch) and then afterwards if we find a match with the key argument, we
> > can copy the whole context over.
> > 
> > On Tue, 2010-02-02 at 11:44 -0500, Stephen Smalley wrote:
> > > On Tue, 2010-02-02 at 15:22 +0100, Guido Trentalancia wrote:
> > > Did you give up on addressing the initial SID issue or are you saving
> > > that for a later, separate patch?
> > 
> > 	/*
> > 	 * Switching between non-MLS and MLS policy:
> > 	 * ensure that the MLS fields of the context for all
> > 	 * existing entries in the sidtab are filled in with a
> > 	 * suitable default value, likely taken from one of the
> > 	 * initial SIDs.
> > 	 */
> > 	else if (!args->oldp->mls_enabled && args->newp->mls_enabled) {
> > 		int number_of_isids = 0;
> > 		int matching_key = 0;
> > 		oc = args->newp->ocontexts[OCON_ISID];
> > 		while (oc) {
> > 			if (oc->sid[0] == key)
> > 				matching_key = 1;
> > 			oc = oc->next;
> > 			number_of_isids = number_of_isids + 1;
> > 		}
> > 		oc = args->newp->ocontexts[OCON_ISID];
> > 		if (!matching_key) {
> > 			while (oc && oc->sid[0] != SECINITSID_UNLABELED)
> > 				oc = oc->next;
> > 			if (!oc) {
> > 				printk(KERN_ERR "SELinux:  unable to look up"
> > 					" the initial SIDs list\n");
> > 				goto bad;
> > 			}
> > 			range = &oc->context[0].range;
> > 			/* set only the MLS range from "unlabeled" */
> > 			rc = mls_range_set(c, range);
> > 			if (rc)
> > 				goto bad;
> > 		} else {
> > 			while (oc && oc->sid[0] != key)
> > 				oc = oc->next;
> > 			/* copy the whole context */
> > 			rc = context_cpy(c, oc->context[0]);
> > 			if (rc)
> > 				goto bad;
> > 		}
> > 	}
> > 
> > I look forward to hearing from you about the above issue.
> 
> We later talked about using policydb_load_isids().  See:
> http://marc.info/?l=selinux&m=126505150603677&w=2
> 
> This would be more general and would address reloading of initial SIDs
> even when staying within the same kind of policy.

Let's leave that for a separate, later patch though.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
