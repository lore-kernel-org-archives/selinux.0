Message-ID: <41F6D5BA.2030901@trustedcs.com>
Date: Tue, 25 Jan 2005 17:26:50 -0600
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: "'SELinux List'" <SELinux@tycho.nsa.gov>
Subject: [patch] add new files to policycoreutils.spec
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
     I noticed that building the latest policycoreutils rpm complains about 
unpackaged files.  Here is a patch to make it happy:

diff -u -p -r1.1.1.6 policycoreutils.spec
--- policycoreutils.spec	25 Jan 2005 18:07:41 -0000	1.1.1.6
+++ policycoreutils.spec	25 Jan 2005 23:24:19 -0000
@@ -58,6 +58,9 @@ rm -rf ${RPM_BUILD_ROOT}
  %{_mandir}/man8/restorecon.8.gz
  %{_sbindir}/genhomedircon
  %{_sbindir}/sestatus
+%{_sbindir}/open_init_pty
+%{_mandir}/man8/genhomedircon.8.gz
+%{_mandir}/man8/open_init_pty.8.gz
  %{_mandir}/man8/sestatus.8.gz
  %{_mandir}/man8/setfiles.8.gz
  %{_mandir}/man8/fixfiles.8.gz
@@ -66,6 +69,7 @@ rm -rf ${RPM_BUILD_ROOT}
  %{_bindir}/newrole
  %{_bindir}/audit2allow
  %{_mandir}/man1/newrole.1.gz
+%{_mandir}/man1/audit2allow.1.gz
  %config %{_sysconfdir}/pam.d/newrole
  %{_sbindir}/run_init
  %config %{_sysconfdir}/pam.d/run_init

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
