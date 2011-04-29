Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p3TN92t7003754
	for <selinux@tycho.nsa.gov>; Fri, 29 Apr 2011 19:09:02 -0400
Received: from phoenicia.airattack-central.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p3TN911n027054
	for <selinux@tycho.nsa.gov>; Fri, 29 Apr 2011 23:09:01 GMT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by phoenicia.airattack-central.com (Postfix) with ESMTP id 272D0BD000F
	for <selinux@tycho.nsa.gov>; Fri, 29 Apr 2011 23:09:01 +0000 (UTC)
Received: from phoenicia.airattack-central.com ([127.0.0.1])
	by localhost (phoenicia.airattack-central.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nesSSB8IxGjw for <selinux@tycho.nsa.gov>;
	Sat, 30 Apr 2011 01:09:00 +0200 (CEST)
Received: from [192.168.1.50] (host-87-75-140-85.dslgb.com [87.75.140.85])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by phoenicia.airattack-central.com (Postfix) with ESMTP id 6F71FBD0001
	for <selinux@tycho.nsa.gov>; Sat, 30 Apr 2011 01:09:00 +0200 (CEST)
Subject: xattr support in cgroupfs
From: Matthew Ife <deleriux@airattack-central.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 30 Apr 2011 00:05:51 +0100
Message-ID: <1304118351.23317.1.camel@home.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I was wondering what peoples' thoughts where on doing this.

At the moment cgroupfs does not support xattrs so no labelling of selinux
types is permitted, but since /proc and other pseudo filesystems support
it this should be possible.

There are a number of use-cases which would benefit from this. For
example I have recently been working with application layer integration
of libcgroup with other services (apache being able to switch
cgroups for vhosts for example) because cgroups offer an excellent means
of offering resource control to prevent abuse of resources.

Aa a typical example i'd like to be able to label some cgroups in
cgroupfs as "httpd_cgroup_t" / "httpd_cgroup_task_t" so that I can
control the access of the files it creates for administering tasks and
altering what goes in the task list. But currently I must give httpd_t
complete access to cgroup_t files. I can use DAC effectively enough to
limit access but without SELinux backing me up it makes me feel somewhat
naked.

As a matter of fact, I started patching libcgroup to support labelling
cgroupfs without realizing this facility is unsupported! So I have about
70% of an effective patch to do this work properly within libcgroup too.

I welcome peoples' thoughts on this idea.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
