Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9AEsbWt003826
	for <selinux@tycho.nsa.gov>; Fri, 10 Oct 2003 10:54:37 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9AEsY0p026276
	for <selinux@tycho.nsa.gov>; Fri, 10 Oct 2003 14:54:34 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h9AEsXr7026273
	for <selinux@tycho.nsa.gov>; Fri, 10 Oct 2003 14:54:33 GMT
Subject: Re: newrules.pl -o option
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: Dale Amon <amon@vnl.com>, selinux@tycho.nsa.gov
In-Reply-To: <200310110040.30023.russell@coker.com.au>
References: <200310090124.AA01358@ilios104.ori.hitachi-sk.co.jp>
	 <200310102116.16958.russell@coker.com.au>
	 <1065793227.8181.426.camel@moss-spartans.epoch.ncsc.mil>
	 <200310110040.30023.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1065797671.8181.449.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 10 Oct 2003 10:54:31 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2003-10-10 at 10:40, Russell Coker wrote:
> audit2allow is a clearer explanation of what the program does, and is also 
> less likely to be ambiguous.  I think that /usr/bin/audit2allow is a 
> reasonable name.

Ok.  Another question is whether we should leave it as part of the
policy package or whether it should be moved over to the policycoreutils
package.  

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
