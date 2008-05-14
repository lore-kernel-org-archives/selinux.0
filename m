Date: Thu, 15 May 2008 09:55:03 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: Andrew Morton <akpm@linux-foundation.org>, selinux@tycho.nsa.gov,
        Eric Paris <eparis@parisplace.org>
Subject: Re: [PATCH] selinux:  fix sleeping allocation in security_context_to_sid
 (Was: + selinux-dopey-hack.patch added to -mm tree)
In-Reply-To: <1210775635.6206.354.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Xine.LNX.4.64.0805150954100.21686@us.intercode.com.au>
References: <200805130810.m4D8ACbM032389@imap1.linux-foundation.org>
 <1210688804.6206.141.camel@moss-spartans.epoch.ncsc.mil>
 <20080513092150.c819e1fc.akpm@linux-foundation.org>
 <1210698106.6206.188.camel@moss-spartans.epoch.ncsc.mil>
 <20080513114018.5bfa7fb0.akpm@linux-foundation.org>
 <1210774363.6206.344.camel@moss-spartans.epoch.ncsc.mil>
 <1210775635.6206.354.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 14 May 2008, Stephen Smalley wrote:

> Fix a sleeping function called from invalid context bug by moving allocation
> to the callers prior to taking the policy rdlock.
> 
> Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

Applied to 
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/selinux-2.6.git#for-akpm

Andrew, you'll need to drop selinux-dopey-hack.patch before merging this.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
