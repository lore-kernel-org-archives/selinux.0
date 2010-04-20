Date: Wed, 21 Apr 2010 08:59:25 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: Re: [PATCH] SELinux: return error codes on policy load failure
In-Reply-To: <20100420142942.16035.61381.stgit@paris.rdu.redhat.com>
Message-ID: <alpine.LRH.2.00.1004210859130.30324@tundra.namei.org>
References: <20100420142942.16035.61381.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 20 Apr 2010, Eric Paris wrote:

> policy load failure always return EINVAL even if the failure was for some
> other reason (usually ENOMEM).  This patch passes error codes back up the
> stack where they will make their way to userspace.  This might help in
> debugging future problems with policy load.
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
