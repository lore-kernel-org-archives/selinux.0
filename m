Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA13092
	for <selinux@tycho.nsa.gov>; Mon, 19 Feb 2001 13:19:11 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id SAA03083
	for <selinux@tycho.nsa.gov>; Mon, 19 Feb 2001 18:18:55 GMT
Received: from mailhub.iastate.edu (mailhub.iastate.edu [129.186.1.102])
	by jazzswing.ncsc.mil  with ESMTP id SAA03079
	for <selinux@tycho.nsa.gov>; Mon, 19 Feb 2001 18:18:55 GMT
Message-ID: <3A91639D.3BD5A0E6@iastate.edu>
Date: Mon, 19 Feb 2001 12:19:09 -0600
From: Mark Slagell <ms@iastate.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: scontext/tcontext/tclass
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

Hi all,

Hopefully this is very basic stuff, but I'm not sure how to read some of
the error messages I'm seeing. To wit:

avc:  denied { kill } for  pid=14271 exe=/usr/sbin/identd capability=5
   scontext=system_u:system_r:inetd_child_t
   tcontext=system_u:system_r:inetd_child_t
   tclass=capability


avc:  denied  { append } for  pid=27031 exe=/usr/sbin/crond
path=/var/log/cron dev=03:01 ino=99291
   scontext=system_u:system_r:crond_t
   tcontext=system_u:object_r:xfs_tmp_t
   tclass=file


As I suspect getting these errors cleared up is a reasonable first goal
in working with selinux, I wonder if someone would point out to me the
difference between scontext and tcontext and make just one little light
bulb come on here. I've been rtfm'ing for a while here and must be
looking right at it, but it's not getting through.

  Mark



-- 
I took a course in speed reading and was able to read War and Peace in
twenty minutes.  It's about Russia.
    -- Woody Allen

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
