Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j14Ck853006827
	for <selinux@tycho.nsa.gov>; Fri, 4 Feb 2005 07:46:09 -0500 (EST)
Subject: Re: How to install CVS wine
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: ivg2@cornell.edu
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1107499460.29033.7.camel@cobra.ivg2.net>
References: <1107499460.29033.7.camel@cobra.ivg2.net>
Content-Type: text/plain
Message-Id: <1107520773.8078.28.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 04 Feb 2005 07:39:33 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-02-04 at 01:44, Ivan Gyurdiev wrote:
> See, I used to have it under /src, but SElinux didn't like that, and
> kept complaining. I moved it under ~/src and relabeled to user_home_t.
> Now I do cvs update, build it as a regular user, and try to do:
> su -c "make install". However, that doesn't work, because
> the sysadmin can't run user_home_t scripts. Should the sysadmin be able
> to run user_home_t scripts, or am I doing this the wrong way?
> 
> audit(1107498685.995:0): avc:  denied  { execute } for  pid=29007
> exe=/usr/bin/make name=mkinstalldirs dev=dm-2 ino=16332
> scontext=root:sysadm_r:sysadm_t tcontext=root:object_r:user_home_t
> tclass=file
> 
> P.S. tools/wineinstall actually requires that wine be built as a regular
> user, and installed as root.

We'd prefer to avoid having sysadm_t be able to execute anything
potentially untrustworthy.  So I think getting it to work from src_t
would be preferable, but doing your build as staff_t (so that we don't
have to allow arbitrary user_t access).

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
