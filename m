Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA22979
	for <selinux@tycho.nsa.gov>; Wed, 11 Sep 2002 14:30:18 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id SAA02627
	for <selinux@tycho.nsa.gov>; Wed, 11 Sep 2002 18:28:34 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id SAA02623 for <selinux@tycho.nsa.gov>; Wed, 11 Sep 2002 18:28:33 GMT
Date: Wed, 11 Sep 2002 14:29:57 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: macro for run_init etc
In-Reply-To: <200209031007.03455.russell@coker.com.au>
Message-ID: <Pine.GSO.4.33.0209111427350.8813-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 3 Sep 2002, Russell Coker wrote:

> Currently there's a run_init program for initrc_t, a run_deb program for
> running Debian package maintenance utilities, and now we have been discussing
> having similar programs for starting httpd, databases, and others.
>
> I think that we need a macro such as in the attached file for this purpose.
>
> With such a macro file the following three lines take the place of run_init.te
> and run_deb.te, and you could easily define another dozen run_something
> domains without effort.
>
> run_program(sysadm_t, syadm_r, init, etc_t, initrc_t)
> run_program(sysadm_t, syadm_r, deb, dpkg_exec_t, dpkg_t)
> domain_trans(run_deb_t, apt_exec_t, apt_t)

This change has been merged by Chris Vance and is available in sourceforge
CVS.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
