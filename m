Message-ID: <52F39E58.1020204@tycho.nsa.gov>
Date: Thu, 06 Feb 2014 09:38:16 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Paul Moore <pmoore@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] selinux: fix the output of ./scripts/get_maintainer.pl
 for SELinux
References: <20140206125154.20528.84437.stgit@localhost>
In-Reply-To: <20140206125154.20528.84437.stgit@localhost>
Content-Type: text/plain; charset=UTF-8
Cc: James Morris <james.l.morris@oracle.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 02/06/2014 07:51 AM, Paul Moore wrote:
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

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>  MAINTAINERS |    5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6a6e4ac..bfe8da4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7583,11 +7583,10 @@ M:	Security Officers <security@kernel.org>
>  S:	Supported
>  
>  SELINUX SECURITY MODULE
> +M:	Paul Moore <paul@paul-moore.com>
>  M:	Stephen Smalley <sds@tycho.nsa.gov>
> -M:	James Morris <james.l.morris@oracle.com>
>  M:	Eric Paris <eparis@parisplace.org>
> -M:	Paul Moore <paul@paul-moore.com>
> -L:	selinux@tycho.nsa.gov (subscribers-only, general discussion)
> +L:	selinux@tycho.nsa.gov (moderated for non-subscribers)
>  W:	http://selinuxproject.org
>  T:	git git://git.infradead.org/users/pcmoore/selinux
>  S:	Supported
> 
