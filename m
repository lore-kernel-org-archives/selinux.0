Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9ABG9Vg010759
	for <selinux@tycho.nsa.gov>; Tue, 10 Oct 2006 07:16:09 -0400
Received: from wx-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9ABFUTb006441
	for <selinux@tycho.nsa.gov>; Tue, 10 Oct 2006 11:15:30 GMT
Received: by wx-out-0506.google.com with SMTP id i26so2028591wxd
        for <selinux@tycho.nsa.gov>; Tue, 10 Oct 2006 04:16:08 -0700 (PDT)
Message-ID: <6a9b0ede0610100416oa82aaf7t79a76ec935dd20ce@mail.gmail.com>
Date: Tue, 10 Oct 2006 16:46:07 +0530
From: "abcde efghi" <svmdcv@gmail.com>
To: selinux@tycho.nsa.gov
Subject: rpm throws error with selinux enabled
Cc: "Stephen Smalley" <sds@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

on rhel4 u3 x86_64 2.6.9-34.ELsmp kernel , when selinux is enabled, rpm
installation gives the error:
'scriptlet failed, exit status 255'

The default selinux settings are used
#cat /etc/sysconfig/selinux
SELINUX=enforcing
SELINUXTYPE=targeted

e.g. on installing asm rpms:
# rpm -ivh *.rpm
 Preparing...                ###########################################
@ [100%]
@    1:oracleasm-support      ###########################################
33%
error: %post(oracleasm-support-2.0.2-1.x86_64) scriptlet failed, exit status
255
    2:oracleasm-2.6.9-34.ELsm###########################################
 67%]
 error: %post(oracleasm-2.6.9-34.ELsmp-2.0.2-1.x86_64) scriptlet failed, exit
 status 255
    3:oracleasmlib           ##########################################
 [100%]
 .
 However, asm rpms gets installed
 # rpm -qa | grep asm
 oracleasm-support-2.0.2-1
 oracleasmlib-2.0.2-1
 oracleasm-2.6.9-34.ELsmp-2.0.2-1

any help most welcome

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
