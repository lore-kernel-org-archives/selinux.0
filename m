Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n0QGUHHn025384
	for <selinux@tycho.nsa.gov>; Mon, 26 Jan 2009 11:30:17 -0500
Received: from mail-qy0-f17.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n0QGUGbC024325
	for <selinux@tycho.nsa.gov>; Mon, 26 Jan 2009 16:30:16 GMT
Received: by qyk10 with SMTP id 10so7190131qyk.18
        for <selinux@tycho.nsa.gov>; Mon, 26 Jan 2009 08:30:16 -0800 (PST)
MIME-Version: 1.0
Date: Mon, 26 Jan 2009 10:30:15 -0600
Message-ID: <cadfc0e40901260830u1787249doaeb767d33bba4133@mail.gmail.com>
Subject: 3.6.3 policy on fc10 and kerneloops
From: Xavier Toth <txtoth@gmail.com>
To: SELinux List <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've built and install an fc10 version of the rawhide policy and am
now getting kerneloops.  Does the kernel build rely on policy files?

Kernel failure message 1:
SELinux: WARNING: inside open_file_mask_to_av with unknown mode:c1ff
SELinux: WARNING: inside open_file_mask_to_av with unknown mode:c1ff
SELinux: WARNING: inside open_file_mask_to_av with unknown mode:c1ff
SELinux: WARNING: inside open_file_mask_to_av with unknown mode:c1b6
SELinux: WARNING: inside open_file_mask_to_av with unknown mode:c1ff
SELinux: WARNING: inside open_file_mask_to_av with unknown mode:c1ed
SELinux: WARNING: inside open_file_mask_to_av with unknown mode:c1ed

Ted

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
