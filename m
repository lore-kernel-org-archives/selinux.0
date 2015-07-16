Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6G3LmSR024135
 for <selinux@tycho.nsa.gov>; Wed, 15 Jul 2015 23:21:48 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Seth Forshee <seth.forshee@canonical.com>
References: <1436989569-69582-1-git-send-email-seth.forshee@canonical.com>
Date: Wed, 15 Jul 2015 22:15:21 -0500
In-Reply-To: <1436989569-69582-1-git-send-email-seth.forshee@canonical.com>
 (Seth Forshee's message of "Wed, 15 Jul 2015 14:46:01 -0500")
Message-ID: <87615k7pyu.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH 0/7] Initial support for user namespace owned mounts
Cc: Serge Hallyn <serge.hallyn@canonical.com>, linux-kernel@vger.kernel.org,
 Andy Lutomirski <luto@amacapital.net>, linux-security-module@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>, selinux@tycho.nsa.gov,
 linux-fsdevel@vger.kernel.org
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


Seth I think for the LSMs we should start with:

diff --git a/security/security.c b/security/security.c
index 062f3c997fdc..5b6ece92a8e5 100644
--- a/security/security.c
+++ b/security/security.c
@@ -310,6 +310,8 @@ int security_sb_statfs(struct dentry *dentry)
 int security_sb_mount(const char *dev_name, struct path *path,
                        const char *type, unsigned long flags, void *data)
 {
+       if (current_user_ns() != &init_user_ns)
+               return -EPERM;
        return call_int_hook(sb_mount, 0, dev_name, path, type, flags, data);
 }


Then we should push this down into all of the lsms.
Then when we should remove or relax or change the check as appropriate
in each lsm.

The point is this is good enough to see that it is trivially safe,
and this allows us to focus on the core issues, and stop worrying about
the lsms for a bit.

Then we can focus on each lsm one at at time and take the time to really
understand them and talk with their maintainers etc to make certain
we get things correct.

This should remove the need for your patches 5, 6 and 7. For the
immediate future.

Eric
