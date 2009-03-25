Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n2PBe4GP010874
	for <selinux@tycho.nsa.gov>; Wed, 25 Mar 2009 07:40:04 -0400
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n2PBa7DJ023685
	for <selinux@tycho.nsa.gov>; Wed, 25 Mar 2009 11:36:07 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.14.3/8.14.3) with ESMTP id n2PBdhUn028274
	for <selinux@tycho.nsa.gov>; Wed, 25 Mar 2009 07:39:43 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.14.3/8.14.3/Submit) id n2PBdhW9028272
	for selinux@tycho.nsa.gov; Wed, 25 Mar 2009 07:39:43 -0400
Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n2P19HVB014684
	for <selinux@tycho.nsa.gov>; Tue, 24 Mar 2009 21:09:17 -0400
Received: from tyo202.gate.nec.co.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n2P15Kow016790
	for <selinux@tycho.nsa.gov>; Wed, 25 Mar 2009 01:05:20 GMT
Received: from mailgate3.nec.co.jp ([10.7.69.192])
	by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id n2P18tsb027225
	for <selinux@tycho.nsa.gov>; Wed, 25 Mar 2009 10:08:55 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC)
	id n2P18to04429 for selinux@tycho.nsa.gov; Wed, 25 Mar 2009 10:08:55 +0900 (JST)
Received: from mailsv.linux.bs1.fc.nec.co.jp (mailsv.linux.bs1.fc.nec.co.jp [10.34.125.2])
	by mailsv.nec.co.jp (8.13.8/8.13.4) with ESMTP id n2P18tY5027204
	for <selinux@tycho.nsa.gov>; Wed, 25 Mar 2009 10:08:55 +0900 (JST)
Received: from [10.19.71.82] (unknown [10.19.71.82])
	by mailsv.linux.bs1.fc.nec.co.jp (Postfix) with ESMTP id 501DFE482A3
	for <selinux@tycho.nsa.gov>; Wed, 25 Mar 2009 10:08:55 +0900 (JST)
Message-ID: <49C98427.8080300@ak.jp.nec.com>
Date: Wed, 25 Mar 2009 10:08:55 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: [Fwd: [idea] web-application security powered by SELinux]
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

FYI,

I posted a message to open discussion for SELinux support on apache/httpd.
If you like to join the topic, please subscribe the "http-dev" list here.

  http://httpd.apache.org/lists.html#http-dev

-------- Original Message --------
Subject: [idea] web-application security powered by SELinux
Date: Wed, 25 Mar 2009 09:55:06 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
Reply-To: dev@httpd.apache.org
To: dev@httpd.apache.org

Hello,

Now I have considered the way to work web-applications with restrictive
privileges set based on an identification of the client. It enables to
check and prevent violated actions from (buggy) applications using
features provided by the operating system.

I'm concerned about most of web-application, such as PHP scripts, are
launched as part of web-server process itself. It also means all the
web-application instances share the same privilege set of the server
process, even if these are invoked on the requests come from different
users. In other word, we cannot apply valid access controls on them
(except for ones applied by web-application itself, but it is hard to
ensure they don't have security bugs), because it seems to the operating
system multiple processes/threads with same privileges run simultaneously.

If we can run web-applications with more restrictive privileges set
for each users, groups and so on, the operating system can acquire
any actions from userspace and apply its access control policies.
I assume SELinux as the operating system feature here, but not
limited to SELinux. I guess this discussion can be applied on any
other advanced security features also.

In my opinion, we need the following three facilities:

1. The backend identifies the client and decide what privileges should
   be assigned on the launched web-applications prior to its invocation.
   The existing http-authentication is a candidate, but we don't assume
   a certain method to identify the client.

2. The backend creates a one-time thread or process to handle the given
   requests, and assigns the new privileges, then launches the worker
   thread or process to invoke contents handler.

3. The backend wait for the completion of the worker. The reason why
   we don't use them again is that it is fundamentally danger to allow
   a path to revert the privileges of web-application.

Please note that we don't assume users who want to use this feature
give first priority for performance. It is a kind of security tradeoff.

One idea is to add a security focused MPM which provide above features
and hooks for external modules.
I've actually developed a working example based on the "prefork" MPM.
When it accepts a request from the client, it creates a one-time thread
and assigns a new security context (which is a privileges set in SELinux),
then invokes contents handler.

  http://code.google.com/p/sepgsql/source/browse/misc/httpd-selinux/

However, I don't adhere the current implementation as is.
I would like to have a discussion to brush up the idea to achieve
the goal and to get acceptance in the mainline.

Any comments, questions and others are welcome.

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
