Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lAN6EhJA022423
	for <selinux@tycho.nsa.gov>; Fri, 23 Nov 2007 01:14:43 -0500
Received: from nz-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id lAN6EgWI004132
	for <selinux@tycho.nsa.gov>; Fri, 23 Nov 2007 06:14:43 GMT
Received: by nz-out-0506.google.com with SMTP id i1so2423362nzh
        for <selinux@tycho.nsa.gov>; Thu, 22 Nov 2007 22:14:42 -0800 (PST)
Message-ID: <f71a82820711222214i46474da1ucd1b402fbbc9d38d@mail.gmail.com>
Date: Fri, 23 Nov 2007 15:14:42 +0900
From: "Shintaro Fujiwara" <shintaro.fujiwara@gmail.com>
To: selinux <selinux@tycho.nsa.gov>
Subject: semodule -i postgresql.pp fails on F8
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I got src package of selinux-policy-3.0.8

#cd serefpolicy-3.0.8/policy/modules/services
#make -f /usr/share/selinux/devel/Makefile postgresql.pp
#semodule -i postgresql.pp

libsepol.scope_copy_callback: postgresql: Duplicate declaration in
module: type/attribute postgresql_var_run_t
libsemanage.semanage_link_sandbox: Link packages failed
semodule:  Failed!


I doubted that in base.pp having postgresql ( it should not have, though)
#semodule -r clamav -b /etc/selinux/targeted/modules/active/base.pp
libsemanage.semanage_direct_remove: Module postgresql was not found.
semodule:  Failed on postgresql!

So, I think something wrong with SELinux policy itself.

Please lead me to the right direction...

I just want to install postgresql policy.


-- 
Shintaro Fujiwara
segatex project (SELinux policy tool)
http://sourceforge.net/projects/segatex/
Home page
http://intrajp.no-ip.com/
Blog
http://intrajp.no-ip.com/nucleus/
CMS
http://intrajp.no-ip.com/xoops/
Wiki
http://intrajp.no-ip.com/pukiwiki/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
