Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i523G2rT000701
	for <selinux@tycho.nsa.gov>; Tue, 1 Jun 2004 23:16:02 -0400 (EDT)
Received: from smtp801.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i52BAXbn009463
	for <selinux@tycho.nsa.gov>; Wed, 2 Jun 2004 07:10:34 -0400 (EDT)
Date: Tue, 1 Jun 2004 11:13:21 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>, Russell Coker <russell@coker.com.au>
Subject: /var/tmp/kdecache-username
Message-ID: <20040601111321.GG8312@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

whoops, one for the forgotten-about list on rm -fr /tmp/*

sez:/etc/selinux/file_contexts# ls -altr --context /var/tmp/
drwxr-xr-x  root     root     system_u:object_r:var_t          ..
drwxrwxrwt  root     root     system_u:object_r:tmp_t
vi.recover
drwxrwxrwt  root     root     system_u:object_r:tmp_t          .
drwx------  lkcl     lkcl     root:object_r:sysadm_tmp_t
kdecache-lkcl
drwx------  root     root     root:object_r:sysadm_tmp_t
kdecache-root

i had done a make relabel and then couldn't run any kde programs!

l.

-- 
-- 
expecting email to be received and understood is a bit like
picking up the telephone and immediately dialing without
checking for a dial-tone; speaking immediately without listening
for either an answer or ring-tone; hanging up immediately and
believing that you have actually started a conversation.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
