Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h7I2sWHa009836
	for <selinux@tycho.nsa.gov>; Sun, 17 Aug 2003 22:54:33 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h7I2rAOD011456
	for <selinux@tycho.nsa.gov>; Mon, 18 Aug 2003 02:53:10 GMT
Received: from hotmail.com (bay8-f54.bay8.hotmail.com [64.4.27.54])
	by jazzswing.ncsc.mil  with ESMTP id h7I2r9KO011453
	for <selinux@tycho.nsa.gov>; Mon, 18 Aug 2003 02:53:10 GMT
From: "Timmy Jones" <zapperlink@hotmail.com>
To: selinux@tycho.nsa.gov
Subject: 2.6 error
Date: Sun, 17 Aug 2003 19:43:04 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY8-F54UJvBfqI1kJG0000bb40@hotmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hey all,

Im having issues fixing this error. Wondering if any of you might know of a 
solution.


CC [M]  drivers/block/paride/friq.o
  CC [M]  drivers/block/paride/fit2.o
  CC [M]  drivers/block/paride/fit3.o
  CC [M]  drivers/block/paride/on20.o
  CC [M]  drivers/block/paride/on26.o
  CC [M]  drivers/block/paride/ktti.o
  CC [M]  drivers/block/paride/bpck6.o
  CC [M]  drivers/block/paride/pd.o
drivers/block/paride/pd.c: In function `pd_init':
drivers/block/paride/pd.c:896: warning: passing arg 1 of `blk_init_queue' 
from incompatible pointer type
drivers/block/paride/pd.c:896: warning: passing arg 2 of `blk_init_queue' 
from incompatible pointer type
drivers/block/paride/pd.c:896: too many arguments to function 
`blk_init_queue'
make[2]: *** [drivers/block/paride/pd.o] Error 1
make[1]: *** [drivers/block/paride] Error 2
make: *** [drivers] Error 2


Any helpful pointers or fixes would be greatly appreciated.

_________________________________________________________________
STOP MORE SPAM with the new MSN 8 and get 2 months FREE*  
http://join.msn.com/?page=features/junkmail


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
