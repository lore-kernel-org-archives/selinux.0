Subject: Re: bug#24541: runcon tty hijacking via TIOCSTI ioctl
To: up201407890@alunos.dcc.fc.up.pt, 24541@debbugs.gnu.org,
 SE-Linux <SELinux@tycho.nsa.gov>
References: <20160925133955.72163x0kftak7yqs@webmail.alunos.dcc.fc.up.pt>
From: Paul Eggert <eggert@cs.ucla.edu>
Message-ID: <ad807471-3549-b9fa-e718-8110e6a768b2@cs.ucla.edu>
Date: Sun, 25 Sep 2016 11:49:40 -0700
MIME-Version: 1.0
In-Reply-To: <20160925133955.72163x0kftak7yqs@webmail.alunos.dcc.fc.up.pt>
Content-Type: multipart/mixed; boundary="------------0E4B4496D9029FEB435C050E"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a multi-part message in MIME format.
--------------0E4B4496D9029FEB435C050E
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

up201407890@alunos.dcc.fc.up.pt wrote re <http://bugs.gnu.org/24541>:
> When executing a program via the runcon utility, the nonpriv session
> can escape to the parent session by using the TIOCSTI ioctl to push
> characters into the terminal's input buffer, allowing an attacker to
> execute arbitrary commands without the SELinux security context.

Thanks for the bug report. Surely this is a bug in the setexeccon system =
call,=20
not in the runcon command that uses the system call. That being said, per=
haps=20
runcon should work around the bug via something like the attached patch.

--------------0E4B4496D9029FEB435C050E
Content-Type: text/x-diff;
 name="runcon.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="runcon.diff"

diff --git a/src/runcon.c b/src/runcon.c
index b25db04..52b0b36 100644
--- a/src/runcon.c
+++ b/src/runcon.c
@@ -249,6 +249,11 @@ main (int argc, char **argv)
     error (EXIT_FAILURE, errno, _("invalid context: %s"),
            quote (context_str (con)));
=20
+  /* Prevent the sandboxed process from using the TIOCSTI ioctl to
+     push characters into the controlling terminal's input buffer.  */
+  if (setsid () !=3D 0)
+    error (EXIT_FAILURE, errno, _("cannot create session"));
+
   if (setexeccon (context_str (con)) !=3D 0)
     error (EXIT_FAILURE, errno, _("unable to set security context %s"),
            quote (context_str (con)));

--------------0E4B4496D9029FEB435C050E--
