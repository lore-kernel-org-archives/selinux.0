Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8KJtTrT020490
	for <selinux@tycho.nsa.gov>; Mon, 20 Sep 2004 15:55:30 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8KJtTT2012239
	for <selinux@tycho.nsa.gov>; Mon, 20 Sep 2004 19:55:29 GMT
Subject: Re: policy patch: some misc additions
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Cc: SELinux ML <selinux@tycho.nsa.gov>
In-Reply-To: <20040917230545.GB2517@jmh.mhn.de>
References: <20040911133324.GA2557@jmh.mhn.de>
	 <1095451769.4295.7.camel@moss-lions.epoch.ncsc.mil>
	 <20040917230545.GB2517@jmh.mhn.de>
Content-Type: text/plain
Message-Id: <1095710080.3225.10.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 20 Sep 2004 15:54:40 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged.

Ended up modifying your second patch and used this:

--- file_contexts/types.fc	13 Sep 2004 19:47:51 -0000	1.46
+++ file_contexts/types.fc	20 Sep 2004 18:20:43 -0000
@@ -333,17 +337,11 @@
 # /usr/lib(64)?
 #
 /usr/lib(64)?(/.*)?			system_u:object_r:lib_t
-/usr/lib(64)?/lib[^/]*\.so(\.[^/]*)*	--	system_u:object_r:shlib_t
-/usr/lib(64)?/python.*\.so	--	system_u:object_r:shlib_t
-/usr/lib(64)?/.*/lib[^/]*\.so(\.[^/]*)* --	system_u:object_r:shlib_t
-/usr/lib(64)?/.*/.*\.so	--	system_u:object_r:shlib_t
-/usr/lib(64)?/autofs/.*\.so	--	system_u:object_r:shlib_t
+/usr/lib(64)?/.*\.so(\.[^/]*)*	--	system_u:object_r:shlib_t
 /usr/lib(64)?/perl5/man(/.*)?	system_u:object_r:man_t
-/usr/lib(64)?/perl.*\.so	--	system_u:object_r:shlib_t
 /usr/lib(64)?/selinux(/.*)?		system_u:object_r:policy_src_t
 /usr/lib(64)?/emacsen-common/.*	system_u:object_r:bin_t
 /usr/lib(64)?/.*/bin(/.*)?		system_u:object_r:bin_t
-/usr/lib(64)?/gconv/.*\.so	--	system_u:object_r:shlib_t
 /usr/share/guile/g-wrapped/.*\.so -- system_u:object_r:shlib_t
 
 #

On Fri, 2004-09-17 at 19:05, Thomas Bleher wrote:
> * James Carter <jwcart2@epoch.ncsc.mil> [2004-09-17 23:58]:
> > On Sat, 2004-09-11 at 09:33, Thomas Bleher wrote:
> > > The following patch against latest CVS adds some misc policy:
> > > 
> > > types.fc: added file contexts for some kde and gnome libraries
> > >           (filenames are like /opt/kde3/lib/kde3/kcalc.so)
> > >           the nVidia libs need some extra file context, too
> > 
> > > diff -ur orig/file_contexts/types.fc mod/file_contexts/types.fc
> > > --- orig/file_contexts/types.fc 2004-09-11 14:31:47.000000000 +0200
> > > +++ mod/file_contexts/types.fc  2004-09-11 14:47:06.000000000 +0200
> > > @@ -336,11 +340,14 @@
> > >  /usr/lib(64)?/autofs/.*\.so    --      system_u:object_r:shlib_t
> > >  /usr/lib(64)?/perl5/man(/.*)?  system_u:object_r:man_t
> > >  /usr/lib(64)?/perl.*\.so       --      system_u:object_r:shlib_t
> > > +/usr/lib(64)?/(NORM|NVIDIA)_lib.*\.so(\.[^/]*)*        --      system_u:object_r:shlib_t
> > > +/usr/lib(64)?/tls/NVIDIA/(NORM|NVIDIA)_lib.*\.so(\.[^/]*)*     --      system_u:object_r:shlib_t
> > >  /usr/lib(64)?/selinux(/.*)?            system_u:object_r:policy_src_t
> > >  /usr/lib(64)?/emacsen-common/.*        system_u:object_r:bin_t
> > >  /usr/lib(64)?/.*/bin(/.*)?             system_u:object_r:bin_t
> > >  /usr/lib(64)?/gconv/.*\.so     --      system_u:object_r:shlib_t
> > >  /usr/share/guile/g-wrapped/.*\.so -- system_u:object_r:shlib_t
> > > +/usr/lib/[^/]*\.so     --      system_u:object_r:shlib_t
> > 
> > Why add this?  Why not /usr/lib(64)?/[^/]*\.so ?
> 
> Because I have no 64bit system and didn't think of it? ;-)
> 
> > If this rule is added, some other rules can be deleted.
> 
> True. We already have
> /usr/lib(64)?/.*/.*\.so --      system_u:object_r:shlib_t
> a few lines above, so we can probably just say
> /usr/lib(64)?/.*\.so    --      system_u:object_r:shlib_t
> and be OK.
> 
> Patch which does this attached.
> 
> Thomas
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
