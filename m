Date: Mon, 18 Oct 2010 10:14:25 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: Re: [PATCH 1/6] kernel: rounddown helper function
In-Reply-To: <20101013215002.17293.43060.stgit@paris.rdu.redhat.com>
Message-ID: <alpine.LRH.2.00.1010181014050.9476@tundra.namei.org>
References: <20101013215002.17293.43060.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 13 Oct 2010, Eric Paris wrote:

> The roundup() helper function will round a given value up to a multiple of
> another given value.  aka  roundup(11, 7) would give 14 = 7 * 2.  This new
> function does the opposite.  It will round a given number down to the
> nearest multiple of the second number: rounddown(11, 7) would give 7.
> 
> I need this in some future SELinux code and can carry the macro myself, but
> figured I would put it in the core kernel so others might find and use it
> if need be.
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>

All applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/security-testing-2.6#next

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
