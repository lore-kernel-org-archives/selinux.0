Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8KKiGrT020801
	for <selinux@tycho.nsa.gov>; Mon, 20 Sep 2004 16:44:16 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8KKhHoq024195
	for <selinux@tycho.nsa.gov>; Mon, 20 Sep 2004 20:43:17 GMT
Message-ID: <414F4113.1000208@redhat.com>
Date: Mon, 20 Sep 2004 16:44:03 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Colin Walters <walters@verbum.org>
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>,
   Joshua Brindle <method@gentoo.org>, Russell Coker <russell@coker.com.au>,
   SELinux Mail List <selinux@tycho.nsa.gov>
Subject: File types that are not sysadmfiles...
References: <414DA0A7.1000708@gentoo.org>	 <200409200646.51865.russell@coker.com.au> <414DF5F2.9030700@gentoo.org>	 <200409200729.50087.russell@coker.com.au>  <414E1AC3.2070209@gentoo.org>	 <1095651232.4431.123.camel@nexus.verbum.private>	 <1095684970.8397.117.camel@selinux> <1095695627.4431.157.camel@nexus.verbum.private>
In-Reply-To: <1095695627.4431.157.camel@nexus.verbum.private>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

grep file_type policy.conf | grep -v sysadmfile | grep "^type "
type device_t, file_type, dev_fs;
type printer_device_t, file_type, device_type, dev_fs;
type shadow_t, file_type;
type policy_config_t, file_type;
type policy_src_t, file_type;
type httpd_php_exec_t, file_type, exec_type;
type lvm_control_t, file_type, device_type, dev_fs;
type rpmbuild_exec_t, file_type, exec_type;
type vmware_user_exec_t, file_type, exec_type;
type vmware_device_t, file_type, device_type, dev_fs;
type vmware_user_var_run_t, file_type, pidfile;
type vmware_user_file_t, homedirfile, file_type;
type vmware_user_conf_t, homedirfile, file_type;
type watchdog_device_t, file_type, device_type, dev_fs;


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
