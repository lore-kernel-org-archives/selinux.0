Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w1FHYmHF007364
 for <selinux@tycho.nsa.gov>; Thu, 15 Feb 2018 12:34:48 -0500
Received: by mail-wm0-f66.google.com with SMTP id v71so2305843wmv.2
 for <selinux@tycho.nsa.gov>; Thu, 15 Feb 2018 09:34:43 -0800 (PST)
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Date: Thu, 15 Feb 2018 18:34:37 +0100
Message-Id: <20180215173437.14632-1-dac.override@gmail.com>
Subject: [PATCH] Describe multiple-decls in secilc.8.xml
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Dominick Grift <dac.override@gmail.com>
---
 secilc/secilc.8.xml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/secilc/secilc.8.xml b/secilc/secilc.8.xml
index 4c779b64..e08a9624 100644
--- a/secilc/secilc.8.xml
+++ b/secilc/secilc.8.xml
@@ -75,6 +75,11 @@
             <listitem><para>Treat tunables as booleans.</para></listitem>
          </varlistentry>
 
+         <varlistentry>
+            <term><option>-m, --multiple-decls</option></term>
+            <listitem><para>Allow some statements to be re-declared.</para></listitem>
+         </varlistentry>
+
          <varlistentry>
             <term><option>-N, --disable-neverallow</option></term>
             <listitem><para>Do not check <emphasis role="bold">neverallow</emphasis> rules.</para></listitem>
-- 
2.16.1
