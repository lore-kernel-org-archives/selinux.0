Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mBO6SS5U026016
	for <selinux@tycho.nsa.gov>; Wed, 24 Dec 2008 01:28:28 -0500
Received: from fgwmail7.fujitsu.co.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id mBO6Q0gs025417
	for <selinux@tycho.nsa.gov>; Wed, 24 Dec 2008 06:26:01 GMT
Received: from mt1.gw.fujitsu.co.jp ([10.0.50.74])
	by fgwmail7.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id mBO6SHbj027955
	for <selinux@tycho.nsa.gov> (envelope-from sakaia@jp.fujitsu.com);
	Wed, 24 Dec 2008 15:28:17 +0900
Received: from smail (m4 [127.0.0.1])
	by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 3357945DE50
	for <selinux@tycho.nsa.gov>; Wed, 24 Dec 2008 15:28:17 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
	by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 11D2045DD7A
	for <selinux@tycho.nsa.gov>; Wed, 24 Dec 2008 15:28:17 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id CF24F1DB8016
	for <selinux@tycho.nsa.gov>; Wed, 24 Dec 2008 15:28:16 +0900 (JST)
Received: from m024.s.css.fujitsu.com (m024.s.css.fujitsu.com [10.0.81.64])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 867B21DB8014
	for <selinux@tycho.nsa.gov>; Wed, 24 Dec 2008 15:28:16 +0900 (JST)
Received: from m024.css.fujitsu.com (m024 [127.0.0.1])
	by m024.s.css.fujitsu.com (Postfix) with ESMTP id 779EB18071
	for <selinux@tycho.nsa.gov>; Wed, 24 Dec 2008 15:28:16 +0900 (JST)
Received: from smtp-d.css.fujitsu.com (dhcp110-153.sky.yk.fujitsu.co.jp [10.33.110.153])
	by m024.s.css.fujitsu.com (Postfix) with SMTP id 5200518070
	for <selinux@tycho.nsa.gov>; Wed, 24 Dec 2008 15:28:16 +0900 (JST)
Date: Wed, 24 Dec 2008 15:28:15 +0900
From: Atsushi SAKAI <sakaia@jp.fujitsu.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Question about SELinux userspace library and scripts?
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20081224062816.5200518070@m024.s.css.fujitsu.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

I have a question about user-space library and script.
As far as I know, following 6-library and 1-script are exists.

Userspace library(6-libs(utils included))
  http://userspace.selinuxproject.org/trac/wiki/Userland

macro for reference policy(scripts in following dir)
  serefpolicy-3.5.13/support

Any other library and script exists ?
and 
some explanation about serefpolicy macros?


Thanks
Atsushi SAKAI




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
