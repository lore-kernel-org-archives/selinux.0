Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA12022
	for <selinux@tycho.nsa.gov>; Tue, 16 Jul 2002 07:32:42 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id LAA00623
	for <selinux@tycho.nsa.gov>; Tue, 16 Jul 2002 11:32:02 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id LAA00619
	for <selinux@tycho.nsa.gov>; Tue, 16 Jul 2002 11:32:01 GMT
Date: Tue, 16 Jul 2002 07:32:01 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Ryan Emge <emger@norwich.edu>
cc: <selinux@tycho.nsa.gov>
Subject: Re: XDM with SE Linux
In-Reply-To: <20020715094822.63805dbc.emger@norwich.edu>
Message-ID: <Pine.GSO.4.33.0207160724560.23767-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 15 Jul 2002, Ryan Emge wrote:

>  Is there anyone here successfully running XDM with their SE Linux
> system? If you have both working together please contact me as I'm
> interested in how you went about it.

To use an X Display Manager with SELinux, you need a patched [xgk]dm to
set the security context for the user session, as noted in selinux/README.
You can alternatively run X via startx after a normal login, which is what
I typically do.  We do not provide a patched [xgk]dm, but Mark Westerman
has a patched gdm available from the sourceforge selinux project site
(www.sf.net/projects/selinux), and Russell Coker has a patched kdm
available from his site (http://www.coker.com.au/selinux/kdm).

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
