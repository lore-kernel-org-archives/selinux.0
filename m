Message-Id: <sf0be0df.042@atlas.snu.edu>
Date: Wed, 09 Jul 2003 09:30:37 -0500
From: "Joshua Brindle" <JBrindle@snu.edu>
To: <SELinux@tycho.nsa.gov>, <wlsel@verizon.net>
Subject: Re: SELinux, KDE, and honeypots
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>The idea I had was to create a pseudo-device driver that leverages
NetFilter 
>to output all traffic from all TCP streams to a user-mode daemon that
writes 
>the packets for each stream into their own separate disk files (and
governing 
>the throughput if need be so that the transcribing daemon can keep up
with 
>the traffic).  If no security violations are reported during the
lifetime of 
>the TCP stream, then when it is closed the transcript is moved to a
directory 
>where it remains for some period of time (perhaps for auditing
purposes) 
>before being routinely deleted.

this is sorta offtopic so i'll just quickly say it would be insane to
try and
handle that with netfilter.. you can use libpcap but that would take
decades to review, your best bet is to plug in an IDS like prelude
(www.prelude-ids.org) to monitor tcp traffic for violations. we are
looking
into getting rules written for the prelude log monitor to understand
selinux avc messages so thats a plus (prelude is hybrid ids, that is
net + host ids) so you can monitor network traffic on your router
and host ids (logs, file digests, etc) on your other machines.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
