Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8MKP5rT004636
	for <selinux@tycho.nsa.gov>; Wed, 22 Sep 2004 16:25:05 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8MKP2WF024484
	for <selinux@tycho.nsa.gov>; Wed, 22 Sep 2004 20:25:02 GMT
Subject: Re: File types that are not sysadmfiles...
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Russell Coker <russell@coker.com.au>
Cc: Daniel J Walsh <dwalsh@redhat.com>, Colin Walters <walters@verbum.org>,
   "Christopher J. PeBenito" <cpebenito@tresys.com>,
   Joshua Brindle <method@gentoo.org>,
   SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <200409211508.59158.russell@coker.com.au>
References: <414DA0A7.1000708@gentoo.org>
	 <1095695627.4431.157.camel@nexus.verbum.private>
	 <414F4113.1000208@redhat.com>  <200409211508.59158.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1095884556.11254.8.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 22 Sep 2004 16:22:36 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged.

On Tue, 2004-09-21 at 01:08, Russell Coker wrote:
> On Tue, 21 Sep 2004 06:44, Daniel J Walsh <dwalsh@redhat.com> wrote:
> > grep file_type policy.conf | grep -v sysadmfile | grep "^type "
> > type printer_device_t, file_type, device_type, dev_fs;
> > type httpd_php_exec_t, file_type, exec_type;
> > type lvm_control_t, file_type, device_type, dev_fs;
> > type vmware_user_exec_t, file_type, exec_type;
> > type vmware_device_t, file_type, device_type, dev_fs;
> > type vmware_user_var_run_t, file_type, pidfile;
> > type vmware_user_file_t, homedirfile, file_type;
> > type vmware_user_conf_t, homedirfile, file_type;
> > type watchdog_device_t, file_type, device_type, dev_fs;
> 
> The above are all bugs in the policy.  I have attached a patch that fixes them 
> along with a few other minor things.
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
