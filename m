Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBJ08heN012336
	for <selinux@tycho.nsa.gov>; Tue, 18 Dec 2007 19:08:43 -0500
Received: from py-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id lBJ08g7C027056
	for <selinux@tycho.nsa.gov>; Wed, 19 Dec 2007 00:08:42 GMT
Received: by py-out-1112.google.com with SMTP id u77so5709404pyb.15
        for <selinux@tycho.nsa.gov>; Tue, 18 Dec 2007 16:08:42 -0800 (PST)
Message-ID: <dd18b0c30712181608n40756522l10bf8a3e233b6546@mail.gmail.com>
Date: Tue, 18 Dec 2007 16:08:41 -0800
From: "Justin Mattock" <justinmattock@gmail.com>
To: selinux@tycho.nsa.gov
Subject: acpid.socket
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_19956_22250134.1198022921559"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_19956_22250134.1198022921559
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello im wanting to know if there is somebody else who has experienced this
problem; when in enforcing mode from /etc/selinux/config. A system reboot
then reports
a unable to connect to socket acpid.socket permissions denied. I've noticed
the label gives me system_u:object_r:tmpfs_t then after restorecon
acpid.socket I receive
system_u:object_r:apmd_run_run_t .
Any info would be helpful,
regards;
              --Justin P. Mattock

------=_Part_19956_22250134.1198022921559
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello im wanting to know if there is somebody else who has experienced this problem; when in enforcing mode from /etc/selinux/config. A system reboot then reports <br>a unable to connect to socket acpid.socket permissions denied. I&#39;ve noticed the label gives me system_u:object_r:tmpfs_t then after restorecon 
acpid.socket I receive<br>system_u:object_r:apmd_run_run_t .<br>Any info would be helpful,<br>regards;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --Justin P. Mattock<br>

------=_Part_19956_22250134.1198022921559--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
