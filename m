Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9ADeYWt003124
	for <selinux@tycho.nsa.gov>; Fri, 10 Oct 2003 09:40:35 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9ADeV0p019488
	for <selinux@tycho.nsa.gov>; Fri, 10 Oct 2003 13:40:31 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h9ADeUr7019485
	for <selinux@tycho.nsa.gov>; Fri, 10 Oct 2003 13:40:30 GMT
Subject: Re: newrules.pl -o option
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: Dale Amon <amon@vnl.com>, selinux@tycho.nsa.gov
In-Reply-To: <200310102116.16958.russell@coker.com.au>
References: <200310090124.AA01358@ilios104.ori.hitachi-sk.co.jp>
	 <20031010090846.5bdaf336.ynakam@ori.hitachi-sk.co.jp>
	 <20031010082834.GA31227@vnl.com>  <200310102116.16958.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1065793227.8181.426.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 10 Oct 2003 09:40:27 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2003-10-10 at 07:16, Russell Coker wrote:
> Also "newrules" is not a good choice of name.  There are potentially hundreds 
> of things on a Unix system that have rules and which may have new rules 
> generated.  On Debian systems it is currently /usr/bin/newrules-selinux, I 
> think that's an ideal name for it.

Not clear you need a '-selinux' suffix for SELinux-related programs; we
certainly haven't done that for other SELinux utilities (e.g.
checkpolicy, load_policy).  Other possible names might be:
	genpol (generate policy)
	audit2allow (convert audit messages to allow rules)

If you feel the need to include some kind of SELinux distinguisher,
perhaps you can just use a 'sel' prefix, e.g.
	selnewrules
	selgenpol
	selaudit2allow

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
