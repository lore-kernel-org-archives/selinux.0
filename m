Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA23373
	for <selinux@tycho.nsa.gov>; Wed, 7 Aug 2002 07:05:28 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id LAA15283
	for <selinux@tycho.nsa.gov>; Wed, 7 Aug 2002 11:04:33 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id LAA15279
	for <selinux@tycho.nsa.gov>; Wed, 7 Aug 2002 11:04:32 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Samarth Sharma" <samarth7880@rediffmail.com>, selinux@tycho.nsa.gov
Subject: Re: adduser??
Date: Wed, 7 Aug 2002 13:05:16 +0200
References: <20020807102118.30560.qmail@webmail9.rediffmail.com>
In-Reply-To: <20020807102118.30560.qmail@webmail9.rediffmail.com>
MIME-Version: 1.0
Message-Id: <20020807110516.851CE19A4@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 7 Aug 2002 12:21, Samarth  Sharma wrote:
>   i wish to add another user in the system with sysadm_r role and
> priviliges.what is the procedure for doing so??
> i tried adding to the a new user with sysadm_r role to
> /policy/users file but it still used the default context for that

You have to edit /etc/security/default_context.

Also you may want to change the file_context/types.fc to use the 
sysadm_home_t for the home directory of the user in question and use setfiles 
to apply the change.


Russell Coker

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
