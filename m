Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8BJFOLa018613
	for <selinux@tycho.nsa.gov>; Thu, 11 Sep 2003 15:15:24 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h8BJDlLY017937
	for <selinux@tycho.nsa.gov>; Thu, 11 Sep 2003 19:13:47 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h8BJDksG017934
	for <selinux@tycho.nsa.gov>; Thu, 11 Sep 2003 19:13:46 GMT
Received: from moss-huskies (moss-huskies [144.51.25.7])
	by epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8BJFKLX006041
	for <selinux@tycho.nsa.gov>; Thu, 11 Sep 2003 15:15:21 -0400 (EDT)
Subject: Mail list reliability
From: Howard Holm <hdholm@epoch.ncsc.mil>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Message-Id: <1063307722.29990.46.camel@moss-huskies>
Mime-Version: 1.0
Date: 11 Sep 2003 15:15:22 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm seeing an increasing number of bounces from people who aren't
receiving all the messages sent to the mailing list.  While this is a
small minority of the list subscribers it is increasingly widespread and
I suspect it will get worse.  These bounces are happening when mail
servers along the route decide that a message has been through too many
hops (has too many received headers) and must be in a loop through some
set of hosts.  The vast majority of mail servers seem to have the
maximum number of hops set to 25 (the default for sendmail, if I'm not
mistaken.)  I've seen some set as low as 15.

The problem is that as local networks grow, people are sending mail
through more local hosts to get to the Internet.  There are now often
extra hops through virus scanners and such on outbound mail.  It gets to
the mail list processors here and our processing adds a few, and
sometimes more than a few, hops before it gets sent out, then it gets to
your local network and probably goes through virus scanners, maybe
forwarded through hotmail or yahoo some other redirector and even more
hops are added.

The point of my message is that if you're experiencing dropped messages
from the list, this is a very good place to start looking.  I'd suggest
that hosts receiving mail a few hops down in their internal networks
start thinking about maybe 30 hops or more as occasionally necessary
rather than 25.  15 hops, in my humble opinion, is too few even for most
edge systems these days and will probably result in your losing at least
a few messages from this list that are sent "the long way around."

If you find you're loosing messages (typically by seeing responses to
messages you never got) and can't control the maximum number of hops
configuration on your hosts, you may want to think about trying to
minimize the route to you (i.e., not forwarding through hotmail, yahoo,
acm, extra corporate domains, etc.)

Hopefully this will help some people diagnose or avoid dropped SELinux
messages.  Since mail server configuration isn't really an SELinux
topic, send your comments and complaints to me not the list.  Thanks.

-- 
Howard Holm <hdholm@epoch.ncsc.mil>
Office of Defensive Computing Research
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
