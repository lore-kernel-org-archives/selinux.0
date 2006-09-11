Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8B08LhA031844
	for <selinux@tycho.nsa.gov>; Sun, 10 Sep 2006 20:08:22 -0400
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8B07V1c018942
	for <selinux@tycho.nsa.gov>; Mon, 11 Sep 2006 00:07:32 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Joshua Brindle <method@gentoo.org>
Subject: Re: [RFC] SELinux and PostgreSQL (draft v2)
Date: Mon, 11 Sep 2006 10:08:06 +1000
Cc: Richard Hally <rhally@mindspring.com>, KaiGai Kohei <kaigai@kaigai.gr.jp>,
        selinux@tycho.nsa.gov
References: <44FFEB42.90203@kaigai.gr.jp> <45045046.40905@mindspring.com> <45045913.5080500@gentoo.org>
In-Reply-To: <45045913.5080500@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-2022-jp"
Message-Id: <200609111008.11243.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 11 September 2006 04:27, Joshua Brindle <method@gentoo.org> wrote:
> You can do privilege separation in the database system via process
> labels instead of only by dbms role. This is analogous to using fine
> grained types to break up root privileges.

Which also means that if two domains are not permitted to share data via files 
on disk then we can also be assured that they can't share data via the 
database.  As we want to be able to analyse policy and prove that it meets 
our security goals this is quite important.  Even if two users had different 
DBMS roles and the SE Linux access controls merely enforced the same access 
controls as the standard DBMS access control this would provide a benefit 
that would justify the existence of MAC support in the database for some 
users.

-- 
http://etbe.blogspot.com/          My Blog
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
