Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72KvE7D027781
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 16:57:14 -0400
Received: from fk-out-0910.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l72KvCM1010860
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 20:57:13 GMT
Received: by fk-out-0910.google.com with SMTP id 19so949523fkr
        for <selinux@tycho.nsa.gov>; Thu, 02 Aug 2007 13:57:12 -0700 (PDT)
Message-ID: <f71a82820708021357o66c94abbgfd73370b98fdbcca@mail.gmail.com>
Date: Fri, 3 Aug 2007 05:57:12 +0900
From: "Shintaro Fujiwara" <shintaro.fujiwara@gmail.com>
To: selinux <selinux@tycho.nsa.gov>
Subject: libsepol.print_missing_requirements
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
I made a .pp file by policygentool in devel directory.
But can not istall .pp file in strict policy.
I added many type/attribute as global requirements.
And finally, libsemanage says common (null) were not met.

I did

semodule -b base.pp

in /usr/share/selinux/strict directory,
but can_send_audit_msg were not met.

so, I did

semodule -b base.pp

in /etc/selinux/strict/modules/active

it worked.

Still I can't install my .pp file.


Why and what sould I do ?

Please help...

version

selinux-policy-strict-2.6.4-29.fc7
selinux-doc-1.26-1.1
libselinux-2.0.14-4.fc7
selinux-policy-mls-2.6.4-29.fc7
libselinux-devel-2.0.14-4.fc7
selinux-policy-2.6.4-29.fc7
selinux-policy-targeted-2.6.4-29.fc7
libselinux-python-2.0.14-4.fc7
selinux-policy-devel-2.6.4-29.fc7
libsepol-devel-2.0.3-1.fc7
libsepol-2.0.3-1.fc7
libsemanage-2.0.3-4.fc7
policycoreutils-2.0.16-6.fc7
policycoreutils-2.0.16-11.fc7
policycoreutils-2.0.16-10.fc7
policycoreutils-newrole-2.0.16-11.fc7
policycoreutils-gui-2.0.16-11.fc7

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
