Subject: Re: [PATCH 1/3] libselinux: string and compute_create functions
	(resend)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <460D5829.4010405@tycho.nsa.gov>
References: <460D495B.3060000@tycho.nsa.gov>
	 <460D5829.4010405@tycho.nsa.gov>
Content-Type: text/plain
Date: Fri, 30 Mar 2007 15:28:53 -0400
Message-Id: <1175282933.5479.222.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-03-30 at 14:34 -0400, Eamon Walsh wrote:
> Resending patch 1, was whitespace damaged.

for future reference:
http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt

Merged, with a couple comments below to follow up on.

> --
>  include/selinux/selinux.h |   12 ++++-
>  src/avc.c                 |   99 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 109 insertions(+), 2 deletions(-)
> 
> --
> Index: libselinux/src/avc.c
> ===================================================================
> --- libselinux/src/avc.c	(revision 2307)
> +++ libselinux/src/avc.c	(working copy)

> +int security_av_string(security_class_t tclass, access_vector_t av, char **res)
> +{
> +	unsigned int i = 0;
> +	size_t len = 5;
> +	access_vector_t tmp = av;
> +	int rc = 0;
> +	const char *str;
> +	char *ptr;
> +
> +	/* first pass computes the required length */
> +	while (tmp) {
> +		if (tmp & 1) {
> +			str = security_av_perm_to_string(tclass, av & (1<<i));
> +			if (str)
> +				len += strlen(str) + 1;
> +			else {
> +				rc = -1;
> +				errno = EINVAL;
> +				goto out;
> +			}

This fails if the av contains any permissions not defined in the
headers, which can occur for e.g. allow a b:c *; (as with unconfined
domains).  avc_dump_av() will instead display any remaining permission
bits as a hex value after the string list.

We should also consolidate this with avc_dump_av() and
print_access_vector(), and deprecate print_access_vector(), converting
over any users to using the new function instead.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
