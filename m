Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i35CMGRb022012
	for <selinux@tycho.nsa.gov>; Mon, 5 Apr 2004 08:22:16 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i35CKIUZ009689
	for <selinux@tycho.nsa.gov>; Mon, 5 Apr 2004 12:20:18 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i35CKHmT009686
	for <selinux@tycho.nsa.gov>; Mon, 5 Apr 2004 12:20:17 GMT
Subject: Re: role of pax
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Rogelio Serrano <rogelio@smsglobal.net>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <62a9a88a4e1ed0d0d1cd1c3beb953026@debian>
References: <62a9a88a4e1ed0d0d1cd1c3beb953026@debian>
Content-Type: text/plain
Message-Id: <1081167726.5343.20.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 05 Apr 2004 08:22:06 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-04-05 at 05:45, Rogelio Serrano wrote:
> Hi i just rebuilt an selinux + pax system on uclibc. Now im 
> beginning to consider  taking out pax since it breaks the GNU 
> obective-c runtime. What is the significance of pax?

See the papers available from http://pax.grsecurity.net/docs/.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
