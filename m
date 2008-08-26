Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7Q9q0YQ012949
	for <selinux@tycho.nsa.gov>; Tue, 26 Aug 2008 05:52:00 -0400
Received: from py-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m7Q9px8L012221
	for <selinux@tycho.nsa.gov>; Tue, 26 Aug 2008 09:51:59 GMT
Received: by py-out-1112.google.com with SMTP id a78so1867556pyh.32
        for <selinux@tycho.nsa.gov>; Tue, 26 Aug 2008 02:51:59 -0700 (PDT)
Message-ID: <7b740b700808260251l55f56127n8668e777dacbe26f@mail.gmail.com>
Date: Tue, 26 Aug 2008 14:51:58 +0500
From: Shaz <shazalive@gmail.com>
To: selinux@tycho.nsa.gov
Subject: semodule -i not working
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I was trying to load the following module:
---------------------------------
     module spamd 1.0;

     require {
     role object_r;
     role system_r;

     class tcp_socket name_connect;

     type ldap_port_t;
     type spamd_t;
     };

     allow spamd_t ldap_port_t:tcp_socket name_connect;
--------------------------------

and I got the following error:

     [root@develap lpm]# semodule -i spamd.pp
     libsepol.module_package_read_offsets: wrong magic number for
module package:  expected 4185718671, got 1969516397
     libsemanage.parse_module_headers: Could not parse module data.
     semodule:  Failed on spamd.pp!

How do I understand the problem and what can be the possible solution?

Thanks.
-- 
Shaz

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
