Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l8ILS8co006513
	for <selinux@tycho.nsa.gov>; Tue, 18 Sep 2007 17:28:08 -0400
Received: from py-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l8ILS7m4016608
	for <selinux@tycho.nsa.gov>; Tue, 18 Sep 2007 21:28:07 GMT
Received: by py-out-1112.google.com with SMTP id u77so4391816pyb
        for <selinux@tycho.nsa.gov>; Tue, 18 Sep 2007 14:28:07 -0700 (PDT)
Message-ID: <f71a82820709181428j1e8cc81fwc4907a3b18bd5589@mail.gmail.com>
Date: Wed, 19 Sep 2007 06:28:06 +0900
From: "Shintaro Fujiwara" <shintaro.fujiwara@gmail.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        selinux <selinux@tycho.nsa.gov>
Subject: Re: [PATCH] fstools.te needs corecmd_exec_bin
In-Reply-To: <1190138720.17544.13.camel@gorn>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <f71a82820709181039s6aeac4eaq404542de3148c411@mail.gmail.com>
	 <1190138720.17544.13.camel@gorn>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Will this OK?

Index: policy/modules/system/fstools.fc
===================================================================
--- policy/modules/system/fstools.fc    (revision 2423)
+++ policy/modules/system/fstools.fc    (working copy)
@@ -1,3 +1,4 @@
+/sbin/badblocks	--	gen_context(system_u:object_r:fsadm_exec_t,s0)
 /sbin/blkid		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
 /sbin/blockdev		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
 /sbin/cfdisk		--	gen_context(system_u:object_r:fsadm_exec_t,s0)


2007/9/19, Christopher J. PeBenito <cpebenito@tresys.com>:
> On Wed, 2007-09-19 at 02:39 +0900, Shintaro Fujiwara wrote:
> > I have attached usb hdd on my strict machine and typed
> > mkfs -c /dev/sdb
> > and error saying cannot execute /sbin/badblocks.
> > I always use -c with mkfs command so I added
> > this line to fstools.te.
>
> I think instead badblocks should be labeled fsadm_exec_t.
>
> > Index: policy/modules/system/fstools.te
> > ===================================================================
> > --- policy/modules/system/fstools.te    (revision 2422)
> > +++ policy/modules/system/fstools.te    (working copy)
> > @@ -119,6 +119,9 @@
> >  corecmd_read_bin_pipes(fsadm_t)
> >  corecmd_read_bin_sockets(fsadm_t)
> >
> > +# for mkfs -c
> > +corecmd_exec_bin(fsadm_t)
> > +
> >  domain_use_interactive_fds(fsadm_t)
> >
> >  files_list_home(fsadm_t)
> >
> > --
> > This message was distributed to subscribers of the selinux mailing list.
> > If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> > the words "unsubscribe selinux" without quotes as the message.
> --
> Chris PeBenito
> Tresys Technology, LLC
> (410) 290-1411 x150
>
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
