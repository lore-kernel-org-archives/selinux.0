Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p3RNQm9d023523
	for <selinux@tycho.nsa.gov>; Wed, 27 Apr 2011 19:26:48 -0400
Received: from smtp105.prem.mail.sp1.yahoo.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id p3RNQkfH009690
	for <selinux@tycho.nsa.gov>; Wed, 27 Apr 2011 23:26:47 GMT
Message-ID: <4DB8A633.6080102@schaufler-ca.com>
Date: Wed, 27 Apr 2011 16:26:43 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Roberto Sassu <roberto.sassu@polito.it>
CC: linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com, jmorris@namei.org,
        zohar@linux.vnet.ibm.com, safford@watson.ibm.com,
        tyhicks@linux.vnet.ibm.com, kirkland@canonical.com,
        ecryptfs-devel@lists.launchpad.net, eparis@redhat.com,
        sds@tycho.nsa.gov, selinux@tycho.nsa.gov, viro@zeniv.linux.org.uk
Subject: Re: [RFC][PATCH 3/7] smack: assign the label set in file->f_cred
 to new file descriptors
References: <1303907657-18366-1-git-send-email-roberto.sassu@polito.it> <1303907657-18366-4-git-send-email-roberto.sassu@polito.it>
In-Reply-To: <1303907657-18366-4-git-send-email-roberto.sassu@polito.it>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 4/27/2011 5:34 AM, Roberto Sassu wrote:
> The SMACK label of new file descriptors is obtained from the credentials
> set in the 'f_cred' field of the same structure.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@polito.it>
> ---
>  security/smack/smack_lsm.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index c6f8fca..e3c9e54 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -1011,7 +1011,7 @@ static int smack_file_permission(struct file *file, int mask)
>   */
>  static int smack_file_alloc_security(struct file *file)
>  {
> -	file->f_security = smk_of_current();
> +	file->f_security = smk_of_task(file->f_cred->security);

Now hang on. This just looks wrong. You're setting the value of one
field of the file structure to another value in the same file structure.
I don't see that this is what I want.

>  	return 0;
>  }
>  


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
