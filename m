Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i95IUSrT028569
	for <selinux@tycho.nsa.gov>; Tue, 5 Oct 2004 14:30:28 -0400 (EDT)
Received: from legolas.drinsama.de (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i95ITJPe011771
	for <selinux@tycho.nsa.gov>; Tue, 5 Oct 2004 18:29:19 GMT
Subject: Re: gentoo diff for mysqld
From: Erich Schubert <erich@debian.org>
To: petre rodan <kaiowas@gentoo.org>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <41625B74.2090503@gentoo.org>
References: <41625B74.2090503@gentoo.org>
Content-Type: text/plain; charset=ISO-8859-15
Date: Tue, 05 Oct 2004 20:30:16 +0200
Message-Id: <1097001016.15549.4.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

> +# if controled by daemontools
> +ifdef(`daemontools.te', `
> +domain_auto_trans( svc_run_t, mysqld_exec_t, mysqld_t)
> +allow svc_start_t mysqld_t:process signal;
> +svc_ipc_domain(mysqld_t)
> +')dnl end ifdef daemontools

I think the "deamontools.te" ifdef is enough, why put this into the
"gentoo" ifdef, too?
Please don't use distro-ifdefs unneccessarily. Basically anything being
in {FHS,upstream,best-practice} should be outside of such ifdefs.
Only things dependant on non-generic domains or non-standard behaviour -
for example the gentoo init - should be wrapped IMHO.

Greetings,
Erich Schubert
-- 
    erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
  A polar bear is a rectangular bear after a coordinate transform.   //\
        Glück gleicht durch Höhe aus, was ihm an Länge fehlt.        V_/_
                        --- Robert Lee Frost



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
