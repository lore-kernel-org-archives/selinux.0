Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q83EoJ8u007368
	for <selinux@tycho.nsa.gov>; Mon, 3 Sep 2012 10:50:22 -0400
Message-ID: <1346683819.9228.YahooMailClassic@web87706.mail.ir2.yahoo.com>
Date: Mon, 3 Sep 2012 15:50:19 +0100 (BST)
From: Richard Haines <richard_c_haines@btinternet.com>
Subject: The SELinux Notebook 3rd Edition
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've just published the 3rd edition of the SELinux Notebook at:
http://www.freetechbooks.com/the-selinux-notebook-the-foundations-t785.html
that covers:
    a) SELinux and its purpose in life.
    b) The LSM / SELinux architecture, its supporting services and how
       they are implemented within GNU / Linux.
    c) SELinux Networking, Virtual Machine, X-Windows, PostgreSQL and
       Apache/SELinux-Plus SELinux-aware capabilities.
    d) The core SELinux policy language and how basic policy modules can
       be constructed for instructional purposes.
    e) The core SELinux policy management tools with examples of usage.
    f) The Reference Policy architecture, its supporting services and how
       it is implemented.
    g) The integration of SELinux within Android - SEAndroid.

To demonstrate some of the SELinux capabilities, a supporting Notebook
source tarball is available (notebook-source-3.0.tar.gz) that contains:
    a) Building a Basic Policy - Describes how to build monolithic, base
       and loadable policy modules using core policy language statements
       and SELinux commands. This expands to a simple message filter
       using SECMARK, NetLabel and Labeled IPSec that also has a CIL
       policy version.
    b) Example libselinux applications - This contains over 100 samples
       that use all libselinux 2.1.6 functions. There are also some
       supporting policy modules for the Fedora 16/17 targeted policy
       to show how the functions work.
    c) Experimenting with X-Windows - Builds a sample selection manager
       application, a simple test application for the XSELinux extension
       Get/Set functions.
    d) Experimenting with PostgreSQL 9.1 using sepgsql - This shows how
       to create a simple database that uses SELinux functionality.
       This is then expanded to demonstrate adding additional functions
       to support libselinux. There are also demos using Apache with
       threads (mod_selinux), PHP, Labeled IPSec and NetLabel.
       The policy modules supplied have been tested using Fedora 16/17
       targeted policy.

I'll start updating the selinuxproject.org site with the new text over
the next month or so. If you find any errors please let me know.

Richard



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
