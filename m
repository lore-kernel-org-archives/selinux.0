Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i757eUrT003704
	for <selinux@tycho.nsa.gov>; Thu, 5 Aug 2004 03:40:30 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i757eRZl012998
	for <selinux@tycho.nsa.gov>; Thu, 5 Aug 2004 07:40:28 GMT
From: Russell Coker <rcoker@redhat.com>
Reply-To: rcoker@redhat.com
To: Colin Walters <walters@redhat.com>
Subject: Re: [patch] fix /var/run/console bits
Date: Thu, 5 Aug 2004 17:40:14 +1000
Cc: dwalsh@redhat.com, selinux@tycho.nsa.gov
References: <1091584911.8312.7.camel@nexus.verbum.private> <200408042007.03512.rcoker@redhat.com> <1091624615.9005.6.camel@nexus.verbum.private>
In-Reply-To: <1091624615.9005.6.camel@nexus.verbum.private>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200408051740.14931.rcoker@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 4 Aug 2004 23:03, Colin Walters <walters@redhat.com> wrote:
> > I think that perhaps the following would be good for the fc entry to keep
> > the convention:
> > /var/run/console/(.*)?                    
> > system_u:object_r:pam_var_console_t
>
> Sounds good.

Actually I did a typo, this is what is should be:
/var/run/console(/.*)?    system_u:object_r:pam_var_console_t

> > This is not what we want.  Ideally we will never have any files of type
> > var_run_t.
> > rw_dir_create_file(xdm_t, var_run_t)
> > rw_dir_create_file($1_login_t, var_run_t)
>
> I agree, but unfortunately pam_console creates a lockfile
> named /var/run/console.lock.  We should probably fix that.

Dan has just offered to fix that.  But if it was not possible to change that 
then the solution would be to have a file_type_auto_trans() rule.

I've been thinking of adding neverallow rules to prevent any access to files 
of type var_run_t, tmp_t, and tmpfs_t...

> > I guess that the following code is to allow the xdm to check which login
> > processes are active when searching for an unused virtual console.
>
> Ok.  I just thought it was weird at first glance, and worthy of a
> comment :)

It is weird, and probably something needs to be changed about it.

-- 
http://apac.redhat.com/disclaimer
See above URL for disclaimer.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
