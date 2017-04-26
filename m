Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v3QKAM3V011392
 for <selinux@tycho.nsa.gov>; Wed, 26 Apr 2017 16:10:22 -0400
Message-Id: <1493237420.1820719.957368808.08E54C5A@webmail.messagingengine.com>
From: Colin Walters <walters@verbum.org>
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Date: Wed, 26 Apr 2017 16:10:20 -0400
Subject: is_selinux_enabled() always returns 0 after selinux_set_policy_root()
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I've been reworking some bits of ostree/rpm-ostree's SELinux support
recently in https://github.com/ostreedev/ostree/pull/797 - basically
using setfscreatecon() more.

However, I ran into an interesting thing I think is a bug - if others
agree I can write a patch.   Right now, as far as I can see, after
a process calls selinux_set_policy_root(), every further call to
is_selinux_enabled() will return FALSE (0).

In current git master of libselinux, we initialize via a library
constructor:
https://github.com/SELinuxProject/selinux/blob/89ce96cac6ce5eeed78cb39c58514cd68494d7aa/libselinux/src/init.c#L151

Now, selinux_set_policy_root() explicitly undoes this initialization:
https://github.com/SELinuxProject/selinux/blob/89ce96cac6ce5eeed78cb39c58514cd68494d7aa/libselinux/src/selinux_config.c#L285

Why does it do that?  It looks like this call existed since the function
was created in
https://github.com/SELinuxProject/selinux/commit/7fe6036ca5e3624d6e3a0294b909d93b145eac31

And I can't see any other place where we will reinitialize the variable;
There's no API to reinitialize `selinux_mnt`, it's only set once at library
init time.

In other words...

diff --git a/libselinux/src/selinux_config.c b/libselinux/src/selinux_config.c
index d8e140c..292728f 100644
--- a/libselinux/src/selinux_config.c
+++ b/libselinux/src/selinux_config.c
@@ -282,7 +282,6 @@ int selinux_set_policy_root(const char *path)
 	}
 	policy_type++;
 
-	fini_selinuxmnt();
 	fini_selinux_policyroot();
 
 	selinux_policyroot = strdup(path);

Right?
