Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8GFsSLa020533
	for <selinux@tycho.nsa.gov>; Tue, 16 Sep 2003 11:54:29 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h8GFqmLY012386
	for <selinux@tycho.nsa.gov>; Tue, 16 Sep 2003 15:52:48 GMT
Received: from Woody.fw.matav.hu (matav-1.matav.hu [145.236.241.98])
	by jazzswing.ncsc.mil  with ESMTP id h8GFqksG012381
	for <selinux@tycho.nsa.gov>; Tue, 16 Sep 2003 15:52:47 GMT
Subject: policy model
From: =?ISO-8859-1?Q?Magos=E1nyi_=C1rp=E1d?= <mag@bunuel.tii.matav.hu>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: 16 Sep 2003 17:49:41 +0200
Message-Id: <1063727381.3351.42.camel@kusturica>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi!

We have found the default selinux policy a bit too complex for our
simple minds. We have created the following set of statements.

I have two questions about them:

1. Do you think that this approach is feasible?

2. Is this set of statements would be suitable as a secuity policy model
 per ADV_SPM.1? If not, what to enhance? How a informal TSP model looks
 like anyway?

And now our TSP:
-------------------------------------------------------------------
Conventions:
-TCB is the base of the system, tcb is the set of objects and subjects
which
 have been marked as part of the trusted computing base. Most of the TCB
is
 also tcb, and most of the tcb is in the TCB, but not all.
-each role have a '_r', each domain have a '_d', each type a '_t'
postfix.
-each role and domain have a <sandbox>'_' prefix. The 'tcb_' and 'ldap_'
 prefixes are reserved for the TCB.
-one role -- one domain. Each role have one domain. Beyond that only
 a minimal number of domains exist for well-defined technical purposes.
 Most notably user authorization.
- the <domainname>_exec_t is the type which corresponds to the
entrypoint
 of <domainname>_domain. Each entrypoint is part of the tcb.
-The system contains a TCB and one or more chrooted environments for
 application logic.
The TCB:
 The TCB contains two parts: The OS root with the boot process, and the
 ldap replica in its chrooted environment.
 We have the following roles in the TCB:
  tcb_{sysadm,secadm,user}_r
  boot_r
 Technical domains:
  tcb{ssh,login}_d
 Those technical domains are under boot_r only, both for authorisation
purposes.
 There is NO newrole here.
 The boot_r role (and boot_d domain) is for the boot process. It can
 read and execute only files which  are part of the tcb, only write to
temporary
 dirs.
 The types have the following attributes:
  tcb_type: this mark tells that we have a object which is part of the
tcb.
  tcb_executable_type: executable
  tcb_sys_config_type: system config file (can be writtem by
tcb_sysadm_d)
  tcb_sec_config_type: security config file (can be written by
tcb_secadm_d)
  tcb_entrypoint: an entrypoint to one of the technical domains. It
should
        be tcb_type and tcb_executable_type as well to work.
 The admin domains (tcb_sysadm_d and tcb_secadm_d) can execute and read
 only types with tcb_type attribute.
 The tcb can only be written by the admin domains; either one or the
other,
 and both only in explicitly listed cases.
 The chrooted environment for the ldap is administered by the secadm.

Sandboxen:
 There is a macro to facilitate creating sandboxen.
 A sandbox have the following parameters:
  name: the name of the sandbox
  domainlist: the list of domains in the sandbox
 The following things will be created:
  <name>_system_r role and <name>_system_d domain for the system and its
   administrator. The security config files shall still belong to the
domain
   which is tcb_type and tcb_sec_config_type.
   system_d should be readable by tcb_sysadm_d and tcb_secadm_d, but not
   writeable. tcb_sysadm_d should be able to transition to
<name>_system_d.
  <name>_<domain>_r role and <name>_<domain>_d for each domain in the
   domainlist.
   These domains are fully separated from others, and their dominance
   and other relationships should be explicitly given. One can use
   the following macros for that: FIXME: are there macros for it in
   upstream selinux?
    dominate(dom1,dom2): dom1 dominates dom2
    can_read(dom1,dom2): dom1 can read dom2
    can_write(dom1,dom2): dom1 can write dom2
  <name>_{ssh,newrole}_d 
   The technical domains for ssh and newrole for login and
   role change. They are under <name>_system_r.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
