Subject: Re: [RFC PATCH v1 1/3] lsm: introduce hooks for kdbus
To: Paul Moore <pmoore@redhat.com>,
 Paul Osmialowski <p.osmialowsk@samsung.com>,
 linux-security-module@vger.kernel.org,
 Lukasz Pawelczyk <l.pawelczyk@samsung.com>, selinux@tycho.nsa.gov
References: <20150923213043.25616.43422.stgit@localhost>
 <20150923214413.25616.29131.stgit@localhost>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <56043A7D.7030205@tycho.nsa.gov>
Date: Thu, 24 Sep 2015 14:01:33 -0400
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
>  	/*
>  	 * Account the connection against the current user (UID), or for
>  	 * custom endpoints use the anonymous user assigned to the endpoint.

It occurs to me that we aren't passing any information about the
endpoint or bus here.  conn->cred will be file->f_cred.  That will
generally be the same as the current cred since the process will have
opened the endpoint file in kdbusfs and then invoked ioctl with the
KDBUS_CMD_HELLO command on that open file.  So if I do a check against
that cred, it will always be to my own label, not to the actual creator
of the bus or the endpoint.

In comparison, kdbus_ep_is_owner(), which is called by this function,
checks file->f_cred->euid against ep->bus->node.uid.  Unfortunately the
kdbus_node struct does not contain a complete cred, just uid/gid/mode
information that gets used in various places, including for setting up
the pseudo file in kdbusfs that is used to access the bus or endpoint.
That seems to be kdbus' basic means of isolating different users; by
default, any bus or endpoint I create will only be accessible by my own
uid unless I choose to make it group or world accessible. current_euid()
and current_egid() are saved in the nodes when the bus or endpoint is
created, and later used in populating the inode and for uid comparisons.

If we want the same for MAC, I guess we either need kdbus_node to hold a
ref to a cred (and then we can pass ep->node->cred to the hooks), or
just add our own security field to kdbus_node.  The former seems cleaner
to me; we can then just take an additional reference to the bus or
endpoint creator's cred at creation time.  And then we need kdbusfs to
call a new hook on the inode and the cred in order to set the
inode->i_security to something appropriate for the bus or endpoint
creator.  Otherwise, we don't get any control over the ability to open
any given endpoint or bus in kdbusfs, as that is only subject to the
inode permission checks.
