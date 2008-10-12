Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m9C3uQE1007140
	for <selinux@tycho.nsa.gov>; Sat, 11 Oct 2008 23:56:26 -0400
Received: from wf-out-1314.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m9C3uQNX008303
	for <selinux@tycho.nsa.gov>; Sun, 12 Oct 2008 03:56:26 GMT
Received: by wf-out-1314.google.com with SMTP id 28so1910541wff.30
        for <selinux@tycho.nsa.gov>; Sat, 11 Oct 2008 20:56:25 -0700 (PDT)
Message-ID: <dd18b0c30810112056r5c107307jbcab88d07a382233@mail.gmail.com>
Date: Sat, 11 Oct 2008 20:56:25 -0700
From: "Justin Mattock" <justinmattock@gmail.com>
To: "SE Linux" <selinux@tycho.nsa.gov>
Subject: gdm ubuntu 8.10
Cc: tresys <refpolicy@oss.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello; for a while I've been using nubuntu,but now have decided
to try a full loaded O.S. when using nubuntu  there is no automatic
gnome-desktop-manager, normally just a login then choosing a context,
then startx.
Now with ubuntu there's an automatic login screen with bells and whistles,
 what is the best way to add pam_selinux.so so I can choose my context,
or should I adjust the policy to start in sysadm_r as the default
instead of user_r?
Then what is the best way to have my apps start in there certain role
rather than opening a shell
and manually doing so? (the policy refpolicy);
Any info would be appreciated.
regards;

-- 
Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
