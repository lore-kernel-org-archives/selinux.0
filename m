Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA27546
	for <selinux@tycho.nsa.gov>; Thu, 25 Oct 2001 18:49:07 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id WAA28890
	for <selinux@tycho.nsa.gov>; Thu, 25 Oct 2001 22:48:32 GMT
Received: from localhost.localdomain (fdslppp21.dnvr.uswest.net [63.225.20.21])
	by jazzband.ncsc.mil  with ESMTP id WAA28886
	for <selinux@tycho.nsa.gov>; Thu, 25 Oct 2001 22:48:32 GMT
Date: Thu, 25 Oct 2001 16:31:56 -0600 (MDT)
From: Dave Nielsen <dave@technogeeks.com>
To: Stephen Smalley <sds@tislabs.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: Problems with install
In-Reply-To: <Pine.GSO.4.33.0110250849250.11191-100000@raven>
Message-ID: <Pine.LNX.4.33.0110251622350.1787-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 25 Oct 2001, Stephen Smalley wrote:

|
|On Wed, 24 Oct 2001, Dave Nielsen wrote:
|
|> What about breaking the instructions into two files and have the README
|> point the user to the file that goes with the build that he is wanting.
|
|The problem with this approach is that most of the INSTALLING instructions
|are identical for the two cases, so there would be a lot of duplication.
|I suppose you could just split the BUILDING instructions and leave the
|INSTALLING instructions alone, but then you have multiple files that have
|to be read to do a build and install.
|
|Anyway, this is a lot of trouble for an option that we don't really
|support (using SELinux as a separately loaded module rather than building
|it into the kernel), so we could just drop these instructions entirely.

Removing that section would be the best. I spent sometime on my proposel
and found that 95% of it was the same and came to that same concluesion.
Seeing that I was the one that brought it up I figures I should at least
give it a shot.

Dave


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
