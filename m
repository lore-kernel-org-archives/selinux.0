Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p67EENsI029096
	for <selinux@tycho.nsa.gov>; Thu, 7 Jul 2011 10:14:24 -0400
Received: from smtp.sws.net.au (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p67EELvf010044
	for <selinux@tycho.nsa.gov>; Thu, 7 Jul 2011 14:14:22 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Eric Paris <eparis@parisplace.org>
Subject: Re: context NFS mounts
Date: Fri, 8 Jul 2011 00:14:16 +1000
Cc: "SE-Linux" <selinux@tycho.nsa.gov>
References: <201107072319.14792.russell@coker.com.au> <CACLa4pvtqfe0nL9MObusdNEF-H+3s4mtrPgONKr1BT4JH6ieiw@mail.gmail.com>
In-Reply-To: <CACLa4pvtqfe0nL9MObusdNEF-H+3s4mtrPgONKr1BT4JH6ieiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201107080014.16963.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 7 Jul 2011, Eric Paris <eparis@parisplace.org> wrote:
> I'm not sure what all the NFSv4 shared superblock magic is, but I
> think you might need to mount with nosharecache.  See if that works
> for you....

Yes, that works!  Thanks!

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
