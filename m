Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k1GJSoXf001666
	for <selinux@tycho.nsa.gov>; Thu, 16 Feb 2006 14:28:51 -0500 (EST)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k1GJRRTW026056
	for <selinux@tycho.nsa.gov>; Thu, 16 Feb 2006 19:27:27 GMT
Subject: Re: Latest diffs
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <43F1E2AC.40603@redhat.com>
References: <43EB8C6D.7060809@redhat.com> <1139868484.13925.134.camel@sgc>
	 <43F1E2AC.40603@redhat.com>
Content-Type: text/plain
Date: Thu, 16 Feb 2006 14:30:57 -0500
Message-Id: <1140118257.13925.213.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-02-14 at 09:01 -0500, Daniel J Walsh wrote:
> Christopher J. PeBenito wrote:
> > On Thu, 2006-02-09 at 13:39 -0500, Daniel J Walsh wrote:
> >   
> >> Update build.conf to match what I believe should be the defaults.
> >
> > I don't see a compelling need to make MCS default for the upstream
> > policy.  As for the MONOLITHIC=n, I'd prefer to wait until FC5 comes out
> > so that there is a final release with loadable modules.
> >   
> I was looking to make these changes, back when I thought this was the 
> Makefile for users to build reference policy.  I have made some changes 
> to Makefile.devel instead.

If you use the same settings (TYPE=.. NAME=..,etc.) when you run the
headers-install target, the settings will be preserved in the build.conf
that gets installed, so this change shouldn't be needed.

> >> Add some of Russell's mcs changes
> >
> > I dropped the mcs file change.  We can't have hard-coded types.
> >   
> Added a typealias mlskillall.  Does this look better?

Yes, that looks fine, but I renamed it to mcskillall, and created a mcs
module for greater clarity.

> >> mta/sendmail wants to read postfix config and spools.
> >>     
> >
> > I don't understand why this change is needed for mta_send_mail().  It
> > makes sendmail_exec_t an entrypoint for the domain that wants to send
> > mail:
> >   
> Ok, where should I move it.

Well it adds the rule:

allow $1 sendmail_exec_t:file entrypoint;

which doesn't make sense, why would sendmail_exec_t be an entrypoint for
the domain sending the mail?

> More fixes for postfix.

I removed the sysnet_dontaudit_read_config(postfix_postdrop_t), since
its redundant.  The DNS resolve rule right above it allows this access.

> spamd needs ldap

Already in there, but down by the other sysnet calls.

> prelink needs to unlink lib_t lnk_files when managing them.

I switched this over to a separate interface.

> More privs for secadm

Changed the corecmd_exec_shell(sysadm_t) to secadm_t.

I didn't commit the semodule policy yet, pending discussion on its
design.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
