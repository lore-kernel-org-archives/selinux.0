Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA23580
	for <selinux@tycho.nsa.gov>; Wed, 7 Aug 2002 07:45:59 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id LAA16654
	for <selinux@tycho.nsa.gov>; Wed, 7 Aug 2002 11:45:04 GMT
Received: from smails.columbia.tresys.com ([66.200.42.2])
	by jazzswing.ncsc.mil  with ESMTP id LAA16650
	for <selinux@tycho.nsa.gov>; Wed, 7 Aug 2002 11:45:03 GMT
From: "david caplan" <dac@tresys.com>
To: "Russell Coker" <russell@coker.com.au>,
        "Samarth Sharma" <samarth7880@rediffmail.com>, <selinux@tycho.nsa.gov>
Subject: RE: adduser??
Date: Wed, 7 Aug 2002 07:47:41 -0400
Message-ID: <GBEAJBKHFOBIBBJBCGAGCEEKCEAA.dac@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <20020807110516.851CE19A4@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

You can also use our seuser tool, included in the download at the bottom of
http://www.tresys.com/selinux.html.  It makes sure that you've done the
appropriate things when adding a user.  It will also examine all of the
users defined in the policy and indicate if they are well formed with
respect to the policy.  The help file and a screen shot are also available
on the above page.

David

-----Original Message-----
From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov]On
Behalf Of Russell Coker
Sent: Wednesday, August 07, 2002 7:05 AM
To: Samarth Sharma; selinux@tycho.nsa.gov
Subject: Re: adduser??


On Wed, 7 Aug 2002 12:21, Samarth  Sharma wrote:
>   i wish to add another user in the system with sysadm_r role and
> priviliges.what is the procedure for doing so??
> i tried adding to the a new user with sysadm_r role to
> /policy/users file but it still used the default context for that

You have to edit /etc/security/default_context.

Also you may want to change the file_context/types.fc to use the
sysadm_home_t for the home directory of the user in question and use
setfiles
to apply the change.


Russell Coker

--
You have received this message because you are subscribed to the selinux
list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
the words "unsubscribe selinux" without quotes as the message.


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
