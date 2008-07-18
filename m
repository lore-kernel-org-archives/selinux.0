Message-ID: <4880D585.9000405@redhat.com>
Date: Fri, 18 Jul 2008 13:40:21 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SE Linux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: Patch to make libselinux shut up when SELinux is disabled.
References: <4880CFD1.1040102@redhat.com> <1216402063.17602.322.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1216402063.17602.322.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Stephen Smalley wrote:
> On Fri, 2008-07-18 at 13:16 -0400, Daniel J Walsh wrote:
> SELinux complains about things like restorecon or rpm when conflicts
> exist in file_context file even when SELinux is disabled.
> 
> It should just shut up....
> 
>> I think that's the wrong place to do it:
>> - the fact that the application called libselinux at all except to test
>> is_selinux_enabled() when SELinux is disabled is either a bug in the
>> application or an indication that the application wants SELinux behavior
>> regardless,
>> - silencing all log messages coming from libselinux is too broad.
> 
>> And of course, file_contexts conflicts should be caught during policy
>> build time aside from local customizations; if not, then we need to
>> change the policy build process to do that even for modular policy
>> builds.
> 
Well it could be argued that libraries should never write to the terminal...

Try explaining this to the users we are telling selinux disabled does
not effect their machines.  They just come away with the opinion that
SELinux Sucks and is broken.  Besides we are even complaining when they
are warnings and SELinux is disabled.

The problem seems to be a broken genhomedircon, but we don't currently
prevent users (rpm post install scripts)  from adding conflicting file
context in file context.local
plain text document attachment (diff)

The tools just complain about it after the fact.

# semanage fcontext -a -t httpd_sys_content_t /tmp
# matchpathcon /etc
# matchpathcon /etc/
/etc/selinux/targeted/contexts/files/file_contexts: Multiple different
specifications for /tmp  (system_u:object_r:httpd_sys_content_t:s0 and
system_u:object_r:tmp_t:s0).
/etc/	system_u:object_r:etc_t:s0

Nice.




diff --exclude-from=exclude -N -u -r nsalibselinux/src/callbacks.c
libselinux-2.0.67/src/callbacks.c
- --- nsalibselinux/src/callbacks.c	2008-06-12 23:25:14.000000000 -0400
+++ libselinux-2.0.67/src/callbacks.c	2008-07-18 11:15:56.000000000 -0400
@@ -16,6 +16,7 @@
 {
 	int rc;
 	va_list ap;
+	if (is_selinux_enabled() == 0) return 0;
 	va_start(ap, fmt);
 	rc = vfprintf(stderr, fmt, ap);
 	va_end(ap);

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkiA1YUACgkQrlYvE4MpobOXawCgqA+eAWSiytqSXvdmAXSOboMU
7BMAoOh5vRzyK8u8sWC/fIIaEuiK+I0F
=XAen
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
