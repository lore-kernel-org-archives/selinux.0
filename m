Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h763fPHa024555
	for <selinux@tycho.nsa.gov>; Tue, 5 Aug 2003 23:41:26 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h763eAFB001234
	for <selinux@tycho.nsa.gov>; Wed, 6 Aug 2003 03:40:10 GMT
Received: from mta202-rme.xtra.co.nz (mta202-rme.xtra.co.nz [210.86.15.145])
	by jazzswing.ncsc.mil  with ESMTP id h763e9GD001231
	for <selinux@tycho.nsa.gov>; Wed, 6 Aug 2003 03:40:09 GMT
Received: from mta2-rme.xtra.co.nz ([210.86.15.142])
          by mta202-rme.xtra.co.nz with ESMTP
          id <20030806034122.DZWS1245.mta202-rme.xtra.co.nz@mta2-rme.xtra.co.nz>
          for <selinux@tycho.nsa.gov>; Wed, 6 Aug 2003 15:41:22 +1200
Received: from nccproxy.napier.govt.nz ([210.54.249.146])
          by mta2-rme.xtra.co.nz with ESMTP
          id <20030806034120.YDEG9359.mta2-rme.xtra.co.nz@nccproxy.napier.govt.nz>
          for <selinux@tycho.nsa.gov>; Wed, 6 Aug 2003 15:41:20 +1200
Date: Wed, 06 Aug 2003 15:40:26 +1200
From: Glen Boyd <glenb@napier.govt.nz>
To: selinux@tycho.nsa.gov
Subject: libsecure Compilation Failure
Message-ID: <86170000.1060141226@glenb.napier.govt.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

I am attempting to compile libsecure on a RedHat 8 based system and I get 
the following error message when running make:

*****

cc -o fstat_secure.o -c -I../include -I/usr/local/seclinux/include 
fstat_secure.c
In file included from fstat_secure.c:5
xstat_conv.h: In function `xstat_conv':
xstat_conv.h:59: structure has no member named `st_atim'
xstat_conv.h:60: structure has no member named `st_atim'
xstat_conv.h:61: structure has no member named `st_mtim'
xstat_conv.h:62: structure has no member named `st_mtim'
xstat_conv.h:63: structure has no member named `st_ctim'
xstat_conv.h:64: structure has no member named `st_ctim'
make: *** [fstat_secure.o] Error 1

*****

Is there any workaround to this to enable compilation?

If you require further details or if this is in fact the completely wrong 
place to post this question please let me know.

thanks

Glen Boyd               <glenb@napier.govt.nz>
Network Administrator   Napier City Council
Private Bag 6010, Napier, NEW ZEALAND
Phone: +64-6-8344119    Fax: +64-6-8357574


######################################################################
Attention: 
This e-mail message and accompanying data may contain information 
that is confidential and subject to legal privilege. Any information
provided is given in good faith. However unless specifically stated
to the contrary, Napier City Council accepts no liability for the
content of this e-mail or for the consequences of any action taken on
the basis of the information provided, unless that information is
subsequently confirmed in writing. If you are not the intended recipient,
you are notified that any use, dissemination, distribution or copying
of this message or data is prohibited. If you received this e-mail
message in error, please notify us immediately and erase all copies
of this message and attachments. Thank you.
######################################################################

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
