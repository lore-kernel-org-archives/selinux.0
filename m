Message-ID: <1343742406.13704.7.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: [PATCH 1/1] Allow release_app getattr of netlink_selinux sockets
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Haiqing Jiang <hqjiang1988@gmail.com>
Cc: selinux@tycho.nsa.gov, bill.c.roberts@gmail.com
Date: Tue, 31 Jul 2012 09:46:46 -0400
In-Reply-To: <1343683094-5461-1-git-send-email-hqjiang1988@gmail.com>
References: <1343683094-5461-1-git-send-email-hqjiang1988@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2012-07-30 at 14:18 -0700, Haiqing Jiang wrote:
> ---
>  app.te |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)

I think the right fix is to instead close the NETLINK_SELINUX socket in
the child process.  I've made this change to libselinux.  Can you
re-test with the new libselinux and see if the permission is still
required by the test?

> 
> diff --git a/app.te b/app.te
> index 139652f..4e002bf 100644
> --- a/app.te
> +++ b/app.te
> @@ -63,6 +63,8 @@ net_domain(release_app)
>  bluetooth_domain(release_app)
>  # Read logs.
>  allow release_app log_device:chr_file read;
> +# Use netlink_selinux socket
> +allow release_app zygote:netlink_selinux_socket getattr;
>  
>  #
>  # An example of a specific domain for a specific app

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
