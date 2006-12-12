Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kBCDHrV3020682
	for <selinux@tycho.nsa.gov>; Tue, 12 Dec 2006 08:17:53 -0500
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kBCDINoA029061
	for <selinux@tycho.nsa.gov>; Tue, 12 Dec 2006 13:18:23 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.8/8.13.8) with ESMTP id kBCDEm0e003446
	for <selinux@tycho.nsa.gov>; Tue, 12 Dec 2006 08:14:48 -0500
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.8/8.13.8/Submit) id kBCDEmFa003445
	for selinux@tycho.nsa.gov; Tue, 12 Dec 2006 08:14:48 -0500
Message-ID: <d032e8510612120128u7a1aa53ege2d5cdc849b3dad1@mail.gmail.com>
Date: Tue, 12 Dec 2006 09:28:18 +0000
From: "=?GB2312?B?ssy8ztPC?=" <millerfor@gmail.com>
To: SELinux@tycho.nsa.gov
Subject: help: 2 conditional expressions in refpolicy must match?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

while i am testing refpolicy conditional expression by switching
monolic and module compile mode, i found a strange thing. following is
the steps i took:

step 1: add a new boolean to policy
   in policy/global_tunables:
     gen_tunable(user_ping,false)
     gen_tunable(test_ping,false)

step 2: modify conditional expression
    in policy/modules/admin/netutils.if:

interface(`netutils_run_ping_cond',`
        gen_require(`
                type ping_t;
                bool user_ping;
                bool test_ping;
        ')

        role $2 types ping_t;

        if ( test_ping && user_ping ) {
                netutils_domtrans_ping($1)
                allow ping_t $3:chr_file rw_term_perms;
        }
')

then i try to build policy in monolic and module mode, i use apol to
check binary policy. monolinc is ok, it shows the conditional rules
exactly, while modules building boolean test_ping  is in the policy,
but the rules are lost!!!!

furthermore a more strange thing came, that  if I modify the interface
netutils_run_traceroute_cond in the same file
policy/modules/admin/netutils.if  like following:
interface(`netutils_run_traceroute_cond',`
        gen_require(`
                type traceroute_t;
                bool user_ping;
                bool test_ping;
        ')

        role $2 types traceroute_t;

        if( user_ping && test_ping ) {
                netutils_domtrans_traceroute($1)
                allow traceroute_t $3:chr_file rw_term_perms;
        }
')

then rebuild module policy, conditional av rules are ok. if i make 2
conditional expressions different, conditional av rule still lost!

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
