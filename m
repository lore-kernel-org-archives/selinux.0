Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5HIclWp016189
	for <selinux@tycho.nsa.gov>; Tue, 17 Jun 2008 14:38:47 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m5HIckBx001032
	for <selinux@tycho.nsa.gov>; Tue, 17 Jun 2008 18:38:46 GMT
Subject: Re: gnome-screensav AVCs
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Ted X Toth <txtoth@gmail.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <48580267.7000309@gmail.com>
References: <cadfc0e40806170746p6de7c1b7m6c27ca74ae0ca183@mail.gmail.com>
	 <1213717150.11146.88.camel@gorn>
	 <cadfc0e40806170855hf95edf4vdefe9b9710cadfb6@mail.gmail.com>
	 <1213723428.11146.93.camel@gorn>  <48580267.7000309@gmail.com>
Content-Type: text/plain
Date: Tue, 17 Jun 2008 14:38:07 -0400
Message-Id: <1213727887.11146.97.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2008-06-17 at 13:28 -0500, Ted X Toth wrote:
> Christopher J. PeBenito wrote:
> > On Tue, 2008-06-17 at 10:55 -0500, Xavier Toth wrote:
> >> On Tue, Jun 17, 2008 at 10:39 AM, Christopher J. PeBenito
> >> <cpebenito@tresys.com> wrote:
> >>     
> >>> On Tue, 2008-06-17 at 09:46 -0500, Xavier Toth wrote:
> >>>       
> >>>> I'm seeing AVCs related to netlink_audit_socket when the screen saver
> >>>> dialog is run. gnome-screensaver-dialog opens a pam session which uses
> >>>> pam_unix which in turn runs the unix_chkpwd helper. I'm thinking that
> >>>> gnome-screensaver-dialog is going to need some policy including
> >>>> possibly authlogin_common_auth_domain_template.
> >>>>         
> >>> I'm not 100% clear, is the auditing happening from unix_chkpwd or the
> >>> screensaver proper?
> >>>
> >>>       
> >> I'm sure that it is unix_chkpwd that is auditing and not
> >> gnome-screensaver-dialog.
> >>     
> >
> > Is gnome-screensaver-dialog not running the user domain?
> I believe this is true.
> 
> >   I would have
> > expected that it was, and that when unix_chkpwd is run, that it
> > transitions to *_unix_chkpwd_t, which should be able to send audit
> > messages.
> >
> >   
> You know policy better than I, where is the policy for this?

In authlogin_per_role_template():

	role $3 types $1_chkpwd_t;

	# Transition from the user domain to this domain.
	domtrans_pattern($2,chkpwd_exec_t,$1_chkpwd_t)

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
