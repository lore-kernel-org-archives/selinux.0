Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5BNCXrT007937
	for <selinux@tycho.nsa.gov>; Fri, 11 Jun 2004 19:12:33 -0400 (EDT)
Received: from smtp802.mail.ukl.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i5BNCU1j027512
	for <selinux@tycho.nsa.gov>; Fri, 11 Jun 2004 19:12:30 -0400 (EDT)
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.155.76.36 with poptime)
  by smtp802.mail.ukl.yahoo.com with SMTP; 11 Jun 2004 23:12:31 -0000
Date: Fri, 11 Jun 2004 23:09:50 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: [debian] - installation of mysqld requires chfn
Message-ID: <20040611230950.GK2861@lkcl.net>
References: <20040609222209.GH5727@lkcl.net> <200406101220.53966.russell@coker.com.au> <20040610204147.GE2861@lkcl.net> <200406111052.37270.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200406111052.37270.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Jun 11, 2004 at 10:52:37AM +1000, Russell Coker wrote:
> On Fri, 11 Jun 2004 06:41, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > if you look at dpkg.te, and presumably rpm.te too, are you at all
> > concerned about the ever-increasing permission set that's added to
> > these two packages' policies?
> 
> No.
 
  *grin*

> > it doesn't seem right to me that dpkg's policy file has to grant
> > permission to run passwd.te in order to install oh, say, foomatic-db.
> >
> > it just goes against the grain of granting least privilege.
> 
> We can't grant least privilege to dpkg and rpm.  By design these programs need 
> write access to every significant file on the system and can totally break 
> the system with the smallest bug.
> 
> Trying to reduce the access of such programs to the system makes no sense.
> 
> > i'm just concerned that dpkg.te and rpm.te turn into these
> > pretty-much-everything "monsters".
> 
> That's what they do!
> 
> > so, let's see... is it possible to add something into dpkg
> > (se_dpkg?) to make it call run_init or do a domain_auto_trans
> > just before calling the postinstall / prerm etc. scripts,
> > to move it from dpkg.te into dpkg_<PACKAGENAME>.te?
> 
> What good would that do?  dpkg/rpm still has full control.  They can replace 
> libc, they can replace anything in /sbin, /bin, etc.

 i'd just feel more comfortable if dpkg or rpm had control over their
 package files, and were only able to transition to certain groups
 of postinstall / prerm contexts, e.g.

 dpkg_libc.te
 dpkg_samba.te
 dpkg_apache.te

 in other words, how about, in each .te file, there being a set of
 policy permissions for:

 - install and configuration
 - normal operation
 - deinstall

 if that means having to have an apache.install.te, an apache.remove.te
 and an apache.te, then so be it.

 so my passwd.install.te file could have that domain_auto_trans(dpkg_t,
 chfn_exec_t, chfn_t) in it because it's needed there.

 just a thought.

 l.

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
