Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p3RNlAQC024647
	for <selinux@tycho.nsa.gov>; Wed, 27 Apr 2011 19:47:10 -0400
Received: from smtp102.prem.mail.sp1.yahoo.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id p3RNl81e029732
	for <selinux@tycho.nsa.gov>; Wed, 27 Apr 2011 23:47:08 GMT
Message-ID: <4DB8AAFA.2050903@schaufler-ca.com>
Date: Wed, 27 Apr 2011 16:47:06 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Roberto Sassu <roberto.sassu@polito.it>
CC: linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com, jmorris@namei.org,
        zohar@linux.vnet.ibm.com, safford@watson.ibm.com,
        tyhicks@linux.vnet.ibm.com, kirkland@canonical.com,
        ecryptfs-devel@lists.launchpad.net, eparis@redhat.com,
        sds@tycho.nsa.gov, selinux@tycho.nsa.gov, viro@zeniv.linux.org.uk,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [RFC][PATCH 5/7] smack: import the security label in smack_secctx_to_secid()
References: <1303907657-18366-1-git-send-email-roberto.sassu@polito.it> <1303907657-18366-6-git-send-email-roberto.sassu@polito.it>
In-Reply-To: <1303907657-18366-6-git-send-email-roberto.sassu@polito.it>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 4/27/2011 5:34 AM, Roberto Sassu wrote:
> The security label passed as argument in smack_secctx_to_secid() must be
> first imported in the 'smack_known_list' list before finding the security
> identifier associated to it. This allows the function
> set_security_override_from_ctx() to be performed successfully even if the
> label is not yet present in the smack list.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@polito.it>

Nacked-by: Casey Schaufler <casey@schaufler-ca.com>

security_secctx_to_secid() is called from the netlabel code
and hence cannot (to my understanding) allocate memory,
which is something that smk_import will do if the label is
new. I am willing to be convinced that doing so is safe,
but my understanding is that it is not.

> ---
>  security/smack/smack_lsm.c |    8 +++++++-
>  1 files changed, 7 insertions(+), 1 deletions(-)
>
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 0e7ed31..6612ba1 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -3346,7 +3346,13 @@ static int smack_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
>   */
>  static int smack_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
>  {
> -	*secid = smack_to_secid(secdata);
> +	char *smack;
> +
> +	smack = smk_import(secdata, seclen);
> +	if (smack == NULL)
> +		return -EINVAL;
> +
> +	*secid = smack_to_secid(smack);
>  	return 0;
>  }
>  


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
