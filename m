Subject: Re: [PATCH 6/6] libsepol: resource leak in avrule_decl_create
From: Stephen Smalley <sds@tycho.nsa.gov>
To: serue@us.ibm.com
Cc: Joshua Brindle <jbrindle@tresys.com>, SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <20050822162059.GF4191@sergelap.austin.ibm.com>
References: <20050822162059.GF4191@sergelap.austin.ibm.com>
Content-Type: text/plain
Date: Tue, 23 Aug 2005 09:20:05 -0400
Message-Id: <1124803205.7874.28.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-08-22 at 11:20 -0500, serue@us.ibm.com wrote:
> This patch fixes a resource leak found by Coverity:
> 
> 	avrule_decl_destroy(decl) does not free decl itself.
> 	Must do so manually on after avrule_decl_destroy().

It looks to me as if there are still going to be problems in the caller
with respect to freeing the data structures already linked into the
policydb.  In fact, looking at policydb_read since the module support
was merged, I see a lot of cases where it is immediately returning -1
rather than doing a goto bad to clean up the partially constructed
policydb.  Anything after the policydb_init should be doing that upon
error.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
