Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o14JS5U2001946
	for <selinux@tycho.nsa.gov>; Thu, 4 Feb 2010 14:28:05 -0500
Received: from authsmtp.register.it (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o14JRtBS020138
	for <selinux@tycho.nsa.gov>; Thu, 4 Feb 2010 19:27:55 GMT
Subject: Re: [PATCH] Allowing MLS->non-MLS and vice versa upon policy reload
From: Guido Trentalancia <guido@trentalancia.com>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Thu, 04 Feb 2010 20:27:55 +0100
Message-Id: <1265311675.3007.17.camel@tesla.lan>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Eric,

thanks for your comments. Unfortunately you are commenting an old
version of the patch.

The latest version of the "initial SIDs loading" patch was posted on
Wed, 03 Feb 2010 at 12:59:13 -0500 (18:59 CET).

The latest version of the "runtime switching between different policy
types" was posted on Wed, 03 Feb 2010 at 16:40:20 +0100.

And they've both been commited already by James Morris on Thu, 4 Feb
2010 at 09:07:38 +1100 (EST) (Wed, 23:07 CET).

The comment about the boolean has been removed by Stephen, I was just
following the other comments. Of course, that's an integer but
functionally it represents a boolean (on/off). To be picky it should
have been unsigned int.

The newline issue has been fixed. I am sorry about that...

You should fix this line to match the line above that you changed ?? I
didn't get that... Do you mean tab misalignment or what ?

Regards,

Guido


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
