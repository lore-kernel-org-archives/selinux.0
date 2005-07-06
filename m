Message-ID: <a1025d74050706043350354e8@mail.gmail.com>
Date: Wed, 6 Jul 2005 07:33:37 -0400
From: Trevor Vaughan <peiriannydd@gmail.com>
Reply-To: Trevor Vaughan <peiriannydd@gmail.com>
To: SELinux@tycho.nsa.gov
Subject: Virus Scanner Policies
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I was wondering how one would go about integrating a system-wide virus
scanner into a SELinux-based system?

I was building a test machine and had all servers and services working
perfectly.  Unfortunately, when I put a virus scanner on the machine,
it (rightly so) wasn't able to access much of anything.

Personally, I dislike the idea of giving any program full access to
all system files since a properly configured machine will prevent most
problems.  However, I have spoken with several people whose companies
require the use of virus scanning technology on ALL machines
regardless.

Additionally, this type of policy is relevant for programs such as
AIDE (http://sourceforge.net/projects/aide) and cfengine
(http://www.cfengine.org/) that routinely touch a great number of
files but should also be restricted to only the files that you wish
them to touch.  I.e. cfengine should not be poking at your DNS files
if you only want it to check files in /etc.

This question has been rolling around in my head for some time now and
I would like to know how someone would go about doing something like
this.

I apologize if this would be painfully obvious if I had already
managed to make sense of all of the documentation but I'm still
getting my feet wet.

Thanks,

Trevor

-- 
Heredocs, theredocs, everwhereadocsdocs
old macdonald had a server farm
he eyed the I/O


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
