Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5OGlFgA007959
	for <selinux@tycho.nsa.gov>; Fri, 24 Jun 2005 12:47:15 -0400 (EDT)
Received: from web31614.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id j5OGlDUD021992
	for <selinux@tycho.nsa.gov>; Fri, 24 Jun 2005 16:47:13 GMT
Message-ID: <20050624164714.15368.qmail@web31614.mail.mud.yahoo.com>
Date: Fri, 24 Jun 2005 09:47:13 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: RE: file contexts and modularity
To: Karl MacMillan <kmacmillan@tresys.com>, selinux@tycho.nsa.gov
In-Reply-To: <200506241636.j5OGauqc016824@gotham.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



--- Karl MacMillan <kmacmillan@tresys.com> wrote:


> Let's try to separate out the problems correctly.
> There are 2 issues:
> 
> 1) The current kernel avtab makes an inappropriate
> space / time tradeoff.
> 2) The current policies are not sufficiently
> designed and may have too many
> rules.
> 
> 1 can be fixed even if 2 is true, which it might be.

Is it valuable to do 1 in the face of 2?
Sorry, my pointy hair side can't see doing
much about 1 in the light of 2.

> We are trying to address that with refpolicy.

Great.

> I would encourage you to make
> concrete suggestions for the
> reference policy - one of its aims is to add the
> design component to SELinux
> policies that you are suggesting.

Err, I did in the rest of the message.

> Otherwise, your
> opinions on SELinux policies
> are clear at this point - is it doing any good to
> restate them in threads that
> are only tangentially related?

I will pull the elephant off the table
and go back to work. Sorry to have bothered
you.




Casey Schaufler
casey@schaufler-ca.com


		
__________________________________ 
Yahoo! Mail 
Stay connected, organized, and protected. Take the tour: 
http://tour.mail.yahoo.com/mailtour.html 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
