Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j14Fb153008016
	for <selinux@tycho.nsa.gov>; Fri, 4 Feb 2005 10:37:01 -0500 (EST)
Subject: Re: How to install CVS wine
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1107521277.8078.32.camel@moss-spartans.epoch.ncsc.mil>
References: <1107499460.29033.7.camel@cobra.ivg2.net>
	 <1107520773.8078.28.camel@moss-spartans.epoch.ncsc.mil>
	 <1107521277.8078.32.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 04 Feb 2005 10:36:47 -0500
Message-Id: <1107531407.31488.4.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-02-04 at 07:47 -0500, Stephen Smalley wrote:
> On Fri, 2005-02-04 at 07:39, Stephen Smalley wrote:
> > We'd prefer to avoid having sysadm_t be able to execute anything
> > potentially untrustworthy.  So I think getting it to work from src_t
> > would be preferable, but doing your build as staff_t (so that we don't
> > have to allow arbitrary user_t access).
> 
> Other alternative would be to get it to work in a home directory labeled
> staff_home_dir_t/staff_home_t.  If you define a separate user entry for
> all users authorized for sysadm_r, and authorize them for staff_r
> sysadm_r, then this should be generated in file_contexts automatically
> upon building the policy.  At that point, you can disable
> user_canbe_sysadm in your tunables.  That is the preferred security
> setup; then only users authorized for staff_r can reach sysadm_r.

I haven't done anything with roles so far, but I will investigate :)
Speaking of roles, is the jadmin user in local.users supposed to be 
uncommented? It's been that way for a while.

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
