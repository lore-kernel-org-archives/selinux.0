Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h7ACO7Ha011448
	for <selinux@tycho.nsa.gov>; Sun, 10 Aug 2003 08:24:07 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h7ACMnOD018013
	for <selinux@tycho.nsa.gov>; Sun, 10 Aug 2003 12:22:49 GMT
Received: from blackbird.intercode.com.au (blackbird.intercode.com.au [203.32.101.10])
	by jazzswing.ncsc.mil  with ESMTP id h7ACMkKO018010
	for <selinux@tycho.nsa.gov>; Sun, 10 Aug 2003 12:22:48 GMT
Date: Sun, 10 Aug 2003 22:23:47 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Diyab <diyab@diyab.net>
cc: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: execute_no_trans
In-Reply-To: <3F34314D.90806@diyab.net>
Message-ID: <Mutt.LNX.4.44.0308102217200.7105-100000@excalibur.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 8 Aug 2003, Diyab wrote:

> Can anyone tell me what the execute_no_trans permission does.  I have 
> run across it used in both policy files and the access_vectors file and 
> although I see it is part of the kernel I do not find anything that 
> explains exactly what it does.

See the following:
http://www.nsa.gov/selinux/doc/module/x103.html#EXEC_PERMS_CHANGES
http://www.nsa.gov/selinux/doc/module/x693.html#BPRM_SET_SECURITY


- James
-- 
James Morris
<jmorris@intercode.com.au>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
