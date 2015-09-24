Subject: Re: [RFC PATCH v1 1/3] lsm: introduce hooks for kdbus
To: Paul Moore <pmoore@redhat.com>,
 Paul Osmialowski <p.osmialowsk@samsung.com>,
 linux-security-module@vger.kernel.org,
 Lukasz Pawelczyk <l.pawelczyk@samsung.com>, selinux@tycho.nsa.gov
References: <20150923213043.25616.43422.stgit@localhost>
 <20150923214413.25616.29131.stgit@localhost>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <56041D53.3090806@tycho.nsa.gov>
Date: Thu, 24 Sep 2015 11:57:07 -0400
MIME-Version: 1.0
In-Reply-To: <20150923214413.25616.29131.stgit@localhost>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/23/2015 05:44 PM, Paul Moore wrote:
> Add LSM access control hooks to kdbus; several new hooks are added and
> the existing security_file_receive() hook is reused.  The new hooks
> are listed below:
> 
>  * security_kdbus_conn_new
>    Check if the current task is allowed to create a new kdbus
>    connection.
>  * security_kdbus_own_name
>    Check if a connection is allowed to own a kdbus service name.
>  * security_kdbus_conn_talk
>    Check if a connection is allowed to talk to a kdbus peer.
>  * security_kdbus_conn_see
>    Check if a connection can see a kdbus peer.
>  * security_kdbus_conn_see_name
>    Check if a connection can see a kdbus service name.
>  * security_kdbus_conn_see_notification
>    Check if a connection can receive notifications.
>  * security_kdbus_proc_permission
>    Check if a connection can access another task's pid namespace info.
> 
> Signed-off-by: Paul Moore <pmoore@redhat.com>
> ---
>  include/linux/security.h |  113 ++++++++++++++++++++++++++++++++++++++++++++++
>  ipc/kdbus/connection.c   |   73 ++++++++++++++++++++----------
>  ipc/kdbus/message.c      |   19 ++++++--
>  ipc/kdbus/metadata.c     |    6 +-
>  security/security.c      |   45 ++++++++++++++++++
>  5 files changed, 223 insertions(+), 33 deletions(-)
> 

> diff --git a/ipc/kdbus/connection.c b/ipc/kdbus/connection.c
> index ef63d65..be8d210 100644
> --- a/ipc/kdbus/connection.c
> +++ b/ipc/kdbus/connection.c
> @@ -26,6 +26,7 @@
>  #include <linux/path.h>
>  #include <linux/poll.h>
>  #include <linux/sched.h>
> +#include <linux/security.h>
>  #include <linux/shmem_fs.h>
>  #include <linux/sizes.h>
>  #include <linux/slab.h>
> @@ -213,6 +214,13 @@ static struct kdbus_conn *kdbus_conn_new(struct kdbus_ep *ep,
>  			goto exit_unref;
>  	}
>  
> +	ret = security_kdbus_conn_new(conn->cred, creds, pids, seclabel,
> +				      owner, privileged,
> +				      is_activator, is_monitor,
> +				      is_policy_holder);
> +	if (ret < 0)
> +		goto exit_unref;
> +

I think this could be moved up much earlier, right after the existing if
(!owner && (creds || pids || seclabel)) return ERR_PTR(-EPERM);, aside
from needing to pass file->f_cred instead of conn->cred at that point.
The advantage is that you can then just return the result immediately,
as there won't have been any allocation or setup of the conn structure,
and if permission was denied, you won't have wasted all of that
unnecessary processing.

>  	/*
>  	 * Account the connection against the current user (UID), or for
>  	 * custom endpoints use the anonymous user assigned to the endpoint.
> @@ -1435,12 +1443,12 @@ bool kdbus_conn_policy_own_name(struct kdbus_conn *conn,
>  			return false;
>  	}
>  
> -	if (conn->owner)
> -		return true;
> -
>  	res = kdbus_policy_query(&conn->ep->bus->policy_db, conn_creds,
>  				 name, hash);
> -	return res >= KDBUS_POLICY_OWN;
> +	if (conn->owner || res >= KDBUS_POLICY_OWN)
> +		return security_kdbus_own_name(conn_creds, name) == 0;
> +
> +	return false;

I could see them possibly objecting to this change on performance
grounds, as normally they wouldn't pay the cost of a
kdbus_policy_query() if conn->owner.  We could make it something like:
	if (!conn->owner) {
		res = kdbus_policy_query(...);
		if (res < KDBUS_POLICY_OWN)
			return false;
	}
	return (security_kdbus_own_name(conn_creds, name) == 0);
or even get rid of res and just coalesce it as:
	if (!conn->owner && kdbus_policy_query(...) < KDBUS_POLICY_OWN)
		return false;
	return (security_kdbus_own_name(conn_creds, name) == 0);

This has the side benefit of making the security hook call the tail of
the function.

>  }
>  
>  /**
> @@ -1465,14 +1473,13 @@ bool kdbus_conn_policy_talk(struct kdbus_conn *conn,
>  					 to, KDBUS_POLICY_TALK))
>  		return false;
>  
> -	if (conn->owner)
> -		return true;
> -	if (uid_eq(conn_creds->euid, to->cred->uid))
> -		return true;
> +	if (conn->owner || uid_eq(conn_creds->euid, to->cred->uid) ||
> +	    kdbus_conn_policy_query_all(conn, conn_creds,
> +					&conn->ep->bus->policy_db, to,
> +					KDBUS_POLICY_TALK) == 0)

kdbus_conn_policy_query_all() returns a bool (false/0 on denial; true/1
on allowed).  So I think the test is wrong above?

> +		return security_kdbus_conn_talk(conn_creds, to->cred) == 0;
>  
> -	return kdbus_conn_policy_query_all(conn, conn_creds,
> -					   &conn->ep->bus->policy_db, to,
> -					   KDBUS_POLICY_TALK);
> +	return false;

This might be more readable as:
	if (!conn->owner && !uid_eq(conn_creds->euid, to->cred->uid) &&
		!kdbus_conn_policy_query_all(...))
		return false;
        return (security_kdbus_conn_talk(conn_creds, to->cred) == 0);
		
>  }
>  
>  /**
> @@ -1493,17 +1500,19 @@ bool kdbus_conn_policy_see_name_unlocked(struct kdbus_conn *conn,
>  {
>  	int res;
>  
> +	if (!conn_creds)
> +		conn_creds = conn->cred;
> +
>  	/*
>  	 * By default, all names are visible on a bus. SEE policies can only be
>  	 * installed on custom endpoints, where by default no name is visible.
>  	 */
> -	if (!conn->ep->user)
> -		return true;
> -
> -	res = kdbus_policy_query_unlocked(&conn->ep->policy_db,
> -					  conn_creds ? : conn->cred,
> +	res = kdbus_policy_query_unlocked(&conn->ep->policy_db, conn_creds,
>  					  name, kdbus_strhash(name));
> -	return res >= KDBUS_POLICY_SEE;
> +	if (!conn->ep->user || res >= KDBUS_POLICY_SEE)
> +		return security_kdbus_conn_see_name(conn_creds, name) == 0;
> +
> +	return false;

Similar to the first one, we could avoid the cost of
kdbus_policy_query_unlocked() here via:
	if (!conn->ep->user &&
		kdbus_policy_query_unlocked(...) < KDBUS_POLICY_SEE)
		return false;
	return (security_kdbus_conn_see_name(conn_creds, name) == 0);

>  }
>  
>  static bool kdbus_conn_policy_see_name(struct kdbus_conn *conn,
> @@ -1523,6 +1532,9 @@ static bool kdbus_conn_policy_see(struct kdbus_conn *conn,
>  				  const struct cred *conn_creds,
>  				  struct kdbus_conn *whom)
>  {
> +	if (!conn_creds)
> +		conn_creds = conn->cred;
> +
>  	/*
>  	 * By default, all names are visible on a bus, so a connection can
>  	 * always see other connections. SEE policies can only be installed on
> @@ -1530,10 +1542,13 @@ static bool kdbus_conn_policy_see(struct kdbus_conn *conn,
>  	 * peers from each other, unless you see at least _one_ name of the
>  	 * peer.
>  	 */
> -	return !conn->ep->user ||
> -	       kdbus_conn_policy_query_all(conn, conn_creds,
> -					   &conn->ep->policy_db, whom,
> -					   KDBUS_POLICY_SEE);
> +	if (!conn->ep->user ||
> +	    kdbus_conn_policy_query_all(conn, conn_creds,
> +					&conn->ep->policy_db, whom,
> +					KDBUS_POLICY_SEE))
> +		return security_kdbus_conn_see(conn_creds, whom->cred) == 0;
> +
> +	return false;

Could restructure the same way, ala:
	if (!conn->ep->user && !kdbus_conn_policy_query_all(...))
		return false;
	return security_kdbus_conn_see(conn_creds, whom->cred) == 0);

>  }
>  
>  /**
> @@ -1551,6 +1566,9 @@ bool kdbus_conn_policy_see_notification(struct kdbus_conn *conn,
>  					const struct cred *conn_creds,
>  					const struct kdbus_msg *msg)
>  {
> +	if (!conn_creds)
> +		conn_creds = conn->cred;
> +
>  	/*
>  	 * Depending on the notification type, broadcasted kernel notifications
>  	 * have to be filtered:
> @@ -1567,18 +1585,25 @@ bool kdbus_conn_policy_see_notification(struct kdbus_conn *conn,
>  	case KDBUS_ITEM_NAME_ADD:
>  	case KDBUS_ITEM_NAME_REMOVE:
>  	case KDBUS_ITEM_NAME_CHANGE:
> -		return kdbus_conn_policy_see_name(conn, conn_creds,
> -					msg->items[0].name_change.name);
> +		if (!kdbus_conn_policy_see_name(conn, conn_creds,
> +						msg->items[0].name_change.name))
> +			return false;
>  
>  	case KDBUS_ITEM_ID_ADD:
>  	case KDBUS_ITEM_ID_REMOVE:
> -		return true;
> +		/* fall through for the LSM check */
> +		break;
>  
>  	default:
>  		WARN(1, "Invalid type for notification broadcast: %llu\n",
>  		     (unsigned long long)msg->items[0].type);
>  		return false;
>  	}
> +
> +	if (security_kdbus_conn_see_notification(conn_creds) < 0)
> +		return false;
> +
> +	return true;

Could make this just:
	return (security_kdbus_conn_see_notification(conn_creds) == 0);

>  }
>  
>  /**

> diff --git a/ipc/kdbus/metadata.c b/ipc/kdbus/metadata.c
> index 71ca475..07c45d7 100644
> --- a/ipc/kdbus/metadata.c
> +++ b/ipc/kdbus/metadata.c
> @@ -1182,11 +1182,9 @@ static unsigned int kdbus_proc_permission(const struct pid_namespace *pid_ns,
>  					  const struct cred *cred,
>  					  struct pid *target)
>  {
> -	if (pid_ns->hide_pid < 1)
> -		return KDBUS_META_PROC_NORMAL;
> -
>  	/* XXX: we need groups_search() exported for aux-groups */
> -	if (gid_eq(cred->egid, pid_ns->pid_gid))
> +	if ((pid_ns->hide_pid < 1 || gid_eq(cred->egid, pid_ns->pid_gid)) &&
> +	    security_kdbus_proc_permission(cred, target) == 0)
>  		return KDBUS_META_PROC_NORMAL;

Not your fault, but I have to wonder why this function can't just return
a bool like the policy functions; it has only two return values.  Hardly
worth an enum.
