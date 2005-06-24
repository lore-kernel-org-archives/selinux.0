Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5OHPbgA008386
	for <selinux@tycho.nsa.gov>; Fri, 24 Jun 2005 13:25:37 -0400 (EDT)
Received: from web31606.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id j5OHP22B026870
	for <selinux@tycho.nsa.gov>; Fri, 24 Jun 2005 17:25:02 GMT
Message-ID: <20050624172536.36208.qmail@web31606.mail.mud.yahoo.com>
Date: Fri, 24 Jun 2005 10:25:35 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: RE: Alternative user management approach
To: Karl MacMillan <kmacmillan@tresys.com>, selinux@tycho.nsa.gov
In-Reply-To: <200506241704.j5OH4jqc017398@gotham.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



--- Karl MacMillan <kmacmillan@tresys.com> wrote:


> To make my suggestion more concrete, I think a
> mapping file in
> /etc/selinux/policyname that maps from users to
> SELinux users. The config would
> be an ordered list of mappings that use username and
> group information. That
> means that if the admin wants to use group info they
> can, otherwise it is
> ignored. The first match in the ordered list would
> win. Maybe something like:
> 
> id:root	sysadm
> group:wheel staff
> default	normal
> 
> There are a lot of possibilities including boolean
> logic, wildcards, etc. Not
> certain how much complexity is needed.

As a thought, how about:

userid:grouplist:policyname

where userid or grouplist can be '*' (any) and
only exact matches count. Most explicit match
is used.

    root:*:sysadm
    fred:wheel:wand
    *:wheel:staff
    *:*:normal

Fred would be in "wand" if only in group wheel,
in "normal" if in groups wheel and dev. Fun.




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
