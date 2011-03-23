Message-ID: <4D89F4F9.6010200@manicmethod.com>
Date: Wed, 23 Mar 2011 09:26:17 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Harry Ciao <qingtao.cao@windriver.com>
CC: sds@tycho.nsa.gov, jmorris@namei.org, eparis@parisplace.org,
        selinux@tycho.nsa.gov
Subject: Re: [v0 PATCH 3/5] Handle the class in role_trans structure
References: <1300847325-20308-1-git-send-email-qingtao.cao@windriver.com> <1300847325-20308-7-git-send-email-qingtao.cao@windriver.com>
In-Reply-To: <1300847325-20308-7-git-send-email-qingtao.cao@windriver.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Harry Ciao wrote:
> From: Harry Ciao<harrytaurus2002@hotmail.com>
>
> Add the class support to various functions that handle the role_trans
> structure.
>
> Signed-off-by: Harry Ciao<qingtao.cao@windriver.com>
> ---
>   libsepol/src/policydb.c |   28 ++++++++++++++++++++++++----
>   libsepol/src/write.c    |   22 +++++++++++++++++-----
>   2 files changed, 41 insertions(+), 9 deletions(-)
>
> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> index 5c0081f..9b43c56 100644
> --- a/libsepol/src/policydb.c
> +++ b/libsepol/src/policydb.c
> @@ -137,6 +137,13 @@ static struct policydb_compat_info policydb_compat[] = {
>   	 .target_platform = SEPOL_TARGET_SELINUX,
>   	},
>   	{
> +	 .type = POLICY_KERN,
> +	 .version = POLICYDB_VERSION_ROLETRANS,
> +	 .sym_num = SYM_NUM,
> +	 .ocon_num = OCON_NODE6 + 1,
> +	 .target_platform = SEPOL_TARGET_SELINUX,
> +	},
> +	{
>   	 .type = POLICY_BASE,
>   	 .version = MOD_POLICYDB_VERSION_BASE,
>   	 .sym_num = SYM_NUM,

Why just the kernel version? There should be a module version that supports this 
also. Have you attempted to write out modules with classes in role_trans rules?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
