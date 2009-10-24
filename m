Date: Sat, 24 Oct 2009 13:02:03 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: Re: [PATCH] SELinux: add .gitignore files for dynamic classes
In-Reply-To: <20091022193826.22879.95307.stgit@paris.rdu.redhat.com>
Message-ID: <alpine.LRH.2.00.0910241301480.14293@tundra.namei.org>
References: <20091022193826.22879.95307.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 22 Oct 2009, Eric Paris wrote:

> The SELinux dynamic class work in c6d3aaa4e35c71a32a86ececacd4eea7ecfc316c
> creates a number of dynamic header files and scripts.  Add .gitignore files
> so git doesn't complain about these.
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>
> Acked-by: Stephen D. Smalley <sds@tycho.nsa.gov>


Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/security-testing-2.6#next

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
