Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q1C08ZRt027481
	for <selinux@tycho.nsa.gov>; Sat, 11 Feb 2012 19:08:35 -0500
Received: from fallback-in2.mxes.net (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id q1C08Y7g024999
	for <selinux@tycho.nsa.gov>; Sun, 12 Feb 2012 00:08:35 GMT
Received: from mxout-08.mxes.net (mxout-08.mxes.net [216.86.168.183])
	by fallback-in1.mxes.net (Postfix) with ESMTP id E5F532FD7AF
	for <selinux@tycho.nsa.gov>; Sat, 11 Feb 2012 18:52:34 -0500 (EST)
Received: from wm1.irbs.net (wm1.irbs.net [216.86.168.168])
	by smtp.mxes.net (Postfix) with ESMTP id D975A50A65
	for <selinux@tycho.nsa.gov>; Sat, 11 Feb 2012 18:52:15 -0500 (EST)
Received: from localhost (wm1.irbs.net [216.86.168.168])
	by wm1.irbs.net (Postfix) with ESMTPA id A62D44FE326
	for <selinux@tycho.nsa.gov>; Sat, 11 Feb 2012 18:52:15 -0500 (EST)
Message-ID: <20120211235215.13243ztx045c14w0@webmail.tuffmail.net>
Date: Sat, 11 Feb 2012 23:52:15 +0000
From: Martin Orr <martin@martinorr.name>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: role_fix_callback assertion with sysadm in base
References: <20120209225847.969915sba4w431r4@webmail.tuffmail.net>
In-Reply-To: <20120209225847.969915sba4w431r4@webmail.tuffmail.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=UTF-8;
	DelSp="Yes";
	format="flowed"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu  9 Feb 22:58:47 2012, Martin Orr wrote:
> I tried to build latest git refpolicy (6da98efd) using latest   
> checkpolicy and libsepol (339f8079) with the attached modules.conf.   
>  In particular this puts sysadm into base.pp, and minimal other  
> things.   I get the following error.

It turns out that this is not just an issue with base vs modules.  If  
I build refpolicy with the default modules.conf and try to install the  
same set of modules as I built into base previously, then semodule  
fails with the same error, whether I use TYPE = standard or mcs.

$ sudo semodule $(sudo semodule -l | awk '{ print "-r "$1 }') -b  
base.pp -i storage.pp sysadm.pp application.pp authlogin.pp init.pp  
libraries.pp locallogin.pp logging.pp miscfiles.pp modutils.pp  
selinuxutil.pp sysnetwork.pp userdomain.pp
semodule: expand.c:700: role_fix_callback: Assertion `new_role !=  
((void *)0) && new_role->flavor == 1' failed.

It works if I add enough modules that all role attributes "require"d  
by optional blocks are present, i.e. the following command, provided I  
am using an mcs policy.  It seg faults if using a standard policy.

$ sudo semodule $(sudo semodule -l | awk '{ print "-r "$1 }') -b  
base.pp -i storage.pp sysadm.pp application.pp authlogin.pp init.pp  
libraries.pp locallogin.pp logging.pp miscfiles.pp modutils.pp  
selinuxutil.pp sysnetwork.pp userdomain.pp portage.pp rsync.pp  
consoletype.pp usermanage.pp usernetctl.pp bootloader.pp dpkg.pp  
iptables.pp modutils.pp mount.pp rpm.pp sysnetwork.pp vpn.pp ppp.pp

It appears that requiring role attributes does not work correctly.   
The seg fault with a non-mcs policy may be an independent problem.

-- 
Martin Orr



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
