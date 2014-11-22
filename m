Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sAMGkFUl024731
 for <selinux@tycho.nsa.gov>; Sat, 22 Nov 2014 11:46:15 -0500
Received: by mail-oi0-f44.google.com with SMTP id e131so5041302oig.31
 for <selinux@tycho.nsa.gov>; Sat, 22 Nov 2014 08:46:12 -0800 (PST)
MIME-Version: 1.0
Sender: sven.j.vermeulen@gmail.com
Date: Sat, 22 Nov 2014 17:46:12 +0100
Message-ID: <CAPzO=Nx9u_mwAuiPDfpfTOt01t0JLKdgbDQ6-foTr2SZmWPo3g@mail.gmail.com>
Subject: Permission requirements for semodule?
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi all

I'm working with 2.4_rc6 (with the additional patch that Steve sent to
the list on November 19th) and noticed that some of the utilities are
trying to access the HLL files. Currently, our policy disallows that,
but other than that I see no issues.

For instance, when loading a policy module (pp) using "semodule -i
/path/to/module.pp":

type=AVC msg=audit(1416673390.476:215): avc:  denied  { read } for
pid=2729 comm="load_policy"
path="/var/lib/selinux/mcs/active/modules/400/selocal/hll" dev=
"sdb2" ino=6573925 scontext=staff_u:sysadm_r:load_policy_t:s0
tcontext=staff_u:object_r:semanage_var_lib_t:s0 tclass=file

type=AVC msg=audit(1416673390.505:217): avc:  denied  { read } for
pid=2730 comm="setfiles"
path="/var/lib/selinux/mcs/active/modules/400/selocal/hll" dev="sdb2"
ino=6573925 scontext=staff_u:sysadm_r:setfiles_t:s0
tcontext=staff_u:object_r:semanage_var_lib_t:s0 tclass=file

The module is loaded and the changes are active, so I'm inclined to
dontaudit it. But I'd rather ask up front. What are the tools trying
to do? And, is semanage_var_lib_t the right type for the HLL files? I
would expect it to need to be semanage_store_t?

Wkr,
  Sven Vermeulen
