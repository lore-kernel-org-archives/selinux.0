Subject: Re: Minor issue with reading selinuxfs booleans.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
Cc: SELinux List <selinux@tycho.nsa.gov>, James Morris <jmorris@namei.org>
In-Reply-To: <4A122FF0.3010609@tycho.nsa.gov>
References: <4A122FF0.3010609@tycho.nsa.gov>
Content-Type: text/plain
Date: Tue, 19 May 2009 09:02:23 -0400
Message-Id: <1242738143.20082.169.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-05-19 at 00:05 -0400, Eamon Walsh wrote:
> Recent versions of coreutils have bumped the read buffer size from 4K to
> 32K in several of the utilities.
> 
> This means that "cat /selinux/booleans/xserver_object_manager" no longer
> works, it returns "Invalid argument" on F11.  getsebool works fine.
> 
> sel_read_bool has a check for "count > PAGE_SIZE" that doesn't seem to
> be present in the other read functions.  Maybe it could be removed?

Yes, that check is obsoleted by the conversion of those functions to
using simple_read_from_buffer(), which will reduce count if necessary to
what is available in the buffer.

Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

---

 security/selinux/selinuxfs.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 2d5136e..35b447b 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -803,10 +803,6 @@ static ssize_t sel_read_bool(struct file *filep, char __user *buf,
 		goto out;
 	}
 
-	if (count > PAGE_SIZE) {
-		ret = -EINVAL;
-		goto out;
-	}
 	page = (char *)get_zeroed_page(GFP_KERNEL);
 	if (!page) {
 		ret = -ENOMEM;

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
