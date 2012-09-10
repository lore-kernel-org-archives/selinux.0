Message-ID: <1347280786.2480.3.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: Assertion `new_role != ((void *)0) && new_role->flavor == 1'
 when installing modules
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Laurent Bigonville <bigon@debian.org>
Cc: SE-Linux <selinux@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>,
        "Christopher J. PeBenito"
	 <cpebenito@tresys.com>
Date: Mon, 10 Sep 2012 08:39:46 -0400
In-Reply-To: <20120909191000.74e83c73@fornost.bigon.be>
References: <20120909191000.74e83c73@fornost.bigon.be>
Content-Type: multipart/mixed; boundary="=-0tsAamd7Y0xMfalivXL2"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-0tsAamd7Y0xMfalivXL2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sun, 2012-09-09 at 19:10 +0200, Laurent Bigonville wrote:
> Hi,
> 
> When compiling the GIT HEAD of the refpolicy and then trying to install
> the base module with the required dependencies (semodule -b base.pp
> -i ...) , I get the following assertion:
> 
> Assertion `new_role != ((void *)0) && new_role->flavor == 1'
> 
> I've found a previous discussion[0] on the mailing list from some months
> ago but unfortunately without any solution.
> 
> Does anybody have an idea?
> 
> Cheers
> 
> Laurent Bigonville
> 
> [0] http://www.spinics.net/lists/selinux/msg11809.html

Does this patch fix it?

-- 
Stephen Smalley
National Security Agency

--=-0tsAamd7Y0xMfalivXL2
Content-Type: application/mbox;
	name*0="[v1_PATCH_1_1]_role_fix_callback_skips_out-of-scope_roles_during_";
	name*1="expansion..mbox"
Content-Disposition: attachment;
	filename*0="[v1_PATCH_1_1]_role_fix_callback_skips_out-of-scope_roles_dur";
	filename*1="ing_expansion..mbox"
Content-Transfer-Encoding: 7bit

From: Harry Ciao <qingtao.cao@windriver.com>
To: <selinux@tycho.nsa.gov>
Subject: [v1 PATCH 1/1] role_fix_callback skips out-of-scope roles during
 expansion.
Date: Sat, 25 Feb 2012 09:40:08 +0800
Message-ID: <1330134008-3259-1-git-send-email-qingtao.cao@windriver.com>
X-Mailer: git-send-email 1.7.0.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-selinux@tycho.nsa.gov
Precedence: bulk
X-Mailing-List: selinux-tycho.nsa.gov
Content-Transfer-Encoding: 8bit

If a role identifier is out of scope it would be skipped over during
expansion, accordingly, be it a role attribute, it should be skipped
over as well when role_fix_callback tries to propagate its capability
to all its sub-roles.

Signed-off-by: Harry Ciao <qingtao.cao@windriver.com>
---
 libsepol/src/expand.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index 493e478..befb720 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -688,6 +688,11 @@ static int role_fix_callback(hashtab_key_t key, hashtab_datum_t datum,
 		return 0;
 	}
 
+	if (!is_id_enabled(id, state->base, SYM_ROLES)) {
+		/* identifier's scope is not enabled */
+		return 0;
+	}
+
 	if (role->flavor != ROLE_ATTRIB)
 		return 0;
 
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.


--=-0tsAamd7Y0xMfalivXL2--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
