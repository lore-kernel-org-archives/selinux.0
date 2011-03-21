Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p2LGqULM022418
	for <selinux@tycho.nsa.gov>; Mon, 21 Mar 2011 12:52:30 -0400
Received: from mail-px0-f169.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p2LGqTXY023626
	for <selinux@tycho.nsa.gov>; Mon, 21 Mar 2011 16:52:29 GMT
Received: by pxi9 with SMTP id 9so1028477pxi.0
        for <selinux@tycho.nsa.gov>; Mon, 21 Mar 2011 09:52:28 -0700 (PDT)
Message-ID: <4D878244.4060502@gmail.com>
Date: Mon, 21 Mar 2011 09:52:20 -0700
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: refpolicy@oss1.tresys.com, selinux@tycho.nsa.gov
Subject: SELinux: avc_has_perm: unexpected error 22
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

this is showing up with the latest Mainline kernel.
gdm craps out..:

[    60.817] (II) Unloading synaptics
[    60.822] SELinux: avc_has_perm: unexpected error 22
[    60.822] SELinux: avc_has_perm: unexpected error 22
[    60.828] SELinux: avc_has_perm: unexpected error 22
[    60.831] SELinux: avc_has_perm: unexpected error 22
[    60.871] SELinux: avc_has_perm: unexpected error 22
[    60.871] SELinux: avc_has_perm: unexpected error 22
[    60.881] (II) UnloadModule: "mouse"
[    60.881] (II) Unloading mouse


full xorg.0.log is here:
http://fpaste.org/OOM2/

Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
