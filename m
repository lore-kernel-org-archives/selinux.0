Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9NKDJWt011852
	for <selinux@tycho.nsa.gov>; Thu, 23 Oct 2003 16:13:19 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9NKD4IS014189
	for <selinux@tycho.nsa.gov>; Thu, 23 Oct 2003 20:13:04 GMT
Received: from mailhost.unt.edu (mailhost.unt.edu [129.120.209.40])
	by jazzswing.ncsc.mil  with ESMTP id h9NKD3Dc014186
	for <selinux@tycho.nsa.gov>; Thu, 23 Oct 2003 20:13:04 GMT
Received: from iatro (localhost.localdomain [127.0.0.1])
	by mail1 (Postfix) with SMTP id 9A07C60C68
	for <selinux@tycho.nsa.gov>; Thu, 23 Oct 2003 15:13:10 -0500 (CDT)
Received: from eaglemail.unt.edu (imp2.private.acs.unt.edu [192.168.221.72])
	by mailhost.unt.edu (Postfix) with ESMTP id 2768460ECF
	for <selinux@tycho.nsa.gov>; Thu, 23 Oct 2003 15:12:24 -0500 (CDT)
Message-ID: <1066939944.3f9836281d4ed@eaglemail.unt.edu>
Date: Thu, 23 Oct 2003 15:12:24 -0500
From: Ignacio Tripodi <ignaciot@unt.edu>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: selinux, openssh and users
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I just finished setting up a 2.6 selinux kernel environment, and noticed that I
can't ssh to it. I found in the list archives that you cannot ssh using an
admin_r user (is that still valid?) so I tried to create a regular user and
assign the user_r role to it. If I do a "seuser add -R user_r username" it says
that it couldn't modify the policy and failed to create the user. Do you know
where can I start looking for errors? The policy seems to being loaded just fine
(through initrd) and the selinux modules are up.

Also, once I am able to create a regular user, do I need to specify any
role/context parameters in order to ssh to this machine? How does the openssh
client get around this?
Thanks a lot,

Ignacio Tripodi

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
