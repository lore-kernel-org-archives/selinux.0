Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m37ElFhc030468
	for <selinux@tycho.nsa.gov>; Mon, 7 Apr 2008 10:47:15 -0400
Received: from fg-out-1718.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m37EkTQV012562
	for <selinux@tycho.nsa.gov>; Mon, 7 Apr 2008 14:46:54 GMT
Received: by fg-out-1718.google.com with SMTP id 16so1294419fgg.40
        for <selinux@tycho.nsa.gov>; Mon, 07 Apr 2008 07:45:47 -0700 (PDT)
Message-ID: <cadfc0e40804070718s23964c78p5f8f7da33e946733@mail.gmail.com>
Date: Mon, 7 Apr 2008 09:18:38 -0500
From: "Xavier Toth" <txtoth@gmail.com>
To: "SE Linux" <selinux@tycho.nsa.gov>
Subject: gdm login problem when polyinstantiating /tmp
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

When I configure namespace.conf to polyinstantiate /tmp I cannot login
through gdm. Looking at /var/log/secure it appears that pam_namespace
thinks everything is ok:

Apr  7 08:50:37 comms gdm-session-worker[2471]: pam_unix(gdm:session):
session closed for user tedx
Apr  7 08:50:54 comms gdm-session-worker[2687]:
pam_namespace(gdm:session): open_session - start
Apr  7 08:50:54 comms gdm-session-worker[2687]:
pam_namespace(gdm:session): Parsing config file
/etc/security/namespace.conf
Apr  7 08:50:54 comms gdm-session-worker[2687]:
pam_namespace(gdm:session): Expanded polydir: '/tmp'
Apr  7 08:50:54 comms gdm-session-worker[2687]:
pam_namespace(gdm:session): Expanded ruser polydir: '/tmp'
Apr  7 08:50:54 comms gdm-session-worker[2687]:
pam_namespace(gdm:session): Expanded instance prefix: '/tmp.inst/'
Apr  7 08:50:54 comms gdm-session-worker[2687]:
pam_namespace(gdm:session): Configured poly dirs:
Apr  7 08:50:54 comms gdm-session-worker[2687]:
pam_namespace(gdm:session): dir='/tmp' iprefix='/tmp.inst/' meth=3
Apr  7 08:50:54 comms gdm-session-worker[2687]:
pam_namespace(gdm:session): override user 0
Apr  7 08:50:54 comms gdm-session-worker[2687]:
pam_namespace(gdm:session): override user 3
Apr  7 08:50:54 comms gdm-session-worker[2687]:
pam_namespace(gdm:session): Set up namespace for pid 2687
Apr  7 08:50:54 comms gdm-session-worker[2687]:
pam_namespace(gdm:session): Checking for ns override in dir /tmp for
uid 0
Apr  7 08:50:54 comms gdm-session-worker[2687]:
pam_namespace(gdm:session): Checking for ns override in dir /tmp for
uid 0
Apr  7 08:50:54 comms gdm-session-worker[2687]:
pam_namespace(gdm:session): Overriding poly for user 0 for dir /tmp
Apr  7 08:50:54 comms gdm-session-worker[2687]:
pam_namespace(gdm:session): namespace setup ok for pid 2687

but in /var/log/messages I see things that make me think either gdm or
gconfd are having a problem which is killing the session:

Apr  7 08:58:15 comms gdm-simple-slave[3247]: DEBUG: GdmSessionDirect:
Emitting 'accredited' signal
Apr  7 08:58:15 comms gdm-simple-slave[3247]: DEBUG: GdmSimpleSlave: accredited
Apr  7 08:58:15 comms gdm-simple-slave[3247]: DEBUG: GdmSimpleSlave:
trying to migrate session
Apr  7 08:58:15 comms gdm-simple-slave[3247]: DEBUG: GdmSlave: getting
proxy for seat: /org/freedesktop/ConsoleKit/Seat1
Apr  7 08:58:15 comms gdm-simple-slave[3247]: DEBUG: GdmSlave:
checking if seat can activate sessions
Apr  7 08:58:15 comms gdm-simple-slave[3247]: DEBUG: GdmSlave: unable
to determine session to activate
Apr  7 08:58:15 comms gdm-simple-slave[3247]: DEBUG: GdmSimpleSlave: migrated: 0
Apr  7 08:58:15 comms gdm-simple-slave[3247]: DEBUG:
GdmWelcomeSession: Stopping welcome_session
Apr  7 08:58:15 comms gdm-simple-slave[3247]: DEBUG: GdmCommon:
sending signal 15 to process -3271
Apr  7 08:58:15 comms gdm-simple-greeter[3271]: DEBUG:
GdmSignalHandler: handling signal 15
Apr  7 08:58:15 comms gdm-simple-greeter[3271]: DEBUG:
GdmSignalHandler: Found 1 callbacks
Apr  7 08:58:15 comms gdm-simple-greeter[3271]: DEBUG:
GdmSignalHandler: running 15 handler: 0x8052420
Apr  7 08:58:15 comms gdm-simple-greeter[3271]: DEBUG: Got callback
for signal 15
Apr  7 08:58:15 comms gdm-simple-greeter[3271]: DEBUG: Caught signal
15, shutting down normally.
Apr  7 08:58:15 comms gdm-simple-greeter[3271]: DEBUG:
GdmSignalHandler: Caught termination signal - exiting main loop
Apr  7 08:58:15 comms gconfd (gdm-3280): Exiting
Apr  7 08:58:15 comms gdm-simple-slave[3247]: DEBUG:
GdmWelcomeSession: Waiting on process 3271
Apr  7 08:58:15 comms gdm-simple-slave[3247]: DEBUG: GdmCommon:
process (pid:3271) done (status:1)
Apr  7 08:58:15 comms gdm-simple-slave[3247]: DEBUG:
GdmWelcomeSession: Wait on child process failed
Apr  7 08:58:15 comms gdm-simple-slave[3247]: DEBUG:
GdmWelcomeSession: WelcomeSession died
Apr  7 08:58:15 comms gdm-simple-slave[3247]: DEBUG:
GdmWelcomeSession: De-registering session from ConsoleKit
Apr  7 08:58:15 comms gdm-simple-slave[3247]: DEBUG:
GdmWelcomeSession: Stopping D-Bus daemon
Apr  7 08:58:15 comms gdm-simple-slave[3247]: DEBUG: GdmCommon:
sending signal 15 to process -3269
Apr  7 08:58:15 comms gdm-simple-slave[3247]: DEBUG: GreeterServer:
Stopping greeter server...
Apr  7 08:58:15 comms gdm-simple-slave[3247]: DEBUG: GdmSlave:
Requesting user authorization
Apr  7 08:58:15 comms gdm-simple-slave[3247]: DEBUG: GdmSlave: Got
user authorization: /tmp/.gdm-xauth-root.YMLB9T
Apr  7 08:58:15 comms gdm-simple-slave[3247]: DEBUG: GdmSessionDirect:
looking for session file 'gnome.desktop'
Apr  7 08:58:15 comms gdm-simple-slave[3247]: DEBUG: GreeterServer:
obj_path=/org/freedesktop/DBus/Local
interface=org.freedesktop.DBus.Local method=Disconnected
Apr  7 08:58:15 comms gdm-simple-slave[3247]: DEBUG: GreeterServer: Disconnected
Apr  7 08:58:15 comms gdm-simple-slave[3247]: DEBUG:
greeter_server_unregister_handler

I'm using the following init script in my namespace.conf configuration
of /tmp to move the X unix domain socket:

#!/bin/sh
if [ \"$1\" == \"/tmp\" ]; then
   if [ ! -f /.tmp/.X11-unix ]; then
      mkdir -p /.tmp/.X11-unix > /dev/null 2>&1
   fi
   mount | grep X11-unix > /dev/null 2>&1
   if [ $? -ne 0 ]; then
      mount --bind /tmp/.X11-unix /.tmp/.X11-unix > /dev/null 2>&1
   fi
   cp -fp -- /tmp/.X0-lock \"$2/.X0-lock\" > /dev/null 2>&1
   mkdir -- \"$2/.X11-unix\" > /dev/null 2>&1
   ln -fs -- /.tmp/.X11-unix/X0 \"$2/.X11-unix/X0\" > /dev/null 2>&1
fi

Maybe there a similar things I need to do for gconfd?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
