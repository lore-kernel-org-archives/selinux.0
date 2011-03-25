Subject: [PATCH] selinux: Fix regression for Xorg
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@parisplace.org>, James Morris <jmorris@namei.org>
Cc: qingtao.cao@windriver.com, "Justin P. Mattock"
 <justinmattock@gmail.com>,
        selinux@tycho.nsa.gov
In-Reply-To: <1301056481.22099.8.camel@moss-pluto>
References: <4D878244.4060502@gmail.com> <4D8A36E9.3070601@gmail.com>
	 <4D8AACD9.60505@gmail.com> <1300975137.8157.38.camel@moss-pluto>
	 <4D8B70C8.3000800@gmail.com> <1300997637.8157.44.camel@moss-pluto>
	 <4D8BA7F0.5090307@gmail.com> <1300998293.8157.48.camel@moss-pluto>
	 <4D8BACFD.6090400@gmail.com>  <4D8C09A3.5090304@windriver.com>
	 <1301055989.22099.4.camel@moss-pluto> <1301056481.22099.8.camel@moss-pluto>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 25 Mar 2011 10:13:43 -0400
Message-ID: <1301062423.22099.19.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Commit 6f5317e730505d5cbc851c435a2dfe3d5a21d343 introduced a bug in the
handling of userspace object classes that is causing breakage for Xorg
when XSELinux is enabled.  Fix the bug by changing map_class() to return
SECCLASS_NULL when the class cannot be mapped to a kernel object class.

Reported-by:  "Justin P. Mattock" <justinmattock@gmail.com>
Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

---

 security/selinux/ss/services.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 3e7544d..ea7c01f 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -213,7 +213,7 @@ static u16 map_class(u16 pol_value)
 			return i;
 	}
 
-	return pol_value;
+	return SECCLASS_NULL;
 }
 
 static void map_decision(u16 tclass, struct av_decision *avd,

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
