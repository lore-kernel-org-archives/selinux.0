Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n3KIsi5D006081
	for <selinux@tycho.nsa.gov>; Mon, 20 Apr 2009 14:54:44 -0400
Received: from mailhub4.stratus.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n3KIsdHk025038
	for <selinux@tycho.nsa.gov>; Mon, 20 Apr 2009 18:54:43 GMT
Received: from [134.111.199.110] (BSD.mno.stratus.com [134.111.199.110])
	by mailhub4.stratus.com (8.12.11/8.12.11) with ESMTP id n3KIsYa2001827
	for <selinux@tycho.nsa.gov>; Mon, 20 Apr 2009 14:54:34 -0400
Subject: genhomedircon errors with NIS
From: Bandan Das <bandan.das@stratus.com>
To: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Mon, 20 Apr 2009 14:54:03 -0400
Message-Id: <1240253643.7743.78.camel@BSD.mno.stratus.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

This is a RHEL 5.3 system with SELinux configured in the targeted mode.
Whenever genhomedircon is invoked, either as part of loading a new
policy module or anything else, genhomedircon will report errors going
through the NIS database :

bdas homedir /h/bdas or its parent directory conflicts with a
defined context in /etc/selinux/targeted/contexts/files/file_contexts,
/usr/sbin/genhomedircon will not create a new context. This usually
indicates an incorrectly defined system account.  If it is a system
account please make sure its login shell is /sbin/nologin.

/h is where the NIS home directory is automounted and the above message
appears for all the NIS users.

As expected, running genhomedircon manually with the "-n" switch will
not spew these messages. If I look at file_contexts, I do not find any
specified context for /h.


Any ideas ?

 

-- 
BSD


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
