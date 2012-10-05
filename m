Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q95EQQf4013159
	for <selinux@tycho.nsa.gov>; Fri, 5 Oct 2012 10:26:26 -0400
Date: Fri, 5 Oct 2012 14:27:53 +0000
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Jan Stancek <jstancek@redhat.com>
Cc: selinux@tycho.nsa.gov, serge@hallyn.com, jburke@redhat.com
Subject: Re: [selinux-testsuite][PATCH] use auth_read_passwd only if defined
Message-ID: <20121005142753.GA29202@mail.hallyn.com>
References: <4f49eed5e3ce75a790287d42688f7e83ca4689b1.1349434641.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4f49eed5e3ce75a790287d42688f7e83ca4689b1.1349434641.git.jstancek@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Jan Stancek (jstancek@redhat.com):
> This interface doesn't exist on older distros, for example RHEL6.

Thanks, applied.

> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  policy/test_global.te |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/policy/test_global.te b/policy/test_global.te
> index b92cc1c..3891f6e 100644
> --- a/policy/test_global.te
> +++ b/policy/test_global.te
> @@ -90,5 +90,7 @@ selinux_compute_relabel_context(testdomain)
>  selinux_compute_user_contexts(testdomain)
>  
>  ifdef(`distro_redhat', `
> -auth_read_passwd(testdomain)
> +    ifdef(`auth_read_passwd', `
> +        auth_read_passwd(testdomain)
> +    ')
>  ')
> -- 
> 1.7.1

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
