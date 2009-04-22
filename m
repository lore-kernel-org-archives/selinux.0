Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n3MBVCb8016194
	for <selinux@tycho.nsa.gov>; Wed, 22 Apr 2009 07:31:12 -0400
Received: from atoll.udmvt.ru (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n3MBV99C020250
	for <selinux@tycho.nsa.gov>; Wed, 22 Apr 2009 11:31:11 GMT
Received: from ruber.office.udmvt.ru (ruber.office.udmvt.ru [192.168.21.33])
	by atoll.udmvt.ru (8.13.6/8.13.6/Izhcom-V1.1e) with SMTP id n3MBV6li039083
	for <selinux@tycho.nsa.gov>; Wed, 22 Apr 2009 16:31:08 +0500 (SAMST)
	(envelope-from spg@udmvt.ru)
Date: Wed, 22 Apr 2009 16:31:05 +0500
From: selinux@udmvt.ru
To: Eric Paris <eparis@redhat.com>
Cc: jwcart2@epoch.ncsc.mil, Joshua Brindle <method@manicmethod.com>,
        Chad Sellers <csellers@tresys.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>,
        Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: access(2) vs. SELinux
Message-ID: <20090422113105.GQ9889@ruber.office.udmvt.ru>
References: <C60D0537.A684E%csellers@tresys.com> <49EC8841.7050305@manicmethod.com> <1240240273.2562.67.camel@localhost.localdomain> <1240253727.2841.53.camel@moss-lions.epoch.ncsc.mil> <1240254515.2562.113.camel@localhost.localdomain> <1240255715.2841.67.camel@moss-lions.epoch.ncsc.mil> <1240256989.2562.201.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1240256989.2562.201.camel@localhost.localdomain>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Apr 20, 2009 at 03:49:49PM -0400, Eric Paris wrote:
> >From where I sit, I don't care if people probe the policy.  The problem
> I want to solve is that we have dontaudit rules against what I consider
> valuable resources.  (eg: shadow and krb5 files)
> 
> But, I certainly understand why others might care (which is the lesser
> of the two reasons I don't like the _noaudit, interface on access()).
> So I think my kernel patch prototype allows the policy to decide where
> it cares about probing and where it doesn't.
> 
> > What is the security benefit of the access_* permissions?  It looks like
> > they are only going to be used to determine if a denial should be
> > generated.
> 
> Very little security benefit other than we can remove all of the
> dontaudit rules trying to read shadow_t.  Instead we'll have dontaudit
> rules for trying to probe if you can read shadow_t.  Actually trying to
> read shadow_t would begin to generate a denial.  Today neither activity
> would generate a denial.  access_* permissions would have NO meaning
> other than in the dontaudit case (could also do auditallow)
> 
> Let me summarize where I'm coming from.
> 
> Problem:
> Many programs use access() to chose which code path to use thus
> requesting permissions granted by DAC, but we choose to deny through
> SELinux policy.  Thus we currently must dontaudit all read, write, and
> execute for these situations.
> 
> Eric's Restrictions on solutions:
> If SELinux denies access SELinux must is some way inform the user that
> it denied access.
> 
> Other's Restrictions:
> Do not make tool chain significantly more brittle?
> Maintain ability to detect probing of security policy?

I have had a better thought on this all and now I'm sure, that
it would be optimal to have single access permission that will not mean
permitting/denying access(2) calls, but will control the audit messages
generation (depending on the actual access we have got).

If we will just allow averyone silently call access(2) on every file we will
only have one problem that is an information leakage.
To prevent that information leak in some cases or in all cases except some cases
we will use access permission (will it be enough to have one single access?).

So, simply not having access permission will generate audit messages only when access(2)
 returns "NO ACCESS", but will generate nothing if there is access.
If access permission will be dontaudited OR allowed, then that will mean we don't care at all
if someone is probing permissions, that are not permitted to him (we trust him enough).
This is not typical for SELinux to have same meaning for dontaudit and allow, but see,
we are only trying to decide whether we are to AUDIT some actions,
not to permit/deny some access. Right?

Or you gonna make it possible to deny access(2) call at all? I wonder if that would be useful.

-- 
Alexey S

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
