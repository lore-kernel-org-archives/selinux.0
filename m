Received: from [192.168.25.4] (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2LISt2v030171
 for <selinux@tycho.nsa.gov>; Tue, 21 Mar 2017 14:28:55 -0400
Subject: Re: [PATCH] checkpolicy: Fix minor memory leak in checkpolicy
To: selinux@tycho.nsa.gov
References: <1490022873-11869-1-git-send-email-jwcart2@tycho.nsa.gov>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <011e8531-d9dc-b65c-a240-e4fcbaa6e592@tycho.nsa.gov>
Date: Tue, 21 Mar 2017 14:29:19 -0400
MIME-Version: 1.0
In-Reply-To: <1490022873-11869-1-git-send-email-jwcart2@tycho.nsa.gov>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/20/2017 11:14 AM, James Carter wrote:
> sepol_set_sidtab() is called without calling sepol_sidtab_destroy().
> This is not a big deal, since checkpolicy does not run for long, but
> it does add noise when checking for other, more important, leaks.
>
> Call sepol_sidtab_destroy() before exiting if not in debug mode.
>
> Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>

This has been applied.

> ---
>  checkpolicy/checkpolicy.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
> index 442e7db..534fc22 100644
> --- a/checkpolicy/checkpolicy.c
> +++ b/checkpolicy/checkpolicy.c
> @@ -673,6 +673,7 @@ int main(int argc, char **argv)
>
>  	if (!debug) {
>  		policydb_destroy(&policydb);
> +		sepol_sidtab_destroy(&sidtab);
>  		exit(0);
>  	}
>
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
