Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA13896
	for <selinux@tycho.nsa.gov>; Tue, 3 Sep 2002 08:53:09 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA09093
	for <selinux@tycho.nsa.gov>; Tue, 3 Sep 2002 12:51:55 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id MAA09089
	for <selinux@tycho.nsa.gov>; Tue, 3 Sep 2002 12:51:53 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id C774992479
	for <selinux@tycho.nsa.gov>; Tue,  3 Sep 2002 22:53:03 +1000 (EST)
Received: from lyta (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 77811314A
	for <selinux@tycho.nsa.gov>; Tue,  3 Sep 2002 14:52:55 +0200 (CEST)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: macro for run_init etc
Date: Tue, 3 Sep 2002 10:07:03 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_RVRUFH39U3O50FKXX4JA"
Message-Id: <200209031007.03455.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_RVRUFH39U3O50FKXX4JA
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit

Currently there's a run_init program for initrc_t, a run_deb program for 
running Debian package maintenance utilities, and now we have been discussing 
having similar programs for starting httpd, databases, and others.

I think that we need a macro such as in the attached file for this purpose.

With such a macro file the following three lines take the place of run_init.te 
and run_deb.te, and you could easily define another dozen run_something 
domains without effort.

run_program(sysadm_t, syadm_r, init, etc_t, initrc_t)
run_program(sysadm_t, syadm_r, deb, dpkg_exec_t, dpkg_t)
domain_trans(run_deb_t, apt_exec_t, apt_t)

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--------------Boundary-00=_RVRUFH39U3O50FKXX4JA
Content-Type: text/plain;
  charset="us-ascii";
  name="run_init_macros.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="run_init_macros.te"


# $1 is the source domain (or domains), $2 is the source role (or roles) and $3
# is the base name for the domain to run.  $1 is normally sysadm_t, and $2 is
# normally sysadm_r.  $4 is the type of program to run and $5 is the domain to
# transition to.
# sample usage:
# run_program(sysadm_t, syadm_r, init, etc_t, initrc_t)
#
# if you have several users who run the same run_init type program for
# different purposes (think of a run_db program used by several database
# administrators to start several databases) then you can list all the source
# domains in $1, all the source roles in $2, but you may not want to list all
# types of programs to run in $4 and target domains in $5 (as that may permit
# entering a domain from the wrong type).  In such a situation just specify
# one value for each of $4 and $5 and have some rules such as the following:
# domain_trans(run_whatever_t, whatever_exec_t, whatever_t)

define(`run_program', `
type run_$3_exec_t, file_type, exec_type, sysadmfile;

# domain for program to run in, needs to change role (privrole), change
# identity to system_u (privuser), log failures to syslog (privlog) and
# authenticate users (auth)
type run_$3_t, domain, privrole, privuser, privlog, auth;
domain_auto_trans($1, run_$3_exec_t, run_$3_t)
role $2 types run_$3_t;

# for utmp
allow run_$3_t initrc_var_run_t:file rw_file_perms;
allow run_$3_t { sysadm_devpts_t sysadm_tty_device_t }:chr_file rw_file_perms;

# often the administrator runs such programs from a directory that is owned
# by a different user or has restrictive SE permissions, do not want to audit
# the failed access to the current directory
dontaudit run_$3_t file_type:dir search;
dontaudit run_$3_t self:capability { dac_override dac_read_search };

can_exec(run_$3_t, { bin_t chkpwd_exec_t shell_exec_t })

domain_trans(run_$3_t, $4, $5)

# hmm, do we REALLY need this?
every_domain(run_$3_t)
')

--------------Boundary-00=_RVRUFH39U3O50FKXX4JA--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
