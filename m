Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k880mhUf031805
	for <selinux@tycho.nsa.gov>; Thu, 7 Sep 2006 20:48:43 -0400
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k880lu0q029955
	for <selinux@tycho.nsa.gov>; Fri, 8 Sep 2006 00:47:57 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: KaiGai Kohei <kaigai@kaigai.gr.jp>
Subject: Re: [RFC] SELinux and PostgreSQL
Date: Fri, 8 Sep 2006 10:48:36 +1000
Cc: Joshua Brindle <jbrindle@tresys.com>, selinux@tycho.nsa.gov
References: <44FFEB42.90203@kaigai.gr.jp> <200609072324.51487.russell@coker.com.au> <45002CA4.40907@kaigai.gr.jp>
In-Reply-To: <45002CA4.40907@kaigai.gr.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200609081048.39569.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 08 September 2006 00:28, KaiGai Kohei <kaigai@kaigai.gr.jp> wrote:
> The reason of this decision is that we cannot enforce SELinux's access
> controls to any tables, columns and rows, even if the proxy server rewrite
> SQL statement.

You want to label columns AND rows?

How is that going to work?  I can understand the desire for this (EG have a 
password column in the user table), but the mechanism of enforcing this will 
be tricky to say the least.  Will you perform two access checks on each cell, 
one for column and one for row?

-- 
http://etbe.blogspot.com/          My Blog
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
