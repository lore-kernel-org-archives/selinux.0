Subject: init, checkpolicy manpage and labeling questions
From: =?ISO-8859-1?Q?Magos=E1nyi_=C1rp=E1d?= <mag@bunuel.tii.matav.hu>
To: SELinux <SELinux@tycho.nsa.gov>
Content-Type: multipart/mixed; boundary="=-Tbdy3Q696o4BEOZ7gcR7"
Date: 28 Aug 2003 13:51:42 +0200
Message-Id: <1062071503.3076.124.camel@kusturica>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-Tbdy3Q696o4BEOZ7gcR7
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: quoted-printable

Hi!

First the questions:

Make relabel complained about /var/run/pump.sock . putting a <<none>>
in file_contexts did not help, but I could manage it by removing the
socket.
Do we have labels on sockets yet?

My other problem is with various files in /dev. I use devfs and devfsd.
for example getfilecon fails for /dev/console, /dev/null, and /dev/pts/0
(in a devpts fs). Can someone explain the situation to me?

You can find a checkpolicy manpage attached. I was not too definiitive:)
Also here is my boot method, as I did not want to bootfrom initrd:
the real init is moved to /sbin/real_init, and have the same context
as the real init: system_u:object_r:init_exec_t
/sbin/init have root:object_r:sbin_t ( I think it isn't count anyway).
The source for /sbin/init:
-------------
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>

int main(int argc, char **argv)
{
        system("/etc/init.d/preinit.sh");
        execv("/sbin/real_init", argv);
        return errno;
}
------------------
/etc/init.d/preinit.sh:
------------------
#/bin/bash
mount /selinux
mount /proc
/usr/sbin/load_policy /etc/security/selinux/policy.15
-----------------
--=20
GNU GPL: csak tiszta forr=E1sb=F3l

--=-Tbdy3Q696o4BEOZ7gcR7
Content-Disposition: attachment; filename=checkpolicy.8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-troff-man; name=checkpolicy.8; charset=ISO-8859-2

.TH CHECKPOLICY 8
.\" NAME should be all caps, SECTION should be 1-8, maybe w/ subsection
.\" other parms are allowed: see man(7), man(1)
.SH NAME
checkpolicy \- SELinux policy compiler
.SH SYNOPSIS
.B checkpolicy
.I "checkpolicy [-b] [-d] [-o output_file] [input_file]"
.br
.SH "DESCRIPTION"
This manual page documents briefly the
.BR checkpolicy ,
command.
This manual page was written for the Debian GNU/Linux distribution
because the original program does not have a manual page.
.PP
.B checkpolicy
is a program that checks and compiles a SELinux security policy file
to binary representation.

It is used by the Makefile which compiles and installs the security policy.

.SH OPTIONS
.TP
.B \-h, \-\-help
Show summary of options, because do not understands this option.
.TP
.B \-b
Maybe this is to generate binary output.
.TP
.B \-d
Maybe this is to generate debug information.
.TP
.B \-o filename
The output file name.
.SH "SEE ALSO"
SELinux documentation http://www.nsa.gov/selinux/docs.html,
especially "Configuring the SELinux Policy".

The example policy configuration must be compiled into a binary representat=
ion before it can be read by the example security server. The compilation i=
s performed by running make in the policy directory. The compilation involv=
es three steps. First, the example policy configuration files are concatena=
ted togther. Second, the m4 macro processor is applied to the resulting con=
catenation to expand macros, yielding the policy.conf file. The checkpolicy=
 policy compiler is then run on this file to generate the binary representa=
tion in the policy.VERSION file, where VERSION represents the version numbe=
r.

The policy.VERSION file can be installed into the /etc/security/selinux dir=
ectory by running make install. The policy will then be loaded by the examp=
le security server when the kernel is next rebooted. If a runtime policy ch=
ange is desired (and authorized by the policy configuration), then the make=
 load command can be run to load the policy into a running kernel. In the e=
xample policy configuration, dynamically reloading the policy can only be d=
one by the sysadm_t domain.
.SH AUTHOR
This manual page was written by =C1rp=E1d Magos=E1nyi <mag@bunuel.tii.matav=
.hu>,
for the Debian GNU/Linux system (but may be used by others).

--=-Tbdy3Q696o4BEOZ7gcR7--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
