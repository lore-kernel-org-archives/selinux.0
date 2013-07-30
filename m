Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r6UHjxOp027735
	for <selinux@tycho.nsa.gov>; Tue, 30 Jul 2013 13:45:59 -0400
Received: by mail-ve0-f171.google.com with SMTP id pa12so2586762veb.30
        for <selinux@tycho.nsa.gov>; Tue, 30 Jul 2013 10:45:58 -0700 (PDT)
MIME-Version: 1.0
From: Thomas COUDRAY <amanone@gmail.com>
Date: Tue, 30 Jul 2013 19:45:37 +0200
Message-ID: <CABhRnsXoNT5JBbMjd36w5o3Q4KEJ51CqHmL9FJihC-H5yrdqFg@mail.gmail.com>
Subject: Building the Base Policy Module
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I followed the SELinux documentation for building the base policy module.

When I use checkmodule (checkmodule -o base.mod base.conf), I get this error.

# checkmodule -o base.mod base.conf
checkmodule:  loading policy configuration from base.conf
base.conf:1014:ERROR 'unknown role unconfined_r' at token ';' on line 1014:
role unconfined_r types { unconfined_t };
# The only role defined for this policy:
checkmodule:  error(s) encountered while parsing configuration

Also the base.fc, dbus_context,  file, is missing.

[1]: http://selinuxproject.org/page/Building_a_Basic_Policy#Building_the_Base_Policy_Module

Thomas Coudray

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
