Date: Thu, 22 May 2008 19:31:24 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: selinux@tycho.nsa.gov, Eric Paris <eparis@parisplace.org>
Subject: Re: [PATCH] selinux:  enable processes with mac_admin to get the
 raw inode contexts
In-Reply-To: <1211393772.7486.392.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Xine.LNX.4.64.0805221931080.2303@us.intercode.com.au>
References: <1211393772.7486.392.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 21 May 2008, Stephen Smalley wrote:

> Enable processes with CAP_MAC_ADMIN + mac_admin permission in policy
> to get undefined contexts on inodes.  This extends the support for
> deferred mapping of security contexts in order to permit restorecon
> and similar programs to see the raw file contexts unknown to the
> system policy in order to check them.
> 
> 
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> 

Applied to 
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/selinux-2.6.git#for-akpm


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
