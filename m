Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0HMSXXf010212
	for <selinux@tycho.nsa.gov>; Tue, 17 Jan 2006 17:28:33 -0500 (EST)
Received: from iron1-mx.tops.gwu.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0HMRPP2019959
	for <selinux@tycho.nsa.gov>; Tue, 17 Jan 2006 22:27:26 GMT
Date: Tue, 17 Jan 2006 17:22:51 -0500
From: Yuichi Nakamura <ynakam@gwu.edu>
To: selinux@tycho.nsa.gov, fedora-selinux-list@redhat.com
Cc: ynakam@gwu.edu
Subject: [ANN] SELinux Policy Editor 1.3.1
Message-Id: <20060117172251.22f6d601.ynakam@gwu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi.

SELinux Policy Editor 1.3.1 has been released.
About SELinux Policy Editor, visit http://seedit.sourceforge.net/

(1) Notice
This release includes Simplified Policy only. 
GUI is not included, it will be re-developped.
It is development version, may be unstable.
And tested only in Fedora Core4.

(2) Changes
* audit2spdl utility
 It works like audit2allow, generates simplified policy from log.
 You do not have to remember detail of simplified policy syntax.
* Detailed permission for files support
 For users who want more security, new permission a(Append),t(seTattr), 
 c(Create), e(Erace),o(Overwrite) can be used.
* Documentation 
 Documentation about what permissions are integrated, unsupported by simplified policy is prepared.
 Verifying security of Simplified Policy has become easier.
 See http://seedit.sourceforge.net/doc/permission_integrate/
* Generation of above document using XML/Python

(3) How to use
First get seedit-converter-1.3.1-1.i386.rpm and seedit-policy-1.3.1-FC4.noarch.rpm from 
http://sourceforge.net/project/showfiles.php?group_id=135756
How to install is the same as 1.2, 
see http://seedit.sourceforge.net/doc/install/INSTALL.html
For detail, see manual at http://seedit.sourceforge.net/doc_devel/simplified_policy_manual/

(4) Plan
- XML support to be handled easily by UI tools
- New GUI 
- Review security of simplified policy, prepare document 

If you have question, comment, suggestion and others, 
please feel free to send me e-mail(ynakam@gwu.edu).

-----
Yuichi Nakamura
Japan SELinux Users Group(JSELUG)
SELinux Policy Editor: http://seedit.sourceforge.net/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
