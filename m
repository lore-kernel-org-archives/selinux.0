Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o3DLtLHP032513
	for <selinux@tycho.nsa.gov>; Tue, 13 Apr 2010 17:55:21 -0400
Received: from g6t0186.atlanta.hp.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o3DLspVY009398
	for <selinux@tycho.nsa.gov>; Tue, 13 Apr 2010 21:54:52 GMT
From: Paul Moore <paul.moore@hp.com>
To: "Benedict, Phillip M" <phillip.m.benedict@lmco.com>
Subject: Re: MLS telnet question
Date: Tue, 13 Apr 2010 17:54:58 -0400
Cc: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>,
        "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
References: <6235CF4DC66FD5478F0E350E17C202FF251F2BB146@HVXMSP3.us.lmco.com> <20100413164236.GE16595@myhost.felk.cvut.cz>
In-Reply-To: <20100413164236.GE16595@myhost.felk.cvut.cz>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201004131754.58738.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 13 April 2010 12:42:36 pm Michal Svoboda wrote:
> Benedict, Phillip M wrote:
> >    The network does not carry any cipso data for evaluation by my
> >    server, so I don’t think I can use netlabel.
> 
> You can use the fallback label feature that can assign labels statically
> per remote IP.

NetLabel fallback/static label example configuration:

 * http://paulmoore.livejournal.com/1758.html

-- 
paul moore
linux @ hp


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
