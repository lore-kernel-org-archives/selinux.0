Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5N35erT013546
	for <selinux@tycho.nsa.gov>; Tue, 22 Jun 2004 23:05:40 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5N35QAb018081
	for <selinux@tycho.nsa.gov>; Wed, 23 Jun 2004 03:05:27 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Colin Walters <walters@verbum.org>
Subject: Re: generic pam authentication
Date: Wed, 23 Jun 2004 13:05:28 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <1087940480.17038.96.camel@optimus-prime.boston.redhat.com>
In-Reply-To: <1087940480.17038.96.camel@optimus-prime.boston.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200406231305.28609.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 23 Jun 2004 07:41, Colin Walters <walters@verbum.org> wrote:
> What I think might be nice is a generic macro, say uses_pam(passwd)
> which would grant any privileges necessary to use the libraries in the
> PAM stack.  This macro would be defined in domains/pam.te, and would be
> intended for customization by the administrator.  For example, if the
> administrator decided to use PostgreSQL for holding user data, they
> could insert the necessary privileges to talk to postgresql_port_t.

That sounds like the correct approach.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
