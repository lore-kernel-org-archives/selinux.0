Message-ID: <4B5F4D5B.8070407@gmail.com>
Date: Tue, 26 Jan 2010 12:15:23 -0800
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: TaurusHarry <harrytaurus2002@hotmail.com>, refpolicy@oss1.tresys.com,
        selinux-mailing-list <selinux@tycho.nsa.gov>
Subject: Re: [refpolicy] Bootup problem with refpolicy-2.20091117 - 4:login
 successfully finally!
References: <BAY111-W27B5C0DF57292CB495990DAB660@phx.gbl>	,, , ,,<4B53CEB9.3050207@gmail.com>	,,<BAY111-W3E475DBD218D365CE90B6AB660@phx.gbl>	,, , ,,<4B543977.40007@gmail.com>	,,<BAY111-W38C1EDA473E7D38CE32E9EAB650@phx.gbl>	,, , ,,<4B550EB9.50806@gmail.com>	,,<BAY111-W5CC280B61135249DF5E8FAB630@phx.gbl>	,, ,,<1264079995.11002.19.camel@moss-pluto.epoch.ncsc.mil>	,,,<BAY111-W42A0AB9B343372897BA202AB620@phx.gbl>	,,,<1264176847.22211.16.camel@moss-pluto.epoch.ncsc.mil>	,,<BAY111-W51276CC30B166887BBB33AB5F0@phx.gbl>	,<BAY111-W22EC1CF480A00C18111145AB5F0@phx.gbl>	,<1264433745.4297.159.camel@moss-pluto.epoch.ncsc.mil>	<BAY111-W103B9EF7D73E86CFDF3688AB5E0@phx.gbl> <1264513015.19890.14.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1264513015.19890.14.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>> More secmark options should I enable?
>
> If you are still using a kernel<  2.6.29, then you also want:
> SECURITY_SELINUX_ENABLE_SECMARK_DEFAULT=y
>

what does his inittab look like?

had some funk issue with min,
policy worked after adjusting inittab
(maybe this is something with mgetty);

Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
