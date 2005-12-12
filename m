Subject: Re: Latest Ref Policy Diffs
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>, James Morris <jmorris@namei.org>,
   SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1134399286.7305.49.camel@moss-spartans.epoch.ncsc.mil>
References: <4398A239.1080005@redhat.com>
	 <1134399286.7305.49.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 12 Dec 2005 11:41:38 -0500
Message-Id: <1134405698.16519.40.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-12-12 at 09:54 -0500, Stephen Smalley wrote:
> On Thu, 2005-12-08 at 16:14 -0500, Daniel J Walsh wrote:
> Nit:  It is more difficult to search through reference policy for
> occurrences of execmem et al due to the inlining of
> general_domain_access() everywhere (which happens to include it in an
> exclusion list of permissions to not allow to self:process).  It will
> also be harder to add further excluded permissions to that list in the
> future due to such inlining.  Rationale for such inlining in the
> reference policy?

The rationale is the same for all of the example policy macros, save
obvious ones like domain_auto_trans(), can_exec(), object class set, and
permission set macros.  We wanted to expand all of the macros so that we
could see all the rules for each domain.  After all the modules have
been ported over, we can more easily see the common policy patterns.
Then we can reevaluate the old macros and decide what to do with them.
We do intend to add support macros and templates to cover common policy
patterns, but we just haven't gotten to this part yet, since we're still
porting modules over from the example policy.

> > gfs support is added
> 
> I don't think gfs supports security xattrs yet, so I don't think you
> want it to use fs_use_xattr as its labeling mechanism.

Ok, I can reverse this change.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
