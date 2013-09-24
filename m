Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r8O1jrT3010278
	for <selinux@tycho.nsa.gov>; Mon, 23 Sep 2013 21:45:53 -0400
Date: Tue, 24 Sep 2013 11:47:35 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Paul Moore <pmoore@redhat.com>
cc: eparis@parisplace.org, selinux@tycho.nsa.gov
Subject: Re: [PATCH] selinux: add Paul Moore as a SELinux maintainer
In-Reply-To: <20130918171403.24618.84645.stgit@localhost>
Message-ID: <alpine.LRH.2.02.1309241147270.4043@tundra.namei.org>
References: <20130918171403.24618.84645.stgit@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 18 Sep 2013, Paul Moore wrote:

> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  MAINTAINERS |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e61c2e8..4fde706 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7390,9 +7390,10 @@ SELINUX SECURITY MODULE
>  M:	Stephen Smalley <sds@tycho.nsa.gov>
>  M:	James Morris <james.l.morris@oracle.com>
>  M:	Eric Paris <eparis@parisplace.org>
> +M:	Paul Moore <paul@paul-moore.com>
>  L:	selinux@tycho.nsa.gov (subscribers-only, general discussion)
>  W:	http://selinuxproject.org
> -T:	git git://git.infradead.org/users/eparis/selinux.git
> +T:	git git://git.infradead.org/users/pcmoore/selinux
>  S:	Supported
>  F:	include/linux/selinux*
>  F:	security/selinux/
> 

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
