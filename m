Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n1Q6MxfS029371
	for <selinux@tycho.nsa.gov>; Thu, 26 Feb 2009 01:22:59 -0500
Received: from tyo201.gate.nec.co.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n1Q6JRkb003379
	for <selinux@tycho.nsa.gov>; Thu, 26 Feb 2009 06:19:28 GMT
Received: from mailgate3.nec.co.jp ([10.7.69.195])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id n1Q6MWv8020176
	for <selinux@tycho.nsa.gov>; Thu, 26 Feb 2009 15:22:32 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC)
	id n1Q6MW217833 for selinux@tycho.nsa.gov; Thu, 26 Feb 2009 15:22:32 +0900 (JST)
Received: from mailsv.linux.bs1.fc.nec.co.jp (mailsv.linux.bs1.fc.nec.co.jp [10.34.125.2])
	by mailsv.nec.co.jp (8.13.8/8.13.4) with ESMTP id n1Q6MVA7023506
	for <selinux@tycho.nsa.gov>; Thu, 26 Feb 2009 15:22:31 +0900 (JST)
Received: from [10.19.71.82] (unknown [10.19.71.82])
	by mailsv.linux.bs1.fc.nec.co.jp (Postfix) with ESMTP id 6195BE482A0
	for <selinux@tycho.nsa.gov>; Thu, 26 Feb 2009 15:22:31 +0900 (JST)
Message-ID: <49A63527.2020104@ak.jp.nec.com>
Date: Thu, 26 Feb 2009 15:22:31 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: PHP/SELinux: libselinux wrappers
References: <48C61A84.9010001@ak.jp.nec.com>
In-Reply-To: <48C61A84.9010001@ak.jp.nec.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

I tried to implement a libselinux wrapper for PHP script language
several months ago.

Now, I have a plan to propose the facility into official extensions
of PHP community, called as PECL (PHP Extension Community Library),
and Fedora project.

Before that, I would like folks to check the list of supported APIs.

* The list of APIs : PHP/SELinux binding
  http://code.google.com/p/sepgsql/wiki/Memo_PHP_SELinux

  NOTE:
   - All the "_raw" interfaces are omitted, because we can translate
     a human readable format into a system one later using
       string selinux_trans_to_raw_context(string $context).
   - All the AVC related interfaces are omitted, because I didn't
     assume PHP script works as a userspace object manager.

* Step to build and installation
  % svn checkout http://sepgsql.googlecode.com/svn/misc/php-selinux
  % cd php-selinux
  % ./build-php-selinux.sh
         :
  Wrote: /home/kaigai/RPMS/SRPMS/php-selinux-0.1626-beta.fc10.src.rpm
  Wrote: /home/kaigai/RPMS/RPMS/i386/php-selinux-0.1626-beta.fc10.i386.rpm
         :
  % su
  # rpm -Uvh /path/to/package/php-selinux-0.1626-beta.fc10.i386.rpm

  NOTE:
   - It requires "php-devel" and "libselinux-devel" are installed
     prior to ./build-php-selinux.sh
   - It requires "rpmbuild" works correctly. Please confirm your
     ~/.rpmmacros, if the script does not work correctly.

* Example:
  % rpm -q php-selinux
  php-selinux-0.1626-beta.fc10.i386
  % php -r 'echo selinux_getcon()."\n";'
  unconfined_u:unconfined_r:unconfined_t:SystemLow-SystemMiddle
  % php -r 'echo selinux_getfilecon("/etc/shadow")."\n";'
  system_u:object_r:shadow_t
  % php -r '$tclass = selinux_string_to_class("file");
            $avd = selinux_compute_av("staff_u:staff_r:staff_t:s0",
                                      "system_u:object_r:etc_t:s0",
                                      $tclass);
            var_dump($avd);'
  array(5) {
    ["allowed"]=>
    int(139347)
    ["decided"]=>
    int(-1)
    ["auditallow"]=>
    int(0)
    ["auditdeny"]=>
    int(-17)
    ["seqno"]=>
    int(41)
  }

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
