Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5AKiTrT001267
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 16:44:29 -0400 (EDT)
Received: from smtp802.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i5AKiOP2026491
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 16:44:24 -0400 (EDT)
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.155.76.36 with poptime)
  by smtp802.mail.ukl.yahoo.com with SMTP; 10 Jun 2004 20:44:27 -0000
Date: Thu, 10 Jun 2004 20:41:47 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: [debian] - installation of mysqld requires chfn
Message-ID: <20040610204147.GE2861@lkcl.net>
References: <20040609222209.GH5727@lkcl.net> <200406101220.53966.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200406101220.53966.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

russell, steven - just a thought.

if you look at dpkg.te, and presumably rpm.te too, are you at all
concerned about the ever-increasing permission set that's added to
these two packages' policies?

it doesn't seem right to me that dpkg's policy file has to grant
permission to run passwd.te in order to install oh, say, foomatic-db.

it just goes against the grain of granting least privilege.

i'm just concerned that dpkg.te and rpm.te turn into these
pretty-much-everything "monsters".

so, let's see... is it possible to add something into dpkg
(se_dpkg?) to make it call run_init or do a domain_auto_trans
just before calling the postinstall / prerm etc. scripts,
to move it from dpkg.te into dpkg_<PACKAGENAME>.te?

l.

On Thu, Jun 10, 2004 at 12:20:53PM +1000, Russell Coker wrote:
> On Thu, 10 Jun 2004 08:22, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > i added the can_exec chfn_exec_t into domains/programs/dpkg.te:

> > [ to make it possible to install mysqld ]

> ifdef(`passwd.te', `
> domain_auto_trans(dpkg_t, chfn_exec_t, chfn_t)
> ')

> The above is what you want.  You don't want to allow dpkg_t direct access 
> to /etc/shadow because it will probably mess it up (replace it with a copy 
> labelled as etc_t).
> 
> -- 
> http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
> http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
> http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
> http://www.coker.com.au/~russell/  My home page

-- 
-- 
Information I post is with honesty, integrity, and the expectation that
you will take full responsibility for acting on the information contained,
and that, should you find it to be flawed or even mildly useful, you
will act with both honesty and integrity in return - and tell me.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
