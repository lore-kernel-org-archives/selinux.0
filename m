Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2S4qkDo022960
	for <selinux@tycho.nsa.gov>; Sun, 27 Mar 2005 23:52:46 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2S4nNUJ007879
	for <selinux@tycho.nsa.gov>; Mon, 28 Mar 2005 04:49:23 GMT
Subject: Desktop apps interoperability
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: selinux@tycho.nsa.gov
Cc: fedora-selinux-list@redhat.com
Content-Type: text/plain
Date: Sun, 27 Mar 2005 23:57:35 -0500
Message-Id: <1111985855.1514.70.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Okay, mozilla's handling of saved files is a problem. Here's what it
does - files saved under ROLE_home_dir_t, or ROLE_home_t directories
turn to ROLE_mozilla_home_t via file_type_auto_trans.

Here's what gift does by default - it has a download folder where it
puts stuff. The downloaded files turn to ROLE_gift_home_t (context of
parent folder, which is ~/.giFT/completed or something).

Here's what mencoder does - it saves stuff as ROLE_mplayer_home_t
via file_type_auto_trans.

==============

This is bad for interoperability. Using the home_domain macro,
the user has access to the home_domain type of an application.
However one app has no access to the home_domain type of another app.
Basically I can never play (mplayer) a movie that I just downloaded,
whether or not it was via mozilla, or gift. 

Alternatively, there could be a common data type - ROLE_home_t.
However none of those apps can save its data directly
under /home/username as ROLE_home_t, because all of them have a
home_domain, and that's where the file_type_auto_trans rule is used.
There can't be more than one file_type_auto_trans on the same folder
type (right?). Furthermore this seems to be explicitly avoided for
mozilla (it does not write to ROLE_home_t for security reasons -
overwriting .bashrc?).

============

Ok, here


Fundamentally, what I want to know is:

1) Do desktop apps need to be confined? Is it a good idea to confine
them?

2) If so, a shared data type is needed for interoperability. 
Is ROLE_home_t acceptable for that purpose.

3) 

0) No 

1) Shared data type is needed for interoperability

2) Keeping both application settings, and user data in the same folder
is a problem




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
