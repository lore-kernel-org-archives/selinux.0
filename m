Message-ID: <455CE2F3.3070200@mentalrootkit.com>
Date: Thu, 16 Nov 2006 17:15:15 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: Daniel J Walsh <dwalsh@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: Multiple small fixes to policycoreutils
References: <6FE441CD9F0C0C479F2D88F959B015885C79BC@exchange.columbia.tresys.com>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B015885C79BC@exchange.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
>> From: Karl MacMillan [mailto:kmacmillan@mentalrootkit.com] 
>>
>> Daniel J Walsh wrote:
>>> Joshua Brindle wrote:
>>>> Karl MacMillan wrote:
>> <snip>
>>
>>>>> What about a top-level USE_PIE makefile variable that directs all 
>>>>> sub-Makefiles to set PIE flags if appropriate for that module? By 
>>>>> default it would be off. This gets the behavior you want without 
>>>>> having to carry a patch and keeps the current behavior.
>>>>>
>>>> No patch necessary, like Chris said make CFLAGS="-fPIE -02 -Werror 
>>>> -Wall" LDFLAGS="-pie"
>>>>
>>>> done and done.
>>>>
>>> No, because then all compiled apps become -pie.  We only 
>> want this on 
>>> the daemons.
>>>
>> What about this instead?
> 
> Why doesn't make CFLAGS="-fPIE -02 -Werror -Wall" LDFLAGS="-pie" work? 
> Why does it matter if everything is built pie?
> 

There are performance costs associated with pie, particularly at 
startup. Talking to Dan though, he doesn't think it is enough to not 
just build everything as pie.

Resend below that I will apply unless there are other objections.

> This is distro specific (gentoo completely overrides the CFLAGS and
> LDFLAGS, I'm not sure what debian does). I don't think whether or not to
> override the user CFLAGS with non-critical things (e.g., things
> necessary to build the app like -I($PREFIX)/include) is appropriate for
> the upstream makefiles.
> 
> For that matter, anyone know why -D_FILE_OFFSET_BITS=64 is in the
> override?
> 

I wondered that as well - Dan?

Karl

diff -r fdaf7172a43e policycoreutils/newrole/newrole.c
--- a/policycoreutils/newrole/newrole.c	Wed Nov 15 15:49:31 2006 -0500
+++ b/policycoreutils/newrole/newrole.c	Thu Nov 16 17:03:40 2006 -0500
@@ -1028,6 +1028,7 @@ int main(int argc, char *argv[])
  	{
  		fprintf(stderr, _("newrole: incorrect password for %s\n"),
  			pw.pw_name);
+		send_audit_message(0, old_context, new_context, ttyn);
  		goto err_close_pam;
  	}

diff -r fdaf7172a43e policycoreutils/restorecond/restorecond.conf
--- a/policycoreutils/restorecond/restorecond.conf	Wed Nov 15 15:49:31 
2006 -0500
+++ b/policycoreutils/restorecond/restorecond.conf	Thu Nov 16 17:03:40 
2006 -0500
@@ -2,5 +2,6 @@
  /etc/samba/secrets.tdb
  /etc/mtab
  /var/run/utmp
+/var/log/wtmp
  ~/public_html
  ~/.mozilla/plugins/libflashplayer.so
diff -r fdaf7172a43e policycoreutils/scripts/genhomedircon.8
--- a/policycoreutils/scripts/genhomedircon.8	Wed Nov 15 15:49:31 2006 -0500
+++ b/policycoreutils/scripts/genhomedircon.8	Thu Nov 16 17:03:40 2006 -0500
@@ -45,35 +45,30 @@ Indicates the selinux type of this insta
  .SH DESCRIPTION
  .PP
  This utility is used to generate file context configuration entries for
-user home directories based on their default roles and is run when 
building
-the policy. It can also be run when ever the
-.I /etc/selinux/<<SELINUXTYPE>>/users/local.users
-file is changed
+user home directories based on their
+.B prefix
+entry in the the
+.B semanage user record.
+genhomedircon is run when building
+the policy. It is also run automaticaly when ever the
+.B semanage
+utility modifies
+.B user
+or
+.B login
+records.
  Specifically, we replace HOME_ROOT, HOME_DIR, and ROLE macros in the
  .I /etc/selinux/<<SELINUXTYPE>>/contexts/files/homedir_template
-file with generic and user-specific values.
-.I local.users
-file. If a user has more than one role in
-.I local.users,
-.B genhomedircon
-uses the first role in the list.
+file with generic and user-specific values.  HOME_ROOT and HOME_DIR is 
replaced with each distinct location where login users homedirectories 
are located.  Defaults to /home. ROLE is replaced based on the prefix 
entry in the
+.B user
+record.
  .PP
-If a user is not listed in
-.I local.users,
-.B genhomedircon
-assumes that the user's home dir will be found in one of the
-HOME_ROOTs.
-When looking for these users,
-.B genhomedircon
-only considers real users. "Real" users (as opposed
-to system users) are those whose UID is greater than or equal
+genhomedircon searches through all password entires for all "login" 
user home directories, (as opposed
+to system users).  Login users are those whose UID is greater than or 
equal
  .I STARTING_UID
  (default 500) and whose login shell is not "/sbin/nologin", or
  "/bin/false".
  .PP
-Users who are explicitly defined in
-.I local.users,
-are always "real" (including root, in the default configuration).
  .SH AUTHOR
  This manual page was originally written by
  .I Manoj Srivastava <srivasta@debian.org>,
diff -r fdaf7172a43e policycoreutils/semanage/semanage.8
--- a/policycoreutils/semanage/semanage.8	Wed Nov 15 15:49:31 2006 -0500
+++ b/policycoreutils/semanage/semanage.8	Thu Nov 16 17:03:40 2006 -0500
@@ -7,7 +7,7 @@ semanage \- SELinux Policy Management to
  .br
  .B semanage login \-{a|d|m} [\-sr] login_name
  .br
-.B semanage user \-{a|d|m} [\-LrR] selinux_name
+.B semanage user \-{a|d|m} [\-LrRP] selinux_name
  .br
  .B semanage port \-{a|d|m} [\-tr] [\-p protocol] port | port_range
  .br
@@ -71,6 +71,9 @@ MLS/MCS Security Range (MLS/MCS Systems
  .I                \-R, \-\-role
  SELinux Roles.  You must enclose multiple roles within quotes, 
separate by spaces. Or specify \-R multiple times.
  .TP
+.I                \-P, \-\-prefix
+SELinux Prefix.  Prefix added to home_dir_t and home_t for labeling 
users home directories.
+.TP
  .I                \-s, \-\-seuser
  SELinux user name
  .TP
diff -r fdaf7172a43e policycoreutils/semodule_expand/semodule_expand.8
--- a/policycoreutils/semodule_expand/semodule_expand.8	Wed Nov 15 
15:49:31 2006 -0500
+++ b/policycoreutils/semodule_expand/semodule_expand.8	Thu Nov 16 
17:03:40 2006 -0500
@@ -18,7 +18,7 @@ together a set of packages into a single
  .SH "OPTIONS"
  .TP
  .B \-V
-verbose mode
+show version
  .TP
  .B \-c [version]
  policy version to create

Signed-off by: Karl MacMillan <kmacmillan@mentalrootkit.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
