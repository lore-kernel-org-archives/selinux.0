Date: Fri, 12 Apr 2002 12:23:49 +0200
From: Tom <tom@lemuria.org>
To: SELinux@tycho.nsa.gov
Subject: db conflict ?
Message-ID: <20020412122349.A28382@lemuria.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have just installed a new SELinux test machine. It had an SELinux
earlier, but I deleted that and installed a new one, from the Debian
packages.

During boot, I get this error message:

security:  starting up (compiled Jan 12 2002)
security:  loading policy configuration from /ss_policy
security:  policydb version 8 does not match my version 7
security:  error while loading /ss_policy, cannot initialize.
SELinux:  Could not initialize
Freeing unused kernel memory: 208k freed
Adding Swap: 498004k swap-space (priority -1)
security_context_to_sid: called before initial load_policy on unknown context system_u:object_r:policy_config_t

something looks very wrong here. my /ss_policy is up-to-date:

-rw-r--r--    1 root     root      1291704 Apr 12 11:50 ss_policy

but my "make install" fails:

arkham:/etc/selinux# make install
install -m 644 -o root -g root policy /ss_policy
chsid system_u:object_r:policy_config_t /ss_policy
system_u:object_r:policy_config_t: Invalid argument
make: *** [install] Error 1

so that is probably the source of the problem. anyone got an idea what 
I'm doing wrong? the policy itself looks ok:

arkham:/etc/selinux# checkpolicy
checkpolicy:  loading policy configuration from policy.conf
security:  5 users, 5 roles, 488 types
security:  29 classes, 52901 rules
checkpolicy:  policy configuration loaded

I also have this error:

arkham:/etc/selinux# load_policy /ss_policy
security_load_policy: Invalid argument

maybe it's related. Since this fails, I can't relabel:

arkham:/etc/selinux# make relabel
/usr/bin/load_policy /ss_policy
security_load_policy: Invalid argument
make: *** [tmp/load] Error 2


I did remove the persistent label things:
  rm -rf /...security /var/...security


I'll try a few more things, but I'm afraid the failed make install is
the cause of all troubles, so any help would be appreciated...



-- 
http://web.lemuria.org/pubkey.html
pub  1024D/D88D35A6 2001-11-14 Tom Vogt <tom@lemuria.org>
     Key fingerprint = 276B B7BB E4D8 FCCE DB8F  F965 310B 811A D88D 35A6

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
