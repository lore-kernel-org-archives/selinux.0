Date: Tue, 22 Jan 2002 17:15:07 -0500
From: forrest whitcher <fw@fwsystems.com>
To: <SELinux@tycho.nsa.gov>
Subject: switching between SE Linux utils - kernel versions ? ... also ntp
Message-Id: <20020122171507.060a9821.fw@fwsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


A note on NTP: ntpd / ntpdate on my selinux installation has (surprsingly) not
raised any AVC: messages in develop/permissive mode. Does this suggest that
setting system time is not LSM / SEL hooked?


I'll be updating to 2.4.17 shortly, wondered what is the safe matrix for 
mixing versions?

If I need to still sometimes boot the .12 kernel will it be able to deal 
with PSID's left by .17? and are the .17 version utils likely to cause
problems on .12 kernel?

>From all I've read I'll be happy to have .17 in place and not look back,
but thought it would be prudent to check for possible gotcha's

forrest


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
