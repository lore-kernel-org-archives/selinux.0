Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id GAA11591
	for <selinux@tycho.nsa.gov>; Mon, 8 Oct 2001 06:15:02 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id KAA01117
	for <selinux@tycho.nsa.gov>; Mon, 8 Oct 2001 10:14:33 GMT
Received: from mrelay.jrc.it (mrelay.jrc.it [139.191.1.65])
	by jazzband.ncsc.mil  with ESMTP id KAA01113
	for <selinux@tycho.nsa.gov>; Mon, 8 Oct 2001 10:14:31 GMT
Received: from mrelay.jrc.it (localhost [127.0.0.1])
	by mrelay.jrc.it (LMC5614B) with ESMTP id f98AEvs21207
	for <selinux@tycho.nsa.gov>; Mon, 8 Oct 2001 12:14:57 +0200 (MEST)
Received: from isis-ms.sti.jrc.it (isis-gs.sti.jrc.it [139.191.8.244])
	by mrelay.jrc.it (LMC5614A) with ESMTP id f98AEks21161
	for <selinux@tycho.nsa.gov>; Mon, 8 Oct 2001 12:14:57 +0200 (MEST)
Message-ID: <3BC17C93.9080601@jrc.it>
Date: Mon, 08 Oct 2001 12:14:43 +0200
From: "James Bishop" <james.bishop@jrc.it>
MIME-Version: 1.0
To: Stephen Smalley <sds@tislabs.com>
CC: selinux@tycho.nsa.gov
Subject: Re: Compiling for SuSE 7.2
References: <Pine.GSO.4.33.0110050931280.29582-100000@raven>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thankyou for your reply, and your patience in helping me "get up to 
speed" with SELinux.

I can live without X for this project, where we have to implement a root 
certification authority for a system using public key cryptography. I'm 
interested in using Linux for the registration service of the root CA, 
and SELinux appears to be ideal for this task. So, X is neither 
required, nor desirable if it bypasses the login choke-point.

I've applied the Makefile and stack patches you recommended, and edited 
the file_contexts as you suggested, but I'm still getting a variety of 
avc denied messages.

In reply to your questions:

1) My modified login does not work on my original SuSE (7.2 running a 
2.4.4 kernel); I go through the motions of logging in, but just get 
returned to the login screen, as in SELinux.

2) The SuSE login uses PAM.

3) My /etc/security/default_context file is simply:

root:sysadm_r:sysadm_t
bishop:user_r:user_t

After running SELinux (no X), the following messages appear in 
/var/log/messages:

login: ROOT LOGIN ON tty1 USING root:sysadm_r:sysadm_t
and
login: LOGIN ON tty1 BY bishop USING bishop:user_r:user_t

and after running SuSE 7.2, in runlevel 3 (no X), /var/log/messages contains

login: ROOT LOGIN ON tty1
and
login: LOGIN ON tty1 BY bishop

Looking through the login.c source, it appears to me that this message 
results from a successful login attempt. So either something goes wrong 
in forking the shell, or my code has a bug which just causes it to exit 
before normal completion (I'll just chuck in some printf's and see what 
happens...).

By the way, sshd is not working either, but that's not an issue right now.

Stephen Smalley wrote:

>On Fri, 5 Oct 2001, James Bishop wrote:
>
>>I had that feeling that it was too easy...
>>
>>When I boot selinux (or SuSE linux) into runlevel 3 (no X), I get the
>>login prompt, I enter username and password, and then answer the query
>>about choosing a new context (in selinux only). After replying "no", I'm
>>back at the login prompt again; not the shell prompt.
>>
>>So my modified login doesn't actually work - awareness dawns (somewhat
>>slowly). I had assumed that the same login binary was used for all
>>logins to the system, but apparently X, and / or Gnome, do things
>>differently. Is this really so?
>>
>
>Yes, the X Display Manager handles login separately from the login
>program.  Likewise, sshd handles remote logins without ever running the
>login program.
>
>Does the modified login program still work when running the original SuSE
>kernel?  It is supposed to function as usual when SELinux is not running.
>If it doesn't work on the SuSE kernel, then this suggests that your
>util-linux MCONFIG is wrong for SuSE.  Does the SuSE login use PAM?
>
>If the modified login program does work when running the original SuSE
>kernel, then check /var/log/messages to see if there were any error
>messages from login.  Did you remember to edit and install the
>/etc/security/default_context file?
>
>--
>Stephen D. Smalley, NAI Labs
>ssmalley@nai.com
>
>
>
>



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
