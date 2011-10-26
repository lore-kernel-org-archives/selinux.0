Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p9QHBh1v003886
	for <selinux@tycho.nsa.gov>; Wed, 26 Oct 2011 13:11:43 -0400
Received: from mail-vw0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p9QHBgsI011670
	for <selinux@tycho.nsa.gov>; Wed, 26 Oct 2011 17:11:42 GMT
Received: by vws19 with SMTP id 19so1889250vws.12
        for <selinux@tycho.nsa.gov>; Wed, 26 Oct 2011 10:11:42 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 26 Oct 2011 10:11:42 -0700
Message-ID: <CAOdLEarjJg4Gs9ZJbWfE68XkFTYh6veOcdr=ToSVZe-97F0b1Q@mail.gmail.com>
Subject: Where does linux kernel call initial policy load
From: Sam Gandhi <samgandhi9@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

I am not an expert in kernel source navigation. Anybody want to give
me clues as to where  does linux kernel load initial policy at
startup, even before the rcS scripts get started?

It looks like if  I have /etc/selinux/config file that says config is
as shown below

SELINUX=permissive
SELINUXTYPE=mypolicy


It looks like linux kernel is loading file
/etc/selinux/mypolicy/policy.24 I want to find out how that is getting
invoked. I see that it looks like it is triggered by write to selinux
sysfs entry /selinux/load but I want to find out where in the kernel
code is that write to /sexlinux/load generated?

-Sam

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
