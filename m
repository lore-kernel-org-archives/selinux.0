Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r31Fwkco022006
	for <selinux@tycho.nsa.gov>; Mon, 1 Apr 2013 11:58:46 -0400
Message-ID: <5159AEA8.2090004@tresys.com>
Date: Mon, 1 Apr 2013 11:58:32 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: Laurent Bigonville <bigon@debian.org>
CC: <selinux@tycho.nsa.gov>
Subject: Re: File context not applied due to regex ordering
References: <20130321123256.198ba5b6@soldur.bigon.be>
In-Reply-To: <20130321123256.198ba5b6@soldur.bigon.be>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 03/21/13 07:32, Laurent Bigonville wrote:
> Hello,
> 
> I remember that I already talk about this on IRC a while back, but I
> don't remember if there was any outcome.
> 
> The refpolicy is containing the following filecontext:
> 
> /usr/(s)?bin/gdm(3)?    --      gen_context(system_u:object_r:xdm_exec_t,s0)
> 
> But for some reasons /usr/sbin/gdm3 is labeled on disk as bin_t instead
> of xdm_exec_t. matchpathcon is giving me this:
> 
> /usr/bin/gdm	system_u:object_r:xdm_exec_t:SystemLow
> /usr/bin/gdm3	system_u:object_r:xdm_exec_t:SystemLow
> /usr/sbin/gdm	system_u:object_r:bin_t:SystemLow
> /usr/sbin/gdm3	system_u:object_r:bin_t:SystemLow
> 
> Changing the regex to /usr/s?bin/gdm(3)? fix the issue.
> 
> Shouldn't this be fixed in the userspace libraries?

I'm not clear; are you saying this is a file context sorting issue or a matchpathcon error?  Matchpathcon should be able to handle a regex with ()? so I'd guess its a sorting issue.  Since sorting file contexts is tricky, it would probably be simpler to fix the policy.

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
