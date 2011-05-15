Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p4FEepBs008837
	for <selinux@tycho.nsa.gov>; Sun, 15 May 2011 10:40:51 -0400
Received: from mail-iy0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p4FEeplT010872
	for <selinux@tycho.nsa.gov>; Sun, 15 May 2011 14:40:51 GMT
Received: by iyb26 with SMTP id 26so3893187iyb.12
        for <selinux@tycho.nsa.gov>; Sun, 15 May 2011 07:40:50 -0700 (PDT)
MIME-Version: 1.0
Date: Sun, 15 May 2011 07:40:50 -0700
Message-ID: <BANLkTim-1VFJHg1BdSjbWH-6RrfMHVBx3A@mail.gmail.com>
Subject: FUSE and SELinux labeling
From: Sam Gandhi <samgandhi9@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi


Is there a FAQ or some description on what one needs to do to enable
labeling on files created under a fuse filesystem?

When I mount my fuse file system I see message like

SELinux: initialized (dev fuse, type fuse), not configured for labeling

Now if I use statement such as shown below in my SELinux policy before
loading it I don't see those messages

fs_use_xattr fuse system_u:object_r:fs_t;

But then when I try to mount fuse file system using simple fuse hello
program as hello /tmp/foo, I see message:

SELinux: (dev fuse, type fuse) getxattr errno 4 on console and my system hangs!


( Has anybody been successful in adding the SELinux labels to file
created  by fuse? I have search both fuse and SElinux mailing list,
also done bit of google search and nothing comes up , either this is
way too simple thing to do and I am missing obvious thing)

Would appreciate any help.

( I had sent message earlier to fuse-devel, but didn't cross-post it
to SELinux )
-Sam

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
