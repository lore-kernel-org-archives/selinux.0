Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l9GEW31w012500
	for <selinux@tycho.nsa.gov>; Tue, 16 Oct 2007 10:32:03 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l9GEW2EK006613
	for <selinux@tycho.nsa.gov>; Tue, 16 Oct 2007 14:32:02 GMT
Subject: Re: [PATCH] refpolicy:locallogin problem still exists?
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Shintaro Fujiwara <shintaro.fujiwara@gmail.com>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <f71a82820710151502q26a176c6vf583263651735563@mail.gmail.com>
References: <1192337398.3126.8.camel@notepc.intrajp-yokosuka.co.jp>
	 <1192472831.13098.137.camel@gorn>
	 <f71a82820710151502q26a176c6vf583263651735563@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 16 Oct 2007 10:29:36 -0400
Message-Id: <1192544976.32627.17.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-10-16 at 07:02 +0900, Shintaro Fujiwara wrote:
> I understand.
> 
> But, last weekend I made another strict F7 machine,
> updated everything,
> and could not login in enforcing mode.
> I thought you guys fixed it, though.
> What's wrong or am I wrong?
> I just want to login and no other.

Are you using refpolicy svn or the fedora policy?

> 2007/10/16, Christopher J. PeBenito <cpebenito@tresys.com>:
> > On Sun, 2007-10-14 at 13:49 +0900, shintaro_fujiwara wrote:
> > > Index: modules/system/locallogin.te
> > > ===================================================================
> > > --- modules/system/locallogin.te        (revision 2454)
> > > +++ modules/system/locallogin.te        (working copy)
> > > @@ -33,7 +33,7 @@
> > >  # Local login local policy
> > >  #
> > >
> > > -allow local_login_t self:capability { dac_override chown fowner fsetid
> > > kill setgid setuid sys_nice sys_resource sys_tty_config };
> > > +allow local_login_t self:capability { audit_control dac_override chown
> > > fowner fsetid kill setgid setuid sys_nice sys_resource sys_tty_config };
> > >  allow local_login_t self:process ~{ ptrace setcurrent setexec
> > > setfscreate setrlimit execmem execstack execheap };
> > >  allow local_login_t self:process { setrlimit setexec };
> > >  allow local_login_t self:fd use;
> > > @@ -102,6 +102,8 @@
> > >  auth_rw_faillog(local_login_t)
> > >  auth_manage_pam_console_data(local_login_t)
> > >  auth_domtrans_pam_console(local_login_t)
> > > +auth_domtrans_chk_passwd(local_login_t)
> > > +logging_send_audit_msgs(local_login_t)
> > >
> > >  corecmd_list_bin(local_login_t)
> > >  corecmd_read_bin_symlinks(local_login_t)
> >
> > local_login_t already has these perms due to it being a
> > auth_login_pgm_domain().

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
