Subject: RE: [Clip] Unexpected role change from custom role back to user_r
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "West, Gary-P55389" <Gary.West@gdc4s.com>
Cc: Brian Williams <brian@bri3001.com>, clip@oss1.tresys.com,
        selinux@tycho.nsa.gov
In-Reply-To: <FA8938DBA959E546BF6527F085F22FF804C16C93@AZ25EXM04.gddsi.com>
References: <FA8938DBA959E546BF6527F085F22FF804C16BB4@AZ25EXM04.gddsi.com>
	 <1243446033.2752.19.camel@localhost.localdomain>
	 <000901c9deff$a7c08a90$f7419fb0$@com>
	 <FA8938DBA959E546BF6527F085F22FF804C16C93@AZ25EXM04.gddsi.com>
Content-Type: text/plain
Date: Wed, 27 May 2009 15:47:25 -0400
Message-Id: <1243453645.2752.33.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-05-27 at 12:44 -0700, West, Gary-P55389 wrote:
> System is mls
> System is currently in permissive mode
> Policy is modular but all modules are in the base policy
> 
> Files changed with custom role:
> 
> src/config/appconfig-mls/default_type --------------------
> app_pso_r:app_pso_t
> 
> src/config/appconfig-mls/default_contexts ----------------
> system_r:xdm_t:s0	user_r:user_t:s0 staff_r:staff_t:s0
> sysadm_r:sysadm_t:s0 unconfined_r:unconfined_t:s0 app_pso_r:app_pso_t:s0

Doesn't this cause you to still default to user_r (if the user is
authorized for both user_r and app_pso_r), since user_r is listed first?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
