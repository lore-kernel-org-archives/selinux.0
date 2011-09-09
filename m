Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p89FZ3wb019015
	for <selinux@tycho.nsa.gov>; Fri, 9 Sep 2011 11:35:03 -0400
Received: from exchange10.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p89FZ28w028695
	for <selinux@tycho.nsa.gov>; Fri, 9 Sep 2011 15:35:03 GMT
Message-ID: <4E6A3225.2090502@tresys.com>
Date: Fri, 9 Sep 2011 11:35:01 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: SELinux Mail List <selinux@tycho.nsa.gov>,
        Refpolicy Mail List
	<refpolicy@oss1.tresys.com>
Subject: ANN: Reference Policy contrib repository
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The challenge of Reference Policy has always been balancing the needs of having a well reviewed policy against responding to fairly rapid application development and new user needs in Linux.  If you are not familiar with the differences between the Reference Policy and Fedora policy, it is quite large.  Since Fedora is the largest SELinux-enabled distribution, its development version, rawhide, is on the front lines of seeing new features in apps.  Due to Dan and Miroslav's extensive work, the Fedora policy evolves rapidly.  However, this has proven to be too fast for me to constantly review all the changes and integrate them upstream, resulting in the huge difference between the two policies.

To ameliorate this situation, additional contributors with commit access have been added for Reference Policy.  To be specific, a large amount of the policy has been moved into a contrib layer (a git submodule), where these contributors may commit.  The core policy modules will remain in the primary Reference Policy repository, for which I remain the maintainer.  Due to its nature, the contrib repository will be faster moving and less reviewed than the core Reference Policy repository.

The core modules are critical modules on the system.  This includes all of the kernel layer, most of the system and roles layers, some admin modules, such as bootloader, su, and sudo, and userspace object managers.  It is possible to build a policy using only the core modules.  It is important to ensure these modules are well reviewed to ensure quality, so Reference Policy can be used as a base for both general-purpose systems (e.g. Linux distributions) and custom systems.  All remaining modules were moved to the contrib repository.  An important thing to note is that in the future, modules may move between core and contrib as necessary.

For those that have a current checkout of the repository, you will need to do the following to get the new contrib submodule:

$ git pull
$ git submodule init
$ git submodule update

If you are looking to check out the repository for the first time, the instructions are at:
http://oss.tresys.com/projects/refpolicy/wiki/RepositoryCheckout

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
