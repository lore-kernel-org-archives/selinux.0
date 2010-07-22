Subject: Re: This is my first patch for systemd
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <4C4837F2.1070806@redhat.com>
References: <4C4837F2.1070806@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 22 Jul 2010 10:21:20 -0400
Message-ID: <1279808480.11197.28.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2010-07-22 at 08:22 -0400, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Wanted to have you guys review before I send it up to systemd.
> 
> This patch sets the socket context based on the domain of the daemon
> that systemd will start on connection.  It also labels the fifo_file
> based off of the daemons label and the label of the directory the
> fifo_file will be created in.
> 
> 
> The patch does not handle, systemd creating the directories for the
> fifo_file.  In the future, their is talk of making /var/run a tmpfs file
> system.  This would mean systemd would create /var/run/mysqld/ before
> creating /var/run/mysqld/mysqld.socket.  Additional SELinux controls
> would have to be added to systemd to get this correct.  Not sure if the
> correct thing to do is at selabel or use
> selinux_getfileconfrompath(daemon, parentdir, "dir")

selabel_lookup is likely safer, as the /var/run/mysqld directory might
be created by the package or by the init script rather than by the
daemon itself, so there might not be a type transition defined in policy
for it.  A few comments below.

diff --git a/configure.ac b/configure.ac
index 03feb43..4c75f66 100644
--- a/configure.ac
+++ b/configure.ac
@@ -105,6 +105,11 @@ PKG_CHECK_MODULES(DBUS, [ dbus-1 >= 1.3.2 ])
 AC_SUBST(DBUS_CFLAGS)
 AC_SUBST(DBUS_LIBS)
 
+PKG_CHECK_MODULES(SELINUX, [ libselinux >= 2.0.96 ])

Not sure you need this strict of a version check.  The libselinux
interfaces that you are using have been around for a while.

diff --git a/src/socket-util.c b/src/socket-util.c
index 442abfe..7712b8b 100644
--- a/src/socket-util.c
+++ b/src/socket-util.c
@@ -315,8 +316,12 @@ int socket_address_listen(
         if ((r = socket_address_verify(a)) < 0)
                 return r;
 
-        /* FIXME SELINUX: The socket() here should be done with the
-         * right SELinux context set */
+        if (scon && setsockcreatecon(scon) < 0) {

Why not unconditionally call setsockcreatecon(scon) here?
If scon is NULL, this will simply reset to the default policy behavior
for the socket so it does no harm and it will prevent you from
accidentally labeling a socket with the context used the last time
around.  Alternatively you should call setsockcreatecon(NULL) after
calling socket() each time to reset it.

diff --git a/src/socket.c b/src/socket.c
index b06ba09..f1f378c 100644
--- a/src/socket.c
+++ b/src/socket.c

 static int fifo_address_create(
 <snip>
-        /* FIXME SELINUX: The mkfifo here should be done with
-         * the right SELinux context set */
+        if (scon && ((r = selinux_getfileconfrompath(scon, path, "FIFO_FILE", &filecon))  == 0)) {

Should be 'fifo_file' (lowercase) rather than FIFO_FILE.

+                r = setfscreatecon(filecon);

Where do you reset the fscreate context to NULL so that other directories and files won't keep
being created in the prior fscreate context?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
