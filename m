Message-ID: <4371594D.4010508@cmcrc.com>
Date: Wed, 09 Nov 2005 13:05:01 +1100
From: Johan Fischer <jfischer@cmcrc.com>
MIME-Version: 1.0
To: SELinux@tycho.nsa.gov
Subject: [refpolicy] policy not compiling
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi list,

Sorry for the trouble again....
I'm trying to install the refpolicy (tried the cvs HEAD and
refpolicy-20051019) but even with the patch applied earlier, the policy
doesn't compile....

Here's the output of make:
----------------------------
clamp:/etc/selinux/refpolicy/src/policy# make policy
cat policy/flask/security_classes policy/flask/initial_sids
policy/flask/access_vectors policy/support/loadable_module.spt
policy/support/misc_macros.spt policy/support/obj_perm_sets.spt
policy/mls policy/mcs > tmp/pre_te_files.conf
echo "define(\`per_userdomain_templates',\`" >
tmp/generated_definitions.conf
for i in apache apm bluetooth lpd; do \
        echo
"ifdef(\`""$i""_per_userdomain_template',\`""$i""_per_userdomain_template("'$*'")')"
\
                >> tmp/generated_definitions.conf ;\
done
echo "')" >> tmp/generated_definitions.conf
for i in apache.te apm.te bluetooth.te lpd.te; do \
        echo "define(\`$i')" >> tmp/generated_definitions.conf ;\
done
support/set_tunables policy/booleans.conf >> tmp/generated_definitions.conf
m4 policy/support/loadable_module.spt policy/support/misc_macros.spt
policy/support/obj_perm_sets.spt policy/modules/services/apache.if
policy/modules/services/apm.if policy/modules/services/bluetooth.if
policy/modules/services/lpd.if | sed -e s/dollarsstar/\$\*/g >
tmp/all_interfaces.conf
cat policy/modules/services/apache.te policy/modules/services/apm.te
policy/modules/services/bluetooth.te policy/modules/services/lpd.te >
tmp/all_te_files.conf
cat policy/systemuser policy/users policy/constraints >
tmp/post_te_files.conf
grep ^attribute tmp/all_te_files.conf > tmp/all_attrs_types.conf || true
grep '^type ' tmp/all_te_files.conf >> tmp/all_attrs_types.conf
cat tmp/post_te_files.conf > tmp/all_post.conf
grep '^sid ' tmp/all_te_files.conf >> tmp/all_post.conf || true
egrep '^fs_use_(xattr|task|trans)' tmp/all_te_files.conf >>
tmp/all_post.conf || true
grep ^genfscon tmp/all_te_files.conf >> tmp/all_post.conf || true
sed -r -e /^attribute/d -e '/^type /d' -e /^genfscon/d \
                -e '/^sid /d' -e '/^fs_use_(xattr|task|trans)/d' \
                < tmp/all_te_files.conf > tmp/only_te_rules.conf
Creating refpolicy policy.conf
m4 -D self_contained_policy -D enable_mcs -D targeted_policy -D
distro_redhat -D direct_sysadm_daemon -D hide_broken_symptoms -s
tmp/pre_te_files.conf tmp/generated_definitions.conf
tmp/all_interfaces.conf tmp/all_attrs_types.conf policy/global_booleans
policy/global_tunables tmp/only_te_rules.conf tmp/all_post.conf >
tmp/policy.conf.tmp
sed -e /^portcon/d -e /^nodecon/d -e /^netifcon/d < tmp/policy.conf.tmp
> policy.conf
grep ^portcon tmp/policy.conf.tmp >> policy.conf || true
grep ^netifcon tmp/policy.conf.tmp >> policy.conf || true
grep ^nodecon tmp/policy.conf.tmp >> policy.conf || true
Compiling refpolicy policy.20
/usr/bin/checkpolicy -M policy.conf -o policy.20
/usr/bin/checkpolicy:  loading policy configuration from policy.conf
tmp/only_te_rules.conf:28:ERROR 'syntax error' at token
'init_daemon_domain' on line 3204:
init_daemon_domain(httpd_t,httpd_exec_t)

/usr/bin/checkpolicy:  error(s) encountered while parsing configuration
make: *** [policy.20] Error 1
clamp:/etc/selinux/refpolicy/src/policy#
---------------------------

FYI, I'm using a debian unstable with policycoreutils 1.26.
even if I changed the distro to debian, it doesn't help...

Thx,
Johan.

-- 
Johan Fischer
Capital Markets CRC Limited
Level 2, 9 Castlereagh Street, Sydney NSW 2000
Tel: +61 2 9233 7999   Direct: +61 2 9236 9150
Fax: +61 2 9236 9177   http://www.cmcrc.com

Capital Markets CRC Ltd (CMCRC) - Confidential Communication
The information contained in this e-mail is confidential.  It is intended solely for the addressee. If you receive this e-mail by mistake please promptly inform us by reply e-mail and then delete the e-mail and destroy any printed copy. You must not disclose or use in any way the information in the e-mail. There is no warranty that this e-mail is error or virus free. It may be a private communication, and if so, does not represent the views of the CMCRC and its associates. If it is a private communication, care should be taken in opening it to ensure that undue offence is not given.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
