MIME-Version: 1.0
Date: Thu, 2 Aug 2012 15:30:55 -0700
Message-ID: <CAFftDdrNKJM_DJLxMFuwm6i-v=kG-Q9ZXPEK699tcCUYdpYe-g@mail.gmail.com>
Subject: re-loadable policy support
From: William Roberts <bill.c.roberts@gmail.com>
To: selinux@tycho.nsa.gov
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Doing the following steps on master is causing a reboot...

1. boot the device
2. push a sepolicy.24 to /data/system/sepolicy.24
3. adb shell setprop selinux.reload_policy 1
4. wait a few seconds
5. repeat step 3 and a reboot happens


-- 
Respectfully,

William C Roberts

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
