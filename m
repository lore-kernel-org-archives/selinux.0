Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i523ZjrT000846
	for <selinux@tycho.nsa.gov>; Tue, 1 Jun 2004 23:35:45 -0400 (EDT)
Received: from smtp803.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i52BUGbn009884
	for <selinux@tycho.nsa.gov>; Wed, 2 Jun 2004 07:30:16 -0400 (EDT)
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.155.76.36 with poptime)
  by smtp803.mail.ukl.yahoo.com with SMTP; 1 Jun 2004 08:49:04 -0000
Date: Tue, 1 Jun 2004 08:46:31 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: progress! ssh.
Message-ID: <20040601084631.GJ8312@lkcl.net>
References: <20040531212109.GQ3170@lkcl.net> <200406011312.48669.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200406011312.48669.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Jun 01, 2004 at 01:12:48PM +1000, Russell Coker wrote:
> On Tue, 1 Jun 2004 07:21, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > --- /usr/share/selinux/policy/default/domains/program/ssh.te	2004-05-30
> > 07:06:13.000000000 +0100 +++ domains/program/ssh.te	2004-06-01
> > 00:02:58.000000000 +0100
> > @@ -231,3 +231,12 @@
> >  allow ssh_keygen_t self:unix_stream_socket create_stream_socket_perms;
> >  allow ssh_keygen_t sysadm_tty_device_t:chr_file { read write };
> >  allow ssh_keygen_t urandom_device_t:chr_file { getattr read };
> > +
> > +# provide means for /sbin/unix_chkpwd to do some "stuff" with sshd, hey
> > +# i don't pretend to understand...
> > +allow system_chkpwd_t sshd_t:tcp_socket { read write };
> > +allow system_chkpwd_t sshd_t:unix_stream_socket { read write };
> 
> This is not necessary.  In the Fedora PAM package there is code to close those 
> file handles before exec so those accesses are never attempted.  

 oh, right.  *puzzled*.

 if Fedora PAM has been patched, would you mind forwarding the patch
 to me so i can ping pam-list with it?

 

> A dontaudit 
> rule would be an OK work-around (but should not be in the distributed 
> policy).

 ah... ... okay.

> > +# users can't ssh in!  or they _can_, they just can't run a shell (!)
> > +allow user_t sshd_devpts_t:chr_file { ioctl read write };
> 
> That's a bug in PAM or sshd.  I haven't got around to tracking it down.  It 
> would be good if you could debug pam and find out why it doesn't relabel the 
> controlling tty for some users.
 
 eek!  me??  *panic* :)

 okay.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
