MIME-Version: 1.0
In-Reply-To: <1478034104-25583-1-git-send-email-sds@tycho.nsa.gov>
References: <1478034104-25583-1-git-send-email-sds@tycho.nsa.gov>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Tue, 1 Nov 2016 14:23:48 -0700
Message-ID: <CAFftDdooKv3Zuzzrj0wppO9WjMerX2C=Rj-r5zhNAoH+hgCr3w@mail.gmail.com>
Subject: Re: [PATCH] libselinux: avc_internal.c: allow building with clang
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

We're gonna cross, I just sent this out as well, as well as noreturn
fixes for utils.

On Tue, Nov 1, 2016 at 2:01 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> Resolves the following errors from clang:
> avc_internal.c:105:25: error: cast from 'char *' to 'struct nlmsghdr *' increases required alignment from 1 to 4 [-Werror,-Wcast-align]
>         struct nlmsghdr *nlh = (struct nlmsghdr *)buf;
>                                ^~~~~~~~~~~~~~~~~~~~~~
> avc_internal.c:161:25: error: cast from 'char *' to 'struct nlmsghdr *' increases required alignment from 1 to 4 [-Werror,-Wcast-align]
>         struct nlmsghdr *nlh = (struct nlmsghdr *)buf;
>                                ^~~~~~~~~~~~~~~~~~~~~~
>
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  libselinux/src/avc_internal.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/libselinux/src/avc_internal.c b/libselinux/src/avc_internal.c
> index be94857..26f3360 100644
> --- a/libselinux/src/avc_internal.c
> +++ b/libselinux/src/avc_internal.c
> @@ -96,7 +96,7 @@ void avc_netlink_close(void)
>         fd = -1;
>  }
>
> -static int avc_netlink_receive(char *buf, unsigned buflen, int blocking)
> +static int avc_netlink_receive(void *buf, unsigned buflen, int blocking)
>  {
>         int rc;
>         struct pollfd pfd = { fd, POLLIN | POLLPRI, 0 };
> @@ -155,7 +155,7 @@ static int avc_netlink_receive(char *buf, unsigned buflen, int blocking)
>         return 0;
>  }
>
> -static int avc_netlink_process(char *buf)
> +static int avc_netlink_process(void *buf)
>  {
>         int rc;
>         struct nlmsghdr *nlh = (struct nlmsghdr *)buf;
> --
> 2.7.4
>



-- 
Respectfully,

William C Roberts
