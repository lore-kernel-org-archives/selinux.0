Subject: rox file contexts
From: Timothy Wood <timothy@hallcomp.com>
To: SELinux <SELinux@tycho.nsa.gov>
Content-Type: multipart/mixed; boundary="=-slfIRmd0rJ1+h6komycm"
Date: 23 Aug 2002 12:15:49 -0400
Message-Id: <1030119350.16277.49.camel@phobos>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-slfIRmd0rJ1+h6komycm
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Attached and inline, for anyones interest, are the file contexts I
created for the ROX file/session manager and wrappers.  Please note that
although this is a seperate file the contents should be appended to the
policy/file_contexts/types.fc in order for them to work properly.

As a side note, if anyone is looking for a very fast, pretty and
decently featured Window/Session Manager give ROX a try.  It takes a
little bit of work to get it installed but it's quite decent. 
rox.sourceforge.net

Timothy,

#
# Rules for ROX Filer/Session and Wrappers
#
# PLEASE APPEND ME TO 
# policy/file_contexts/types.fc
# in order for me to work properly
#
# eg cat rox.contexts >> types.fc

# ROX-Filer
/usr/apps/ROX-Filer/Linux-ix86/ROX-Filer		system_u:object_r:bin_t

# ROX-Session
/usr/apps/ROX-Session/Linux-ix86/ROX-Session		system_u:object_r:bin_t

# ROX wrappers
/usr/apps/Wallpaper/AutoStart.py		system_u:object_r:bin_t
/usr/apps/Wallpaper/no_display.py		system_u:object_r:bin_t
/usr/apps/(.*)/AppRun		system_u:object_r:bin_t

--=-slfIRmd0rJ1+h6komycm
Content-Disposition: attachment; filename=rox.contexts
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=rox.contexts; charset=ISO-8859-1


#
# Rules for ROX Filer/Session and Wrappers
#
# PLEASE APPEND ME TO=20
# policy/file_contexts/types.fc
# in order for me to work properly
#
# eg cat rox.contexts >> types.fc

# ROX-Filer
/usr/apps/ROX-Filer/Linux-ix86/ROX-Filer		system_u:object_r:bin_t

# ROX-Session
/usr/apps/ROX-Session/Linux-ix86/ROX-Session		system_u:object_r:bin_t

# ROX wrappers
/usr/apps/Wallpaper/AutoStart.py		system_u:object_r:bin_t
/usr/apps/Wallpaper/no_display.py		system_u:object_r:bin_t
/usr/apps/(.*)/AppRun		system_u:object_r:bin_t

--=-slfIRmd0rJ1+h6komycm--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
