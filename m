Message-ID: <72222DC86846D411ABD300A0C9EB08A10152435F@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: "'Stephen Smalley'" <sds@tislabs.com>, Reino Wallin <reino@oribium.com>
Cc: "Westerman, Mark" <Mark.Westerman@csoconline.com>,
        SELinux
	 <SELinux@tycho.nsa.gov>
Subject: RE: SELinux RPM Version
Date: Wed, 24 Apr 2002 07:42:14 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wednesday, April 24, 2002 7:37 AM, Stephen Smalley wrote:

> The file contexts configuration has been moved under the policy directory,
> within a subdirectory named file_contexts, and the Makefile rules for the
> policy and relabeling have been merged into a single policy/Makefile.  The
> setfiles directory in the source tree now only contains the setfiles
> program sources along with a Makefile to build and install the
> setfiles program when SELinux is installed, and this step 
> occurs prior to running 'make relabel' in the policy directory.
> 
I have been palnning to ask this, since the file_contexts have been
move back to the policy directory, did you create a setfiles directory
or just move the file_contexts to the policy directory ?

I move the file_contexts to the policy directory and created an
entry into the Makefile call relabelfs  'make relabelfs' to 
relabel the file system.


Mark

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
