Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1FH2lL9009031
	for <selinux@tycho.nsa.gov>; Tue, 15 Feb 2005 12:02:47 -0500 (EST)
Received: from web50206.mail.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id j1FH1dEP007328
	for <selinux@tycho.nsa.gov>; Tue, 15 Feb 2005 17:01:39 GMT
Message-ID: <20050215170139.79356.qmail@web50206.mail.yahoo.com>
Date: Tue, 15 Feb 2005 09:01:39 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: Setting loginuid
To: Stephen Smalley <sds@epoch.ncsc.mil>,
   Casey Schaufler <casey@schaufler-ca.com>
Cc: Steve G <linux_4ever@yahoo.com>, selinux@tycho.nsa.gov
In-Reply-To: <1108485083.17854.106.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Stephen Smalley <sds@epoch.ncsc.mil> wrote:

> On Tue, 2005-02-15 at 11:27, Casey Schaufler wrote:
> > Some programs that use PAM, including su, are
> > not login sessions and hence must not set the
> > loginuid.
> 
> That can be handled by not including the pam_audit
> or pam_loginuid
> (whatever it is called) module in the pam
> configuration for su (i.e.
> /etc/pam.d/su).  It doesn't necessarily requiring
> patching the
> individual programs; it just means that you have to
> insert individual
> pam_audit entries in desired program-specific pam
> configuration files
> rather than just putting it in the generic
> system-auth one.

You're correct. It would be possible to do su
correctly using the PAM scheme. It would also be
simple^H^H^H^H^H^H possible to configure the system
incorrectly. There is never a case where you want
the wrong behavior. It is better to hard code
correctness that to make correct behavior a
configuration option.

And that does not address cron.


=====
Casey Schaufler
casey@schaufler-ca.com


		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - Easier than ever with enhanced search. Learn more.
http://info.mail.yahoo.com/mail_250

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
