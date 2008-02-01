Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m116a79s017882
	for <selinux@tycho.nsa.gov>; Fri, 1 Feb 2008 01:36:07 -0500
Received: from py-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m116a6jA025728
	for <selinux@tycho.nsa.gov>; Fri, 1 Feb 2008 06:36:06 GMT
Received: by py-out-1112.google.com with SMTP id a78so1201608pyh.32
        for <selinux@tycho.nsa.gov>; Thu, 31 Jan 2008 22:36:06 -0800 (PST)
Message-ID: <dd18b0c30801312236k1a2d90c4q8a2f440e83a0b552@mail.gmail.com>
Date: Fri, 1 Feb 2008 06:36:04 +0000
From: "Justin Mattock" <justinmattock@gmail.com>
To: selinux@tycho.nsa.gov
Subject: usb_hcd_poll_rh_status (rh_timer_func)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_19565_29696413.1201847764579"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_19565_29696413.1201847764579
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello; Im in need of some help, first things first; thank you far for all
the help so far, I need to find a good mailing.list for a problem that I
have with power consumption on my laptop; to give you an idea of what im
facing; running linux on a macbook pro the battery life is a whole 1:30hr,
I've managed to move it up to 2:50hr with the kernel boot option of
uhci-hcd.ignore=1, and radeontool power low, but seem to be at a wall with
trying to figure out why usb_hcd_poll_rh_status (rh_timer_func) keeps waking
the cpu from going into a deep sleep.  With using lsusb -vv I noticed remote
wakeup with some of the devices? but still am unsure of what or where the
Watts are being taken from, and why the wakeups keep occuring.
regards;
              --Justin P. Mattock

------=_Part_19565_29696413.1201847764579
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello; Im in need of some help, first things first; thank you far for all the help so far, I need to find a good mailing.list for a problem that I have with power consumption on my laptop; to give you an idea of what im facing; running linux on a macbook pro the battery life is a whole 1:30hr, I&#39;ve managed to move it up to 2:50hr with the kernel boot option of uhci-hcd.ignore=1, and radeontool power low, but seem to be at a wall with trying to figure out why usb_hcd_poll_rh_status (rh_timer_func) keeps waking the cpu from going into a deep sleep.&nbsp; With using lsusb -vv I noticed remote wakeup with some of the devices? but still am unsure of what or where the Watts are being taken from, and why the wakeups keep occuring. <br>
regards;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --Justin P. Mattock<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>

------=_Part_19565_29696413.1201847764579--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
