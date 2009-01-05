Date: Mon, 5 Jan 2009 20:34:09 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: Re: [PATCH] SELinux: shrink sizeof av_inhert selinux_class_perm and
 context
In-Reply-To: <1230936006.8510.21.camel@localhost.localdomain>
Message-ID: <alpine.LRH.1.10.0901052033550.16929@tundra.namei.org>
References: <1230936006.8510.21.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2 Jan 2009, Eric Paris wrote:

> I started playing with pahole today and decided to put it against the
> selinux structures.  Found we could save a little bit of space on x86_64
> (and no harm on i686) just reorganizing some structs.

Applied to 
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/security-testing-2.6#next

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
