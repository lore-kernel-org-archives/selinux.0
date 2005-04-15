Subject: Re: make install fails if any users are in local.users
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Colin Walters <walters@redhat.com>, Daniel J Walsh <dwalsh@redhat.com>,
   selinux@tycho.nsa.gov
In-Reply-To: <1110986633.4802.88.camel@moss-spartans.epoch.ncsc.mil>
References: <1110672353.29153.2.camel@cobra.ivg2.net>
	 <4235BE2F.8020009@redhat.com> <1110821742.16850.14.camel@cobra.ivg2.net>
	 <42360347.1030105@redhat.com>  <1110838214.19525.1.camel@cobra.ivg2.net>
	 <1110864047.30167.8.camel@cobra.ivg2.net>
	 <1110979208.4802.45.camel@moss-spartans.epoch.ncsc.mil>
	 <1110983044.3914.24.camel@nexus.verbum.private>
	 <1110986633.4802.88.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 15 Apr 2005 04:19:16 -0400
Message-Id: <1113553156.17324.12.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> 
> > Perhaps though genhomedircon itself could run setfiles -c though on e.g.
> > file_contexts.homedir.tmp before renaming it to file_contexts.homedir.

Can you clarify how this is different from the Makefile running setfiles
-c? I thought this was working for a while, but it seems not - it's
broken again:

Loading Policy ...
/usr/sbin/load_policy /etc/selinux/strict/policy/policy.19
touch tmp/load
Building file contexts files...
Validating file contexts files ...
/usr/sbin/setfiles -q -c /etc/selinux/strict/policy/policy.19
file_contexts/file_contexts
install -m 644 tmp/system.users /etc/selinux/strict/users/system.users
install -m 644
tmp/customizable_types /etc/selinux/strict/contexts/customizable_types
Installing file contexts files...
install -m 644
file_contexts/homedir_template /etc/selinux/strict/contexts/files/homedir_template
install -m 644
file_contexts/file_contexts /etc/selinux/strict/contexts/files/file_contexts
Invalid values in the new file_contexts.homedirs.   File not created.
Bad file in file_contexts.homedirs.tmp
Output
was /etc/selinux/strict/contexts/files/file_contexts.homedirs.tmp:  line
62 has invalid context phantom:object_r:staff_home_dir_t

==============

Also, every error in the .tmp file causes it not to install, and I think
it gets overwritten upon upgrade of the binary policy package to one
without my local user customizations - I don't think the previous file
is preserved. Then I run into trouble when I run restorecon on various
things in /home, and it starts relabeling everything with the wrong
role, since it has no knowledge of my users.

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
