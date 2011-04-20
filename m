Subject: Re: [PATCH] selinux: revise /selinux/create to handle
 whitespace/multibytes correctly
From: Eric Paris <eparis@redhat.com>
To: Kohei KaiGai <kaigai@kaigai.gr.jp>
Cc: Kohei Kaigai <Kohei.Kaigai@EU.NEC.COM>,
        "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
        "method@manicmethod.com" <method@manicmethod.com>,
        "sds@tycho.nsa.gov" <sds@tycho.nsa.gov>
In-Reply-To: <BANLkTi=Czi-Zh1s3YP+rG4KZr1uwoHUTXA@mail.gmail.com>
References: <BANLkTi=Czi-Zh1s3YP+rG4KZr1uwoHUTXA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 20 Apr 2011 16:13:40 -0400
Message-ID: <1303330420.1708.32.camel@unknown001a4b0c2895>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2011-04-16 at 16:09 +0200, Kohei KaiGai wrote:
> This patch allows to accept percent-encoded object name as the forth
> argument of /selinux/create interface to avoid possible bugs when we
> supply an object name that includes whitespace or multibytes.
> 
> Although I could not test this patch on named TYPE_TRANSITION rules,
> but printk() messages for debugging seems to me the logic works correctly.
> I assume the libselinux provide the logic to encode object name, so it shall
> be applied transparently for the viewpoint of application.


"You assume" libselinux provides this.  Does it?  Or are you going to
send a patch to support it?  I honestly don't know....

Thanks!
-Eric

> 
> Signed-off-by: KaiGai Kohei <kohei.kaigai@eu.nec.com>
> ---
>  security/selinux/selinuxfs.c |   38 +++++++++++++++++++++++++++++++++++++-
>  1 files changed, 37 insertions(+), 1 deletions(-)
> 
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index 973f5a4..4fde279 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -28,6 +28,7 @@
>  #include <linux/percpu.h>
>  #include <linux/audit.h>
>  #include <linux/uaccess.h>
> +#include <linux/ctype.h>
> 
>  /* selinuxfs pseudo filesystem for exporting the security policy API.
>     Based on the proc code and the fs/nfsd/nfsctl.c code. */
> @@ -750,6 +751,15 @@ out:
>  	return length;
>  }
> 
> +static inline int hexcode_to_int(int code)
> +{
> +	if (code == '\0' || !isxdigit(code))
> +		return -1;
> +	if (isdigit(code))
> +		return code - '0';
> +	return tolower(code) - 'a' + 10;
> +}
> +
>  static ssize_t sel_write_create(struct file *file, char *buf, size_t size)
>  {
>  	char *scon = NULL, *tcon = NULL;
> @@ -784,8 +794,34 @@ static ssize_t sel_write_create(struct file
> *file, char *buf, size_t size)
>  	nargs = sscanf(buf, "%s %s %hu %s", scon, tcon, &tclass, namebuf);
>  	if (nargs < 3 || nargs > 4)
>  		goto out;
> -	if (nargs == 4)
> +	if (nargs == 4) {
> +		/*
> +		 * If and when the name of new object to be queried contains
> +		 * either whitespace or multibyte characters, they shall be
> +		 * encoded based on the percentage-encoding rule.
> +		 * If not encoded, the sscanf logic picks up only left-half
> +		 * of the supplied name; splitted by a whitespace unexpectedly.
> +		 */
> +		char   *r, *w;
> +		int	c1, c2;
> +
> +		r = w = namebuf;
> +		do {
> +			c1 = *r++;
> +			if (c1 == '+')
> +				c1 = ' ';
> +			else if (c1 == '%') {
> +				if ((c1 = hexcode_to_int(*r++)) < 0)
> +					goto out;
> +				if ((c2 = hexcode_to_int(*r++)) < 0)
> +					goto out;
> +				c1 = (c1 << 4) | c2;
> +			}
> +			*w++ = c1;
> +		} while (c1 != '\0');
> +
>  		objname = namebuf;
> +	}
> 
>  	length = security_context_to_sid(scon, strlen(scon) + 1, &ssid);
>  	if (length)



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
