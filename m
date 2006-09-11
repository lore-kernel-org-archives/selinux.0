Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8BGNgiL022162
	for <selinux@tycho.nsa.gov>; Mon, 11 Sep 2006 12:23:43 -0400
Received: from pop04.mail.atl.earthlink.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8BGMqsx021746
	for <selinux@tycho.nsa.gov>; Mon, 11 Sep 2006 16:22:52 GMT
Message-ID: <45058D45.2090909@mindspring.com>
Date: Mon, 11 Sep 2006 12:22:29 -0400
From: Richard Hally <rhally@mindspring.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: Joshua Brindle <method@gentoo.org>, KaiGai Kohei <kaigai@kaigai.gr.jp>,
        selinux@tycho.nsa.gov
Subject: Re: [RFC] SELinux and PostgreSQL (draft v2)
References: <44FFEB42.90203@kaigai.gr.jp> <45045046.40905@mindspring.com> <45045913.5080500@gentoo.org> <200609111008.11243.russell@coker.com.au>
In-Reply-To: <200609111008.11243.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:
> On Monday 11 September 2006 04:27, Joshua Brindle <method@gentoo.org> wrote:
>> You can do privilege separation in the database system via process
>> labels instead of only by dbms role. This is analogous to using fine
>> grained types to break up root privileges.
> 
> Which also means that if two domains are not permitted to share data via files 
> on disk then we can also be assured that they can't share data via the 
> database.  As we want to be able to analyse policy and prove that it meets 
> our security goals this is quite important.  Even if two users had different 
> DBMS roles and the SE Linux access controls merely enforced the same access 
> controls as the standard DBMS access control this would provide a benefit 
> that would justify the existence of MAC support in the database for some 
> users.
> 
Thanks guys! It *will* add additional features (e.g. MLS) that are
unlikely to be included in the existing "roles and privileges".
This seems like the perfect use for a user space security server.
Any prognostication as to when that might appear?

Richard


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
