Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n5A3eCM2017885
	for <selinux@tycho.nsa.gov>; Tue, 9 Jun 2009 23:40:12 -0400
Received: from smtp108.prem.mail.sp1.yahoo.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id n5A3eW34000038
	for <selinux@tycho.nsa.gov>; Wed, 10 Jun 2009 03:40:33 GMT
Message-ID: <4A2F2B08.40701@schaufler-ca.com>
Date: Tue, 09 Jun 2009 20:39:52 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: "Serge E. Hallyn" <serue@us.ibm.com>
CC: Linux Containers <containers@lists.osdl.org>,
        Oren Laadan <orenl@cs.columbia.edu>,
        David Howells <dhowells@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morgan <morgan@kernel.org>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: [PATCH 10/10] cr: lsm: restore file->f_security
References: <20090610014412.GA5628@us.ibm.com> <20090610014704.GI5658@us.ibm.com>
In-Reply-To: <20090610014704.GI5658@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Serge E. Hallyn wrote:
> file->f_cred is the cred of the task which opened it.  file->f_security
> can be separately set by the LSM.  Checkpoint the file->f_security,
> and at restart ask the LSM, using security_file_restore, based on the current
> task's context and the checkpointed f_security, which f_security to apply (or
> whether to refuse the restart altogether).
>
> For Smack, accept the checkpointed label if the restarting task has
> CAP_MAC_ADMIN.
>
> For SELinux, I currently ignore the checkpointed label and call
> file_alloc_security().  Do we want to have 'restore' permission for
> class file?
>
> Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>
> ---
>  checkpoint/files.c             |   33 +++++++++++++++++++++++++++++++++
>  include/linux/checkpoint_hdr.h |    1 +
>  include/linux/security.h       |   13 +++++++++++++
>  security/capability.c          |    6 ++++++
>  security/security.c            |    5 +++++
>  security/selinux/hooks.c       |   11 +++++++++++
>  security/smack/smack_lsm.c     |   26 +++++++++++++++++++++++++-
>  7 files changed, 94 insertions(+), 1 deletions(-)
>
>   

> ...

> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index dfc0f7a..7bcdfde 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -831,6 +831,30 @@ static int smack_file_alloc_security(struct file *file)
>  }
>  
>  /**
> + * smack_file_restore_security - assign a file security blob
> + * @file: the object
> + * @stored: the label stored in the checkpoint file
> + *
> + * Returns 0
>   

Or -EINVAL if the label is not acceptable

> + */
> +static int smack_file_restore_security(struct file *file, void *stored)
> +{
> +	char *str = smk_import(stored, 0);
> +
> +	if (str == NULL)
> +		return -EINVAL;
> +
> +	file->f_security = current_security();
> +	if (current_security() != str) {
> +		if (!capable(CAP_MAC_ADMIN))
> +			return -EPERM;
> +		file->f_security = str;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
>   * smack_file_free_security - clear a file security blob
>   * @file: the object
>   *
> @@ -1630,7 +1654,6 @@ static int smack_msg_msg_restore_security(struct msg_msg *msg,
>  		msg->security = str;
>  	}
>  	return 0;
> -	return 0;
>   

Looks like you caught that. Thank you

>  }
>  
>  /**
> @@ -2996,6 +3019,7 @@ struct security_operations smack_ops = {
>  
>  	.file_permission = 		smack_file_permission,
>  	.file_alloc_security = 		smack_file_alloc_security,
> +	.file_restore_security =	smack_file_restore_security,
>  	.file_free_security = 		smack_file_free_security,
>  	.file_ioctl = 			smack_file_ioctl,
>  	.file_lock = 			smack_file_lock,
>   

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
