Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6BGY1PG024963
	for <selinux@tycho.nsa.gov>; Wed, 11 Jul 2007 12:34:01 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l6BGY0wX015850
	for <selinux@tycho.nsa.gov>; Wed, 11 Jul 2007 16:34:00 GMT
Message-ID: <46950663.5010801@tresys.com>
Date: Wed, 11 Jul 2007 12:33:39 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
CC: selinux@tycho.nsa.gov
Subject: Re: [PATCH] Initial policyrep patch v3
References: <c438376dfb35c9525c9c.1184161294@localhost.localdomain>
In-Reply-To: <c438376dfb35c9525c9c.1184161294@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Karl MacMillan wrote:
> Initial patch to create a new policyrep branch using C++. This patch includes basic classes for
> representing policy (Node and Parent), a few policy objects, a bison parser, a boost::python
> binding, and basic test infrastructure.
> 
> Includes updates based on comments from James Antill
> and Josh Brindle.
> * * *
> 
> Signed-off-by: User "Karl MacMillan <kmacmillan@mentalrootkit.com>"
> ---

Acked and merged into a new policyrep branch. Now we can have 
incremental patches instead of giant ones :)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
