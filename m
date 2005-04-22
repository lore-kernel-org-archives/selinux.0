Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3MCbxJR015449
	for <selinux@tycho.nsa.gov>; Fri, 22 Apr 2005 08:37:59 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3MCU3rf005891
	for <selinux@tycho.nsa.gov>; Fri, 22 Apr 2005 12:30:03 GMT
Subject: Re: policy hierarchy patch
From: Joshua Brindle <jbrindle@tresys.com>
To: russell@coker.com.au
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <200504221152.39180.russell@coker.com.au>
References: <1112631282.19526.18.camel@localhost>
	 <200504221152.39180.russell@coker.com.au>
Content-Type: text/plain
Date: Fri, 22 Apr 2005 08:32:37 -0400
Message-Id: <1114173157.9531.8.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-04-22 at 11:52 +1000, Russell Coker wrote:
> On Tuesday 05 April 2005 02:14, Joshua Brindle <jbrindle@tresys.com> wrote:
> > 	type apache;
> > 	type apache.cgi;
> > 	type apache.cgi.user;
> 
> This is a bad example.  Currently the domains for user CGI scripts have access 
> that the main Apache domain lacks.  I expect it to be common that a less 
> privileged process will be granted access to files that have low integrity 
> and therefore it's access will not be a sub-set of the more privileged domain 
> that launches it.
> 

Right, I guess I could have flushed the example out a bit more but the
intention was that the type "apache" is really an unused domain that has
the privileges of all the apache processes (including cgi's). The type
"apache.main" could then be the main processes domain and would have a
subset of the permissions of apache and possibly apache.cgi.

Joshua Brindle


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
