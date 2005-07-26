Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6QEfdgA003297
	for <selinux@tycho.nsa.gov>; Tue, 26 Jul 2005 10:41:41 -0400 (EDT)
Received: from iron2-mx.tops.gwu.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6QEa92V015355
	for <selinux@tycho.nsa.gov>; Tue, 26 Jul 2005 14:36:12 GMT
Message-Id: <3un3qj$3ptdhc@iron2-mx.tops.gwu.edu>
Date: Tue, 26 Jul 2005 10:36:03 -0400
From: Yuichi Nakamura <ynakam@gwu.edu>
MIME-Version: 1.0
To: SELinux@tycho.nsa.gov, fedora-selinux-list@redhat.com
Cc: ynakam@gwu.edu
Subject: ANN: SELinux Policy Editor 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

We are glad to announce that SELinux Policy Editor 1.0 has been released.
In this release, 
our policy called "Simplified policy" can be used without GUI.
To try, visit http://seedit.sourceforge.net/ .                  
Install manual, how to and specification documentations are ready.

SELinux Policy Editor and Simplified policy works on Fedora Core4 and 3.
Our tool does not affect existing SELinux, you can go back to default 
SELinux easily. Feel free to try.

If you have question, suggestion or something email to 
seedit-admin@lists.sourceforge.net.

* About SELinux Policy Editor
SELinux Policy Editor is a tool to edit and view SELinux policy, 
originally developed by Hitachi Softwarek, not developed in 
SELinux Policy Editor Project(seedit.sourceforge.net).

 The tool is composed of simplified policy and GUI. 
Simplified policy hides detail of SELinux configuration, 
and GUI makes configuration much easier.
It is not just a GUI tool, the important component is simplified policy. 
You can also configure simplified policy without GUI.
Following is example of simplified policy for Apache.
domain httpd_t;
domain_trans initrc_t /usr/sbin/httpd;
allow /var/www r,s;
allownet -tcp -port 80;
As you see, type is not used. You can use file name, port number in 
configuration.
For detail about simplified policy, see
http://seedit.sourceforge.net/doc/simplified_policy_manual.pdf


* TODO
- Review the security of simplified policy
- Extend syntax of simplified policy for detailed configuration
- Auto generation of simplified policy
- Write more policy by simplified policy 
- Test on other distributions

---
Yuichi Nakamura
Hitachi Software, The George Washington University
Japan SELinux Users Group(JSELUG)
Japan Open Source Advocacy Organization(JOSAO)
SELinux Policy Editor:  http://seedit.sourceforge.net/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
