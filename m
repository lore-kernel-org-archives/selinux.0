Message-ID: <1348235436.9436.17.camel@moss-pluto.epoch.ncsc.mil>
Subject: [PATCH] selinux-testsuite: Wrap auth_read_passwd with
 ifdef(`distro_redhat') .
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Sven Vermeulen <sven.vermeulen@siphos.be>
Cc: SELinux <selinux@tycho.nsa.gov>, Serge Hallyn <serge@hallyn.com>
Date: Fri, 21 Sep 2012 09:50:36 -0400
In-Reply-To: <CAPzO=Nw7vE6Q9ncy-vWauQCzTsEBzj75ExREg0j+B-r637+SzA@mail.gmail.com>
References: <1347545325.15047.34.camel@moss-pluto.epoch.ncsc.mil>
	 <5051FB6A.8040106@redhat.com> <20120915022200.GB6438@mail.hallyn.com>
	 <1347975902.29192.17.camel@moss-pluto.epoch.ncsc.mil>
	 <5058A22E.7010407@redhat.com>
	 <1347988800.31966.58.camel@moss-pluto.epoch.ncsc.mil>
	 <20120920163132.GA24398@mail.hallyn.com>
	 <CAPzO=Nw7vE6Q9ncy-vWauQCzTsEBzj75ExREg0j+B-r637+SzA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Wrap Fedora-specific policy with an ifdef.  Alternative would be to fork
a copy of the test policy per distro under policy/<distro>/<release> as
we have already done for redhat 4 and 5.
But I'd prefer to only do that for long-term stable/enterprise releases
that won't be changing very often.

---
 policy/test_global.te | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/policy/test_global.te b/policy/test_global.te
index fdfd291..b92cc1c 100644
--- a/policy/test_global.te
+++ b/policy/test_global.te
@@ -89,4 +89,6 @@ selinux_compute_create_context(testdomain)
 selinux_compute_relabel_context(testdomain)
 selinux_compute_user_contexts(testdomain)
 
+ifdef(`distro_redhat', `
 auth_read_passwd(testdomain)
+')
-- 
1.7.11.4


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
