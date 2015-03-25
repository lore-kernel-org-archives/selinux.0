Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t2P1vZYS019637
 for <selinux@tycho.nsa.gov>; Tue, 24 Mar 2015 21:57:37 -0400
Received: from tracyreed.org (wsip-98-175-106-200.sd.sd.cox.net
 [98.175.106.200])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mail.copilotco.com (Postfix) with ESMTP id A2E1E64C5C
 for <selinux@tycho.nsa.gov>; Tue, 24 Mar 2015 18:57:31 -0700 (PDT)
Date: Tue, 24 Mar 2015 18:57:53 -0700
From: Tracy Reed <treed@ultraviolet.org>
To: selinux@tycho.nsa.gov
Subject: Is there a macro for this?
Message-ID: <20150325015752.GG32173@tracyreed.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="maH1Gajj2nflutpK"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--maH1Gajj2nflutpK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I've written my own policy to confine a custom in-house developed
service.  I am getting the following denials. I'm pretty sure there is a
macro or macros I can use to allow all of these common sorts of things to
happen as I'm pretty sure I used it a few years ago but I can't recall or
find it. Can anyone point me in the right direction?

Thanks!

#=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D initrc_t =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
allow initrc_t myapp_cid_t:dir { getattr search };
allow initrc_t myapp_cid_t:file { read getattr open };
allow initrc_t myapp_java_t:dir { getattr search };

#=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D locate_t =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
allow locate_t myapp_bin_t:dir getattr;
allow locate_t myapp_cid_t:dir { read search open getattr };
allow locate_t myapp_include_t:dir { getattr search };
allow locate_t myapp_java_t:dir { read getattr open search };
allow locate_t myapp_lib64_t:dir { read search open getattr };
allow locate_t myapp_lib_t:dir { read getattr open search };
allow locate_t myapp_logs_t:dir { read search open getattr };
allow locate_t myapp_node_api_t:dir getattr;
allow locate_t myapp_node_bin_t:dir getattr;
allow locate_t myapp_node_conf_t:dir { getattr search };
allow locate_t myapp_node_incoming-dist_t:dir getattr;
allow locate_t myapp_node_lib_t:dir { getattr search };
allow locate_t myapp_node_logs_t:dir getattr;
allow locate_t myapp_node_scripts_t:dir getattr;
allow locate_t myapp_node_tomcat_t:dir { read getattr open search };
allow locate_t myapp_node_util_t:dir getattr;
allow locate_t myapp_node_var_t:dir getattr;
allow locate_t myapp_node_webapps_t:dir { read getattr open search };
allow locate_t myapp_runbooktmp_t:dir getattr;
allow locate_t myapp_share_t:dir { read getattr open search };
allow locate_t myapp_snc-provision_t:dir { read getattr open search };
allow locate_t myapp_temp_t:dir getattr;

#=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D logrotate_t =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
allow logrotate_t var_t:file getattr;

#=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D rpm_t =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
allow rpm_t myapp_bin_t:dir { getattr search };
allow rpm_t myapp_bin_t:file { read getattr open };
allow rpm_t myapp_bin_t:lnk_file { read getattr };
allow rpm_t myapp_cid_t:dir { search getattr };
allow rpm_t myapp_cid_t:file { read getattr open };
allow rpm_t myapp_include_t:dir { getattr search };
allow rpm_t myapp_include_t:file { read getattr open };
allow rpm_t myapp_java_t:dir { getattr search };
allow rpm_t myapp_java_t:file { read getattr open };
allow rpm_t myapp_java_t:lnk_file { read getattr };
allow rpm_t myapp_lib64_t:dir { getattr search };
allow rpm_t myapp_lib64_t:file { read getattr open };
allow rpm_t myapp_lib_t:dir { search getattr };
allow rpm_t myapp_lib_t:file { read getattr open };
allow rpm_t myapp_lib_t:lnk_file { read getattr };
allow rpm_t myapp_logs_t:dir getattr;
allow rpm_t myapp_runbooktmp_t:dir getattr;
allow rpm_t myapp_share_t:dir { getattr search };
allow rpm_t myapp_share_t:file { read getattr open };
allow rpm_t myapp_temp_t:dir getattr;

#=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D system_cronjob_t =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
allow system_cronjob_t myapp_bin_t:dir { search getattr };
allow system_cronjob_t myapp_bin_t:file { ioctl execute read open getattr e=
xecute_no_trans };
allow system_cronjob_t myapp_bin_t:lnk_file { read getattr };
allow system_cronjob_t myapp_include_t:dir search;
allow system_cronjob_t myapp_include_t:file { read getattr open };
allow system_cronjob_t myapp_lib64_t:dir { read search open getattr };
allow system_cronjob_t myapp_lib64_t:file { read getattr open execute };
allow system_cronjob_t myapp_lib_t:dir { read search open getattr };
allow system_cronjob_t myapp_lib_t:file { read getattr open execute };
allow system_cronjob_t myapp_logs_t:dir { read getattr open search };
allow system_cronjob_t myapp_logs_t:lnk_file read;
allow system_cronjob_t myapp_node_api_t:dir { read getattr open search };
allow system_cronjob_t myapp_node_bin_t:dir { read getattr open search };
allow system_cronjob_t myapp_node_conf_t:dir { read getattr open search };
allow system_cronjob_t myapp_node_conf_t:file { read ioctl open getattr };
allow system_cronjob_t myapp_node_myapp-release_t:file { read getattr open =
};
allow system_cronjob_t myapp_node_incoming-dist_t:dir { read getattr open s=
earch };
allow system_cronjob_t myapp_node_lib_t:dir { read getattr open search };
allow system_cronjob_t myapp_node_logs_t:dir { read getattr open search };
allow system_cronjob_t myapp_node_logs_t:file getattr;
allow system_cronjob_t myapp_node_scripts_t:dir { read getattr open search =
};
allow system_cronjob_t myapp_node_tomcat_t:dir { read getattr open search };
allow system_cronjob_t myapp_node_util_t:dir { read getattr open search };
allow system_cronjob_t myapp_node_var_t:dir { read getattr open search };
allow system_cronjob_t myapp_node_webapps_t:dir { read getattr open search =
};

#=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D unconfined_t =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
allow unconfined_t myapp_bin_t:dir { search getattr };
allow unconfined_t myapp_bin_t:file { read getattr open execute execute_no_=
trans };
allow unconfined_t myapp_bin_t:lnk_file { read getattr };
allow unconfined_t myapp_include_t:dir search;
allow unconfined_t myapp_include_t:file { read getattr open };
allow unconfined_t myapp_lib64_t:dir { read search open getattr };
allow unconfined_t myapp_lib64_t:file { read getattr open execute };
allow unconfined_t myapp_lib_t:dir { read search open getattr };
allow unconfined_t myapp_lib_t:file { read getattr open execute };
allow unconfined_t myapp_node_bin_t:file getattr;
allow unconfined_t myapp_node_conf_t:dir search;
allow unconfined_t myapp_node_conf_t:file { read getattr open };
allow unconfined_t myapp_node_webapps_t:dir search;
#!!!! The source type 'unconfined_t' can write to a 'dir' of the following =
types:
# user_home_dir_t, user_tmpfs_t, user_tmp_t, unlabeled_t, proc_type, sandbo=
x_file_t, filesystem_type, user_home_type, sysctl_type, file_type, nfs_t


--=20
Tracy Reed

--maH1Gajj2nflutpK
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFVEhYgBhSTPg0d/nQRAkZ6AKC5cN4QonAnWAvIG/PYLVNaCQ7y/wCfddwn
PKZKm93xYD64UA0ezRq2Hoo=
=sYnV
-----END PGP SIGNATURE-----

--maH1Gajj2nflutpK--
