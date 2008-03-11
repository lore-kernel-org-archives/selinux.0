Date: Wed, 12 Mar 2008 09:16:48 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: selinux <selinux@tycho.nsa.gov>, sds@tycho.nsa.gov
Subject: Re: [PATCH] SELinux: requesting no permissions in avc_has_perm_noaudit
 is a BUG()
In-Reply-To: <1205259574.5297.107.camel@localhost.localdomain>
Message-ID: <Xine.LNX.4.64.0803120916170.21778@us.intercode.com.au>
References: <1205259574.5297.107.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 11 Mar 2008, Eric Paris wrote:

> This patch turns the case where we have a call into avc_has_perm with no
> requested permissions into a BUG_ON.  All callers to this should be in
> the kernel and thus should be a function we need to fix if we ever hit
> this.  The /selinux/access permission checking it done directly in the
> security server and not through the avc, so those requests which we
> cannot control from userspace should not be able to trigger this BUG_ON.
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>
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
