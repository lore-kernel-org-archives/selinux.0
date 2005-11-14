Message-ID: <43789D88.2070005@tresys.com>
Date: Mon, 14 Nov 2005 09:22:00 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] Add swig wrappers for libsemanage
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This adds wrappers for some functions in libsemanage. The only wrapped
interfaces at this point are query functions for modules, seuser, and
user's. These should be sufficient for genhomedircon, and we can add
more wrapped interfaces as necessary.

There is a test script that shows how the functions work in
libsemanage/src/pywrap-test.py

This patch also includes the generated files so that swig isn't required
to build the repository. However, if the libsemanage interfaces change,
or more interfaces are added to the swig interface file you must make
swigify in the libsemanage/src directory to regenerate the files, and
include them in any patch.

To build the wrappers you can use make install-pywrap from the root
directory, this behavior can be changed to be default, however, if these
wrappers are required for most systems.

The patch is rather large due to the generated file so here is a link:
http://sepolicy-server.sourceforge.net/1-swigify-libsemanage.diff


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
