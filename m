Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA03525
	for <selinux@tycho.nsa.gov>; Mon, 3 Mar 2003 13:31:00 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id SAA05332
	for <selinux@tycho.nsa.gov>; Mon, 3 Mar 2003 18:27:43 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id SAA05328
	for <selinux@tycho.nsa.gov>; Mon, 3 Mar 2003 18:27:42 GMT
Message-Id: <200303031838.NAA18412@moss-shockers.ncsc.mil>
Date: Mon, 3 Mar 2003 13:38:35 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: Core policy, third pass
To: wsalamon@tislabs.com
Cc: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Stephen Smalley wrote:
> As a side note, netutils.te should likely be split up into separate
> domains for the differing needs of these utilities, and some of the
> other networking utilities should likely be placed into one of these
> domains.  The current netutils.{te,fc} isn't very well-defined.
> We should likewise look into whether the existing ping.te and traceroute.te
> domains should be folded into a single 

Sorry, I sent this message prematurely.  To complete and correct the
above thought, when partitioning netutils.te into multiple domains and
grouping related network utilities together, we might want to see
whether each of ping.te and traceroute.te might be folded into one of
the resulting domains.  However, it may be desirable to keep them
separate from each other due to differences in their permission sets.

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
