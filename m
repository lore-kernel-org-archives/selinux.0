Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p4OKkeg2022700
	for <selinux@tycho.nsa.gov>; Tue, 24 May 2011 16:46:40 -0400
Received: from mail-iy0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p4OKke11014321
	for <selinux@tycho.nsa.gov>; Tue, 24 May 2011 20:46:40 GMT
Received: by iyb26 with SMTP id 26so6878651iyb.12
        for <selinux@tycho.nsa.gov>; Tue, 24 May 2011 13:46:39 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 24 May 2011 13:46:39 -0700
Message-ID: <BANLkTi=UEBFLWeWMov7GjOn_-Q3QuyTyxw@mail.gmail.com>
Subject: Is it possible to assign different labels to symbolic links and
 actual files?
From: Sam Gandhi <samgandhi9@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

I am working on a embedded platform and we have busybox on this device.

What we would like to do do is assign diffrent labels to various
busybox links. What we have seen when running things on JFFS2 when I
label a symbolic link, the actual file gets the label, but the link
itself doesn't (according to ls -lZ output).  We have seen similar
behaviour with files on tmpfs as well.

ls -lZ
-rw-r--r--        1         0 Jan  1 00:12 system_u:object_r:myfile_t X
lrwxrwxrwx    1         1 Jan  1 00:13 user_u:object_r:tmpfs_t          Y -> X

Is there no way to assign different label to symlink and actual files?
Is this file-system specific issue? Are there any file-system that
support assigning seperate labels to symlink and actual file?

-Sam

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
