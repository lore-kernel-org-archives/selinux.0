Date: Fri, 29 Feb 2008 10:05:58 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: selinux <selinux@tycho.nsa.gov>, sds@tycho.nsa.gov,
        Paul Moore <paul.moore@hp.com>
Subject: Re: [PATCH -v2] SELinux: create new open permission
In-Reply-To: <1204221520.3206.86.camel@localhost.localdomain>
Message-ID: <Xine.LNX.4.64.0802291005430.15439@us.intercode.com.au>
References: <1204221520.3206.86.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 28 Feb 2008, Eric Paris wrote:

> Adds a new open permission inside SELinux when 'opening' a file.  The
> idea is that opening a file and reading/writing to that file are not the
> same thing.  Its different if a program had its stdout redirected
> to /tmp/output than if the program tried to directly open /tmp/output.
> This should allow policy writers to more liberally give read/write
> permissions across the policy while still blocking many design and
> programing flaws SELinux is so good at catching today.
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>

Applied to 
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/selinux-2.6.git#next


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
