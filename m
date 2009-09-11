Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n8BA1DaN012609
	for <selinux@tycho.nsa.gov>; Fri, 11 Sep 2009 06:01:13 -0400
Received: from mail.seekline.net (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n8BA0VWs023102
	for <selinux@tycho.nsa.gov>; Fri, 11 Sep 2009 10:00:31 GMT
Received: from [IPv6:2001:6f8:1294:1:211:24ff:fee1:776c] ([IPv6:2001:6f8:1294:1:211:24ff:fee1:776c])
	(authenticated bits=0)
	by mail.seekline.net (8.13.8/8.13.8) with ESMTP id n8BA14xZ007950
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <selinux@tycho.nsa.gov>; Fri, 11 Sep 2009 12:01:11 +0200
Subject: how to use require and gen_require properly
From: Stefan Schulze Frielinghaus <stefan@seekline.net>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Fri, 11 Sep 2009 12:01:03 +0200
Message-Id: <1252663263.2491.38.camel@vogon.seekline.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm writing a new policy for a special purpose and don't expect to
submit it for refpolicy because it is just too domain specific and not
useful for public domain. Therefore I cannot write a new interface which
could be included in the default policy.

Here is my actual problem. I want to use filetrans because my daemon
creates /dev/twa0 automatically. Therefore I have to write something
like this:

filetrans_pattern(my_daemon_t, device_t, fixed_disk_device_t, chr_file)

Should I include the following require statement at the top of my te
file:

require {
	type device_t, fixed_disk_device_t;
}

or should I use this one:

gen_require(`
	type _device_t, fixed_disk_device_t;
')

What is the actual difference between require and gen_require? Is it
allowed to write such statements at the top of the policy or in general
is this good practice or not? What was the actual intention of having
two require statements? I guess the gen_require was especially for
interfaces. But which one should be used if no interface is used?

Some clarification would be really appreciated.

- Stefan


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
