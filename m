Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n3MCfqYP023888
	for <selinux@tycho.nsa.gov>; Wed, 22 Apr 2009 08:41:53 -0400
Received: from atoll.udmvt.ru (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n3MCfo8v008963
	for <selinux@tycho.nsa.gov>; Wed, 22 Apr 2009 12:41:51 GMT
Received: from ruber.office.udmvt.ru (ruber.office.udmvt.ru [192.168.21.33])
	by atoll.udmvt.ru (8.13.6/8.13.6/Izhcom-V1.1e) with SMTP id n3MCfkuB040814
	for <selinux@tycho.nsa.gov>; Wed, 22 Apr 2009 17:41:48 +0500 (SAMST)
	(envelope-from spg@udmvt.ru)
Date: Wed, 22 Apr 2009 17:41:46 +0500
From: Alexey S <selinux@udmvt.ru>
To: selinux@tycho.nsa.gov
Subject: Re: access(2) vs. SELinux
Message-ID: <20090422124146.GR9889@ruber.office.udmvt.ru>
References: <C60D0537.A684E%csellers@tresys.com> <49EC8841.7050305@manicmethod.com> <1240240273.2562.67.camel@localhost.localdomain> <1240253727.2841.53.camel@moss-lions.epoch.ncsc.mil> <1240254515.2562.113.camel@localhost.localdomain> <1240255715.2841.67.camel@moss-lions.epoch.ncsc.mil> <1240256989.2562.201.camel@localhost.localdomain> <20090422113105.GQ9889@ruber.office.udmvt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090422113105.GQ9889@ruber.office.udmvt.ru>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Apr 22, 2009 at 04:31:05PM +0500, selinux@udmvt.ru wrote:
> I have had a better thought on this all and now I'm sure, that
> it would be optimal to have single access permission that will not mean
> permitting/denying access(2) calls, but will control the audit messages
> generation (depending on the actual access we have got).
> 
> If we will just allow averyone silently call access(2) on every file we will
> only have one problem that is an information leakage.
> To prevent that information leak in some cases or in all cases except some cases
> we will use access permission (will it be enough to have one single access?).
> 
> So, simply not having access permission will generate audit messages only when access(2)
>  returns "NO ACCESS", but will generate nothing if there is access.
> If access permission will be dontaudited OR allowed, then that will mean we don't care at all
> if someone is probing permissions, that are not permitted to him (we trust him enough).
> This is not typical for SELinux to have same meaning for dontaudit and allow, but see,
> we are only trying to decide whether we are to AUDIT some actions,
> not to permit/deny some access. Right?
Or there can be difference.
Since there are other permissions that are tested by access(2) and they can be just denied
or dontaudited. So having access(2) to noise about dontaudited permissions sometimes looks silly,
but sometimes is what required...

It looks unnatural that dontaudit still produces audit messages. But what if
  dontaudit domain_t file_t:class { access }; 
    will produce messages when permissions are probed that are denied (and not dontaudited)
 
  allow domain_t file_t:class { access };
    will never generate audit messages on any permission probe

  deny domain_t file_t:class { access };
    will audit about probes on permissions that are denied or dontaudited

  auditallow domain_t file_t:class { access };
    will audit about any probe attempt regardless it's result (should it also audit the result?)

  auditdeny domain_t file_t:class { access };
    will audit about probes on permissions that are dontaudited (and not denied) :) why do we need this?

And I prefer audit messages generated from access(2) to be different from audits of actual actions,
but still it would be useful if audit2allow will be able to generate allow for actual permissions,
not for access permission. And it should be controlled by a switch from command line.

PS: Sorry, I'm talking with myself.
-- 
Alexey S.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
