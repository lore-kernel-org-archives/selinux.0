Date: Wed, 2 Mar 2011 09:39:49 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
        sds@tycho.nsa.gov
Subject: Re: [PATCH 1/2] LSM: Pass -o remount options to the LSM
In-Reply-To: <20110301215822.26496.45621.stgit@paris.rdu.redhat.com>
Message-ID: <alpine.LRH.2.00.1103020939070.1630@tundra.namei.org>
References: <20110301215822.26496.45621.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 1 Mar 2011, Eric Paris wrote:

> This patch passes the remount mount options to an new LSM hook.
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>

Reviewed-by: James Morris <jmorris@namei.org>

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
