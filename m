Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id DAA03473
	for <selinux@tycho.nsa.gov>; Mon, 16 Apr 2001 03:44:24 -0400 (EDT)
From: gawain.lynch@felicity-consulting.com.au
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id HAA12423
	for <selinux@tycho.nsa.gov>; Mon, 16 Apr 2001 07:43:56 GMT
Received: from mel-relay-dmz-01.felicity.net.au ([203.33.108.4])
	by jazzswing.ncsc.mil  with ESMTP id HAA12419
	for <selinux@tycho.nsa.gov>; Mon, 16 Apr 2001 07:43:51 GMT
Received: from oneone00.felicity.net.au (IDENT:notes@oneone00.felicity.net.au [203.33.109.69])
	by mel-relay-dmz-01.felicity.net.au (8.11.0/8.11.0) with ESMTP id f3FKiGo02543
	for <selinux@tycho.nsa.gov>; Mon, 16 Apr 2001 06:44:18 +1000
To: selinux@tycho.nsa.gov
Subject: Policy configuration errors
MIME-Version: 1.0
Message-ID: <OF482CDDC7.7FD39A91-ONCA256A30.00238056@felicity.net.au>
Date: Mon, 16 Apr 2001 16:37:14 +1000
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I am building an SRPM which is now fully functional, bar the following 
error received during ``make initpolicy'' 

        error in the statement ending on line 1054 (token ';'): unknown 
class filesystem used in rule
 
        ../kernel/security/checkpolicy:  error(s) encountered while 
parsing configuration
        make: *** [initpolicy] Error 1

        ...

        $ rgrep filesystem policy/

        %{errlog}:error in the statement ending on line 1054 (token ';'): 
unknown class filesystem used in rule
        access_vectors:class filesystem
        domains/every.te:allow domain fs_type:filesystem getattr;
        init.te:allow initial_boot_t fs_type:filesystem *;
        macros.te:allow $1_devpts_t devpts_t:filesystem associate;
        mls:class filesystem
        security_classes:class filesystem
        types/file.te:allow file_type fs_t:filesystem associate;
        types/nfs.te:allow nfs_t nfs_t:filesystem associate;
        types/nfs.te:allow nfs_clipper_t nfs_clipper_t:filesystem 
associate;

Can someone please point me in some sort of direction as I am very close 
to finishing and this is just plain annoying.

Thanks,

Gawain

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
