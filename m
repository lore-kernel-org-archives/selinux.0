Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h91DHcsJ024851
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2003 09:17:38 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h91DFoZt027616
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2003 13:15:50 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h91DFoM3027613
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2003 13:15:50 GMT
Subject: Re: makemap
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200310012113.44940.russell@coker.com.au>
References: <200310012113.44940.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1065014251.350.20.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 01 Oct 2003 09:17:31 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-10-01 at 07:13, Russell Coker wrote:
> /usr/bin/makemap                system_u:object_r:sbin_t
> 
> What is the above entry in types.fc about?  Is there a hard-link between a 
> file in /usr/sbin and /usr/bin?

IIRC, this was a hard link to /usr/sbin/makemap in an older version of
RH, but it appears to now be a symlink, so this isn't really necessary
anymore.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
