Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5AKWmrT001105
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 16:32:48 -0400 (EDT)
Received: from smtp803.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i5AKWgP2025774
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 16:32:43 -0400 (EDT)
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.155.76.36 with poptime)
  by smtp803.mail.ukl.yahoo.com with SMTP; 10 Jun 2004 20:32:45 -0000
Date: Thu, 10 Jun 2004 20:30:06 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: [debian] - installation of mysqld requires chfn
Message-ID: <20040610203006.GD2861@lkcl.net>
References: <20040609222209.GH5727@lkcl.net> <200406101220.53966.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200406101220.53966.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Jun 10, 2004 at 12:20:53PM +1000, Russell Coker wrote:
> On Thu, 10 Jun 2004 08:22, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > i added the can_exec chfn_exec_t into domains/programs/dpkg.te:
> 
> ifdef(`passwd.te', `
> domain_auto_trans(dpkg_t, chfn_exec_t, chfn_t)
> ')
> 
> The above is what you want.  

 oooo, thank you v. much.  that wouldn't have occurred to me.

 lots still to learn...

> You don't want to allow dpkg_t direct access 
> to /etc/shadow because it will probably mess it up (replace it with a copy 
> labelled as etc_t).

yerss, i noticed that if i run with "enforcing=0" and run chfn as
sysadm_r, i end up with /etc/shadow labelled as root:object_r:system_t
and i have to do a setfiles /etc/selinux/file_contexts/file_contexts
/etc/shadow pdq.

been bitten by not being able to log in once or twice by that :)

l.

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
