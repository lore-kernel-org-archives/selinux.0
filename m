Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id WAA21017
	for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 22:06:54 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id CAA16665
	for <selinux@tycho.nsa.gov>; Fri, 12 Jul 2002 02:05:25 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id CAA16661 for <selinux@tycho.nsa.gov>; Fri, 12 Jul 2002 02:05:23 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 2865692462
	for <selinux@tycho.nsa.gov>; Fri, 12 Jul 2002 12:06:50 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id D58E442F2
	for <selinux@tycho.nsa.gov>; Fri, 12 Jul 2002 04:06:42 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: revising the su decision
Date: Fri, 12 Jul 2002 04:06:42 +0200
MIME-Version: 1.0
Message-Id: <20020712020642.D58E442F2@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Up until now the su program was not modified, so changing to a different UID 
was a separate and independant operation from changing domain via newrole.

However now that the sshd policy has been set to default to not allow logins 
as sysadm_r:sysadm_t this causes some inconveniance.  I have to ssh in to my 
server as a non-root account with a non-sysadm_r context.  Then I have to use 
newrole to change to sysadm_r (entering the password), and then I have to su 
to the root account (entering the root password).

This requires entering the password two times (or three if not using ssh 
authorized_keys).

This is excessively painful, and I think that to make SE Linux more usable we 
need to address this issue, possibly by changing su to allow it to change 
roles too.

What do you think?

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
