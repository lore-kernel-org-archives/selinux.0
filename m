Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i2GHdhRb021141
	for <selinux@tycho.nsa.gov>; Tue, 16 Mar 2004 12:39:43 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i2GHbw6Q014810
	for <selinux@tycho.nsa.gov>; Tue, 16 Mar 2004 17:37:58 GMT
Received: from mail.gmx.net (mail.gmx.de [213.165.64.20])
	by jazzswing.ncsc.mil  with SMTP id i2GHbv5t014807
	for <selinux@tycho.nsa.gov>; Tue, 16 Mar 2004 17:37:57 GMT
From: Carsten Grohmann <carstengrohmann@gmx.de>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: newrole failed in enforcing mode
Date: Tue, 16 Mar 2004 18:39:13 +0100
References: <200403101650.07042.carstengrohmann@gmx.de>
In-Reply-To: <200403101650.07042.carstengrohmann@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200403161839.13748.carstengrohmann@gmx.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mittwoch, 10. März 2004 16:50, Carsten Grohmann wrote:

[...]

Today I used strace to localize my pam problem and I get follow 
output:
2226  execve("/usr/bin/newrole", ["/usr/bin/newrole", "-r", 
"staff_r"], [/* 20 vars */]) = 0
2226  +++ killed by SIGKILL ++

"killed by SIGKILL" - which process send a sigkill only in the 
enforcing mode? In the permissive mode it runs and I don't get avc 
messages.

I use strace with various prgrams successfull:
- strace newrole in permissive mode
- strace ps ax --context in permissive and enforcing mode
But an strace of passwd failed in the enforcing mode with an similar 
output?

Could it be that the pam libraries are reason of this behavior?
Have anybody an idea to encircle this problem?

Thanks

Carsten




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
