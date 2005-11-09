Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jA9MJeMA024026
	for <selinux@tycho.nsa.gov>; Wed, 9 Nov 2005 17:19:41 -0500 (EST)
Received: from xproxy.gmail.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id jA9MCifN015607
	for <selinux@tycho.nsa.gov>; Wed, 9 Nov 2005 22:12:44 GMT
Received: by xproxy.gmail.com with SMTP id h31so344152wxd
        for <selinux@tycho.nsa.gov>; Wed, 09 Nov 2005 14:13:18 -0800 (PST)
Message-ID: <ef5305790511091413m61a0dc45w23847388910ca32f@mail.gmail.com>
Date: Thu, 10 Nov 2005 11:13:17 +1300
From: Goo GGooo <googgooo@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: Problems with policy-1.26
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1131543572.20591.464.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
References: <ef5305790511060406x26fb2221mff3168b980b68f27@mail.gmail.com>
	 <1131543572.20591.464.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 11/10/05, Stephen Smalley <sds@tycho.nsa.gov> wrote:> On Mon, 2005-11-07 at 01:06 +1300, Goo GGooo wrote:> > Hi all,> > I have downloaded selinuc 1.26 and am trying to use it with linuxkernel 2.6.12.6. Unfortunately I have problems with policy-1.26. Whendoing "make install" I'm constantly getting complaints about missing/etc/libuser.conf:> > /etc/selinux # make installBuilding file contexts files...Validating file contexts files .../usr/sbin/setfiles -q -c /etc/selinux/strict/policy/policy.20file_contexts/file_contextsinstall -m 644 tmp/system.users /etc/selinux/strict/users/system.usersinstall -m 644 tmp/customizable_types/etc/selinux/strict/contexts/customizable_typesinstall -m 644 tmp/port_types /etc/selinux/strict/contexts/port_typesInstalling file contexts files...install -m 644 file_contexts/homedir_template/etc/selinux/strict/contexts/files/homedir_templateinstall -m 644 file_contexts/file_contexts/etc/selinux/strict/contexts/files/file_contextsgrep: /etc/libuser.conf: No such file or directoryYou do not have access to /etc/libuser.conf LU_HOMEDIRECTORY=/var/lib is already defined in /etc/selinux/strict/contexts/files/file_contexts,/usr/sbin/genhomedircon will not create a new context.> > Then with "make load" I'm getting error w.r.t. missing/etc/selinux/targeted/users//{local.users,system.users}, while/etc/selinux/targeted/users is a file, not a directory containing anyfiles:> > # make loadLoading Policy .../usr/sbin/load_policy /etc/selinux/strict/policy/policy.20sepol_genusers: Can't load system.users:  Not a directory/usr/sbin/load_policy:  Error while setting user configuration from/etc/selinux/targeted/users//{local.users,system.users}:  Not adirectorysepol_genbools_array:  boolean secure_mode_insmod no longer in policysepol_genbools_array:  boolean secure_mode_policyload no longer in policy/usr/sbin/load_policy:  Warning!  Unable to reset all booleans/usr/sbin/load_policy:  security_load_policy failedmake: *** [tmp/load] Error 3> > What am I doing wrong?>> Hi,>> From your message, it sou!
nds like you are trying to install the last> nsa.gov SELinux release (which was made 7 Sep 2005) on a system that is> already running SELinux.  What is your distro?
It's OpenSUSE 10.0 which comes only with libselinux-1.23.11 and noother SElinux related packages. So I downloaded the rest of them fromhttp://www.cip.ifi.lmu.de/~bleher/selinux/suse/ and tried to configureit with the policies provided on that website as well as withpolicy-1.26. Failing that I deinstalled all the RPMs again andcompiled SElinux from sources from nsa.gov. However still having theproblems described above.
All I want to achieve for now is permitting everything for everyone(even in enforcing mode) and then harden some network-facing daemonslike Apache or Bind, i.e. use the targeted policy. But I can't evenstart playing with that as I can't load the sample policy :-(
Any other ideas on how to continue? Using something else than OpenSUSE10.0 isn't unfortunately possible.
Thanks
Goo

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
