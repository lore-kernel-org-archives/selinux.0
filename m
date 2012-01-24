Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q0OJRKlC023342
	for <selinux@tycho.nsa.gov>; Tue, 24 Jan 2012 14:27:20 -0500
Received: from mail-ee0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id q0OJRJ6J011581
	for <selinux@tycho.nsa.gov>; Tue, 24 Jan 2012 19:27:19 GMT
Received: by eeke51 with SMTP id e51so1650594eek.12
        for <selinux@tycho.nsa.gov>; Tue, 24 Jan 2012 11:27:18 -0800 (PST)
MIME-Version: 1.0
Date: Tue, 24 Jan 2012 13:27:18 -0600
Message-ID: <CAFPpqQEfm+xyHWZV=1D1oJbqEvPAinQdu0jYZX+cM_Fo3ESc9w@mail.gmail.com>
Subject: X server in enforcing x_drawable avcs
From: Ted Toth <txtoth@gmail.com>
To: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm seeing x_drawable read denials in Xorg.0.log  on a system with the
X server in enforcing. I'm confused about these because the
xserver_object_manager boolean is set which gets:
allow x_domain xdrawable_type:x_drawable *;

and the source context type of the avc is a type in the x_domain
attribute and the target context type is in the xdrawable_type
attribute which should be allowed by the included allow rule.

Ted

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
