Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id TAA02499
	for <selinux@tycho.nsa.gov>; Mon, 12 Aug 2002 19:02:25 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id XAA02198
	for <selinux@tycho.nsa.gov>; Mon, 12 Aug 2002 23:01:26 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id XAA02194
	for <selinux@tycho.nsa.gov>; Mon, 12 Aug 2002 23:01:25 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 15C559246C
	for <selinux@tycho.nsa.gov>; Tue, 13 Aug 2002 09:02:22 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 7CAF68734
	for <selinux@tycho.nsa.gov>; Tue, 13 Aug 2002 01:02:09 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: sendmail policy
Date: Tue, 13 Aug 2002 01:02:09 +0200
MIME-Version: 1.0
Message-Id: <20020812230209.7CAF68734@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>From sendmail.te:
# When sendmail runs as user_mail_domain, it needs some extra permissions.
allow user_mail_domain etc_mail_t:file rw_file_perms;

>From sendmail.fc:
/etc/mail(|/.*)                 system_u:object_r:etc_mail_t

Does sendmail REALLY need to write files in /etc/mail on behalf of the user?

Maybe we should make our sendmail policy be "install postfix or qmail 
instead"? :-#

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
