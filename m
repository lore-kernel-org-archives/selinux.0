To: "SELinux@tycho.nsa.gov" <Selinux@tycho.nsa.gov>, refpolicy
 <refpolicy@oss.tresys.com>
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: ANN: SETools 4.0.0-beta
Message-ID: <56C718D6.9000308@tresys.com>
Date: Fri, 19 Feb 2016 08:29:58 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Tresys has released SETools 4.0.0-beta:

https://github.com/TresysTechnology/setools/releases/tag/4.0.0-beta

In this release, sediff is implemented and the analysis library is
feature complete, except for pending v30 policy support.  This new
version of sediff is more comprehensive than prior versions, finding
differences that were missed in previous versions such as constraints
and portcons.  The remaining effort for the 4.0.0 final release is
completing the apol GUI, plus any bugfixing.

If you would like to help, pending features and bugs are listed in
SETools' GitHub issue tracker:

https://github.com/TresysTechnology/setools/issues

Warning: If you use this to replace SETools 3.x on your system, it will
break the couple of tools from sepolgen/policycoreutils that depend on
SETools (e.g. sepolicy) since libqpol/libapol C libraries and their
corresponding Python wrappers are no longer provided.

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com
