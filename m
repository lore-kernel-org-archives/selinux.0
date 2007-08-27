Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7RDIdFX001297
	for <selinux@tycho.nsa.gov>; Mon, 27 Aug 2007 09:18:39 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l7RDIcnP026192
	for <selinux@tycho.nsa.gov>; Mon, 27 Aug 2007 13:18:38 GMT
Subject: Re: [PATCH] refpolicy: apps_vmware changes
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Tom London <selinux@gmail.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov
In-Reply-To: <4c4ba1530708241033u792d01e8gcc648b3505ca9239@mail.gmail.com>
References: <200708021956.l72Ju2S3029420@redsox.boston.devel.redhat.com>
	 <1187812502.13874.98.camel@gorn> <46CCAC4B.1060506@redhat.com>
	 <4c4ba1530708221752q6ba5f9dy7a1ec67f9c6f8956@mail.gmail.com>
	 <1187890910.13874.140.camel@gorn>
	 <4c4ba1530708241033u792d01e8gcc648b3505ca9239@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 27 Aug 2007 09:17:35 -0400
Message-Id: <1188220655.6723.0.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-08-24 at 10:33 -0700, Tom London wrote:
> On 8/23/07, Christopher J. PeBenito <cpebenito@tresys.com> wrote:
> > On Wed, 2007-08-22 at 17:52 -0700, Tom London wrote:
> > > On 8/22/07, Daniel J Walsh <dwalsh@redhat.com> wrote:
> > > > Christopher J. PeBenito wrote:
> > > > > On Thu, 2007-08-02 at 15:56 -0400, dwalsh@redhat.com wrote:
> > > > >> Fixes for vmware
> >
> > > > >> @@ -29,7 +29,7 @@
> > > > >>
> > > > >>  allow vmware_host_t self:capability { setuid net_raw };
> > > > >>  dontaudit vmware_host_t self:capability sys_tty_config;
> > > > >> -allow vmware_host_t self:process signal_perms;
> > > > >> +allow vmware_host_t self:process { execstack execmem signal_perms };
> > > > >>  allow vmware_host_t self:fifo_file rw_fifo_file_perms;
> > > > >>  allow vmware_host_t self:unix_stream_socket create_stream_socket_perms;
> > > > >>  allow vmware_host_t self:rawip_socket create_socket_perms;
> > > > >
> > > > > Which version of vmware requires this?  Other parts merged.
> > > > >>
> > > > I think these came from Tom?
> > >
> > > I'm running VMWare Workstation 6.0.
> > >
> > > Need me to recreate?
> >
> > Mainly I want to write a comment in the policy since previous
> > workstation versions didn't need it.  However, if if there has been a
> > vmware update since you hit this, it would be good to verify the rules
> > are still required.
> >
> OK, I 'tested' by doing the following:
> 1. removed vmware.pp via 'semodule -r vmware'
> 2. go into permissive mode ('setenforce 0')
> 3. 'configure VMware' via 'vmware-config.pl -d' (this creates the
> kernel modules and starts the service similarly to 'service vmware
> start')
> 4. started up a vmware machine via 'vmware', shutdown the vm
> 5. shut down vmware via 'service vmware stop'
> 
> The service start/stop are similar to what happens during boot/shutdown.
> 
> I attach the audit.log file with the collected AVCs.  Included are
> some AVCs from current Rawhide libtheora.
> 
> The only thing I did not collect were AVCs from rebooting when init
> would be starting the service.
> 
> This good?

Well I was just concerned about the excemem and execstack, so yes, this
is more than enough.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
