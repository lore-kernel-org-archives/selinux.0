Subject: Re: [RFC PATCH v3 1/5] kdbus: add creator credentials to the endpoints
To: Paul Moore <pmoore@redhat.com>, linux-security-module@vger.kernel.org,
 linux-audit@redhat.com, selinux@tycho.nsa.gov
References: <20151007230615.7823.74519.stgit@localhost>
 <20151007230822.7823.96688.stgit@localhost>
Cc: Paul Osmialowski <p.osmialowsk@samsung.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <5617CFAB.1050607@tycho.nsa.gov>
Date: Fri, 9 Oct 2015 10:31:07 -0400
MIME-Version: 1.0
In-Reply-To: <20151007230822.7823.96688.stgit@localhost>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 10/07/2015 07:08 PM, Paul Moore wrote:
> In order to effectively enforce LSM based access controls we need to
> have more information about the kdbus endpoint creator than the
> uid/gid currently stored in the kdbus_node_type struct.  This patch
> replaces the uid/gid values with a reference to the node creator's
> credential struct which serves the needs of both the kdbus DAC access
> controls as well as the LSM's access controls.
>
> Two macros have also been created, kdbus_node_[uid,gid](), which can
> be used to easily extract the euid/egid information from the new
> credential reference.  The effective uid/gid is used as it was used
> in all areas of the previous kdbus code except for areas where the
> uid/gid was never set beyond the basic initialization to zero/root;
> I expect this was a bug that was never caught as the node creator in
> these cases was always expect to be root.
>
> Signed-off-by: Paul Moore <pmoore@redhat.com>
>
> ---
> ChangeLog:
> - v3
>   * Ported to the 4.3-rc4 based kdbus tree
> - v2
>   * Initial draft
> ---
>   ipc/kdbus/bus.c      |   13 +++++--------
>   ipc/kdbus/endpoint.c |   14 ++++----------
>   ipc/kdbus/endpoint.h |    3 +--
>   ipc/kdbus/fs.c       |    4 ++--
>   ipc/kdbus/node.c     |   11 ++++-------
>   ipc/kdbus/node.h     |    5 +++--
>   6 files changed, 19 insertions(+), 31 deletions(-)
>

> diff --git a/ipc/kdbus/node.c b/ipc/kdbus/node.c
> index 89f58bc..cd0c1a0 100644
> --- a/ipc/kdbus/node.c
> +++ b/ipc/kdbus/node.c
> @@ -12,6 +12,7 @@
>    */
>
>   #include <linux/atomic.h>
> +#include <linux/cred.h>
>   #include <linux/fs.h>
>   #include <linux/idr.h>
>   #include <linux/kdev_t.h>
> @@ -170,13 +171,7 @@
>    *                         node initialization. They must remain constant. If
>    *                         NULL, they're skipped.
>    *
> - *     * node->mode: filesystem access modes

mode still remains
