Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iATJLpIi013045
	for <selinux@tycho.nsa.gov>; Mon, 29 Nov 2004 14:21:52 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iATJLskk012019
	for <selinux@tycho.nsa.gov>; Mon, 29 Nov 2004 19:21:54 GMT
Subject: Re: gentoo policy for dante
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: petre rodan <kaiowas@gentoo.org>, SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <41AB3F0B.6050104@redhat.com>
References: <4198E94B.8070008@gentoo.org>
	 <1100808438.26930.28.camel@moss-lions.epoch.ncsc.mil>
	 <419D1ABD.4020901@gentoo.org>
	 <1100893919.31793.32.camel@moss-lions.epoch.ncsc.mil>
	 <41A02530.3070505@redhat.com> <41A99F8C.4080503@gentoo.org>
	 <41AB3F0B.6050104@redhat.com>
Content-Type: text/plain
Message-Id: <1101756267.3219.9.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 29 Nov 2004 14:24:27 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Fixed in CVS.

On Mon, 2004-11-29 at 10:23, Daniel J Walsh wrote:
> petre rodan wrote:
> 
> >
> > Hi Daniel,
> >
> > Daniel J Walsh wrote:
> >
> >> Small change on previous patch.
> >>
> >> Please ignore previous patch and use this one.
> >
> > >
> >
> >> --- nsapolicy/domains/program/unused/postgresql.te    2004-11-20 
> >> 22:29:09.000000000 -0500
> >> +++ policy-1.19.4/domains/program/unused/postgresql.te    2004-11-21 
> >> 00:17:07.933617789 -0500
> >> @@ -110,6 +110,14 @@
> >>  dontaudit postgresql_t selinux_config_t:dir { search };
> >>  allow postgresql_t mail_spool_t:dir { search };
> >>  rw_dir_create_file(postgresql_t, var_lock_t)
> >> +can_exec(postgresql_t, { shell_exec_t bin_t } )
> >> +ifdef(`httpd.te', `
> >> +# +# Allow httpd to work with postgresql
> >> +#
> >> +allow httpd_t postgresql_tmp_t:sock_file rw_file_perms;
> >> +can_unix_connect(httpd_t, posgresql_t)
> >> +')
> >
> >
> > shouldn't this be an ifdef on apache.te instead of httpd.te?
> >
> > bye,
> > peter
> >
> Yes.
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
