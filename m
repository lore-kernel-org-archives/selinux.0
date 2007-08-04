Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l74IKZvi003561
	for <selinux@tycho.nsa.gov>; Sat, 4 Aug 2007 14:20:35 -0400
Received: from web36613.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l74IKYbF003686
	for <selinux@tycho.nsa.gov>; Sat, 4 Aug 2007 18:20:34 GMT
Date: Sat, 4 Aug 2007 11:20:18 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: Scope of SECMARK_MODE_SEL
To: James Morris <jmorris@namei.org>, Casey Schaufler <casey@schaufler-ca.com>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <Pine.LNX.4.64.0708031433510.25207@us.intercode.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <914026.68329.qm@web36613.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- James Morris <jmorris@namei.org> wrote:

> On Fri, 3 Aug 2007, Casey Schaufler wrote:
> 
> > 
> > It is my assumption that SECMARK_MODE_SEL is defined and coded solely
> > for use by SELinux and that it is not intended as a general purpose
> > secmark for any random LSM to use. I assume that if another LSM wants
> > to use SECMARK that it needs to supply its own SECMARK_MODE value and
> > checkentry function.
> > 
> > Are my assumptions accurate?
> 
> Yes, and you likely also need to add your own entry to the union in 
> struct xt_secmark_target_info, which I'd guess would simply be a smack_t.

Thank you. My question was really aimed at finding out if the
code should be changed as part of the effort to pull SELinux
dependencies out of the audit code. Smack and xfrm is a distinct
set of work.



Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
