Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id GAA01419
	for <selinux@tycho.nsa.gov>; Thu, 8 Aug 2002 06:41:55 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id KAA20831
	for <selinux@tycho.nsa.gov>; Thu, 8 Aug 2002 10:40:19 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id KAA20827 for <selinux@tycho.nsa.gov>; Thu, 8 Aug 2002 10:40:13 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 18A4E92469
	for <selinux@tycho.nsa.gov>; Thu,  8 Aug 2002 20:41:46 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 23C2F2FE8
	for <selinux@tycho.nsa.gov>; Thu,  8 Aug 2002 12:41:38 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: new policy
Date: Thu, 8 Aug 2002 12:41:37 +0200
MIME-Version: 1.0
Message-Id: <20020808104138.23C2F2FE8@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I am developing a new policy for chroot environments.  It consists of two 
domains, $2_super_t and $2_t.

$2_super_t is used for administration and can write to all files and 
directories in the chroot.

$2_t is used for all programs that are not involved in installation of new 
software.  $2_t can write to $2_rw_t type files and directories but can only 
read from $2_ro_t files and directories.

There is a domain_auto_trans rule specifying that when $2_super_t executes 
$2_rw_t files then it transitions to $2_t.

This policy is to achieve the following aims:
Not being excessively complex and allowing the user to do all the things that 
they reasonably need to do without my involvement.

Supporting moderate numbers of chroot environments without blowing out the 
policy database size too much.

Being simple enough that a typical Unix admin can understand it after reading 
a 2-3 page document.


This is going to be a part of my paper for Linux Kongress which is due in 4 
days, so if you have any comments or suggestions then I would appreciate them 
quickly...

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
