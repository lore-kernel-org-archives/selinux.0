Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1LJwbe7031428
	for <selinux@tycho.nsa.gov>; Thu, 21 Feb 2008 14:58:37 -0500
Received: from fg-out-1718.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1LJwZB1022704
	for <selinux@tycho.nsa.gov>; Thu, 21 Feb 2008 19:58:35 GMT
Received: by fg-out-1718.google.com with SMTP id 16so114270fgg.40
        for <selinux@tycho.nsa.gov>; Thu, 21 Feb 2008 11:58:34 -0800 (PST)
Message-ID: <cadfc0e40802211158s3f794202s98fff7dd99f3492@mail.gmail.com>
Date: Thu, 21 Feb 2008 13:58:33 -0600
From: "Xavier Toth" <txtoth@gmail.com>
To: "Daniel J Walsh" <dwalsh@redhat.com>
Subject: Re: FC8 enforcing auditd, mcstransd, NFS statd fail to start
Cc: "SE Linux" <selinux@tycho.nsa.gov>
In-Reply-To: <47BCAC42.50003@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <cadfc0e40802201124l5f8b2330x159eb3f7485687c4@mail.gmail.com>
	 <47BCAC42.50003@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Everyone else will too.

--- serefpolicy-3.0.8/policy/modules/system/logging.te  2008-02-21
13:10:20.000000000 -0600
+++ serefpolicy-3.0.8.new/policy/modules/system/logging.te
2008-02-21 13:46:32.000000000 -0600
@@ -162,6 +162,8 @@

 miscfiles_read_localization(auditd_t)

+init_use_script_fds(auditd_t)
+mls_fd_use_all_levels(auditd_t)
 mls_file_read_all_levels(auditd_t)
 mls_file_write_all_levels(auditd_t) # Need to be able to write to
/var/run/ directory

--- serefpolicy-3.0.8/policy/modules/system/setrans.te  2007-09-18
09:48:05.000000000 -0500
+++ serefpolicy-3.0.8.new/policy/modules/system/setrans.te
2008-02-21 13:44:42.000000000 -0600
@@ -52,6 +52,7 @@

 files_read_etc_runtime_files(setrans_t)

+mls_fd_use_all_levels(setrans_t)
 mls_file_read_all_levels(setrans_t)
 mls_file_write_all_levels(setrans_t)
 mls_net_receive_all_levels(setrans_t)


On Wed, Feb 20, 2008 at 4:40 PM, Daniel J Walsh <dwalsh@redhat.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
>  Hash: SHA1
>
>
>
>  Xavier Toth wrote:
>  > type=AVC msg=audit(1197625021.926:66): avc:  denied  { write } for
>  > pid=1494 comm="audispd" path="socket:[7238]" dev=sockfs ino=7238
>  > scontext=system_u:system_r:auditd_t:s15:c0.c1023
>  > tcontext=system_u:system_r:auditd_t:s0-s15:c0.c1023
>  > tclass=unix_stream_socket
>  >
>  > type=AVC msg=audit(1203524274.667:562): avc:  denied  { use } for
>  > pid=19909 comm="mcstransd" path="/lib/ld-2.7.so" dev=dm-0 ino=2359430
>  > scontext=system_u:system_r:setrans_t:s15:c0.c1023
>  > tcontext=system_u:system_r:initrc_t:s0-s15:c0.c1023 tclass=fd
>  >
>  > --
>  > This message was distributed to subscribers of the selinux mailing list.
>  > If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>  > the words "unsubscribe selinux" without quotes as the message.
>  Looks like you have an MLS constraint problem.
>  -----BEGIN PGP SIGNATURE-----
>  Version: GnuPG v1.4.8 (GNU/Linux)
>  Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org
>
>  iEYEARECAAYFAke8rEIACgkQrlYvE4MpobP0CACgqFCF2JTlJQVyHNNTpfx5pJpo
>  8poAoJlMUL0Qp529P5+jLhpOV/yJFNUl
>  =GfHP
>  -----END PGP SIGNATURE-----
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
