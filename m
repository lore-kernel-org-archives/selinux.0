Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h37LjiI4018438
	for <selinux@tycho.nsa.gov>; Mon, 7 Apr 2003 17:45:44 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h37LjXxH025969
	for <selinux@tycho.nsa.gov>; Mon, 7 Apr 2003 21:45:33 GMT
Received: from mx.nas-smoothtransition.com (nas-vm-156.nas-smoothtransition.com [66.95.157.156] (may be forged))
        by jazzband.ncsc.mil  with ESMTP id h37LjWDl025886 for <selinux@tycho.nsa.gov>; Mon, 7 Apr 2003 21:45:32 GMT
From: "david caplan" <dac@tresys.com>
To: "Russell Coker" <russell@coker.com.au>, <selinux@tycho.nsa.gov>
Subject: RE: usermod/group* patch
Date: Mon, 7 Apr 2003 17:45:16 -0400
Message-ID: <GBEAJBKHFOBIBBJBCGAGMEJCCLAA.dac@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <200303301127.05440.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

In trying out the new policy I rn across a problem with userdel (which uses
the useradd.te policy).  I got a denied { rmdir } on a user's home directory
when I tried to remove the account.

I'm not sure when this was changed, but the useradd_t user_home_dir_t
directory line went from:

file_type_auto_trans(useradd_t, home_root_t, user_home_dir_t)

to

file_type_auto_trans(useradd_t, home_root_t, user_home_dir_t, dir)

Specifying the 'dir' results in useradd_t not getting rmdir permission
(necessary for userdel when removing the account's home directory).  This is
because file_type_auto_trans (actually its subcall to file_type_trans) only
gives create_file_perms when a fourth argument is given.  When a fourth
argument is not specified file_type_trans produces two relevant rules, one
of which grants the target type (arg 3) of class dir, create_dir_perms.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
