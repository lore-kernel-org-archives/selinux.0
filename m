Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id DAA08444
	for <selinux@tycho.nsa.gov>; Wed, 7 Mar 2001 03:16:26 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id IAA04840
	for <selinux@tycho.nsa.gov>; Wed, 7 Mar 2001 08:16:17 GMT
Received: from pandora.shad0w.org (shad0w.dial.nildram.co.uk [195.112.18.51])
	by jazzband.ncsc.mil  with ESMTP id IAA04836
	for <selinux@tycho.nsa.gov>; Wed, 7 Mar 2001 08:16:16 GMT
Received: from monolith.sanctum.shad0w.org ([10.2.0.4] ident=shadow)
	by pandora.shad0w.org with esmtp (Exim 3.16 #2)
	id 14aZ23-0001vr-00
	for selinux@tycho.nsa.gov; Wed, 07 Mar 2001 08:10:51 +0000
Date: Wed, 7 Mar 2001 03:12:55 -0500 (EST)
From: Chris Crowther <shadow@shad0w.org>
To: selinux@tycho.nsa.gov
Subject: Re: Thoughts on the list...
In-Reply-To: <saa4e866.078@my.snu.edu>
Message-ID: <Pine.LNX.4.21.0103070309110.28850-100000@monolith.sanctum.shad0w.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

On Tue, 6 Mar 2001, Joshua Brindle wrote:

> Why not filter on the To: field? <selinux@tycho.nsa.gov> 

	I personaly just use a procmail filter:

	:0:
	* ^TO_selinux@tycho.nsa.gov
	security.nsa.SEL

	Works fine for me, the ^TO_ procmail rule will catch the address
anywhere in the To:, Cc: or Fwd-To: headers.

-- 
Chris Crowther
shad0w@shad0w.org
http://www.shad0w.org.uk/


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
