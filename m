Date: Mon, 24 Jan 2011 11:41:16 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Davidlohr Bueso <dave@gnu.org>
cc: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
        LKML <linux-kernel@vger.kernel.org>, selinux@tycho.nsa.gov
Subject: Re: [PATCH 1/3] selinux: return -ENOMEM when memory allocation
 fails
In-Reply-To: <1295623684.1984.2.camel@offworld>
Message-ID: <alpine.LRH.2.00.1101241140510.30744@tundra.namei.org>
References: <1295548318.2089.11.camel@offworld>  <alpine.LRH.2.00.1101211101150.14355@tundra.namei.org> <1295623684.1984.2.camel@offworld>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 21 Jan 2011, Davidlohr Bueso wrote:

> 
> From: Davidlohr Bueso <dave@gnu.org>
> Date: Fri, 21 Jan 2011 12:26:51 -0300
> Subject: [PATCH] selinux: return -ENOMEM when memory allocation fails
> 
> Signed-off-by: Davidlohr Bueso <dave@gnu.org>
> ---
>  security/selinux/ss/conditional.c |    2 +-
>  security/selinux/ss/policydb.c    |    6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/security-testing-2.6#for-linus

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
