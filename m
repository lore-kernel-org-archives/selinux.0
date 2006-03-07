Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k271vqgP017325
	for <selinux@tycho.nsa.gov>; Mon, 6 Mar 2006 20:57:52 -0500
Received: from authusersmtp.mail.cornell.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k271vouY023268
	for <selinux@tycho.nsa.gov>; Tue, 7 Mar 2006 01:57:50 GMT
Message-ID: <440CE892.2060601@cornell.edu>
Date: Mon, 06 Mar 2006 20:57:38 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: "Serge E. Hallyn" <serue@us.ibm.com>
CC: SELinux <selinux@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>
Subject: Re: libsepol/src/link.c:copy_avrule_list( )
References: <20060306214139.GA7960@sergelap.austin.ibm.com>
In-Reply-To: <20060306214139.GA7960@sergelap.austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

That reminds me...
This is a bug I sent to Joshua.

==10331== Invalid read of size 4
==10331==    at 0x4B3D12C: copy_avrule_list (link.c:876)
==10331==    by 0x4B3E061: copy_avrule_decl (link.c:1173)
==10331==    by 0x4B3E356: copy_avrule_block (link.c:1220)
==10331==    by 0x4B3E8FE: copy_module (link.c:1345)
==10331==    by 0x4B4073C: link_modules (link.c:1977)
==10331==    by 0x4B42F8D: sepol_link_packages (module.c:242)
==10331==    by 0x4C91D21: semanage_link_sandbox (in 
/lib64/libsemanage.so.1)
==10331==    by 0x4C86BC1: semanage_direct_commit (in 
/lib64/libsemanage.so.1)
==10331==    by 0x4C893A9: semanage_commit (in /lib64/libsemanage.so.1)
==10331==    by 0x401ACB: (within /usr/sbin/semodule)
==10331==    by 0x4DBE023: __libc_start_main (in /lib64/libc-2.3.90.so)
==10331==  Address 0xEC11728 is 0 bytes after a block of size 8 alloc'd
==10331==    at 0x4A1DA18: calloc (vg_replace_malloc.c:279)
==10331==    by 0x4B3A8D7: permission_copy_callback (link.c:157)
==10331==    by 0x4B37FAA: hashtab_map (hashtab.c:236)
==10331==    by 0x4B3AB96: class_copy_callback (link.c:189)
==10331==    by 0x4B37FAA: hashtab_map (hashtab.c:236)
==10331==    by 0x4B3D9C8: copy_identifiers (link.c:1057)
==10331==    by 0x4B3DC79: copy_module_identifiers (link.c:1102)
==10331==    by 0x4B3E84E: copy_module (link.c:1332)
==10331==    by 0x4B4073C: link_modules (link.c:1977)
==10331==    by 0x4B42F8D: sepol_link_packages (module.c:242)
==10331==    by 0x4C91D21: semanage_link_sandbox (in 
/lib64/libsemanage.so.1)
==10331==    by 0x4C86BC1: semanage_direct_commit (in 
/lib64/libsemanage.so.1)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
