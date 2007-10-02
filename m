Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l92FUJMD025762
	for <selinux@tycho.nsa.gov>; Tue, 2 Oct 2007 11:30:19 -0400
Received: from py-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l92FUIA2018081
	for <selinux@tycho.nsa.gov>; Tue, 2 Oct 2007 15:30:18 GMT
Received: by py-out-1112.google.com with SMTP id u77so8680435pyb
        for <selinux@tycho.nsa.gov>; Tue, 02 Oct 2007 08:29:58 -0700 (PDT)
Message-ID: <f71a82820710020829h2e3707a6h1453ba9d4b6669be@mail.gmail.com>
Date: Wed, 3 Oct 2007 00:29:54 +0900
From: "Shintaro Fujiwara" <shintaro.fujiwara@gmail.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        selinux <selinux@tycho.nsa.gov>
Subject: Re: ANN: Reference Policy Release
In-Reply-To: <1190992795.4282.17.camel@gorn.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1190992795.4282.17.camel@gorn.columbia.tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thank you very much, for including my name on it.
I think everybody would be more encouraged
if you could make a page like this of refpolicy.

http://www.nsa.gov/selinux/info/contrib.cfm

p.s.
I'm encouraging people in my country to get involved in refpolicy.
Not in Akihabara, but on SecureOS-Japan-ML, though...


2007/9/29, Christopher J. PeBenito <cpebenito@tresys.com>:
> A new release of the SELinux Reference Policy is now available on the
> Tresys OSS site, http://oss.tresys.com.  In this release, an option for
> unknown permissions handling was added, several minor MLS enhancements
> were merged, and XML building issues for external reference and headers
> builds were fixed.  The complete change log for this release follows.
>
> * Fri Sep 28 2007 Chris PeBenito <selinux@tresys.com> - 20070928
> - Add support for setting the unknown permissions handling.
> - Fix XML building for external reference builds and headers builds.
> - Patch to add missing requirements in userdomain interfaces from Shintaro
>   Fujiwara.
> - Add tcpd_wrapped_domain() for services that use tcp wrappers.
> - Update MLS constraints from LSPP evaluated policy.
> - Allow initrc_t file descriptors to be inherited regardless of MLS level.
>   Accordingly drop MLS permissions from daemons that inherit from any level.
> - Files and radvd updates from Stefan Schulze Frielinghaus.
> - Deprecate mls_file_write_down() and mls_file_read_up(), replaced with
>   mls_write_all_levels() and mls_read_all_levels(), for consistency.
> - Add make kernel and init ranged interfaces pass the range transition MLS
>   constraints.  Also remove calls to mls_rangetrans_target() in modules that use
>   the kernel and init interfaces, since its redundant.
> - Add interfaces for all MLS attributes except X object classes.
> - Require all sensitivities and categories for MLS and MCS policies, not just
>   the low and high sensitivity and category.
> - Database userspace object manager classes from KaiGai Kohei.
> - Add third-party interface for Apache CGI.
> - Add getserv and shmemserv nscd permissions.
> - Add debian apcupsd binary location, from Stefan Schulze Frielinghaus.
> - Added modules:
>         application
>         awstats (Stefan Schulze Frielinghaus)
>         bitlbee (Devin Carraway)
>         brctl (Dan Walsh)
>
> --
> Chris PeBenito
> Tresys Technology, LLC
> (410) 290-1411 x150
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
