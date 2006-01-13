Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0DMMSXf029319
	for <selinux@tycho.nsa.gov>; Fri, 13 Jan 2006 17:22:29 -0500 (EST)
Received: from e5.ny.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0DMMQpN026303
	for <selinux@tycho.nsa.gov>; Fri, 13 Jan 2006 22:22:26 GMT
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id k0DMMRKN032084
	for <selinux@tycho.nsa.gov>; Fri, 13 Jan 2006 17:22:27 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id k0DMMRpu129952
	for <selinux@tycho.nsa.gov>; Fri, 13 Jan 2006 17:22:27 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k0DMMRMd018415
	for <selinux@tycho.nsa.gov>; Fri, 13 Jan 2006 17:22:27 -0500
Date: Fri, 13 Jan 2006 16:22:26 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: SELinux <selinux@tycho.nsa.gov>
Subject: Re: sereference: screen policy
Message-ID: <20060113222226.GD26911@sergelap.austin.ibm.com>
References: <20060112214819.GA8013@sergelap.austin.ibm.com> <1137168771.29815.211.camel@sgc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1137168771.29815.211.camel@sgc>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Christopher J. PeBenito (cpebenito@tresys.com):
> On Thu, 2006-01-12 at 15:48 -0600, Serge E. Hallyn wrote:
> > Still getting the hang of the various existing interfaces, but this
> > policy at least lets me run screen as sysadm_u and user_u.  This
> > likely shouldn't go in as is since I doubt it's minimal due to clumsy
> > use of wrong interfaces, but I won't be looking at this again until
> > next week at earliest, so meanwhile here's what I've got.
> 
> A screen policy was committed two days ago, can you try that one?  I
> tested it and it seemed to work ok for me.

Almost but not quite for me.  I needed the following lines added to the
template:

	allow $1_screen_t $1_t:process sigchld;
	allow $1_screen_t $1_t:fd use;
	term_setattr_all_user_ptys($1_screen_t)
	term_use_all_terms($1_screen_t)
	allow $1_screen_t tty_device_t:lnk_file read;

Note that I also still need my other patch for local logins from Jan 11.

-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
