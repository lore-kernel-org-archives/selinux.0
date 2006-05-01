From: =?utf-8?q?T=C3=B6r=C3=B6k_Edwin?= <edwin@gurde.com>
To: selinux@tycho.nsa.gov
Subject: [4/4] Labeling only policy for fireflier (install)
Date: Mon, 1 May 2006 19:43:15 +0300
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        fireflier-devel@lists.sourceforge.net
References: <200604021240.21290.edwin@gurde.com> <1146079604.28745.183.camel@moss-spartans.epoch.ncsc.mil> <200605011917.54954.edwin@gurde.com>
In-Reply-To: <200605011917.54954.edwin@gurde.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200605011943.15454.edwin@gurde.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an install script I would use to install this policy.
I put those mkdir/touch there, because otherwise semodule failed on a system 
with no policy installed.
Is anything I should watch out for when installing policy on a system that 
doesn't yet have selinux policy? (but it has the required libs, and binaries 
from policycoreutils).

This install script is to be used before selinux is enabled (i.e. selinux=0 on 
boot), and then doing a reboot with selinux=1 should "just work" (i.e. 
without any avc denied messages on boot).

I tested this on a virtual machine, and will test it on different 
distributions on real machines soon, but in the meantime has anybody 
encountered any problems when setting up selinux?
(I encountered a segfault with semodule, but it got fixed with an upgrade of 
libs+tools, not sure which package/version fixed it)

base contains fireflier_base.pp generated from fireflier_base.conf (see [1/4])
generator contains fireflier.pp generated from fireflier.te, fireflier.fc, 
fireflier.if, unconfined_norelabel.if (see [2/4])

------install.sh
#!/bin/sh
AWK=awk
SEMODULE=/usr/sbin/semodule

SELINUX_ROOT=/etc/selinux
SELINUX_CONFIG=$SELINUX_ROOT/config
SELINUX_CONFIG_OLD=$SELINUX_ROOT/config.old
SELINUX_SEMANAGE_CONF=$SELINUX_ROOT/semanage.conf

FIREFLIER_POLICY_NAME=fireflier
FIREFLIER_POLICY_ROOT=$SELINUX_ROOT/$FIREFLIER_POLICY_NAME
FIREFLIER_POLICY_BASE=base/fireflier_base.pp
FIREFLIER_POLICY_BASE_MOD=generator/fireflier.pp





if [ ! -e $SELINUX_SEMANAGE_CONF ]; then
     echo "You don't have an semanage.conf file, creating one";
     cat >$SELINUX_SEMANAGE_CONF <<EOF
# Specify how libsemanage will interact with a SELinux policy manager.
# The four options are:
#
#  "source"     - libsemanage manipulates a source SELinux policy
#  "direct"     - libsemanage will write directly to a module store.
#  /foo/bar     - Write by way of a policy management server, whose
#                 named socket is at /foo/bar.  The path must begin
#                 with a '/'.
#  foo.com:4242 - Establish a TCP connection to a remote policy
#                 management server at foo.com.  If there is a colon
#                 then the remainder is interpreted as a port number;
#                 otherwise default to port 4242.
module-store = direct

# When generating the final linked and expanded policy, by default
# semanage will set the policy version to POLICYDB_VERSION_MAX, as
# given in <sepol/policydb.h>.  Change this setting if a different
# version is necessary.
#policy-version = 19     
EOF
fi
 

mkdir -p $FIREFLIER_POLICY_ROOT
mkdir -p $FIREFLIER_POLICY_ROOT/policy
mkdir -p $FIREFLIER_POLICY_ROOT/modules
mkdir -p $FIREFLIER_POLICY_ROOT/modules/active
mkdir -p $FIREFLIER_POLICY_ROOT/contexts
mkdir -p $FIREFLIER_POLICY_ROOT/contexts/files
touch $FIREFLIER_POLICY_ROOT/modules/active/policy.kern
touch $FIREFLIER_POLICY_ROOT/modules/active/homedir_template
touch $FIREFLIER_POLICY_ROOT/modules/active/file_contexts
touch $FIREFLIER_POLICY_ROOT/modules/active/seusers.final


$SEMODULE -v -b $FIREFLIER_POLICY_BASE -s $FIREFLIER_POLICY_NAME
$SEMODULE -v -i $FIREFLIER_POLICY_BASE_MOD -s $FIREFLIER_POLICY_NAME

if [ -e $SELINUX_CONFIG_OLD ]; then
    echo "";
    echo "  $SELINUX_CONFIG_OLD already exists, please move it to a safe 
place, and then delete it";
    echo "  Aborting script!";
exit;
fi

if [ -e $SELINUX_CONFIG ]; then
   echo "Backing up SELinux configuration $SELINUX_CONFIG to 
$SELINUX_CONFIG_OLD"
   cp $SELINUX_CONFIG $SELINUX_CONFIG_OLD
   echo "Switching to $FIREFLIER_POLICY_NAME policy"
   CURRENT_TYPE=`$AWK -F= '/^SELINUXTYPE/{ print $2 }' $SELINUX_CONFIG`
   sed -s s/$CURRENT_TYPE/$FIREFLIER_POLICY_NAME/ $SELINUX_CONFIG_OLD > 
$SELINUX_CONFIG
   echo "Switching to enforcing mode"
   CURRENT_MODE=`$AWK -F= '/^SELINUX=/{ print $2 }' $SELINUX_CONFIG`
   sed -s s/$CURRENT_MODE/enforcing/ $SELINUX_CONFIG_OLD > $SELINUX_CONFIG
else
   echo "Generating initial policy config"
   mkdir -p $SELINUX_ROOT
   cat >$SELINUX_CONFIG <<EOF
# used by init
SELINUX=enforcing
# active policy
SELINUXTYPE=fireflier
EOF
fi

echo "Setting up initial labels on critical locations"
setfiles $FIREFLIER_POLICY_ROOT/contexts/files/file_contexts 
$FIREFLIER_POLICY_ROOT /sbin /usr/sbin /etc/selinux/config
chcon system_u:object_r:semanage_lock_t $FIREFLIER_POLICY_ROOT/modules/*.LOCK

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
