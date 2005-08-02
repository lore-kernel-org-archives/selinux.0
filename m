Subject: Re: [RFC][PATCH 0/3] Reduce number of avtab nodes
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Morris <jmorris@redhat.com>
Cc: selinux@tycho.nsa.gov, Joshua Brindle <jbrindle@tresys.com>,
   Karl MacMillan <kmacmillan@tresys.com>,
   Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
In-Reply-To: <1123000986.11904.48.camel@moss-spartans.epoch.ncsc.mil>
References: <1122655799.6573.193.camel@moss-spartans.epoch.ncsc.mil>
	 <Lynx.SEL.4.62.0507311149080.22444@thoron.boston.redhat.com>
	 <1122903665.6573.281.camel@moss-spartans.epoch.ncsc.mil>
	 <1123000986.11904.48.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 02 Aug 2005 16:50:03 -0400
Message-Id: <1123015803.11904.74.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-08-02 at 12:43 -0400, Stephen Smalley wrote:
> On Mon, 2005-08-01 at 09:41 -0400, Stephen Smalley wrote:
> > - We need to write compatibility code for writing out older binary
> > policy versions from libsepol/checkpolicy for the latest change.  This
> > is necessary even just to support loading version 19 policies,
> > since /sbin/init and load_policy regenerate the binary policy image
> > in-memory when adjusting them for local boolean and user definitions and
> > thus need that support in policydb_write.
> 
> This patch, relative to the prior ones, adds this compatibility code.
> It implements it by creating an in-memory attr->type map and then using
> this map to expand the avtab and cond av lists when writing out an older
> binary policy version.  The attr->type map has to be created by both the
> expand_module code (where it is trivial to do so before we discard
> attribute information) and by the policydb_read code, so that the
> compatibility code works regardless of whether we are compiling an older
> binary policy version (e.g. checkpolicy -c 19) or simply mutating an
> in-memory policydb originally created from a kernel binary policy file
> for local settings (e.g. /sbin/init and load_policy's use of
> sepol_genusers/genbools).  This lets me boot an unpatched kernel with a
> policy.19 and the new libsepol installed, without /sbin/init choking on
> sepol_genusers/genbools.

I've made this patch available at
http://www.cs.utah.edu/~sds/libsepol-avtab3.patch as well.  

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
