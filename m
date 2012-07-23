Message-ID: <1343050165.23118.30.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: [PATCH 5/6] external/sepolicy: allow media_app read to
 application data files
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Haiqing Jiang <hqjiang1988@gmail.com>
Cc: selinux@tycho.nsa.gov, bill.c.roberts@gmail.com
Date: Mon, 23 Jul 2012 09:29:25 -0400
In-Reply-To: <1342739276-1686-6-git-send-email-hqjiang1988@gmail.com>
References: <Hi, all>
	 <1342739276-1686-6-git-send-email-hqjiang1988@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2012-07-19 at 16:07 -0700, Haiqing Jiang wrote:
> ---
>  app.te |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/app.te b/app.te
> index a5ff295..06da29b 100644
> --- a/app.te
> +++ b/app.te
> @@ -45,6 +45,8 @@ allow media_app sdcard:file { create_file_perms link_file_perms };
>  # Read/[write] to /proc/net/xt_qtaguid/ctrl and /dev/xt_qtaguid
>  allow media_app qtaguid_proc:file rw_file_perms;
>  allow media_app qtaguid_device:chr_file r_file_perms;
> +# Read to app_data_file
> +allow media_app app_data_file:file r_file_perms;
>  # Apps signed with the shared key.
>  type shared_app, domain;
>  app_domain(shared_app)

Already allowed by this rule in app.te:
allow appdomain app_data_file:notdevfile_class_set create_file_perms;

Maybe your denial was due to MLS categories rather than TE.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
