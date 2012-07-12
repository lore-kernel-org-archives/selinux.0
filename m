From: hqjiang <hqjiang1988@gmail.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, bill.c.roberts@gmail.com
Subject: Add two device-specific labelings to target CSR GPS Chips.
Date: Thu, 12 Jul 2012 15:37:49 -0700
Message-Id: <1342132671-17376-1-git-send-email-hqjiang1988@gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi, all

Today AOSP has updated the patches of targeting denies of GpsLocationManager.
But the correspoinding labeling parts are not updated in device-specific sepolicy. 
We submit the labels to complement the functions. 

If you update the patches from William Robert, you can find that the genfscon syntax
finally can be simply achieved in sepolicy.fc which is device-specific.  


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
