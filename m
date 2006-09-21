Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8LG98JG017077
	for <selinux@tycho.nsa.gov>; Thu, 21 Sep 2006 12:09:08 -0400
Received: from web36612.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k8LG8ccD024352
	for <selinux@tycho.nsa.gov>; Thu, 21 Sep 2006 16:08:39 GMT
Message-ID: <20060921160852.61171.qmail@web36612.mail.mud.yahoo.com>
Date: Thu, 21 Sep 2006 09:08:52 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: Latest diffs
To: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1158850172.11048.2.camel@twoface.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



--- Joshua Brindle <jbrindle@tresys.com> wrote:

 
> > We have customers that use all of our 1024
> categories and want more. 
> > They have requested 10,000 categories.
> > 
> 
> That is because they are probably using categories
> as an integrity
> mechanism which is entirely inappropriate for
> SELinux since TE should be
> used for integrity and mls should only be used for
> confidentiality. I
> seriously doubt that a reasonable system could have
> 10000 useful
> categories.

If y'all don't support on the order of 10,000
categories I know of potential users (they may
be the same ones refered to initially) who
use a category for each "project", which is
perfectly reasonable, never reuse categories
because many "projects" have extended lifetimes
(sometimes decades), and have many projects
start every month. This is correct usage of
MLS categories. These people have been MLS
users since the Reagan administration because
it gives them what they want.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
