Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v3CDgaM6004800
 for <selinux@tycho.nsa.gov>; Wed, 12 Apr 2017 09:42:36 -0400
Received: by mail-wr0-f196.google.com with SMTP id o21so4255925wrb.3
 for <selinux@tycho.nsa.gov>; Wed, 12 Apr 2017 06:42:25 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Wed, 12 Apr 2017 15:42:23 +0200
Message-ID: <CAJ2a_DeiDjzz=CK_MuWB+zSvw7SGOiu_U9N-_LXYvBj3hQtdrw@mail.gmail.com>
Subject: [PATCH 2/2] sestatus: show checkreqprot status
To: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Show the current active checkreqprot state in sestatus

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 policycoreutils/sestatus/sestatus.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/policycoreutils/sestatus/sestatus.c
b/policycoreutils/sestatus/sestatus.c
index 2111b15d..f9ed5b66 100644
--- a/policycoreutils/sestatus/sestatus.c
+++ b/policycoreutils/sestatus/sestatus.c
@@ -330,6 +330,20 @@ int main(int argc, char **argv)
  break;
  }

+ printf_tab("Policy checkreqprot status:");
+ rc = security_checkreqprot();
+ switch (rc) {
+ case 0:
+ printf("kernel\n");
+ break;
+ case 1:
+ printf("application\n");
+ break;
+ default:
+ printf("error (%s)\n", strerror(errno));
+ break;
+ }
+
  rc = security_policyvers();
  printf_tab("Max kernel policy version:");
  if (rc < 0)
-- 
2.11.0
