Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l32ElXhA006421
	for <selinux@tycho.nsa.gov>; Mon, 2 Apr 2007 10:47:33 -0400
Received: from ug-out-1314.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l32ElUd2001199
	for <selinux@tycho.nsa.gov>; Mon, 2 Apr 2007 14:47:32 GMT
Received: by ug-out-1314.google.com with SMTP id y2so1870023uge
        for <selinux@tycho.nsa.gov>; Mon, 02 Apr 2007 07:47:29 -0700 (PDT)
Message-ID: <9d1b82480704020747v1f05b267j874c4bb2d3f1f941@mail.gmail.com>
Date: Mon, 2 Apr 2007 20:17:26 +0530
From: Pravin <shindepravin@gmail.com>
To: "SELinux List" <selinux@tycho.nsa.gov>
Subject: Compatibility between binary policy file and kernel version
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
I am facing some problems with compatibility between binary policy
file and kernel version.

I have properly working selinux with kernel 2.6.19.
But When I use kernel 2.6.18 or 2.6.20, the filesystem labels r not recognized.
These kernels shows the default labels like
"system_u:object_r:unlabeled_t:s0" but same object shows proper label
in kernel 2.6.19.

I am using FC6 filesystem with selinux policies compiled by SEEdit.
The binary policy file created is "/etc/selinux/seedit/policy/policy.21"

Do I need to re-create compiled binary policies for kernel 2.6.18 ?

One more doubt that I have is kernel that I am using are not
Fedora-core kernel but plain vanilla kernels.
Can this create problems, as may be FC kernels are having different
binary policy format?

Regards,
Pravin Shinde

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
