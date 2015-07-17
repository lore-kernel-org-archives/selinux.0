Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6H7SWZo001997
 for <selinux@tycho.nsa.gov>; Fri, 17 Jul 2015 03:28:32 -0400
Date: Fri, 17 Jul 2015 03:28:28 -0400 (EDT)
From: Robert Kuska <rkuska@redhat.com>
To: Jason Zaman <jason@perfinion.com>
Message-ID: <1799051406.34694801.1437118108180.JavaMail.zimbra@redhat.com>
In-Reply-To: <20150717065802.GA12312@meriadoc.Home>
References: <1437047301-17672-1-git-send-email-rkuska@redhat.com>
 <439836082.34025817.1437047775259.JavaMail.zimbra@redhat.com>
 <20150716221605.GB28538@meriadoc.Home>
 <839397810.34677360.1437115148590.JavaMail.zimbra@redhat.com>
 <20150717065802.GA12312@meriadoc.Home>
Subject: Re: Python3 Support for Sepolgen module
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



----- Original Message -----
> From: "Jason Zaman" <jason@perfinion.com>
> To: "Robert Kuska" <rkuska@redhat.com>
> Cc: selinux@tycho.nsa.gov
> Sent: Friday, July 17, 2015 8:58:02 AM
> Subject: Re: Python3 Support for Sepolgen module
> 
> On Fri, Jul 17, 2015 at 02:39:08AM -0400, Robert Kuska wrote:
> > > How much progress do you have on porting policycoreutils? There are a
> > > lot of mismatched tabs/spaces in it which are causing problems in
> > > python3 and I havent gotten further yet. I started looking at fixing up
> > > these but if you've already done it then there is no point in me
> > > re-doing it.
> > 
> > Sepolgen should be done.
> > 
> > There are still scripts which we already got ported and will be here for a
> > review soon:
> > > $ rpm -ql policycoreutils-python | grep bin
> > > [±master ●▴]
> > /usr/bin/audit2allow
> > /usr/bin/audit2why
> > /usr/bin/chcat
> > /usr/bin/sandbox
> > /usr/bin/semodule_package
> > /usr/sbin/semanage
> > 
> > Am I missing something?
> 
> When I tried running semanage with python3, it needed a few more too:
> /usr/lib64/python*/site-packages/sepolicy/*
> /usr/lib64/python*/site-packages/seobject.py
> 
> I look forward to testing the rest of your patches :)
> -- Jason
> 

I cc Petr in case he missed this mail.


Looking at policycoreutils-python3 it seems to me that sepolicy and seobject are already ported.

> $ rpm -ql policycoreutils-python3 | grep seobject                                  [±master ●▴]
/usr/lib/python3.4/site-packages/seobject
/usr/lib/python3.4/site-packages/seobject-0.1-py3.4.egg-info
/usr/lib/python3.4/site-packages/seobject/__init__.py
/usr/lib/python3.4/site-packages/seobject/__pycache__/__init__.cpython-34.pyc
/usr/lib/python3.4/site-packages/seobject/__pycache__/__init__.cpython-34.pyo


> $ rpm -ql policycoreutils-python3 | grep sepolicy                                  [±master ●▴]
/usr/lib64/python3.4/site-packages/sepolicy
/usr/lib64/python3.4/site-packages/sepolicy-1.1-py3.4.egg-info
/usr/lib64/python3.4/site-packages/sepolicy/__init__.py
/usr/lib64/python3.4/site-packages/sepolicy/__pycache__/__init__.cpython-34.pyc
/usr/lib64/python3.4/site-packages/sepolicy/__pycache__/__init__.cpython-34.pyo
/usr/lib64/python3.4/site-packages/sepolicy/__pycache__/booleans.cpython-34.pyc
/usr/lib64/python3.4/site-packages/sepolicy/__pycache__/booleans.cpython-34.pyo
/usr/lib64/python3.4/site-packages/sepolicy/__pycache__/communicate.cpython-34.pyc
/usr/lib64/python3.4/site-packages/sepolicy/__pycache__/communicate.cpython-34.pyo
/usr/lib64/python3.4/site-packages/sepolicy/__pycache__/generate.cpython-34.pyc
/usr/lib64/python3.4/site-packages/sepolicy/__pycache__/generate.cpython-34.pyo
/usr/lib64/python3.4/site-packages/sepolicy/__pycache__/gui.cpython-34.pyc
/usr/lib64/python3.4/site-packages/sepolicy/__pycache__/gui.cpython-34.pyo
/usr/lib64/python3.4/site-packages/sepolicy/__pycache__/interface.cpython-34.pyc
/usr/lib64/python3.4/site-packages/sepolicy/__pycache__/interface.cpython-34.pyo
/usr/lib64/python3.4/site-packages/sepolicy/__pycache__/manpage.cpython-34.pyc
/usr/lib64/python3.4/site-packages/sepolicy/__pycache__/manpage.cpython-34.pyo
/usr/lib64/python3.4/site-packages/sepolicy/__pycache__/network.cpython-34.pyc
/usr/lib64/python3.4/site-packages/sepolicy/__pycache__/network.cpython-34.pyo
/usr/lib64/python3.4/site-packages/sepolicy/__pycache__/sedbus.cpython-34.pyc
/usr/lib64/python3.4/site-packages/sepolicy/__pycache__/sedbus.cpython-34.pyo
/usr/lib64/python3.4/site-packages/sepolicy/__pycache__/transition.cpython-34.pyc
/usr/lib64/python3.4/site-packages/sepolicy/__pycache__/transition.cpython-34.pyo
/usr/lib64/python3.4/site-packages/sepolicy/booleans.py
/usr/lib64/python3.4/site-packages/sepolicy/communicate.py
/usr/lib64/python3.4/site-packages/sepolicy/help
/usr/lib64/python3.4/site-packages/sepolicy/help/__init__.py
/usr/lib64/python3.4/site-packages/sepolicy/help/__pycache__
/usr/lib64/python3.4/site-packages/sepolicy/help/__pycache__/__init__.cpython-34.pyc
/usr/lib64/python3.4/site-packages/sepolicy/help/__pycache__/__init__.cpython-34.pyo
/usr/lib64/python3.4/site-packages/sepolicy/help/booleans.png
/usr/lib64/python3.4/site-packages/sepolicy/help/booleans.txt
/usr/lib64/python3.4/site-packages/sepolicy/help/booleans_more.png
/usr/lib64/python3.4/site-packages/sepolicy/help/booleans_more.txt
/usr/lib64/python3.4/site-packages/sepolicy/help/booleans_more_show.png
/usr/lib64/python3.4/site-packages/sepolicy/help/booleans_more_show.txt
/usr/lib64/python3.4/site-packages/sepolicy/help/booleans_toggled.png
/usr/lib64/python3.4/site-packages/sepolicy/help/booleans_toggled.txt
/usr/lib64/python3.4/site-packages/sepolicy/help/file_equiv.png
/usr/lib64/python3.4/site-packages/sepolicy/help/file_equiv.txt
/usr/lib64/python3.4/site-packages/sepolicy/help/files_apps.png
/usr/lib64/python3.4/site-packages/sepolicy/help/files_apps.txt
/usr/lib64/python3.4/site-packages/sepolicy/help/files_exec.png
/usr/lib64/python3.4/site-packages/sepolicy/help/files_exec.txt
/usr/lib64/python3.4/site-packages/sepolicy/help/files_write.png
/usr/lib64/python3.4/site-packages/sepolicy/help/files_write.txt
/usr/lib64/python3.4/site-packages/sepolicy/help/lockdown.png
/usr/lib64/python3.4/site-packages/sepolicy/help/lockdown.txt
/usr/lib64/python3.4/site-packages/sepolicy/help/lockdown_permissive.png
/usr/lib64/python3.4/site-packages/sepolicy/help/lockdown_permissive.txt
/usr/lib64/python3.4/site-packages/sepolicy/help/lockdown_ptrace.png
/usr/lib64/python3.4/site-packages/sepolicy/help/lockdown_ptrace.txt
/usr/lib64/python3.4/site-packages/sepolicy/help/lockdown_unconfined.png
/usr/lib64/python3.4/site-packages/sepolicy/help/lockdown_unconfined.txt
/usr/lib64/python3.4/site-packages/sepolicy/help/login.png
/usr/lib64/python3.4/site-packages/sepolicy/help/login.txt
/usr/lib64/python3.4/site-packages/sepolicy/help/login_default.png
/usr/lib64/python3.4/site-packages/sepolicy/help/login_default.txt
/usr/lib64/python3.4/site-packages/sepolicy/help/ports_inbound.png
/usr/lib64/python3.4/site-packages/sepolicy/help/ports_inbound.txt
/usr/lib64/python3.4/site-packages/sepolicy/help/ports_outbound.png
/usr/lib64/python3.4/site-packages/sepolicy/help/ports_outbound.txt
/usr/lib64/python3.4/site-packages/sepolicy/help/start.png
/usr/lib64/python3.4/site-packages/sepolicy/help/start.txt
/usr/lib64/python3.4/site-packages/sepolicy/help/system.png
/usr/lib64/python3.4/site-packages/sepolicy/help/system.txt
/usr/lib64/python3.4/site-packages/sepolicy/help/system_boot_mode.png
/usr/lib64/python3.4/site-packages/sepolicy/help/system_boot_mode.txt
/usr/lib64/python3.4/site-packages/sepolicy/help/system_current_mode.png
/usr/lib64/python3.4/site-packages/sepolicy/help/system_current_mode.txt
/usr/lib64/python3.4/site-packages/sepolicy/help/system_export.png
/usr/lib64/python3.4/site-packages/sepolicy/help/system_export.txt
/usr/lib64/python3.4/site-packages/sepolicy/help/system_policy_type.png
/usr/lib64/python3.4/site-packages/sepolicy/help/system_policy_type.txt
/usr/lib64/python3.4/site-packages/sepolicy/help/system_relabel.png
/usr/lib64/python3.4/site-packages/sepolicy/help/system_relabel.txt
/usr/lib64/python3.4/site-packages/sepolicy/help/transition_file.png
/usr/lib64/python3.4/site-packages/sepolicy/help/transition_file.txt
/usr/lib64/python3.4/site-packages/sepolicy/help/transition_from.png
/usr/lib64/python3.4/site-packages/sepolicy/help/transition_from.txt
/usr/lib64/python3.4/site-packages/sepolicy/help/transition_from_boolean.png
/usr/lib64/python3.4/site-packages/sepolicy/help/transition_from_boolean.txt
/usr/lib64/python3.4/site-packages/sepolicy/help/transition_from_boolean_1.png
/usr/lib64/python3.4/site-packages/sepolicy/help/transition_from_boolean_1.txt
/usr/lib64/python3.4/site-packages/sepolicy/help/transition_from_boolean_2.png
/usr/lib64/python3.4/site-packages/sepolicy/help/transition_from_boolean_2.txt
/usr/lib64/python3.4/site-packages/sepolicy/help/transition_to.png
/usr/lib64/python3.4/site-packages/sepolicy/help/transition_to.txt
/usr/lib64/python3.4/site-packages/sepolicy/help/users.png
/usr/lib64/python3.4/site-packages/sepolicy/help/users.txt
/usr/lib64/python3.4/site-packages/sepolicy/interface.py
/usr/lib64/python3.4/site-packages/sepolicy/manpage.py
/usr/lib64/python3.4/site-packages/sepolicy/network.py
/usr/lib64/python3.4/site-packages/sepolicy/policy.cpython-34m.so
/usr/lib64/python3.4/site-packages/sepolicy/sedbus.py
/usr/lib64/python3.4/site-packages/sepolicy/templates
/usr/lib64/python3.4/site-packages/sepolicy/templates/__init__.py
/usr/lib64/python3.4/site-packages/sepolicy/templates/__pycache__
/usr/lib64/python3.4/site-packages/sepolicy/templates/__pycache__/__init__.cpython-34.pyc
/usr/lib64/python3.4/site-packages/sepolicy/templates/__pycache__/__init__.cpython-34.pyo
/usr/lib64/python3.4/site-packages/sepolicy/templates/__pycache__/boolean.cpython-34.pyc
/usr/lib64/python3.4/site-packages/sepolicy/templates/__pycache__/boolean.cpython-34.pyo
/usr/lib64/python3.4/site-packages/sepolicy/templates/__pycache__/etc_rw.cpython-34.pyc
/usr/lib64/python3.4/site-packages/sepolicy/templates/__pycache__/etc_rw.cpython-34.pyo
/usr/lib64/python3.4/site-packages/sepolicy/templates/__pycache__/executable.cpython-34.pyc
/usr/lib64/python3.4/site-packages/sepolicy/templates/__pycache__/executable.cpython-34.pyo
/usr/lib64/python3.4/site-packages/sepolicy/templates/__pycache__/network.cpython-34.pyc
/usr/lib64/python3.4/site-packages/sepolicy/templates/__pycache__/network.cpython-34.pyo
/usr/lib64/python3.4/site-packages/sepolicy/templates/__pycache__/rw.cpython-34.pyc
/usr/lib64/python3.4/site-packages/sepolicy/templates/__pycache__/rw.cpython-34.pyo
/usr/lib64/python3.4/site-packages/sepolicy/templates/__pycache__/script.cpython-34.pyc
/usr/lib64/python3.4/site-packages/sepolicy/templates/__pycache__/script.cpython-34.pyo
/usr/lib64/python3.4/site-packages/sepolicy/templates/__pycache__/semodule.cpython-34.pyc
/usr/lib64/python3.4/site-packages/sepolicy/templates/__pycache__/semodule.cpython-34.pyo
/usr/lib64/python3.4/site-packages/sepolicy/templates/__pycache__/spec.cpython-34.pyc
/usr/lib64/python3.4/site-packages/sepolicy/templates/__pycache__/spec.cpython-34.pyo
/usr/lib64/python3.4/site-packages/sepolicy/templates/__pycache__/test_module.cpython-34.pyc
/usr/lib64/python3.4/site-packages/sepolicy/templates/__pycache__/test_module.cpython-34.pyo
/usr/lib64/python3.4/site-packages/sepolicy/templates/__pycache__/tmp.cpython-34.pyc
/usr/lib64/python3.4/site-packages/sepolicy/templates/__pycache__/tmp.cpython-34.pyo
/usr/lib64/python3.4/site-packages/sepolicy/templates/__pycache__/unit_file.cpython-34.pyc
/usr/lib64/python3.4/site-packages/sepolicy/templates/__pycache__/unit_file.cpython-34.pyo
/usr/lib64/python3.4/site-packages/sepolicy/templates/__pycache__/user.cpython-34.pyc
/usr/lib64/python3.4/site-packages/sepolicy/templates/__pycache__/user.cpython-34.pyo
/usr/lib64/python3.4/site-packages/sepolicy/templates/__pycache__/var_cache.cpython-34.pyc
/usr/lib64/python3.4/site-packages/sepolicy/templates/__pycache__/var_cache.cpython-34.pyo
/usr/lib64/python3.4/site-packages/sepolicy/templates/__pycache__/var_lib.cpython-34.pyc
/usr/lib64/python3.4/site-packages/sepolicy/templates/__pycache__/var_lib.cpython-34.pyo
/usr/lib64/python3.4/site-packages/sepolicy/templates/__pycache__/var_log.cpython-34.pyc
/usr/lib64/python3.4/site-packages/sepolicy/templates/__pycache__/var_log.cpython-34.pyo
/usr/lib64/python3.4/site-packages/sepolicy/templates/__pycache__/var_run.cpython-34.pyc
/usr/lib64/python3.4/site-packages/sepolicy/templates/__pycache__/var_run.cpython-34.pyo
/usr/lib64/python3.4/site-packages/sepolicy/templates/__pycache__/var_spool.cpython-34.pyc
/usr/lib64/python3.4/site-packages/sepolicy/templates/__pycache__/var_spool.cpython-34.pyo
/usr/lib64/python3.4/site-packages/sepolicy/templates/boolean.py
/usr/lib64/python3.4/site-packages/sepolicy/templates/etc_rw.py
/usr/lib64/python3.4/site-packages/sepolicy/templates/executable.py
/usr/lib64/python3.4/site-packages/sepolicy/templates/network.py
/usr/lib64/python3.4/site-packages/sepolicy/templates/rw.py
/usr/lib64/python3.4/site-packages/sepolicy/templates/script.py
/usr/lib64/python3.4/site-packages/sepolicy/templates/semodule.py
/usr/lib64/python3.4/site-packages/sepolicy/templates/spec.py
/usr/lib64/python3.4/site-packages/sepolicy/templates/test_module.py
/usr/lib64/python3.4/site-packages/sepolicy/templates/tmp.py
/usr/lib64/python3.4/site-packages/sepolicy/templates/unit_file.py
/usr/lib64/python3.4/site-packages/sepolicy/templates/user.py
/usr/lib64/python3.4/site-packages/sepolicy/templates/var_cache.py
/usr/lib64/python3.4/site-packages/sepolicy/templates/var_lib.py
/usr/lib64/python3.4/site-packages/sepolicy/templates/var_log.py
/usr/lib64/python3.4/site-packages/sepolicy/templates/var_run.py
/usr/lib64/python3.4/site-packages/sepolicy/templates/var_spool.py

--
Robert Kuska
{rkuska}




--
Robert Kuska
{rkuska}
