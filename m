Subject: Re: [PATCH] libsepol/cil: Ignore object_r in userrole mappings when
 creating policy binary
To: Steve Lawrence <slawrence@tresys.com>, SELinux List <selinux@tycho.nsa.gov>
References: <1469551988-23131-1-git-send-email-slawrence@tresys.com>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <d15ad64c-5e71-029d-77db-e32de307de2c@tycho.nsa.gov>
Date: Tue, 26 Jul 2016 16:34:57 -0400
MIME-Version: 1.0
In-Reply-To: <1469551988-23131-1-git-send-email-slawrence@tresys.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 07/26/2016 12:53 PM, Steve Lawrence wrote:
> Commit 77779d2ca, which added support for userattributes in CIL,
> accidentally removed code that ignored object_r when adding userrole
> mappings to the policydb. This meant that running commands like
> `semanage user -l` would incorrectly show object_r. This patch adds that
> code back in. Note that CIL requires that these mappings exist to
> properly validate file contexts, so pp2cil's behavior of creating these
> mappings is not modified.
>
> Signed-off-by: Steve Lawrence <slawrence@tresys.com>

Applied,

Thanks,

> ---
>  libsepol/cil/src/cil_binary.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
> index 5d03127..46fea4b 100644
> --- a/libsepol/cil/src/cil_binary.c
> +++ b/libsepol/cil/src/cil_binary.c
> @@ -754,6 +754,12 @@ int cil_userrole_to_policydb(policydb_t *pdb, const struct cil_db *db, struct ci
>  				goto exit;
>  			}
>
> +			if (sepol_role->s.value == 1) {
> +				// role is object_r, ignore it since it is implicitly associated
> +				// with all users
> +				continue;
> +			}
> +
>  			if (ebitmap_set_bit(&sepol_user->roles.roles, sepol_role->s.value - 1, 1)) {
>  				cil_log(CIL_INFO, "Failed to set role bit for user\n");
>  				rc = SEPOL_ERR;
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
