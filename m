Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m3THUidR029515
	for <selinux@tycho.nsa.gov>; Tue, 29 Apr 2008 13:30:44 -0400
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m3THUfFm021269
	for <selinux@tycho.nsa.gov>; Tue, 29 Apr 2008 17:30:41 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.14.1/8.14.1) with ESMTP id m3THVeSc011106
	for <selinux@tycho.nsa.gov>; Tue, 29 Apr 2008 13:31:40 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.14.1/8.14.1/Submit) id m3THVex4011105
	for selinux@tycho.nsa.gov; Tue, 29 Apr 2008 13:31:40 -0400
Date: Tue, 29 Apr 2008 10:18:43 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org, selinux@tycho.nsa.gov
Cc: Justin Forbes <jmforbes@linuxtx.org>,
        Zwane Mwaikambo <zwane@arm.linux.org.uk>,
        "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
        Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
        Chris Wedgwood <reviews@ml.cw.f00f.org>,
        Michael Krufky <mkrufky@linuxtv.org>,
        Chuck Ebbert <cebbert@redhat.com>,
        Domenico Andreoli <cavokz@gmail.com>, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk, sds@tycho.nsa.gov,
        jmorris@namei.org, Eric Paris <eparis@redhat.com>
Subject: [20/37] SELinux: no BUG_ON(!ss_initialized) in
	selinux_clone_mnt_opts
Message-ID: <20080429171843.GU14724@suse.de>
References: <20080429171222.073929148@mini.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080429171730.GA14724@suse.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

2.6.25-stable review patch.  If anyone has any objections, please let us
know.

------------------
From: Eric Paris <eparis@redhat.com>

commit 0f5e64200f20fc8f5b759c4010082f577ab0af3f upstream

The Fedora installer actually makes multiple NFS mounts before it loads
selinux policy.  The code in selinux_clone_mnt_opts() assumed that the
init process would always be loading policy before NFS was up and
running.  It might be possible to hit this in a diskless environment as
well, I'm not sure.  There is no need to BUG_ON() in this situation
since we can safely continue given the circumstances.

Signed-off-by: Eric Paris <eparis@redhat.com>
Signed-off-by: James Morris <jmorris@namei.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 security/selinux/hooks.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -756,9 +756,18 @@ static void selinux_sb_clone_mnt_opts(co
 	int set_context =	(oldsbsec->flags & CONTEXT_MNT);
 	int set_rootcontext =	(oldsbsec->flags & ROOTCONTEXT_MNT);
 
-	/* we can't error, we can't save the info, this shouldn't get called
-	 * this early in the boot process. */
-	BUG_ON(!ss_initialized);
+	/*
+	 * if the parent was able to be mounted it clearly had no special lsm
+	 * mount options.  thus we can safely put this sb on the list and deal
+	 * with it later
+	 */
+	if (!ss_initialized) {
+		spin_lock(&sb_security_lock);
+		if (list_empty(&newsbsec->list))
+			list_add(&newsbsec->list, &superblock_security_head);
+		spin_unlock(&sb_security_lock);
+		return;
+	}
 
 	/* how can we clone if the old one wasn't set up?? */
 	BUG_ON(!oldsbsec->initialized);

-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
