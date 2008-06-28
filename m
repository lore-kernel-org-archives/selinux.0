Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5SMNST1015264
	for <selinux@tycho.nsa.gov>; Sat, 28 Jun 2008 18:23:30 -0400
Received: from nf-out-0910.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m5SMNQQj004029
	for <selinux@tycho.nsa.gov>; Sat, 28 Jun 2008 22:23:27 GMT
Received: by nf-out-0910.google.com with SMTP id b21so305394nfd.4
        for <selinux@tycho.nsa.gov>; Sat, 28 Jun 2008 15:23:25 -0700 (PDT)
Message-ID: <dd18b0c30806281523h6263237sfdb9061a13f8e167@mail.gmail.com>
Date: Sat, 28 Jun 2008 22:23:25 +0000
From: "Justin Mattock" <justinmattock@gmail.com>
To: selinux@tycho.nsa.gov
Subject: mls support for xserver
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello; after seeing all of these posts about xserver I couldn't help
but to try MLS policy.
As the same results a few months back it seems there isn't any support
for this policy yet to work with xserver is there?
i.g. from what I see after allowing most of the avc's, I'm left with
these that seem to keep appearing upon a reboot:

allow insmod_t kernel_t:process setsched;
allow kernel_t bluetooth_t:socket write;
allow sysadm_sudo_t devpts_t:dir search;
allow sysadm_xserver_t memory_device_t:chr_file { read write };
<------  I can't start X without this one here.
allow syslogd_t var_log_t:file append;

I think it's the same with hid2hci --tohci upon wakeup, the ioctl or
node is changed resulting in a new avc's for that device.
Is there going to be support to use MLS in the future or is it too
much of a security risk.(xserver).
regards;

-- 
Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
