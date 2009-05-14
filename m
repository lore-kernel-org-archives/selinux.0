Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n4EGp5on019176
	for <selinux@tycho.nsa.gov>; Thu, 14 May 2009 12:51:05 -0400
Received: from yx-out-1718.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n4EGp2Ve020017
	for <selinux@tycho.nsa.gov>; Thu, 14 May 2009 16:51:03 GMT
Received: by yx-out-1718.google.com with SMTP id 34so752795yxf.84
        for <selinux@tycho.nsa.gov>; Thu, 14 May 2009 09:51:04 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 14 May 2009 09:51:04 -0700
Message-ID: <dd18b0c30905140951x72877a78g67ad0a893b210278@mail.gmail.com>
Subject: make: *** No rule to make target with latest svn
From: Justin Mattock <justinmattock@gmail.com>
To: tresys <refpolicy@oss1.tresys.com>, SE-Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've seen this with earlier versions of refpolicy(when making mcs)

Validating mcs  file_contexts.
/sbin/setfiles -q -c /etc/selinux/mcs/policy/policy.22 file_contexts
Installing file_contexts.
install -m 644 file_contexts /etc/selinux/mcs/contexts/files/file_contexts
install -m 644 homedir_template /etc/selinux/mcs/contexts/files/homedir_template
python -E support/genhomedircon -d /etc/selinux -t mcs
The user "staff_u" is not present in the passwd file, skipping...
The user "sysadm_u" is not present in the passwd file, skipping...
The user "unconfined_u" is not present in the passwd file, skipping...
make: *** No rule to make target
`/etc/selinux/mcs/contexts/default_contexts', needed by `install'.
Stop.

when making the policy
I have the policy in my home directory
usually do a chown -R name:name refpolicy
(before building)
then:
make conf
make policy
sudo make install

do I need to build this thing always as root?

-- 
Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
