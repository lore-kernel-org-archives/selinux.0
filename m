Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m24E5qaY018412
	for <selinux@tycho.nsa.gov>; Tue, 4 Mar 2008 09:05:52 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m24E5pKP001040
	for <selinux@tycho.nsa.gov>; Tue, 4 Mar 2008 14:05:51 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: Problem with corenet_* statements.
Date: Tue, 4 Mar 2008 08:49:23 -0500
Message-ID: <1204638563.14217.8.camel@gorn>
In-Reply-To: <29e7ef020803031339h759da5f9gd0eb196eb638ac6b@mail.gmail.com>
References: <29e7ef020803031339h759da5f9gd0eb196eb638ac6b@mail.gmail.com>
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: "Gienek Nowacki" <nowackig@gmail.com>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2008-03-03 at 22:39 +0100, Gienek Nowacki wrote:
> Hi,
> 
> I would like to build my own SE module. The system is CentOS 5.1. The
> source of the module is as follow:
> 
> # ============ amav.te ===================
> 
> module amav 1.0.0;
> require {
>         type amavis_t;
> };
> corenet_udp_bind_generic_port(amavis_t);
> corenet_dontaudit_udp_bind_all_ports(amavis_t);
> 
> # ====================================
> 
> After running the command:
> checkmodule -M -m -o amav.mod  amav.te
> 
> ....there is `syntax error' -  checkmodule doasn't recognize
> corenet_*  statements.
> 
> Next, after successful I would like to use semodule_package and
> semodule commands.

If you use reference policy interfaces, you must use the reference
policy build infrastructure to process it.  Run

make -f /usr/share/selinux/devel/Makefile

and that will compile and package the module, so you'll get the amav.pp.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
