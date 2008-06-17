Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5HEkhUm022044
	for <selinux@tycho.nsa.gov>; Tue, 17 Jun 2008 10:46:43 -0400
Received: from fg-out-1718.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m5HEkgF0009340
	for <selinux@tycho.nsa.gov>; Tue, 17 Jun 2008 14:46:43 GMT
Received: by fg-out-1718.google.com with SMTP id 16so3523951fgg.40
        for <selinux@tycho.nsa.gov>; Tue, 17 Jun 2008 07:46:42 -0700 (PDT)
Message-ID: <cadfc0e40806170746p6de7c1b7m6c27ca74ae0ca183@mail.gmail.com>
Date: Tue, 17 Jun 2008 09:46:42 -0500
From: "Xavier Toth" <txtoth@gmail.com>
To: "SELinux Mail List" <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: gnome-screensav AVCs
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm seeing AVCs related to netlink_audit_socket when the screen saver
dialog is run. gnome-screensaver-dialog opens a pam session which uses
pam_unix which in turn runs the unix_chkpwd helper. I'm thinking that
gnome-screensaver-dialog is going to need some policy including
possibly authlogin_common_auth_domain_template. Would it be best to
add policy for this to gnome or should it have it's own module?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
