From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Colin Walters <walters@verbum.org>
Subject: Re: Latest diffs
Date: Sat, 23 Oct 2004 14:24:13 +1000
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux <SELinux@tycho.nsa.gov>
References: <41768337.3080303@redhat.com> <1098299892.26380.47.camel@decepticon.boston.redhat.com>
In-Reply-To: <1098299892.26380.47.camel@decepticon.boston.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200410231424.13503.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 21 Oct 2004 05:18, Colin Walters <walters@verbum.org> wrote:
> On Wed, 2004-10-20 at 11:24 -0400, Daniel J Walsh wrote:
> > +domain_auto_trans(sysadm_t, httpdcontent, httpd_sys_script_t)
>
> Hm, this change seems a bit asymmetric; we don't give other userdomains
> the ability to directly execute their own scripts
> (httpd_staff_script_exec_t), right?  If we're going to allow this, we
> should probably do it in apache_macros.te too.

>From apache_macros.te in CVS:

ifelse($1, sys, `
#
# If a user starts a script by hand it gets the proper context
#
domain_auto_trans(sysadm_t, httpd_$1_script_exec_t, httpd_$1_script_t)
role sysadm_r types httpd_$1_script_t;
', `

ifdef(`single_userdomain', `', `
# If a user starts a script by hand it gets the proper context
domain_auto_trans($1_t, httpd_$1_script_exec_t, httpd_$1_script_t)
role $1_r types httpd_$1_script_t;

The difference is that Dan is having the domain_auto_trans operate on 
httpdcontent instead of just the script_exec_t.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
