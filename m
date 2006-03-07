Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k27FNw1V029804
	for <selinux@tycho.nsa.gov>; Tue, 7 Mar 2006 10:23:58 -0500
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k27FMNVk012036
	for <selinux@tycho.nsa.gov>; Tue, 7 Mar 2006 15:22:24 GMT
Subject: ANN: Reference Policy Release
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Tue, 07 Mar 2006 10:28:36 -0500
Message-Id: <1141745316.30819.129.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

A new release of the SELinux Reference Policy is now available on
SourceForge from http://serefpolicy.sourceforge.net.  The primary
activity for this release has been renaming interfaces to improve the
naming consistency, in an effort to stabilize the API.  The change log
follows at the bottom of the email.

Again, for those that are interesting in contributing, right now the
best help would be to either test the policy or convert remaining
modules from the example policy over to Reference Policy; there is a
list of modules on the Reference Policy status page on SourceForge.

* Tue Mar 07 2006 Chris PeBenito <selinux@tresys.com> - 20060307
- Make all interface parameters required.
- Move boot_t, system_map_t, and modules_object_t to files module,
  and move bootloader to admin layer.
- Add semanage policy for semodule from Dan Walsh.
- Remove allow_execmem from targeted policy domain_base_type().
- Add users_extra and seusers support.
- Postfix fixes from Serge Hallyn.
- Run python and shell directly to interpret scripts so policy
  sources need not be executable.
- Add desc tag XML to booleans and tunables, and add summary
  to param XML tag, to make future translations possible.
- Remove unused lvm_vg_t.
- Many interface renames to improve naming consistency.
- Merge xdm into xserver.
- Remove kernel module reversed interfaces.
- Add filename attribute to module XML tag and lineno attribute to
  interface XML tag.
- Changed QUIET build option to a yes or no option.
- Add a Makefile used for compiling loadable modules in a
  user's development environment, building against policy headers.
- Add Make target for installing policy headers.
- Separate per-userdomain template expansion from the userdomain
  module and add infrastructure to expand templates in the modules
  that own the template.
- Enable secadm only for MLS policies.
- Remove role change rules in su and sudo since this functionality has been
  removed from these programs.
- Add ctags Make target from Thomas Bleher.
- Collapse commands with grep piped to sed into one sed command.
- Fix type_change bug in term_user_pty().
- Move ice_tmp_t from miscfiles to xserver.
- Login fixes from Serge Hallyn.
- Move xserver_log_t from xdm to xserver.
- Add lpr per-userdomain policy to lpd.
- Miscellaneous fixes from Dan Walsh.
- Change initrc_var_run_t interface noun from script_pid to utmp,
  for greater clarity.
- Added modules:
        certwatch
        mono (Dan Walsh)
        mrtg
        portage
        tvtime
        userhelper
        usernetctl
        wine (Dan Walsh)
        xserver

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
