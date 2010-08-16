Date: Mon, 16 Aug 2010 20:20:19 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: Re: [PATCH] selinux: type_bounds_sanity_check has a meaningless
 variable declaration
In-Reply-To: <20100803192605.1788.92228.stgit@paris.rdu.redhat.com>
Message-ID: <alpine.LRH.2.00.1008162020060.21387@tundra.namei.org>
References: <20100803192605.1788.92228.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 3 Aug 2010, Eric Paris wrote:

> type is not used at all, stop declaring and assigning it.
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
