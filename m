Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9KDd17I009126
	for <selinux@tycho.nsa.gov>; Fri, 20 Oct 2006 09:39:01 -0400
Received: from aplesnation.dom1.jhuapl.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9KDcIAO003248
	for <selinux@tycho.nsa.gov>; Fri, 20 Oct 2006 13:38:18 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: rpm throws error with selinux enabled
Date: Fri, 20 Oct 2006 09:39:01 -0400
Message-ID: <7B95239DDD54E54B9BFA23847142B1EE12CBB8@aplesnation.dom1.jhuapl.edu>
From: "Osborn, Justin D." <Justin.Osborn@jhuapl.edu>
To: "abcde efghi" <svmdcv@gmail.com>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an old issue where SELinux was enforcing something even when it
was disabled.  The details escape me but essentially it prevented rpm
from running scripts that contained ldconfig in the post install script.
I had the same problem and had a dickens of a time tracking it down
because it's such an odd symptom.  Updating to a newer kernel/libselinux
(or new RHEL4 update) should do the trick.

Justin 

-----Original Message-----
From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov]
On Behalf Of Daniel J Walsh
Sent: Thursday, October 19, 2006 10:20 AM
To: abcde efghi
Cc: selinux@tycho.nsa.gov; Stephen Smalley
Subject: Re: rpm throws error with selinux enabled

abcde efghi wrote:
> on rhel4 u3 x86_64 2.6.9-34.ELsmp kernel , when selinux is enabled, 
> rpm installation gives the error:
> 'scriptlet failed, exit status 255'
>
> The default selinux settings are used
> #cat /etc/sysconfig/selinux
> SELINUX=enforcing
> SELINUXTYPE=targeted
>
> e.g. on installing asm rpms:
> # rpm -ivh *.rpm
> Preparing...
###########################################
> @ [100%]
> @    1:oracleasm-support
###########################################
> 33%
> error: %post(oracleasm-support-2.0.2-1.x86_64) scriptlet failed, exit 
> status
> 255
>    
> 2:oracleasm-2.6.9-34.ELsm###########################################
> 67%]
> error: %post(oracleasm-2.6.9-34.ELsmp-2.0.2-1.x86_64) scriptlet 
> failed, exit status 255
>    3:oracleasmlib           ##########################################
> [100%]
> .
> However, asm rpms gets installed
> # rpm -qa | grep asm
> oracleasm-support-2.0.2-1
> oracleasmlib-2.0.2-1
> oracleasm-2.6.9-34.ELsmp-2.0.2-1
>
> any help most welcome
>
This type of question is better off asked on the fedora-selinux list.  
If you are using Fedora :^)
Are you seeing any AVC messages in /var/log/messages?  What policy
version are you running?

> --
> This message was distributed to subscribers of the selinux mailing
list.
> If you no longer wish to subscribe, send mail to 
> majordomo@tycho.nsa.gov with the words "unsubscribe selinux" without 
> quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
