Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7T7M1rT028792
	for <selinux@tycho.nsa.gov>; Sun, 29 Aug 2004 03:22:01 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7T7LBwc022236
	for <selinux@tycho.nsa.gov>; Sun, 29 Aug 2004 07:21:12 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: patches for xdm.te for kdm 3.3
Date: Sun, 29 Aug 2004 17:21:55 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <20040828164528.GC11546@lkcl.net>
In-Reply-To: <20040828164528.GC11546@lkcl.net>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_TQYMBKlKY1C2sEE"
Message-Id: <200408291721.55576.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_TQYMBKlKY1C2sEE
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sun, 29 Aug 2004 02:45, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wro=
te:
> i'm running kdm 3.3, also i'm running an "immediate user login" with no
> password.
>
> added these to get it to work.
>
> also as you can see i changed the type of /etc/qt3 to etc_runtime_t.

file_type_auto_trans(xdm_t, var_run_t, xdm_var_run_t, { dir fifo_file} )

This won't work properly due to a limitation of the file_type_trans() macro=
=2E =20
You must have separate lines for "dir" and "fifo_file" (see the attached=20
patch).

allow xdm_t etc_runtime_t:file { getattr read lock };

Does it work if you put in a dontaudit rule for lock access?  I don't think=
 it=20
should require lock access.

allow xdm_t etc_runtime_t:dir { getattr search };

This is wrong.  There should not be a etc_runtime_t:dir object.  If there i=
s=20
no file_contexts rule for assigning a type to an object and the type in=20
question is not tmpfile then generally you should not include any rules=20
permitting access to the objct.

# had to change /etc/qt3 to etc_runtime_t too

The type xdm_rw_etc_t seems appropriate for this.

allow xdm_t init_t:process { signal };
       #EXE=3D/sbin/halt   :  signal

allow xdm_t xdm_t:capability { sys_boot };

I think that we need a different domain for this.

can_exec(xdm_t, xsession_exec_t)

That looks like a bug.  xsession_exec_t scripts are supposed to execute in=
=20
user context.  Looks like the kdm patch does not set the execute context=20
everywhere that it should.


=46rom the current state I expect that it'll be at least another two iterat=
ions=20
and some bug reports getting filed before your xdm policy patch is ready to=
=20
be included.

=2D-=20
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_TQYMBKlKY1C2sEE
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="x.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="x.diff"

--- /usr/src/se/policy/domains/program/unused/xdm.te	2004-08-28 12:05:08.000000000 +1000
+++ domains/program/unused/xdm.te	2004-08-29 17:11:18.000000000 +1000
@@ -29,6 +29,7 @@
 allow xdm_t xdm_var_run_t:fifo_file create_file_perms;
 allow initrc_t xdm_var_run_t:fifo_file unlink;
 file_type_auto_trans(xdm_t, var_run_t, xdm_var_run_t, fifo_file)
+file_type_auto_trans(xdm_t, var_run_t, xdm_var_run_t, dir)
 
 tmp_domain(xdm)
 var_lib_domain(xdm)

--Boundary-00=_TQYMBKlKY1C2sEE--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
