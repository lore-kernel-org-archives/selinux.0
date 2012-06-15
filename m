Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q5FB2r4H020359
	for <selinux@tycho.nsa.gov>; Fri, 15 Jun 2012 07:02:53 -0400
Message-ID: <4FDB165B.6090806@tycho.ncsc.mil>
Date: Fri, 15 Jun 2012 07:02:51 -0400
From: rpcraig <rpcraig@tycho.ncsc.mil>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: SE Android: Middleware MAC updates
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

    A new round of updates have been pushed to our set of experimental
extensions to the Android middleware. Permission revocation has been
updated to allow policy configuration to specify revocation lists that
are applied automatically on each boot. Whereas the install-time MAC
mechanism received an overhaul. It now offers a much richer set of
install-time policy checks. Both extensions continue to remain on
experimental branches, and information about the current capabilities
can be found at:
http://selinuxproject.org/page/SEAndroid#Middleware_MAC

As always, comments and feedback are welcome.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
