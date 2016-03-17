Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u2HFSKCo001331
 for <selinux@tycho.nsa.gov>; Thu, 17 Mar 2016 11:28:21 -0400
Date: Thu, 17 Mar 2016 15:25:15 +0000 (UTC)
From: Richard Haines <richard_c_haines@btinternet.com>
Reply-To: Richard Haines <richard_c_haines@btinternet.com>
To: SELinux List <selinux@tycho.nsa.gov>
Message-ID: <1198187673.578619.1458228315066.JavaMail.yahoo@mail.yahoo.com>
Subject: Problem building CIL module with new class
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
References: <1198187673.578619.1458228315066.JavaMail.yahoo.ref@mail.yahoo.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Using Fedora 23 targeted policy.

Problem: When adding a new class via the CIL module listed below, the allow
rule is not being resolved if the new class references a common set of
permissions.

Viewing with apol shows that the new class has been allocated the unique and
common permissions, however the allow rule is missing.

Note 1: If the 'all' expression is replaced in the 'classpermissionset' with
the actual permissions, then the allow rule is resolved.

Note 2: If I use the latest 2.5 libsepol with the
(classorder (unordered sctp_socket)) statement I get the same result.

The example CIL policy module is:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(classorder (proxy sctp_socket))  ; 'proxy' is the last class defined in F-23
                                                                  ; and required when using libsepol 2.4

(classcommon sctp_socket socket)
(class sctp_socket (node_bind name_connect association bindx_add bindx_rem
connectx peeloff set_addr set_params))

(classpermission sctp_socket_all_perms)
(classpermissionset sctp_socket_all_perms (sctp_socket (all)))

(allow unconfined_t self sctp_socket_all_perms)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

And is built with the following command:

semodule --priority 400 -i sctp_test_module.cil

Any ideas !!!
Richard
