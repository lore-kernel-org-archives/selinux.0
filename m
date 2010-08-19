Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o7JGhiTQ031472
	for <selinux@tycho.nsa.gov>; Thu, 19 Aug 2010 12:43:44 -0400
Received: from mail-pz0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o7JGhZ9p007081
	for <selinux@tycho.nsa.gov>; Thu, 19 Aug 2010 16:43:36 GMT
Received: by pzk36 with SMTP id 36so9802pzk.12
        for <selinux@tycho.nsa.gov>; Thu, 19 Aug 2010 09:43:43 -0700 (PDT)
From: "Justin P. Mattock" <justinmattock@gmail.com>
To: xorg@freedesktop.org
Cc: selinux@tycho.nsa.gov, "Justin P. Mattock" <justinmattock@gmail.com>
Subject: [PATCH]include/dixaccess.h fix comment.
Date: Thu, 19 Aug 2010 09:43:23 -0700
Message-Id: <1282236203-4267-1-git-send-email-justinmattock@gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

After reading through XACE-Spec.txt, then looking through all the code
I found the below comment, not to make sense. I think it needs to be
changed to "adjust" due to the Property access mode bits giving info
on adjusting different modes etc..(but could be wrong).

Signed-off-by: Justin P. Mattock <justinmattock@gmail.com>

---
 include/dixaccess.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/dixaccess.h b/include/dixaccess.h
index 7180acd..1628769 100644
--- a/include/dixaccess.h
+++ b/include/dixaccess.h
@@ -16,7 +16,7 @@ CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
  * to several of the dix lookup functions.  They were originally part
  * of the Security extension, now used by XACE.
  *
- * You can or these values together to indicate multiple modes
+ * You can adjust these values together to indicate multiple modes
  * simultaneously.
  */
 
-- 
1.7.2.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
