Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l12GG7ow028386
	for <selinux@tycho.nsa.gov>; Fri, 2 Feb 2007 11:16:07 -0500
Received: from ultra1.univ-paris12.fr (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l12GH4x3028773
	for <selinux@tycho.nsa.gov>; Fri, 2 Feb 2007 16:17:05 GMT
Message-ID: <45C363A6.8000703@univ-paris12.fr>
Date: Fri, 02 Feb 2007 17:15:34 +0100
From: Catalin DIMA <dima@univ-paris12.fr>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
CC: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: DWARF2 [was : Problems installing refpolicy with FC6]
References: <45BE44FC.8080303@univ-paris12.fr> <45BE4FC6.4090502@mentalrootkit.com> <45BE6262.5080902@univ-paris12.fr> <45BE68BF.3030607@mentalrootkit.com> <20070129225708.M77854@ssl.univ-paris12.fr> <45BF5BB1.1010603@mentalrootkit.com>
In-Reply-To: <45BF5BB1.1010603@mentalrootkit.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Having a little more time to try to solve the problem, I checked again 
several solutions, especially the following :
- relabeled file system
- rebooted without X in refpolicy, _permissive_ mode
and got a pretty looking DWARF2 unwinding... >:-(
As I never encountered such debugging problems, can someone tell me how 
could I "catch it" in some logfile, at least to post it  ? there's no 
trace of the debugging information in either dmesg or messages.

Catalin.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
