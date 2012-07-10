From: hqjiang <hqjiang1988@gmail.com>
To: selinux@tycho.nsa.gov
Cc: bill.c.roberts@gmail.com, sds@tycho.nsa.gov
Subject: Patches to target denies of LocationManager (GPS).
Date: Tue, 10 Jul 2012 14:36:20 -0700
Message-Id: <1341956182-1071-1-git-send-email-hqjiang1988@gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


LocationManger needs to access GPS over UART devices. Two core functionalities are
required in order to access GPS. The first one is the uart driver. /dev/ttyO0 is 
for UART Driver. It's defined in CSR SiRF policy file. We can find it on both maguro 
and toro devices. But it's Samsung tuna board specific. We define it as "gps_device".

The second one is the uart rts level ctrl. The uart1 is for GPS and CSR GPS chip 
should control uart1 rts level for GPS firmware download. /proc/mcspi1_cs3_ctrl is
the proc entry assigned "uart1 rts level" control. It is also Samsung Tuna Board 
specific. 

But we find one problem that we cannot label contexts of /proc/mcspi1_cs3_ctrl out
of file "ocontext". Could someone help us to label it in the file of 
"/device/samsung/tuna/sepolicy.fc" to make it device-specific? 

Thanks a lot, 

Haiqing Jiang 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
