Date: Tue, 27 Nov 2007 11:38:24 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: linux-kernel@vger.kernel.org, sds@tycho.nsa.gov, selinux@tycho.nsa.gov,
        alan@redhat.com, chrisw@redhat.com, hpa@zytor.com,
        akpm@linux-foundation.org
Subject: Re: [PATCH 3/3-v2] security: allow capable check to permit mmap or
 low vm space
In-Reply-To: <1196120866.16779.16.camel@localhost.localdomain>
Message-ID: <Xine.LNX.4.64.0711271137300.26171@us.intercode.com.au>
References: <1196120866.16779.16.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 26 Nov 2007, Eric Paris wrote:

> On a kernel with CONFIG_SECURITY but without an LSM which implements
> security_file_mmap it is impossible for an application to mmap addresses
> lower than mmap_min_addr.  Based on a suggestion from a developer in the
> openwall community this patch adds a check for CAP_SYS_RAWIO.  It is
> assumed that any process with this capability can harm the system a lot
> more easily than writing some stuff on the zero page and then trying to
> get the kernel to trip over itself.  It also means that programs like X
> on i686 which use vm86 emulation can work even with mmap_min_addr set.
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/selinux-2.6.git#for-akpm

If nobody hollers, I'll push it to Linus when the next merge window opens.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
