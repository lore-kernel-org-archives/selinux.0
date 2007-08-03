Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l73Lct5n022492
	for <selinux@tycho.nsa.gov>; Fri, 3 Aug 2007 17:38:55 -0400
Received: from us.intercode.com.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l73Lcq2k016341
	for <selinux@tycho.nsa.gov>; Fri, 3 Aug 2007 21:38:53 GMT
Date: Fri, 3 Aug 2007 14:38:50 -0700 (PDT)
From: James Morris <jmorris@namei.org>
To: Casey Schaufler <casey@schaufler-ca.com>
cc: SELinux List <selinux@tycho.nsa.gov>
Subject: Re: Scope of SECMARK_MODE_SEL
In-Reply-To: <593652.90657.qm@web36615.mail.mud.yahoo.com>
Message-ID: <Pine.LNX.4.64.0708031433510.25207@us.intercode.com.au>
References: <593652.90657.qm@web36615.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 3 Aug 2007, Casey Schaufler wrote:

> 
> It is my assumption that SECMARK_MODE_SEL is defined and coded solely
> for use by SELinux and that it is not intended as a general purpose
> secmark for any random LSM to use. I assume that if another LSM wants
> to use SECMARK that it needs to supply its own SECMARK_MODE value and
> checkentry function.
> 
> Are my assumptions accurate?

Yes, and you likely also need to add your own entry to the union in 
struct xt_secmark_target_info, which I'd guess would simply be a smack_t.



- James 
-- 
James Morris <jmorris@namei.org>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
