Subject: [PATCH] capability: WARN when invalid capability is requested
	rather than BUG/panic
From: Eric Paris <eparis@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: sds@tycho.nsa.gov, jmorris@namei.org, morgan@kernel.org, serue@us.ibm.com,
        selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Tue, 30 Sep 2008 09:55:46 -0400
Message-Id: <1222782946.28251.63.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The firegl ATI/AMD closed source proprietary driver has some 2,733
panics registered on kerneloops.org and recently SELinux was blamed for
BUGing because of this driver.

http://www.kerneloops.org/search.php?search=firegl_ioctl&btnG=Function+Search

Basically it looks like the firegl_ioctl() function is calling capable()
with a huge value.  cap_capable dereferences an array (64 bits long) WAY
off the end.  I know a specific example would be referencing the array
c.cap[0x7B4BB01].  As dumb luck would have it occasionally this doesn't
pagefault / panic and so we get to selinux code which has a clean check
for values which are obviously too large and BUG().

This patch adds a WARN_ONCE() to cap_capable() so we will stop
dereferencing random spots of memory and will cleanly tell the obviously
broken driver that it doesn't have that ridiculous permissions.  No idea
if the driver is going to handle EPERM but anything that calls capable
and doesn't expect a denial has got to be the worst piece of code ever
written.....  I could return EINVAL, but I think its clear that noone
has capabilities over 64 so clearly they don't have that permission.

This 'could' be considered a regression since 2.6.24.  Neither SELinux
nor the capabilities system had a problem with ginormous request values
until we got 64 bit support, although this is OBVIOUSLY a bug with the
out of tree closed source driver....

Oh yeah, and if anyone knows people at ATI/AMD tell them to fix their
broken driver....

Signed-off-by: Eric Paris <eparis@redhat.com>

---

 security/commoncap.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index e4c4b3f..92715e7 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -50,6 +50,11 @@ EXPORT_SYMBOL(cap_netlink_recv);
  */
 int cap_capable (struct task_struct *tsk, int cap)
 {
+	if (unlikely(!cap_valid(cap))) {
+		WARN_ONCE(1, "Invalid capability:%d\n", cap);
+		return -EPERM;
+	}
+
 	/* Derived from include/linux/sched.h:capable. */
 	if (cap_raised(tsk->cap_effective, cap))
 		return 0;



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
