Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8I2Pv97019177
	for <selinux@tycho.nsa.gov>; Wed, 17 Sep 2008 22:25:57 -0400
Received: from tyo201.gate.nec.co.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m8I2P5sb019448
	for <selinux@tycho.nsa.gov>; Thu, 18 Sep 2008 02:25:06 GMT
Received: from mailgate3.nec.co.jp ([10.7.69.192])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id m8I2PYkU024750
	for <selinux@tycho.nsa.gov>; Thu, 18 Sep 2008 11:25:34 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC)
	id m8I2PY404244 for selinux@tycho.nsa.gov; Thu, 18 Sep 2008 11:25:34 +0900 (JST)
Received: from mailsv.linux.bs1.fc.nec.co.jp (mailsv.linux.bs1.fc.nec.co.jp [10.34.125.2])
	by mailsv3.nec.co.jp (8.13.8/8.13.4) with ESMTP id m8I2PY3u014959
	for <selinux@tycho.nsa.gov>; Thu, 18 Sep 2008 11:25:34 +0900 (JST)
Received: from [10.19.71.82] (unknown [10.19.71.82])
	by mailsv.linux.bs1.fc.nec.co.jp (Postfix) with ESMTP id 24352E4827A
	for <selinux@tycho.nsa.gov>; Thu, 18 Sep 2008 11:25:34 +0900 (JST)
Message-ID: <48D1BC1D.4030507@ak.jp.nec.com>
Date: Thu, 18 Sep 2008 11:25:33 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: PHP/SELinux: libselinux wrappers
References: <48C61A84.9010001@ak.jp.nec.com>
In-Reply-To: <48C61A84.9010001@ak.jp.nec.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I wrote the list of PHP/SELinux APIs:
  http://code.google.com/p/sepgsql/wiki/Memo_PHP_SELinux

Does anyone be possible to check the specification of them
before submitting it to PHP developer's list?

Thanks,

KaiGai Kohei wrote:
> Hi,
> 
> I tried to implement libselinux wrappers for PHP.
> 
> It requires the following steps to build.
> 
>  $ svn checkout http://sepgsql.googlecode.com/svn/misc/php-selinux
>  $ cd php-selinux
>  $ ./build-php-selinux.sh  /tmp/php-5.2.6-4.src.rpm
> 
>  (*) You have to get the source rpm package from somewhere.
> 
> It is a conceptual implementation earlier than submitting
> to PHP developer's community.
> 
> Please comment anything, if you have.
> I have a plan to submit it to them with some more works like
> documentation, test cases.
> 
> Thanks,

-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
