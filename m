Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA00562
	for <selinux@tycho.nsa.gov>; Wed, 17 Apr 2002 13:22:47 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id RAA22417
	for <selinux@tycho.nsa.gov>; Wed, 17 Apr 2002 17:21:36 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id RAA22412 for <selinux@tycho.nsa.gov>; Wed, 17 Apr 2002 17:21:33 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 60A8E92457
	for <selinux@tycho.nsa.gov>; Thu, 18 Apr 2002 03:22:28 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 1500922C7
	for <selinux@tycho.nsa.gov>; Wed, 17 Apr 2002 19:22:02 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: what's wrong this this rule?
Date: Wed, 17 Apr 2002 19:22:01 +0200
MIME-Version: 1.0
Message-Id: <20020417172203.1500922C7@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

allow setfiles_t file_type:dir_file_class_set { getattr relabelfrom relabelto 
};

Above is the rule, below is a sample of the error I get when running setfiles 
with it.

avc:  denied  { relabelto } for  pid=6893 exe=/usr/sbin/setfiles 
path=/etc/security/selinux/policy.9 dev=03:02 ino=1281 
scontext=rjc:sysadm_r:setfiles_t tcontext=system_u:object_r:policy_config_t 
tclass=file

The reason I'm doing this is that I've got some code running as initrc_t that 
needs to run setfiles, and I don't want to give initrc_t such total write 
access.

The code in question hopefully won't be running in initrc_t for much longer, 
but then I'll have the same issue but with a different source domain.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
