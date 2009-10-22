Subject: Re: [PATCH] SELinux: add .gitignore files for dynamic classes
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org
In-Reply-To: <20091022150859.20503.17193.stgit@paris.rdu.redhat.com>
References: <20091022150859.20503.17193.stgit@paris.rdu.redhat.com>
Content-Type: text/plain
Date: Thu, 22 Oct 2009 11:20:23 -0400
Message-Id: <1256224823.2191.51.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2009-10-22 at 11:08 -0400, Eric Paris wrote:
> The SELinux dynamic class work in c6d3aaa4e35c71a32a86ececacd4eea7ecfc316c
> creates a number of dynamic header files and scripts.  Add .gitignore files
> so git doesn't complain about these.
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>

Acked-by:  Stephen D. Smalley <sds@tycho.nsa.gov>

I guess we also should add them to Documentation/dontdiff?

> ---
> 
>  scripts/selinux/genheaders/.gitignore |    1 +
>  security/selinux/.gitignore           |    2 ++
>  2 files changed, 3 insertions(+), 0 deletions(-)
>  create mode 100644 scripts/selinux/genheaders/.gitignore
>  create mode 100644 security/selinux/.gitignore
> 
> diff --git a/scripts/selinux/genheaders/.gitignore b/scripts/selinux/genheaders/.gitignore
> new file mode 100644
> index 0000000..4c0b646
> --- /dev/null
> +++ b/scripts/selinux/genheaders/.gitignore
> @@ -0,0 +1 @@
> +genheaders
> diff --git a/security/selinux/.gitignore b/security/selinux/.gitignore
> new file mode 100644
> index 0000000..2e5040a
> --- /dev/null
> +++ b/security/selinux/.gitignore
> @@ -0,0 +1,2 @@
> +av_permissions.h
> +flask.h
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
