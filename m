Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1SIELRb019207
	for <selinux@tycho.nsa.gov>; Sat, 28 Feb 2004 13:14:21 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i1SICilK026846
	for <selinux@tycho.nsa.gov>; Sat, 28 Feb 2004 18:12:44 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
	by jazzswing.ncsc.mil  with ESMTP id i1SIChOX026843
	for <selinux@tycho.nsa.gov>; Sat, 28 Feb 2004 18:12:43 GMT
Date: Sat, 28 Feb 2004 18:14:18 +0000
From: Dale Amon <amon@vnl.com>
To: selinux@tycho.nsa.gov
Subject: Attn Colin: Overhelpful /usr/sbin/policy-remove-unwanted
Message-ID: <20040228181418.GO11147@vnl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Colin's /usr/sbin/policy-remove-unwanted gets into trouble
when you are using syslog-ng and do not have klogd installed:

	Using policy installation method "Automatic"
	Copying the sample /usr/share/selinux/policy/current directory from
	/usr/share/selinux/policy/default
	Removal of unwanted policy files
	Removing "current/domains/program/gnome-pty-helper.te"
	Keeping "current/domains/program/checkpolicy.te"
	Keeping "current/domains/program/chkpwd.te"
	Keeping "current/domains/program/crond.te"
	Keeping "current/domains/program/crontab.te"
	Keeping "current/domains/program/fsadm.te"
	Keeping "current/domains/program/getty.te"
	Keeping "current/domains/program/ifconfig.te"
	Keeping "current/domains/program/init.te"
	Keeping "current/domains/program/initrc.te"
	Removing "current/domains/program/klogd.te"

I think he needs to special case this and either test
for syslog-ng if the .te to be removed is klogd and
klogd is not found; or else simply never remove klogd.te
under any circumstance.

This problem could pop up at other places under
Automatic install as there is an assumption of an
absolute correspondence between the xxxx.te and one or
more xxxxx*.deb packages. (Or that's what I get from
a quick read through of the code without figuring
out all the details.)

Colin? Pong... in your court! :-)

-- 
------------------------------------------------------
   Dale Amon     amon@islandone.org    +44-7802-188325
       International linux systems consultancy
     Hardware & software system design, security
    and networking, systems programming and Admin
	      "Have Laptop, Will Travel"
------------------------------------------------------

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
