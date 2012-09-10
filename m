Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q8ANE9mG007228
	for <selinux@tycho.nsa.gov>; Mon, 10 Sep 2012 19:14:10 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by anor.bigon.be (Postfix) with ESMTP id 20E2C1A056
	for <selinux@tycho.nsa.gov>; Tue, 11 Sep 2012 01:14:04 +0200 (CEST)
Received: from anor.bigon.be ([127.0.0.1])
	by localhost (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2q1yQyTlATAY for <selinux@tycho.nsa.gov>;
	Tue, 11 Sep 2012 01:14:02 +0200 (CEST)
Received: from eldamar.bigon.be (unknown [IPv6:2a02:578:8500:2601:5a94:6bff:fe3f:6930])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(Client did not present a certificate)
	(Authenticated sender: bigon)
	by anor.bigon.be (Postfix) with ESMTPSA id B61611A025
	for <selinux@tycho.nsa.gov>; Tue, 11 Sep 2012 01:14:02 +0200 (CEST)
Date: Tue, 11 Sep 2012 01:13:49 +0200
From: Laurent Bigonville <bigon@debian.org>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: Assertion `new_role != ((void *)0) && new_role->flavor == 1'
 when installing modules
Message-ID: <20120911011349.0ecc2f99@eldamar.bigon.be>
In-Reply-To: <1347280786.2480.3.camel@moss-pluto.epoch.ncsc.mil>
References: <20120909191000.74e83c73@fornost.bigon.be>
	<1347280786.2480.3.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Le Mon, 10 Sep 2012 08:39:46 -0400,
Stephen Smalley <sds@tycho.nsa.gov> a écrit :

> Does this patch fix it?

It's now unfortunately crashing with the following trace :(

#0  __strlen_sse42 () at ../sysdeps/x86_64/multiarch/strlen-sse4.S:32
#1  0x00007f30554c20b1 in ustr_replace_cstr (s1=0x7fff6721a668, oc=0x7f3055ea4ef9 "s0", nc=0x0, lim=0) at ustr-replace.h:58
#2  0x00007f3055e8d398 in replace_all (str=0x7f3057796860 "HOME_DIR/.+\tsystem_u:object_r:user_home_t", repl=0x7fff6721a6c0) at genhomedircon.c:513
#3  0x00007f3055e8d644 in write_home_dir_context (s=0x7fff6721a7d0, out=0x7f305779d9a0, tpl=0x7f305779c260, user=0x7f3057081660 "user_u", seuser=0x7f3057081660 "user_u", home=0x7f3057791ef3 "/home/[^/]*", role_prefix=0x7f3057081640 "user", level=0x0) at genhomedircon.c:580
#4  0x00007f3055e8e6d2 in write_context_file (s=0x7fff6721a7d0, out=0x7f305779d9a0) at genhomedircon.c:1012
#5  0x00007f3055e8e977 in semanage_genhomedircon (sh=0x7f30570015b0, policydb=0x7f30576fcbd0, usepasswd=1, ignoredirs=0x0) at genhomedircon.c:1090
#6  0x00007f3055e8993e in semanage_direct_commit (sh=0x7f30570015b0) at direct_api.c:994
#7  0x00007f3055e8f7bc in semanage_commit (sh=0x7f30570015b0) at handle.c:435
#8  0x00007f305674c921 in main (argc=21, argv=0x7fff6721aac8) at semodule.c:479

I get this with the userspace version of Debian sid (and libsepol
patched) and the following command:

semodule -v -b base.pp -s refpolicy -n -i init.pp libraries.pp
logging.pp selinuxutil.pp modutils.pp storage.pp userdomain.pp
miscfiles.pp sysadm.pp authlogin.pp sysnetwork.pp application.pp
locallogin.pp

Cheers

Laurent Bigonville


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
