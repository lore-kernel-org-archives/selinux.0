Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBAGXrIi021298
	for <selinux@tycho.nsa.gov>; Fri, 10 Dec 2004 11:33:53 -0500 (EST)
Received: from web50209.mail.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id iBAGWFwg006517
	for <selinux@tycho.nsa.gov>; Fri, 10 Dec 2004 16:32:16 GMT
Message-ID: <20041210163357.14110.qmail@web50209.mail.yahoo.com>
Date: Fri, 10 Dec 2004 08:33:57 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: Single home directory type for all roles.
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <41B9AE1D.1020305@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Daniel J Walsh <dwalsh@redhat.com> wrote:

> Ok I succumb.    I will not fight the battle any
> longer, but I believe 
> that average people will not user roles because it
> is too difficult.

Roles are *hard*. The best scheme we ever came up
with in the B1/CMW era was to devote a role to each
MAC label that the system used. Thus, system
information that was not sensitive (e.g. /etc/passwd)
was associated with one role, system information
that was sensitive (e.g. /etc/shadow) got another,
and audit trail file got a third. We ended up
trashing the whole role model because it made
working with name services too difficult. Oh, and
the first question out of every customer's mouth was
"How do I get real root"?



=====
Casey Schaufler
casey@schaufler-ca.com


		
__________________________________ 
Do you Yahoo!? 
Meet the all-new My Yahoo! - Try it today! 
http://my.yahoo.com 
 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
