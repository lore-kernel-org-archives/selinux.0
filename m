Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D8D219CA1
	for <selinux@vger.kernel.org>; Thu, 17 Oct 2024 19:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729193284; cv=none; b=a7YzYGXA8S5EIfTZgnfEf3xySlG/3ChBvasziEOZXjeBQ62lZu+Ll0hn2pYWa+XGeny+ZSOkdtxW6VLiCAUD73WLaowKecU3nAT2rN4xBb9S/fiX8UNtIeg9x5+99M7JfHz46/MbpFNS/+ZqOOaX9VRgGoT7IduP2a+sCytLMVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729193284; c=relaxed/simple;
	bh=3yUQxD3Bt8ZtQKBoI6I3sE/j8ROkrxpJXXTIRraYsCI=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=QrbNFRKBH5n5gRYIAx0THOtVALGgO2GuBsk6YKQFupsEDSBhItQsrsNVhAEdlrN99fJCWUr1UaPlLHlLAYD7t3dC1JVM+406QgyJ6jbl4X4qRg56wDzoje6hE7A9v3oXIv/kghU3GflhjZo41NQFcxARcub0daNhZp/CG0YbKGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=B3ubvtYw; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="B3ubvtYw"
Received: from [100.75.128.227] (unknown [40.78.12.246])
	by linux.microsoft.com (Postfix) with ESMTPSA id 83ED820F9E01
	for <selinux@vger.kernel.org>; Thu, 17 Oct 2024 12:28:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 83ED820F9E01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1729193282;
	bh=ycL88CG5W2j5L0pvMBQ2Q55vhZJwCHg8gb6IRwOuU/Y=;
	h=Date:To:From:Subject:From;
	b=B3ubvtYwOL9kZTp0TUOZ3CNkxA6ayYuP+Z+vjjIS0LYwdwLW2WW9yEvLyuF3dQftL
	 /hF074nDw94qfKIOF24+TmQSFtxD2AainvQAdIXhav4xqXxa766aDj4sQmvsip3x2u
	 DUcSIM78cn/5lv+4wt4SWX0vx6rVIfk0S29snc+I=
Message-ID: <a79e0e6f-e83d-4b4b-a55c-3f2c20b93c83@linux.microsoft.com>
Date: Thu, 17 Oct 2024 12:28:01 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: SELinux <selinux@vger.kernel.org>
From: Matthew Sheets <masheets@linux.microsoft.com>
Subject: selinux_set_callback for policy load not triggering
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi All,

I am currently working on an update for dbus-broker to trigger reload of 
its configuration whenever an SELinux policy load event is seen.

For some background dbus-broker is comprised of two major elements the 
launcher and the broker.  To trigger a config reload you can either send 
a SIGHUP to the launcher or send a message to the launcher over dbus. 
In most cases the launcher will be the brokers parent.

Here is a link to my current PR:
https://github.com/bus1/dbus-broker/pull/379

In this current state things work.  The broker will see the POLICY_LOAD 
event and properly send a SIGHUP to its parent, but as David pointed out 
my initial attempt at the fix is no good since there is no guarantee 
that the brokers parent will be the launcher.

My attempts at moving the callback registration into the launcher have 
been less successful.  From what my debugging has told me is that the 
selinux_set_callback is going through successfully and the function 
pointer is correctly pointing to the callback function I define.  But 
when I trigger a load_policy my callback function is never called.

I am not familiar with how the callbacks in libselinux work under the 
hood so I am unsure about what could be blocking them in this situation.

Here is my current diff with all of my debug taken out to make it easier 
to read:

diff --git a/Makefile b/Makefile
index d806160..3b29620 100644
--- a/Makefile
+++ b/Makefile
@@ -66,6 +66,7 @@ FORCE:
  MESON_SETUP        = \
     meson \
         setup \
+       --prefix=/usr \
         --buildtype "debugoptimized" \
         --reconfigure \
         --warnlevel "2" \
diff --git a/meson_options.txt b/meson_options.txt
index 5227a93..3f65964 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -4,6 +4,6 @@ option('docs', type: 'boolean', value: false, 
description: 'Build documentation'
  option('launcher', type: 'boolean', value: true, description: 'Build 
compatibility launcher')
  option('linux-4-17', type: 'boolean', value: false, description: 
'Require linux-4.17 at runtime and make use of its features')
  option('reference-test', type: 'boolean', value: false, description: 
'Run test suite against reference implementation')
-option('selinux', type: 'boolean', value: false, description: 'SELinux 
support')
+option('selinux', type: 'boolean', value: true, description: 'SELinux 
support')
  option('system-console-users', type: 'array', value: [], description: 
'Additional set of names of system-users to be considered at-console')
  option('tests', type: 'boolean', value: false, description: 'Include 
tests in the distribution')
diff --git a/src/launch/main.c b/src/launch/main.c
index ed08e85..46cb5f0 100644
--- a/src/launch/main.c
+++ b/src/launch/main.c
@@ -9,6 +9,7 @@
  #include <systemd/sd-daemon.h>
  #include "launch/launcher.h"
  #include "util/error.h"
+#include "util/selinux.h"

  enum {
          _MAIN_SUCCESS,
@@ -164,6 +165,8 @@ int main(int argc, char **argv) {
          if (r)
                  goto exit;

+        bus_selinux_register_load_cb();
+
          sigemptyset(&mask_new);
          sigaddset(&mask_new, SIGCHLD);
          sigaddset(&mask_new, SIGTERM);
diff --git a/src/util/selinux-fallback.c b/src/util/selinux-fallback.c
index 0654a07..7e00c3c 100644
--- a/src/util/selinux-fallback.c
+++ b/src/util/selinux-fallback.c
@@ -60,3 +60,7 @@ int bus_selinux_init_global(void) {
  void bus_selinux_deinit_global(void) {
          return;
  }
+
+void bus_selinux_register_load_cb(void) {
+        return;
+}
diff --git a/src/util/selinux.c b/src/util/selinux.c
index a72cc0a..c9ed99d 100644
--- a/src/util/selinux.c
+++ b/src/util/selinux.c
@@ -6,6 +6,7 @@
  #include <c-stdaux.h>
  #include <selinux/selinux.h>
  #include <selinux/avc.h>
+#include <signal.h>
  #include <stdlib.h>
  #include "util/audit.h"
  #include "util/error.h"
@@ -413,3 +414,50 @@ void bus_selinux_deinit_global(void) {
                  bus_selinux_avc_open = false;
          }
  }
+
+/**
+ * On a policy reload we need to reparse the SELinux configuration 
file, since
+ * this could have changed.  Send a SIGHUP to reload all configs.
+ */
+static int policy_reload_callback(int seqno) {
+        return raise(SIGHUP);
+}
+
+/**
+ * bus_selinux_register_load_cb() - register SIGHUP callback for policy 
load
+ *
+ * Will register a call back to raise a SIGHUP when a SELinux policy load
+ * is seen.
+ */
+void bus_selinux_register_load_cb(void) {
+        int r;
+        if (!is_selinux_enabled())
+                return ;
+
+        if (!bus_selinux_status_open) {
+                r = selinux_status_open(0);
+                if (r == 0) {
+                        /*
+                         * The status page was successfully opened and 
can now
+                         * be used for faster selinux status-checks.
+                         */
+                        bus_selinux_status_open = true;
+                } else if (r > 0) {
+                        /*
+                         * >0 indicates success but with the 
netlink-fallback.
+                         * We didn't request the netlink-fallback, so 
close the
+                         * status-page again and treat it as unavailable.
+                         */
+                        selinux_status_close();
+                } else {
+                        /*
+                         * If the status page could not be opened, 
treat it as
+                         * unavailable and use the slower fallback 
functions.
+                         */
+                }
+        }
+
+        selinux_set_callback(SELINUX_CB_POLICYLOAD, (union 
selinux_callback)policy_reload_callback);
+
+        return;
+}
diff --git a/src/util/selinux.h b/src/util/selinux.h
index 435c8a8..d5452fd 100644
--- a/src/util/selinux.h
+++ b/src/util/selinux.h
@@ -36,3 +36,5 @@ int bus_selinux_check_send(BusSELinuxRegistry *registry,

  int bus_selinux_init_global(void);
  void bus_selinux_deinit_global(void);
+
+void bus_selinux_register_load_cb(void);

Note that I have tried moving where the callback registration happens in 
the launcher with no luck.  I know I can go down the dbus message path 
but the SIGHUP from the launcher seems so much more straight forward.

Thanks in advance for any insight folks might have.
