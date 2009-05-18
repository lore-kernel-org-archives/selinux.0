Date: Tue, 19 May 2009 08:20:39 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: Re: [PATCH] SELinux: move SELINUX_MAGIC into magic.h
In-Reply-To: <20090518142609.31208.20946.stgit@dhcp231-142.rdu.redhat.com>
Message-ID: <alpine.LRH.2.00.0905190820230.5433@tundra.namei.org>
References: <20090518142609.31208.20946.stgit@dhcp231-142.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 18 May 2009, Eric Paris wrote:

> The selinuxfs superblock magic is used inside the IMA code, but is being
> defined in two places and could someday get out of sync.  This patch moves the
> declaration into magic.h so it is only done once.
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>

Applied to 
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/security-testing-2.6#next


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
