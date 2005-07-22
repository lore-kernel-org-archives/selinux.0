Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6MJ1QgA008705
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 15:01:26 -0400 (EDT)
Received: from web34312.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id j6MItoKk002989
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 18:55:50 GMT
Message-ID: <20050722185638.46506.qmail@web34312.mail.mud.yahoo.com>
Date: Fri, 22 Jul 2005 11:56:38 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: RE: Iptables discussion
To: Frank Mayer <mayerf@tresys.com>,
   "'Karl MacMillan'" <kmacmillan@tresys.com>,
   "'Daniel J Walsh'" <dwalsh@redhat.com>, gyurdiev@redhat.com
Cc: "'Joshua Brindle'" <jbrindle@tresys.com>, selinux@tycho.nsa.gov
In-Reply-To: <200507221611.j6MGBcvx018097@gotham.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



--- Frank Mayer <mayerf@tresys.com> wrote:


> I think Karl's point, which I believe Chad also
> made, is that for most "MLS"
> applications with 2 interfaces (e.g., guards), the
> whole interfaces are
> treated differently (e.g., a low interface and a
> high interface), and
> port/host level access is not the central MLS issue.

TE does have a certain appeal for guard
applications. Guard applications are in
fact one of the important class of applications
for which MLS systems are traditionally
used. For guard applications the "MLS issue"
is internal to the application.



Casey Schaufler
casey@schaufler-ca.com


		
____________________________________________________
Start your day with Yahoo! - make it your home page 
http://www.yahoo.com/r/hs 
 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
