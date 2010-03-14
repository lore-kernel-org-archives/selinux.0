Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o2E5ZO4v012486
	for <selinux@tycho.nsa.gov>; Sun, 14 Mar 2010 00:35:24 -0500
Received: from e34.co.us.ibm.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o2E5ZtuD018868
	for <selinux@tycho.nsa.gov>; Sun, 14 Mar 2010 05:35:55 GMT
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com [9.17.195.226])
	by e34.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o2E5Siem012810
	for <selinux@tycho.nsa.gov>; Sat, 13 Mar 2010 22:28:44 -0700
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id o2E5ZMup175572
	for <selinux@tycho.nsa.gov>; Sat, 13 Mar 2010 22:35:22 -0700
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id o2E5bmvU003974
	for <selinux@tycho.nsa.gov>; Sat, 13 Mar 2010 22:37:49 -0700
Date: Sat, 13 Mar 2010 23:35:21 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: mtk.manpages@gmail.com
Cc: James Morris <jmorris@namei.org>, lkml <linux-kernel@vger.kernel.org>,
        SELinux <selinux@tycho.nsa.gov>, linux-security-module@vger.kernel.org,
        Stephen Smalley <sds@epoch.ncsc.mil>,
        Kees Cook <kees.cook@canonical.com>, Andrew Morgan <morgan@kernel.org>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Eric Paris <eparis@parisplace.org>
Subject: Re: [PATCH] Define CAP_SYSLOG
Message-ID: <20100314053521.GA12410@us.ibm.com>
References: <20100312205537.GA1091@us.ibm.com>
 <cfd18e0f1003132118y21bd71band2d07ae85c8d4c9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <cfd18e0f1003132118y21bd71band2d07ae85c8d4c9@mail.gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Michael Kerrisk (mtk.manpages@googlemail.com):
> > There is one downside to this patch:  If some site or distro currently
> > has syslogd/whatever running as a non-root user with cap_sys_admin+pe,
> > then it will need to be changed to run with cap_syslog+pe.  I don't
> > know if there are such sites, or if that concern means we should take
> > a different approach to introducing this change, or simply refuse this
> > change.
> 
> *If* this is a problem, would the way to address it not be to permit
> syslog if the caller has *either* CAP_SYS_ADMIN or CAP_SYSLOG? (The
> only weakness I see in this idea is that it fails to lighten the
> hugely overlaoded CAP_SYS_ADMIN.)

Which becomes a very big weakness because it won't allow a
container to be started with cap_sys_admin but not cap_syslog
in its capability bounding set.

So, if it is deemed a problem, then the alternative will be to
introduce a syslog namespace.  Container setup can then create
a new syslog namespace, and can no longer read or clear the
host's syslog.

thanks,
-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
