Message-ID: <72222DC86846D411ABD300A0C9EB08A101524363@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: "'Reino Wallin'" <reino@oribium.com>,
        Russell Coker
	 <russell@coker.com.au>
Cc: "Westerman, Mark" <Mark.Westerman@csoconline.com>,
        SELinux
	 <SELinux@tycho.nsa.gov>
Subject: RE: SELinux RPM Version
Date: Thu, 25 Apr 2002 07:48:59 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

In the Filesystem Hierarchy Standard (FHS) document for the 
Linux Standard Base.

"Any program or package which contains or requires data the doesn't
need to modified should store that data in /usr/share. "

the doc subdirectory if for "Miscellaneous documentation"

I do not consider the examples/policy to be required 
by the selinux package. I look at the example
policy as being documentation. That is why
I will be keeping the
/usr/share/doc/selinux/example/.......
Directory Structure.

The /etc/selinux/policy directory is created 
and can be modified. 

This data in /usr/share is for read-only. That is
why a symbolic link is not created. 

I will keep with the Linux Standard Base
Filesystem Hierarchy Standard and
keep.

/usr/share/doc/seliunx 
directory structure.

Mark


 

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
