Date: Tue, 15 Sep 2009 11:35:17 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
cc: linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH] SELinux: inline selinux_is_enabled in
 !CONFIG_SECURITY_SELINUX
In-Reply-To: <20090915005948.12692.40854.stgit@paris.rdu.redhat.com>
Message-ID: <alpine.LRH.2.00.0909151134250.13708@tundra.namei.org>
References: <20090915005948.12692.40854.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 14 Sep 2009, Eric Paris wrote:

> Without this patch building a kernel emits millions of warning like:
> 
> include/linux/selinux.h:92: warning: ?selinux_is_enabled? defined but not used
> 
> When it is build without CONFIG_SECURITY_SELINUX.  This is harmless, but
> the function should be inlined, so it gets compiled out.
> 
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Eric Paris <eparis@redhat.com>

Acked-by: James Morris <jmorris@namei.org>

Linus, I'll assume you'll want to apply this directly.


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
