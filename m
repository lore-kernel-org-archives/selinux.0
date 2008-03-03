Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m23Lk8dU029092
	for <selinux@tycho.nsa.gov>; Mon, 3 Mar 2008 16:46:08 -0500
Received: from wr-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m23Lk7pQ001183
	for <selinux@tycho.nsa.gov>; Mon, 3 Mar 2008 21:46:07 GMT
Received: by wr-out-0506.google.com with SMTP id c57so550251wra.4
        for <selinux@tycho.nsa.gov>; Mon, 03 Mar 2008 13:46:05 -0800 (PST)
Message-ID: <29e7ef020803031339h759da5f9gd0eb196eb638ac6b@mail.gmail.com>
Date: Mon, 3 Mar 2008 22:39:59 +0100
From: "Gienek Nowacki" <nowackig@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Problem with corenet_* statements.
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

I would like to build my own SE module. The system is CentOS 5.1. The
source of the module is as follow:

# ============ amav.te ===================

module amav 1.0.0;
require {
        type amavis_t;
};
corenet_udp_bind_generic_port(amavis_t);
corenet_dontaudit_udp_bind_all_ports(amavis_t);

# ====================================

After running the command:
checkmodule -M -m -o amav.mod  amav.te

....there is `syntax error' -  checkmodule doasn't recognize
corenet_*  statements.

Next, after successful I would like to use semodule_package and
semodule commands.

The purpose of creating such modul is because amavisd use random UDP
source ports when connecting to DNS serwer.

Could you help me how  - how there is possible to find the solution?

Gienek

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
