Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p3RNMcdJ023382
	for <selinux@tycho.nsa.gov>; Wed, 27 Apr 2011 19:22:38 -0400
Received: from smtp104.prem.mail.sp1.yahoo.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id p3RNMb1e025819
	for <selinux@tycho.nsa.gov>; Wed, 27 Apr 2011 23:22:37 GMT
Message-ID: <4DB8A53A.4010709@schaufler-ca.com>
Date: Wed, 27 Apr 2011 16:22:34 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Roberto Sassu <roberto.sassu@polito.it>
CC: linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com, jmorris@namei.org,
        zohar@linux.vnet.ibm.com, safford@watson.ibm.com,
        tyhicks@linux.vnet.ibm.com, kirkland@canonical.com,
        ecryptfs-devel@lists.launchpad.net, eparis@redhat.com,
        sds@tycho.nsa.gov, selinux@tycho.nsa.gov, viro@zeniv.linux.org.uk
Subject: Re: [RFC][PATCH 4/7] smack: fix label check in smack_kernel_act_as()
References: <1303907657-18366-1-git-send-email-roberto.sassu@polito.it> <1303907657-18366-5-git-send-email-roberto.sassu@polito.it>
In-Reply-To: <1303907657-18366-5-git-send-email-roberto.sassu@polito.it>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 4/27/2011 5:34 AM, Roberto Sassu wrote:
> The function smack_kernel_act_as() must return -EINVAL if the label
> returned by smack_from_secid() is equal to 'smack_known_invalid.smk_known',
> which means that no entries in the 'smack_known_list' list matching the
> security identifier given are found.

I'll admit that the code here is wrong, but I disagree with the fix.

smack_from_secid() will never return NULL, so the check for NULL is
pointless. Checking for known_invalid is not right either, as the
Smack philosophy is to return a label in all cases, as is evident
by the behavior of smack_from_secid(). Thus, the correct change
would be to remove the error check completely and set the new task
value to the value obtained from smack_from_secid in all cases.

Besides, where did the caller of this function get a secid that isn't
going to map to a Smack label?

> Signed-off-by: Roberto Sassu <roberto.sassu@polito.it>
> ---
>  security/smack/smack_lsm.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index e3c9e54..0e7ed31 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -1415,7 +1415,7 @@ static int smack_kernel_act_as(struct cred *new, u32 secid)
>  	struct task_smack *new_tsp = new->security;
>  	char *smack = smack_from_secid(secid);
>  
> -	if (smack == NULL)
> +	if (smack == smack_known_invalid.smk_known)
>  		return -EINVAL;
>  
>  	new_tsp->smk_task = smack;


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
