Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mABGv9vw002268
	for <selinux@tycho.nsa.gov>; Tue, 11 Nov 2008 11:57:09 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id mABGv9wW007644
	for <selinux@tycho.nsa.gov>; Tue, 11 Nov 2008 16:57:09 GMT
Subject: Re: [refpolicy] latest svn refpolicy confusion
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Justin Mattock <justinmattock@gmail.com>
Cc: SE-Linux <selinux@tycho.nsa.gov>, tresys <refpolicy@oss.tresys.com>
In-Reply-To: <dd18b0c30811110732y79e609fct783e393a7b5f2e5c@mail.gmail.com>
References: <dd18b0c30811110732y79e609fct783e393a7b5f2e5c@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 11 Nov 2008 11:54:36 -0500
Message-Id: <1226422476.24358.40.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2008-11-11 at 07:32 -0800, Justin Mattock wrote:
> when making the latest refpolicy
> from svn I keep receiving a checkpolicy error
> with anything having to do with dbus:
> allow sysadm_dbusd_t gconf_etc_t:dir { read search getattr };
> allow sysadm_dbusd_t gconf_etc_t:file { read getattr };
> changing these roles to staff_r still produces
> and error, when commenting these out in my .te file
> the error will continue to the next *_dbusd_t *
> rule for some reason. is there a new setting with dbus
> that I'm missing?
> the system is ubuntu intrepid(unstable, or my own hacked version);

I don't see any problems.  Can you post your modules.conf so I can try
to reproduce?

BTW its not necessary to cross-post an email like this; it defeats one
of the purposes of having a separate refpolicy list.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
