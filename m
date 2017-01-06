Subject: Re: [PATCH 2/2] libsemanage: increment the right index variable in
 for loop
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
References: <20170104214623.24674-1-nicolas.iooss@m4x.org>
 <20170104214623.24674-2-nicolas.iooss@m4x.org>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <1007bd3d-4366-6208-df23-be32b035ec0d@tycho.nsa.gov>
Date: Fri, 6 Jan 2017 14:31:35 -0500
MIME-Version: 1.0
In-Reply-To: <20170104214623.24674-2-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 01/04/2017 04:46 PM, Nicolas Iooss wrote:
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Applied.

Thanks,

> ---
>  libsemanage/src/semanage_store.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
> index 58a58ef9452e..f468faba4b64 100644
> --- a/libsemanage/src/semanage_store.c
> +++ b/libsemanage/src/semanage_store.c
> @@ -1158,7 +1158,7 @@ cleanup:
>  	free(all_modinfos);
>
>  	if (status != 0) {
> -		for (i = 0; i < j; j++) {
> +		for (i = 0; i < j; i++) {
>  			semanage_module_info_destroy(sh, &(*modinfo)[i]);
>  		}
>  		free(*modinfo);
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
