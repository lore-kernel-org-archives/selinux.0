Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9HDWIWt009135
	for <selinux@tycho.nsa.gov>; Fri, 17 Oct 2003 09:32:18 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9HDW80p008305
	for <selinux@tycho.nsa.gov>; Fri, 17 Oct 2003 13:32:08 GMT
Received: from Cantor.suse.de (ns.suse.de [195.135.220.2])
	by jazzswing.ncsc.mil  with ESMTP id h9HDW7r7008291
	for <selinux@tycho.nsa.gov>; Fri, 17 Oct 2003 13:32:08 GMT
Received: from Hermes.suse.de (Hermes.suse.de [195.135.221.8])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by Cantor.suse.de (Postfix) with ESMTP id 37B5116F19C9
	for <selinux@tycho.nsa.gov>; Fri, 17 Oct 2003 15:32:09 +0200 (CEST)
Date: Fri, 17 Oct 2003 15:32:07 +0200
From: Thorsten Kukuk <kukuk@suse.de>
To: selinux@tycho.nsa.gov
Subject: Symlinks with wrong context after copy
Message-ID: <20031017133207.GA5665@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Hi,

I don't know if this is a libattr or a selinux bug:

Symlinks have wrong attributes after copying:

dilbert:~ # ls --context /lib/ld-*
-rwxr-xr-x  root     root     system_u:object_r:ld_so_t        /lib/ld-2.3.2.so
lrwxrwxrwx  root     root     system_u:object_r:ld_so_t        /lib/ld-linux.so.2 -> ld-2.3.2.so

dilbert:~ # cp -dp /lib/ld-* .
dilbert:~ # ls --context ld-*
-rwxr-xr-x  root     root     system_u:object_r:ld_so_t        ld-2.3.2.so
lrwxrwxrwx  root     root     system_u:object_r:sysadm_home_dir_t ld-linux.so.2 -> ld-2.3.2.so

any ideas what goes wrong?

  Thorsten

-- 
Thorsten Kukuk       http://www.suse.de/~kukuk/        kukuk@suse.de
SuSE Linux AG        Deutschherrnstr. 15-19        D-90429 Nuernberg
--------------------------------------------------------------------    
Key fingerprint = A368 676B 5E1B 3E46 CFCE  2D97 F8FD 4E23 56C6 FB4B

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
