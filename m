Subject: Re: [PATCH] libselinux: disable filespec hash table stats on
 non-debug builds
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
References: <1485287190-476-1-git-send-email-sds@tycho.nsa.gov>
From: Alan Jenkins <alan.christopher.jenkins@gmail.com>
Message-ID: <492a9bf9-c577-f957-0adb-38539b9a3c22@gmail.com>
Date: Wed, 25 Jan 2017 00:07:00 +0000
MIME-Version: 1.0
In-Reply-To: <1485287190-476-1-git-send-email-sds@tycho.nsa.gov>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 24/01/17 19:46, Stephen Smalley wrote:
> Disable generating filespec hash table stats on non-debug builds,
> as they are not useful information for users and cause fixfiles
> check to produce noisy output.
>
> Reported-by: Alan Jenkins <alan.christopher.jenkins@gmail.com>
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>

Thanks!
This patch looks exactly how I would want.

> ---
>   libselinux/src/selinux_restorecon.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
> index 7020669..38acbd2 100644
> --- a/libselinux/src/selinux_restorecon.c
> +++ b/libselinux/src/selinux_restorecon.c
> @@ -487,6 +487,7 @@ oom:
>   /*
>    * Evaluate the association hash table distribution.
>    */
> +#ifdef DEBUG
>   static void filespec_eval(void)
>   {
>   	file_spec_t *fl;
> @@ -513,6 +514,11 @@ static void filespec_eval(void)
>   		     "filespec hash table stats: %d elements, %d/%d buckets used, longest chain length %d\n",
>   		     nel, used, HASH_BUCKETS, longest);
>   }
> +#else
> +static void filespec_eval(void)
> +{
> +}
> +#endif
>   
>   /*
>    * Destroy the association hash table.
