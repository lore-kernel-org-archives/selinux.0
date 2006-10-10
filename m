Subject: Re: [PATCH 1/1] Reworked patch for restorecon
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: SELinux List <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1160172593.29401.4.camel@localhost.localdomain>
References: <1160172593.29401.4.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 10 Oct 2006 15:49:10 -0400
Message-Id: <1160509750.3322.29.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-10-06 at 18:09 -0400, Karl MacMillan wrote:
> This patch makes the following changes to restorecon:
> 
> -i flag to tell restorecon to ignore missing files
> 
> -o now takes "-" to allow it to output file list to stdout
> 
> Check to make sure restorecon has at least one input file
> 
> This patch is based on Dan's patch from Sep. 26 but only includes the
> restorecon changes (see
> http://marc.theaimsgroup.com/?l=selinux&m=115928447719072&w=2). Please
> apply.
> 
> Signed-off-by: Karl MacMillan <kmacmillan@mentalrootkit.com>
> 
> ---
> 
>  restorecon.8 |    3 ++
>  restorecon.c |   55 +++++++++++++++++++++++++++++++++++++------------
>  2 files changed, 45 insertions(+), 13 deletions(-)
> 

> diff --git a/policycoreutils/restorecon/restorecon.c b/policycoreutils/restorecon/restorecon.c
> index 022a453..c1352aa 100644
> --- a/policycoreutils/restorecon/restorecon.c
> +++ b/policycoreutils/restorecon/restorecon.c
> @@ -41,12 +42,14 @@ #define __USE_XOPEN_EXTENDED 1	/* nftw *
>  #include <ftw.h>
>  
>  static int change = 1;
> +static int change_ctr = 0;
<snip>
> @@ -249,7 +260,9 @@ int restore(const char *filename)
>  						freecon(scontext);
>  						return 1;
>  					}
> -				}
> +				} else
> +					change_ctr++;
> +
>  				if (verbose)
>  					printf("%s reset %s context %s->%s\n",
>  					       progname, filename,
<snip>
> @@ -428,5 +454,8 @@ int main(int argc, char **argv)
>  	if (outfile)
>  		fclose(outfile);
>  
> +	if (!change)
> +		return change_ctr;
> +
>  	return errors;
>  }

This was rejected earlier as an interface change (change in exit code of
restorecon -n, with a non-zero exit status on a successful completion).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
