Subject: Creating Permissions for New Software
To: SELinux@tycho.nsa.gov
Message-ID: <OFC3FE5220.D84825C9-ON85256BF8.00591C2A@hq.caci.com>
From: "Richard Mayo" <rmayo@caci.com>
Date: Tue, 16 Jul 2002 12:28:05 -0400
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm trying to configure a computer here running SELinux on RH7.2 to run a
custom software package.  I've defined and assigned three new file
contexts, one for executable files, one for user files, and one for config
files, which are used to create user directories for new users.  I've
checked and these types are correctly assigned to the files on disk
(apparently that was the easy part).

Additionally, I created a new .te file (copied from Mr. Smalley's original
for Netscape) and commented out most of the original lines.   I've left a
few in -- the ones that create the derived domain and transition to this
domain --  but all of the specific permissions have been removed.
Additinally, I did remember to add this file to the list of includes in
user_macros.te.

Since then, I've tried to grant permissions to the user for his user files,
but nothing changed.  Can some of you more experienced folks give me a clue
or two concerning how I ensure that the macro file I created actually gets
used and, if it does, what sort of goodies I should put in there.
One specific question I have is, "What do I gain by creating the derived
(temporary?) domain and how does this impact the permission I must grant to
run my software?"


Any and all help will be greatly appreciated,
R. Mayo



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
