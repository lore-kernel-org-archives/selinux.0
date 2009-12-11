Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nBBCHdC2007255
	for <selinux@tycho.nsa.gov>; Fri, 11 Dec 2009 07:17:39 -0500
Received: from moss-lions.epoch.ncsc.mil (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id nBBCGTGk005334
	for <selinux@tycho.nsa.gov>; Fri, 11 Dec 2009 12:16:29 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.14.3/8.14.3) with ESMTP id nBBCHYwL003784
	for <selinux@tycho.nsa.gov>; Fri, 11 Dec 2009 07:17:34 -0500
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.14.3/8.14.3/Submit) id nBBCHYjl003782
	for selinux@tycho.nsa.gov; Fri, 11 Dec 2009 07:17:34 -0500
Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nBB8VNJE028632
	for <selinux@tycho.nsa.gov>; Fri, 11 Dec 2009 03:31:29 -0500
Received: from outbound.icp-qv1-irony-out1.iinet.net.au (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id nBB8XM1m001347
	for <selinux@tycho.nsa.gov>; Fri, 11 Dec 2009 08:33:27 GMT
Message-ID: <4B22032F.906@ii.net>
Date: Fri, 11 Dec 2009 16:30:39 +0800
From: Cliffe <cliffe@ii.net>
MIME-Version: 1.0
To: apparmor-dev@forge.novell.com, selinux@tycho.nsa.gov,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        fbac-lsm-general@lists.sourceforge.net
Subject: New security system FBAC-LSM announcement and call for collaborators
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

In preparation for my LCA talk “A New Paradigm for Restricting 
Applications and Protecting Yourself from Your Processes”, today I have 
released the code for FBAC-LSM. This initial development version of 
FBAC-LSM is functional, but is unstable and slow. It is developed 
against an older version of the LSM interface (using the AppArmor 
path-based hooks), and will be updated to work with the new interface in 
the future. There is quite a bit of work to be done before it is ready 
for production systems or formal code review.

I developed FBAC-LSM for my PhD research. FBAC-LSM restricts programs 
based on the features each application provides. Reusable policy 
abstractions, known as functionalities, can be used to grant the 
authority to perform high level features (for example using the 
Web_Browser functionality) or lower level features (such as using the 
HTTP_Client functionality) or to grant privileges to access any 
specified resources. Functionalities are parameterised, which allows 
them to be adapted to the needs of specific applications. 
Functionalities are also hierarchical; that is, functionalities can 
contain other functionalities.

Over one hundred applications were analysed, and functionalities and 
policies were developed. A number of techniques for automating aspects 
of policy specification were also developed. A usability study comparing 
FBAC-LSM with SELinux and AppArmor found that the new approach provided 
significant benefits including higher levels of user satisfaction and of 
successful policy creation. In the near future I will share the results 
of the usability study, including suggestions for improving the 
usability of SELinux and AppArmor.

Currently I am planning on expanding the FBAC-LSM tools to export to and 
manage AppArmor and SEEdit policies.

I am looking for anyone interested in collaborating on the project. 
Please contact me. There are a number of problems with the 
synchronisation in the LSM code, which I hope someone on one of these 
mailinglists can help with.

Programmed in C and C++, using the LSM and Qt frameworks. Policy 
abstractions in FBAC-LSM-PL policy language. Licensed GPL.

Check out the FBAC-LSM homepage which has lots more information and videos:
http://schreuders.org/FBAC-LSM

Pull the sourceforge Git repo (which includes the Linux Security Module 
(LSM), graphical policy manager, and policies) to your computer with the 
command:
git clone git://fbac-lsm.git.sourceforge.net/gitroot/fbac-lsm/fbac-lsm

If you are attending the 2010 linux.conf.au conference, I hope to see 
you at my talk in room Renouf 2 at 16:45 on Wednesday 20/01/10:
http://www.lca2010.org.nz/programme/schedule/view_talk/50029?day=wednesday

Thanks,

Z. Cliffe Schreuders
http://schreuders.org
PhD Candidate
Murdoch University



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
