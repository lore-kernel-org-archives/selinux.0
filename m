Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA27599
	for <selinux@tycho.nsa.gov>; Thu, 5 Sep 2002 07:03:26 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id LAA15282
	for <selinux@tycho.nsa.gov>; Thu, 5 Sep 2002 11:01:43 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id LAA15278 for <selinux@tycho.nsa.gov>; Thu, 5 Sep 2002 11:01:41 GMT
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: bug in SE Linux / LSM
Date: Thu, 5 Sep 2002 13:03:29 +0200
Cc: linux-security-module@wirex.com
MIME-Version: 1.0
Message-Id: <200209051047.55917.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

In my tutorial yesterday a Robert Dorn <selinux@rddorn.net>
discovered a bug in the way SE Linux/LSM operates.

If you login to a virtual console as an unpriviledged user you can use 
"loadkeys" to change the keyboard mapping for everything apart from the SAK 
sequence.

This can allow you to arbitarily re-program the keyboard which can make it 
impossible to login (define it such that there is no ENTER key) or so that a 
common key performs a bad function such as "; mkfs /dev/hda".

You can do this whenever you are logged in at the console, but if there are a 
number of virtual consoles open then you could change to a console that's not 
commonly used and then run a program that takes input from the network to 
determine keyboard mappings (and then wait for someone to login at the 
console and control what they can do).

One partial solution to this is to have a getty wrapper which runs "loadkeys 
-d", which solves the problem of a hostile user remapping the keyboard and 
logging out.  But it doesn't solve the problem of a hostile user remapping 
the keyboard from a program that's still in a login session on another 
virtual console.

One potential solution to this would be to have the SAK sequence trigger a 
relabel of all the devices that have getty's to their default type before 
running "loadkeys -d".  Then you just have to get into the habit of "SAK 
before login" (which you should have anyway).

But it would be better if we could just catch such remappings in SE policy, in 
99% of all machines there is no cause for the user to remap the keyboard.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
