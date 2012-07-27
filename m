Message-ID: <1343411694.17570.70.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: [PATCH 1/1] Platform app domain sdcard accesses
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Haiqing Jiang <hqjiang1988@gmail.com>
Cc: selinux@tycho.nsa.gov, bill.c.roberts@gmail.com
Date: Fri, 27 Jul 2012 13:54:54 -0400
In-Reply-To: <1343411642-3444-1-git-send-email-hqjiang1988@gmail.com>
References: <1343411642-3444-1-git-send-email-hqjiang1988@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2012-07-27 at 10:54 -0700, Haiqing Jiang wrote:
> ---
>  app.te |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/app.te b/app.te
> index df0f5df..818f5c0 100644
> --- a/app.te
> +++ b/app.te
> @@ -86,6 +86,9 @@ net_domain(browser_app)
>  # App sandbox file accesses.
>  allow platformappdomain platform_app_data_file:dir create_dir_perms;
>  allow platformappdomain platform_app_data_file:notdevfile_class_set create_file_perms;
> +# App sdcard file accesses
> +allow platformappdomain sdcard:dir create_dir_perms;
> +allow platformappdomain sdcard:file create_file_perms;
>  
>  #
>  # Untrusted apps.

In that case, we should be able to delete the rules for platform_app and
media_app to sdcard, right?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
