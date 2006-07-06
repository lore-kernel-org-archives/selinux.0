Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k66JTeSJ025195
	for <selinux@tycho.nsa.gov>; Thu, 6 Jul 2006 15:29:40 -0400
Received: from iron1-mx.tops.gwu.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k66JTeec014243
	for <selinux@tycho.nsa.gov>; Thu, 6 Jul 2006 19:29:40 GMT
Date: Thu, 6 Jul 2006 15:29:29 -0400
From: Yuichi Nakamura <ynakam@gwu.edu>
To: selinux@tycho.nsa.gov, fedora-selinux-list@redhat.com
Cc: ynakam@gwu.edu
Subject: [ANN] SELinux Policy Editor 2.0(seedit 2.0)
Message-Id: <20060706152929.dcab61db.ynakam@gwu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi.

I am glad to announce that SELinux Policy Editor 2.0(seedit 2.0) has been released.
seedit is a tool to make SELinux easy.
We have renewed the tool. Almost everything have been changed. 
Policy generator, new GUI are developed, and many others.
You can download and try it from 
http://seedit.sourceforge.net 
Manuals are also provided.
It supports Fedora Core 5 and Cent OS 4.

If you have question, please feel free to contact me.


Here is a brief introduction of seedit 2.0:

1.  About SELinux Policy Editor
SELinux Policy Editor(seedit) is a tool to make SELinux easy.
It was originally developed by Hitachi Software, 
now is developed in SELinux Policy Editor Project(http://seedit.sourceforge.net).

seedit is composed of Simplified Policy and 
tools such as GUI and policy generator. 
The most important is Simplified Policy.
Simplified Policy is a policy described by 
Simplified Policy Description Language(SPDL). 
SPDL hides detail of SELinux configuration by name-based configuration 
and reducing number of permissions.
Following is example policy for Apache by SPDL.

domain httpd_t;
include daemon.sp;
program /usr/sbin/httpd;
allow /var/www/** r,s;
allownet -protocol tcp -port 80 server.
...

As you see, type is not used. 
You can use file name, port number in configuration.
SPDL is converted into SELinux policy by SPDL compiler.

2. New features in 2.0
In this release, we have renewed our tool.
We improved usability and security.

2.1 Improvement in usability
 About usability, we learned a lot from AppArmor.
 We investigated AppArmor and taken good points of it.
 We have to thank to them :-)

* New GUI
 We have developed new GUI "seedit Control Panel".
 It works on X Window System, implemented by python and pygtk.
 You can see screenshots at 
 http://sourceforge.net/project/screenshots.php?group_id=135756 .

 You can do almost everything about SELinux from control panel.
 Features of control panel are following:
 - Policy Generator
  Read audit log and generate Simplified Policy.
 - Policy Template tool
  User can generate policy template for applications by answering some questions.
 - Editor
  Editor for SPDL, you can insert configuration by GUI.
 - Status checker
  It is like AppArmor's unconfined command.
  You can check network process's domain. 
  You can see which domains are assigned unconfined domain.

* Syntax of SPDL: 
 We have taken some AppArmor's profile syntax into SPDL.
 
* RBAC(Role-Based Access Control) Support
 You can switch on/off RBAC support easily by one command.
 See RBAC guide.  

2.2 Improvement of security
 SPDL reduces number of permissions by integrating SELinux's permissions,
 but it affects security.
 We have re-designed permission integration of SPDL, 
 as a research project at The George Washington University.
 For detail of SPDL, see document 
 "Specification of Simplified Policy Description Language(SPDL)".
 More documents about security is in progress.

3. Feedback
 If you have question or want to say something to us,
 please e-mail to me(himainu-ynakam@miomio.jp), 
 or subscribe seedit-devel-list at 
 http://sourceforge.net/mail/?group_id=135756
 
---
Yuichi Nakamura
The George Washington University, Hitachi Software
SELinux Policy Editor:  http://seedit.sourceforge.net/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
