Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s84DHJT0027435
 for <selinux@tycho.nsa.gov>; Thu, 4 Sep 2014 09:17:20 -0400
Message-ID: <1409836477.67254.YahooMailNeo@web87902.mail.ir2.yahoo.com>
Date: Thu, 4 Sep 2014 14:14:37 +0100
From: Richard Haines <richard_c_haines@btinternet.com>
Subject: SELinux Userspace Release 2014-08-26-rc2 HLL/CIL query
To: selinux list <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Reply-To: Richard Haines <richard_c_haines@btinternet.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I've been attempting to convert a monolithic policy (really a modular base policy with
no modules) to CIL, however it fails with:

Failed to resolve roletype statement at XX of /var/lib/selinux/modular-test/tmp/modules/400/base/cil

when running: semodule -s modular-test -i base.pp


The cause of this appears to be the following in policycoreutils/hll/pp/pp.c where the role
statement is ignored for the base policy:


    case ROLE_ROLE:
        if (scope == SCOPE_DECL) {
            if (pdb->policy_type == SEPOL_POLICY_MOD) {
                // roles are defined twice, once in a module and once in base.
                // CIL doesn't allow duplicate declarations, so only take the
                // roles defined in the modules
                cil_println(indent, "(role %s)", key);

Question: Should these type of policies be supported, if so should the CIL compiler
cope with duplicate role statements or the conversion service modified to remove duplicates.
Also there is a bug in that the CIL module is deleted from the tmp directory so you cannot
view the failed conversion.

I built the CIL module using pp directly  (cat base.pp | ./pp > base.cil), then added the
(role ...) statement, this compiled okay using secilc.


Richard
