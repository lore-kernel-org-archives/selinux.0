From: hqjiang <hqjiang1988@gmail.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, bill.c.roberts@gmail.com
Subject: Patches to target denies of GpsLocationProvider and media_app over mtp_device
Date: Wed, 11 Jul 2012 15:39:47 -0700
Message-Id: <1342046389-9271-1-git-send-email-hqjiang1988@gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

One thing should be paid attentions here: 
We add a new entry of "user=app_* name=android.process.media domain=media_app levelFromUid=true" to seapp_context file. 
One would say it's nonecessary because there's already one policy "user=app_* seinfo=media domain=media_app levelFromUid=true". 
But the thing is that the seinfo of "android.process.media" is not media. 

If you have better ideas, pleae let us know. And we can resubmit the refined patches later. 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
