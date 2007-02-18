Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1IB3Ibx011774
	for <selinux@tycho.nsa.gov>; Sun, 18 Feb 2007 06:03:20 -0500
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1IB4VXX012552
	for <selinux@tycho.nsa.gov>; Sun, 18 Feb 2007 11:04:32 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: KaiGai Kohei <kaigai@kaigai.gr.jp>
Subject: Re: [RFC] Security design of SE-PostgreSQL (2/3)
Date: Sun, 18 Feb 2007 22:04:19 +1100
Cc: selinux@tycho.nsa.gov, jbrindle@tresys.com
References: <45D542AF.1030108@kaigai.gr.jp>
In-Reply-To: <45D542AF.1030108@kaigai.gr.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200702182204.21346.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 16 February 2007 16:35, KaiGai Kohei <kaigai@kaigai.gr.jp> wrote:
> 2. about Loadable module
>
> PostgreSQL allowed to load dynamic link library.
> It has a possibility to mess up the access control of SE-PostgreSQL no need
> to say, so we have to restrict loading them by the security policy.
>
> I have an idea to add the following access vector for the purpose.
>   1. allow (context of client)   (context of database)  
> database:load_module;
> 2. allow (context of database) (context of shlib 
> file) database:associate;

Who will be loading such modules?  Only the DBA or regular users too?

In the above access control design you control which databases a user may load 
modules for and which modules may be associated with a given database.  But 
you don't control which modules a user may load.  Is it possible that modules 
A and B may be loaded into a database but only user C will be permitted to 
load module A?

Do modules have parameters?  Or is there only one way that a module can be 
used?

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
