Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9C8jfrT010259
	for <selinux@tycho.nsa.gov>; Tue, 12 Oct 2004 04:45:41 -0400 (EDT)
Received: from mproxy.gmail.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9C8iUsX023376
	for <selinux@tycho.nsa.gov>; Tue, 12 Oct 2004 08:44:30 GMT
Received: by mproxy.gmail.com with SMTP id u52so67950cwc
        for <selinux@tycho.nsa.gov>; Tue, 12 Oct 2004 01:45:37 -0700 (PDT)
Message-ID: <ae023b60041012014519599f80@mail.gmail.com>
Date: Tue, 12 Oct 2004 04:45:37 -0400
From: Jim McCullough <jim.mccullough@gmail.com>
Reply-To: Jim McCullough <jim.mccullough@gmail.com>
To: Richard Hally <rhally@mindspring.com>
Subject: Re: PostgreSQL Fun
Cc: Alex Ackerman <alex@darkhonor.com>, selinux@tycho.nsa.gov
In-Reply-To: <416B13D6.4080205@mindspring.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <A52BEA1D8EE8634B9196A136333637B1DAEC@maat.darkhonor.net>
	 <416B13D6.4080205@mindspring.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I also ran across this working on getting OpenNMS, Snort and a few
other applications to push directly to a centralized database server. 
 Part of my problem was my build and traffic tunneling configurations
( thats another subject not related to selinux).  Upgrading SQL
packages correct the issue on Core 2 for the DB server.  Application
servers were Debian Sarge base and was showing no signs of problems as
of  4am EDT.

Jim McCullough


On Mon, 11 Oct 2004 19:14:30 -0400, Richard Hally <rhally@mindspring.com> wrote:
> 
> 
> Alex Ackerman wrote:
> 
> >
> > I've been having a ton of fun lately trying to get PostgreSQL running
> > using the Strict policy. I have a Fedora Core 2 system that has been
> > updated to run the latest selinux strict policy (1.17.30-1). Most of
> > the rest of the services run ok (MySQL still isn't happy either, but
> > that's next), but PostgreSQL refuses to start. After running
> > audit2allow, it generates the following recommendations:
> >
> > allow postgresql_t chkpwd_exec_t:file { execute };
> > allow postgresql_t file_t:dir { search };
> > allow postgresql_t security_t:dir { search };
> > allow postgresql_t shadow_t:file { read };
> >
> > Those don't work for various reasons. The main reason is that the last
> > line causes checkpolicy to choke on the following directive:
> >
> > neverallow { domain -auth -auth_write } shadow_t:file ~getattr;
> >
> > A discussion I found () suggests this is due to the requirement to
> > limit access to /etc/shadow. I looked at my logs and found the top two
> > errors lead me to believe it is a PAM issue with the following command
> > in /etc/init.d/postgresql:
> >
> > su -l postgres -c "/usr/bin/pg_ctl  -D $PGDATA -p /usr/bin/postmaster
> > -o '-p ${PGPORT} ${PGOPTS}' start  > /dev/null 2>&1" < /dev/null
> >
> > The offending lines are:
> > Oct 11 16:21:47 baal kernel: audit(1097526107.360:0): avc:  denied  {
> > search } for  pid=26072 exe=/bin/su dev=selinuxfs ino=1005
> > scontext=root:system_r:postgresql_t
> > tcontext=system_u:object_r:security_t tclass=dir
> > Oct 11 16:21:47 baal PAM-rootok[26072]: pam_check_access failed, user
> > does not have proper access: root:system_r:postgresql_t
> >
> > Has anyone else looked at this issue? Is it possibly a bugzilla issue
> > to raise? I have pam-0.77-56 installed on my system. I imagine the
> > problem doesn't show up in FC3test3 since the targeted policy runs
> > postgres unconfined (haven't tested that theory though).  Any help I
> > can get on this issue (even if it is just a link to a solution or
> > ongoing discussion somewhere) would be greatly appreciated. I have
> > found nothing so far on this issue.
> >
> > Thanks!
> > Alex Ackerman
> > http://www.darkhonor.com
> >
> >
> 
> Have you updated to the latest Postgresql?  7.4.5-3 has the fix for the
> problem. It uses runuser in place of  the su in the start script.
> HTH
> Richard Hally
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 


-- 
Jim McCullough

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
