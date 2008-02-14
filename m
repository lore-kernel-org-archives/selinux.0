Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1EF8nD1000621
	for <selinux@tycho.nsa.gov>; Thu, 14 Feb 2008 10:08:49 -0500
Received: from nf-out-0910.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1EF8lYk000211
	for <selinux@tycho.nsa.gov>; Thu, 14 Feb 2008 15:08:48 GMT
Received: by nf-out-0910.google.com with SMTP id k4so321367nfd.4
        for <selinux@tycho.nsa.gov>; Thu, 14 Feb 2008 07:08:46 -0800 (PST)
Message-ID: <cadfc0e40802140708t1bca9f8bye0994928ef47d91e@mail.gmail.com>
Date: Thu, 14 Feb 2008 09:08:46 -0600
From: "Xavier Toth" <txtoth@gmail.com>
To: "SE Linux" <selinux@tycho.nsa.gov>
Subject: svn refpolicy ppp.if syntax error
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--- policy/modules/services/ppp.if      2008-02-13 17:35:42.000000000 -0600
+++ policy/modules/services/ppp.if.new  2008-02-14 09:07:59.000000000 -0600
@@ -323,7 +323,7 @@
        manage_files_pattern($1, pppd_var_lib_t, pppd_var_lib_t)

        files_list_pids($1)
-       manage_files_pattern($1, pppd_var_run_t), pppd_var_run_t
+       manage_files_pattern($1, pppd_var_run_t, pppd_var_run_t)

        allow $1 pptp_t:process { ptrace signal_perms getattr };
        ps_process_pattern($1, pptp_t)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
