Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6OFXjgA017351
	for <selinux@tycho.nsa.gov>; Sun, 24 Jul 2005 11:33:47 -0400 (EDT)
Received: from web34310.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id j6OFSbgA007214
	for <selinux@tycho.nsa.gov>; Sun, 24 Jul 2005 15:28:37 GMT
Message-ID: <20050724152822.95995.qmail@web34310.mail.mud.yahoo.com>
Date: Sun, 24 Jul 2005 08:28:22 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: Iptables discussion
To: James Morris <jmorris@redhat.com>, Daniel J Walsh <dwalsh@redhat.com>
Cc: gyurdiev@redhat.com, Joshua Brindle <jbrindle@tresys.com>,
   Karl MacMillan <kmacmillan@tresys.com>, selinux@tycho.nsa.gov
In-Reply-To: <Lynx.SEL.4.62.0507240048310.16350@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



--- James Morris <jmorris@redhat.com> wrote:


> > MLS System, wants to have two Apache systems,  One
> listening at port 80 for 
> > Top Secret communications, another at port 81 for
> secret.  How do you do 
> > this?
> 
> IPsec is likely the best way to do this

IPsec is an important part of the "correct"
solution but it requires that the application
is aware of IPsec and takes advantage of it
and can be trusted to do so properly. There
are many examples (web serving is one) of
applications that you don't really want to
muck with the internals of (and the maintainers
ain't gonna let you anyhow) that work just
fine in a server-per-label scheme. At least,
that's true for B&L+Biba. There are many
deployed examples, which is where I suspect
the original questino can from.



Casey Schaufler
casey@schaufler-ca.com

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
