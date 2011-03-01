Date: Wed, 2 Mar 2011 09:42:01 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
        sds@tycho.nsa.gov
Subject: Re: [PATCH 2/2] SELinux: implement the new sb_remount LSM hook
In-Reply-To: <20110301215828.26496.68739.stgit@paris.rdu.redhat.com>
Message-ID: <alpine.LRH.2.00.1103020941450.1630@tundra.namei.org>
References: <20110301215822.26496.45621.stgit@paris.rdu.redhat.com> <20110301215828.26496.68739.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 1 Mar 2011, Eric Paris wrote:

> For SELinux we do not allow security information to change during a remount
> operation.  Thus this hook simply strips the security module options from
> the data and verifies that those are the same options as exist on the
> current superblock.
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>
> ---

Reviewed-by: James Morris <jmorris@namei.org>

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
