Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA13919
	for <selinux@tycho.nsa.gov>; Fri, 1 Nov 2002 10:16:11 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA02741
	for <selinux@tycho.nsa.gov>; Fri, 1 Nov 2002 15:14:17 GMT
Received: from csoc-fire1.csoconline.com (csoc-mail-imc.csoconline.com [140.169.2.142])
	by jazzswing.ncsc.mil  with SMTP id PAA02737
	for <selinux@tycho.nsa.gov>; Fri, 1 Nov 2002 15:14:16 GMT
Message-ID: <72222DC86846D411ABD300A0C9EB08A10152444C@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: "'Russell Coker'" <russell@coker.com.au>,
        "Westerman, Mark"
	 <Mark.Westerman@csoconline.com>,
        "'azeredo@qmc.ufsc.br'"
	 <azeredo@qmc.ufsc.br>, selinux@tycho.nsa.gov
Subject: RE: Problems with policy in RH8
Date: Fri, 1 Nov 2002 09:15:36 -0600 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday, November 01, 2002 9:03 AM Russell Coker wrote:

> I don't think that the Postfix policy is related to the  problem reported 
> by Aldrovando.  They report problems aith atd and other 
> programs that will never access files under /var/spool/postfix.


The problem I was talking about is in Red Hat, the files
/var/spool/postfix/lib are hard linked (shareing the same 
inode) to the orginal location. The setfile utilities uses 
the last defination and was relabeling the libs with var_spool_t 
adding the label definations to the postfix.fs fix the problem.
I was having same problem about the libs being labeled var_spool_t
and the previous Information I supplied correctd the problem

Mark

PS: This should be added into the distribution as a patch

file: file_contexts/program/postfix.fc
/var/spool/postfix/flush(/.*)? system_u:object_r:postfix_spool_flush_t
/var/spool/postfix/lib(/.*)?                    system_u:object_r:lib_t
/var/spool/postfix/lib/ld.*\.so.*               system_u:object_r:ld_so_t
/var/spool/postfix/lib/lib.*\.so.*              system_u:object_r:shlib_t
/var/spool/postfix/lib/[^/]*/lib.*\.so.*        system_u:object_r:shlib_t
/var/spool/postfix/lib/devfsd/.*\.so.*  system_u:object_r:shlib_t
/var/spool/postfix/etc/services         system_u:object_r:etc_t

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
