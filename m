Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1KEmRdW013801
	for <selinux@tycho.nsa.gov>; Sun, 20 Feb 2005 09:48:28 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1KEiBli020109
	for <selinux@tycho.nsa.gov>; Sun, 20 Feb 2005 14:44:11 GMT
Subject: Mozilla vs ORBit tmp files
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: selinux@tycho.nsa.gov
Cc: dwalsh@redhat.com
Content-Type: text/plain
Date: Sun, 20 Feb 2005 09:48:57 -0500
Message-Id: <1108910937.3610.22.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

Mozilla was recently changed in the Fedora policy
to prevent writing to user_tmp_t. However that introduced
the following regression:

audit(1108909606.145:0): avc:  denied  { write } for  pid=3830
exe=/usr/lib/firefox-1.0/firefox-bin name=linc-fd0-0-5891c0341b10d
dev=dm-0 ino=827446 scontext=user_u:user_r:user_mozilla_t
tcontext=user_u:object_r:user_tmp_t tclass=sock_file

Should it be changed back? 

The original suggestion was to transition mozilla to user_mozilla_tmp_t,
but file_auto_trans() only works for creating new files, while here
mozilla is using existing sockets in /tmp/orbit-username.  

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
