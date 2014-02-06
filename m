Date: Fri, 7 Feb 2014 10:52:39 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Paul Moore <pmoore@redhat.com>
Subject: Re: [PATCH] selinux: fix the output of ./scripts/get_maintainer.pl
 for SELinux
In-Reply-To: <20140206125154.20528.84437.stgit@localhost>
Message-ID: <alpine.LRH.2.02.1402071052280.4798@tundra.namei.org>
References: <20140206125154.20528.84437.stgit@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
 James Morris <james.l.morris@oracle.com>, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 6 Feb 2014, Paul Moore wrote:

> Correctly tag the SELinux mailing list as moderated for non-subscribers
> and do some shuffling of the SELinux maintainers to try and make things
> more clear when the scripts/get_maintainer.pl script is used.
> 
>  # ./scripts/get_maintainer.pl -f security/selinux
>  Paul Moore <paul@paul-moore.com> (supporter:SELINUX SECURITY...)
>  Stephen Smalley <sds@tycho.nsa.gov> (supporter:SELINUX SECURITY...)
>  Eric Paris <eparis@parisplace.org> (supporter:SELINUX SECURITY...)
>  James Morris <james.l.morris@oracle.com> (supporter:SECURITY SUBSYSTEM)
>  selinux@tycho.nsa.gov (moderated list:SELINUX SECURITY...)
>  linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
>  linux-kernel@vger.kernel.org (open list)
> 
> Cc: Stephen Smalley <sds@tycho.nsa.gov>
> Cc: Eric Paris <eparis@parisplace.org>
> Cc: James Morris <james.l.morris@oracle.com>
> Signed-off-by: Paul Moore <pmoore@redhat.com>

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next


-- 
James Morris
<jmorris@namei.org>
