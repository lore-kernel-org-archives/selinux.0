Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA01966
	for <selinux@tycho.nsa.gov>; Mon, 3 Mar 2003 11:42:24 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id QAA26931
	for <selinux@tycho.nsa.gov>; Mon, 3 Mar 2003 16:39:07 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id QAA26927
	for <selinux@tycho.nsa.gov>; Mon, 3 Mar 2003 16:39:06 GMT
Message-Id: <200303031649.LAA18340@moss-shockers.ncsc.mil>
Date: Mon, 3 Mar 2003 11:49:51 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: Core policy, third pass
To: wsalamon@tislabs.com, selinux@tycho.nsa.gov, russell@coker.com.au
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Russell Coker wrote:
> Also while re-tagging it I suggest that we merge pump.te and dhcpc.te into a 
> single policy file.  I don't think that we have a need to protect pump and 
> dhclient from each other as they both have essentially the same access.
> 
> I plan to re-write the dhcpc.te file soon in such a way that it'll do all you 
> need for pump.  This re-tagging will be a good opportunity to remove pump.te

I would expect this kind of change to occur after the audit and
reduction of the core policy, while doing a similar audit and reduction
for each of the non-core domains (as well as fixing them to deal with
changes to the global macros).

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
