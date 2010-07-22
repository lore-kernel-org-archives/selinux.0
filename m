Date: Fri, 23 Jul 2010 08:51:42 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: Re: [PATCH 1/2] SELinux: move genfs read to a separate function
In-Reply-To: <20100721165057.5820.23176.stgit@paris.rdu.redhat.com>
Message-ID: <alpine.LRH.2.00.1007230851290.11399@tundra.namei.org>
References: <20100721165057.5820.23176.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 21 Jul 2010, Eric Paris wrote:

> move genfs read functionality out of policydb_read() and into a new
> function called genfs_read()
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
