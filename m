Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j14CsW53006902
	for <selinux@tycho.nsa.gov>; Fri, 4 Feb 2005 07:54:32 -0500 (EST)
Subject: Re: How to install CVS wine
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: ivg2@cornell.edu
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1107520773.8078.28.camel@moss-spartans.epoch.ncsc.mil>
References: <1107499460.29033.7.camel@cobra.ivg2.net>
	 <1107520773.8078.28.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Message-Id: <1107521277.8078.32.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 04 Feb 2005 07:47:57 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-02-04 at 07:39, Stephen Smalley wrote:
> We'd prefer to avoid having sysadm_t be able to execute anything
> potentially untrustworthy.  So I think getting it to work from src_t
> would be preferable, but doing your build as staff_t (so that we don't
> have to allow arbitrary user_t access).

Other alternative would be to get it to work in a home directory labeled
staff_home_dir_t/staff_home_t.  If you define a separate user entry for
all users authorized for sysadm_r, and authorize them for staff_r
sysadm_r, then this should be generated in file_contexts automatically
upon building the policy.  At that point, you can disable
user_canbe_sysadm in your tunables.  That is the preferred security
setup; then only users authorized for staff_r can reach sysadm_r.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
