Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7TAncrT029469
	for <selinux@tycho.nsa.gov>; Sun, 29 Aug 2004 06:49:38 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7TAnXis027574
	for <selinux@tycho.nsa.gov>; Sun, 29 Aug 2004 10:49:36 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: patches for xdm.te for kdm 3.3
Date: Sun, 29 Aug 2004 20:49:24 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <20040828164528.GC11546@lkcl.net> <200408291721.55576.russell@coker.com.au> <20040829091112.GA7610@lkcl.net>
In-Reply-To: <20040829091112.GA7610@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200408292049.24183.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 29 Aug 2004 19:11, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> On Sun, Aug 29, 2004 at 05:21:55PM +1000, Russell Coker wrote:
> > On Sun, 29 Aug 2004 02:45, Luke Kenneth Casson Leighton <lkcl@lkcl.net> 
wrote:
> > > i'm running kdm 3.3, also i'm running an "immediate user login" with no
> > > password.
> > >
> > > added these to get it to work.
> > >
> > > also as you can see i changed the type of /etc/qt3 to etc_runtime_t.
> >
> > file_type_auto_trans(xdm_t, var_run_t, xdm_var_run_t, { dir fifo_file} )
> >
> > This won't work properly due to a limitation of the file_type_trans()
> > macro.
>
>  urrrr... are you sure?  have there been recent changes [in last month]
>  that _stop_ this from working?

ifelse(`$4', `dir', `
allow $1 $3:$4 create_dir_perms;
', `
ifelse(`$4', `lnk_file', `
allow $1 $3:$4 create_lnk_perms;
', `
allow $1 $3:$4 create_file_perms;
')dnl end ifelse lnk_file
')dnl end if dir

The above is in file_type_trans().  Specifying "dir" with something else means 
that create_file_perms will be granted instead of create_dir_perms.

It's been like that ever since I added a fourth parameter to file_type_trans() 
and file_type_auto_trans().

> > allow xdm_t init_t:process { signal };
> >        #EXE=/sbin/halt   :  signal
> >
> > allow xdm_t xdm_t:capability { sys_boot };
> >
> > I think that we need a different domain for this.
>
>  that'd be nice.
>
>  oh - this is what i was referring to about "does anyone _use_ kde"
>  because the without xdmctl thing (allowing /var/run/xdmctl/* to be
>  xdm_var_run_t etc.) and without the above, you can't run "shutdown"
>  from the "logout" menu.

I think that no-one but you uses kdm.  Lots of people use KDE including me.

> > can_exec(xdm_t, xsession_exec_t)
> >
> > That looks like a bug.  xsession_exec_t scripts are supposed to execute
> > in user context.  Looks like the kdm patch does not set the execute
> > context everywhere that it should.
>
>  oh.  ah.... that patch.  um.... the one i haven't applied because i
>  downloaded kde 3.3 and i thought i could get away with putting in
>  pam_selinux.so into /etc/pam.d/kdm because i didn't want to go through
>  _yet another_ kdebase-3.x download and build cycle.

pam_selinux.so never worked properly for xdm type programs.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
