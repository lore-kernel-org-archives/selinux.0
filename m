Date: Fri, 23 Jul 2010 08:51:56 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: Re: [PATCH 2/2] SELinux: break ocontext reading into a separate
 function
In-Reply-To: <20100721165103.5820.1380.stgit@paris.rdu.redhat.com>
Message-ID: <alpine.LRH.2.00.1007230851450.11399@tundra.namei.org>
References: <20100721165057.5820.23176.stgit@paris.rdu.redhat.com> <20100721165103.5820.1380.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 21 Jul 2010, Eric Paris wrote:

> Move the reading of ocontext type data out of policydb_read() in a separate
> function ocontext_read()
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
