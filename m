Subject: Re: [PATCH 5/6] Keys: Restrict contents of /proc/keys to Viewable
	keys
From: Michael LeMay <mdlemay@epoch.ncsc.mil>
To: David Howells <dhowells@redhat.com>
Cc: sds@tycho.nsa.gov, jmorris@redhat.com, selinux@tycho.nsa.gov
In-Reply-To: <20060615141000.15380.76275.stgit@warthog.cambridge.redhat.com>
References: <20060615140948.15380.41826.stgit@warthog.cambridge.redhat.com>
	 <20060615141000.15380.76275.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain
Date: Thu, 15 Jun 2006 10:35:28 -0400
Message-Id: <1150382128.8976.2.camel@moss-tarheels.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The description of this patch needs to be updated, since you trimmed off
the key-users part.  It's also missing my updated config file
descriptions and documentation updates.

On Thu, 2006-06-15 at 15:10 +0100, David Howells wrote:
> From: Michael LeMay <mdlemay@epoch.ncsc.mil>
> 
> This patch restricts /proc/keys such that only those keys to which the current
> task is granted View permission are presented.
> 
> This patch also restricts /proc/key-users so that ordinary users are only
> allowed to view their own statistics.  Processes with superuser privileges,
> however, can view the statistics for all users.
> 
> The documentation is also updated to reflect these changes.
> 
> Signed-off-by: Michael LeMay <mdlemay@epoch.ncsc.mil>
> Signed-Off-By: David Howells <dhowells@redhat.com>
> ---
> 
>  Documentation/keys.txt |    8 ++++----
>  security/keys/proc.c   |    7 +++++++
>  2 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/keys.txt b/Documentation/keys.txt
> index 3bbe157..253b295 100644
> --- a/Documentation/keys.txt
> +++ b/Documentation/keys.txt
> @@ -270,9 +270,9 @@ about the status of the key service:
>  
>   (*) /proc/keys
>  
> -     This lists all the keys on the system, giving information about their
> -     type, description and permissions. The payload of the key is not available
> -     this way:
> +     This lists all the keys that are currently accessible to the task querying
> +     the file, giving information about their type, description and
> +     permissions.  The payload of the key is not available this way:
>  
>  	SERIAL   FLAGS  USAGE EXPY PERM     UID   GID   TYPE      DESCRIPTION: SUMMARY
>  	00000001 I-----    39 perm 1f3f0000     0     0 keyring   _uid_ses.0: 1/4
> @@ -300,7 +300,7 @@ about the status of the key service:
>   (*) /proc/key-users
>  
>       This file lists the tracking data for each user that has at least one key
> -     on the system. Such data includes quota information and statistics:
> +     on the system.  Such data includes quota information and statistics:
>  
>  	[root@andromeda root]# cat /proc/key-users
>  	0:     46 45/45 1/100 13/10000
> diff --git a/security/keys/proc.c b/security/keys/proc.c
> index 12b750e..686a9ee 100644
> --- a/security/keys/proc.c
> +++ b/security/keys/proc.c
> @@ -137,6 +137,13 @@ static int proc_keys_show(struct seq_fil
>  	struct timespec now;
>  	unsigned long timo;
>  	char xbuf[12];
> +	int rc;
> +
> +	/* check whether the current task is allowed to view the key (assuming
> +	 * non-possession) */
> +	rc = key_task_permission(make_key_ref(key, 0), current, KEY_VIEW);
> +	if (rc < 0)
> +		return 0;
>  
>  	now = current_kernel_time();
>  


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
