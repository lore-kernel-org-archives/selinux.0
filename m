Subject: Re: [ SEMANAGE ] More work on policy_components.c
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <4357D211.3090205@cornell.edu>
References: <4356F1B3.3060000@cornell.edu>
	 <1129827334.2375.429.camel@moss-spartans.epoch.ncsc.mil>
	 <4357D211.3090205@cornell.edu>
Content-Type: multipart/mixed; boundary="=-0gGg4vAilExvP4mpFgx5"
Date: Thu, 20 Oct 2005 13:11:27 -0400
Message-Id: <1129828287.2375.435.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-0gGg4vAilExvP4mpFgx5
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2005-10-20 at 13:21 -0400, Ivan Gyurdiev wrote:
> The problem is from earlier patches - you can comment out the init() and 
> release() code in direct_api.c - should eliminate any bugs. I didn't 
> think something as simple would be broken. I'll fix the problem a bit 
> later today...

I think that this may help...

-- 
Stephen Smalley
National Security Agency

--=-0gGg4vAilExvP4mpFgx5
Content-Disposition: attachment; filename=libsemanage-fix.patch
Content-Type: text/x-patch; name=libsemanage-fix.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

Index: libsemanage/src/direct_api.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsemanage/src/direct_api.c,v
retrieving revision 1.15
diff -u -p -r1.15 direct_api.c
--- libsemanage/src/direct_api.c	20 Oct 2005 14:18:42 -0000	1.15
+++ libsemanage/src/direct_api.c	20 Oct 2005 17:01:40 -0000
@@ -153,7 +153,7 @@ static int semanage_direct_disconnect(se
 	user_policydb_dbase_release(sh, semanage_user_dbase_policy(sh));
 	port_policydb_dbase_release(sh, semanage_port_dbase_policy(sh));
 	iface_policydb_dbase_release(sh, semanage_iface_dbase_policy(sh));
-	bool_policydb_dbase_release(sh, semanage_port_dbase_policy(sh));
+	bool_policydb_dbase_release(sh, semanage_bool_dbase_policy(sh));
 
 	return 0;
 }

--=-0gGg4vAilExvP4mpFgx5--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
