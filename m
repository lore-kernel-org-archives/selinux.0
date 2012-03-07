Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q27DIqVK024867
	for <selinux@tycho.nsa.gov>; Wed, 7 Mar 2012 08:18:53 -0500
Received: by lahc1 with SMTP id c1so8075766lah.12
        for <selinux@tycho.nsa.gov>; Wed, 07 Mar 2012 05:18:51 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 7 Mar 2012 08:18:51 -0500
Message-ID: <CAD8iFzxusoJpp=kAMjhT8-toA0N_ejDE=bFTjV7OvsJYyKeDtw@mail.gmail.com>
Subject: CTS failure on SEAndroid Galaxy Nexus
From: Subramani Venkatesh <selinuxv31@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
Trying to execute CTS on SEAndroid with security enforce, but I am not
successful getting it working, it crashes at the very beginning with
an exeception, is anyone else seeing the same issue?

W/ProcessStats(  207): Skipping unknown process pid 1233
D/AndroidRuntime( 1246):
D/AndroidRuntime( 1246): >>>>>> AndroidRuntime START
com.android.internal.os.RuntimeInit <<<<<<
D/AndroidRuntime( 1246): CheckJNI is OFF
W/dalvikvm( 1246): Exception Ljava/lang/NullPointerException; thrown
while initializing Ljava/lang/System;
W/dalvikvm( 1246): Exception Ljava/lang/ExceptionInInitializerError;
thrown while initializing Ljava/lang/ClassLoader$SystemClassLoader;
W/dalvikvm( 1246): WARNING: system class loader is NULL (setting main ctxt)
W/dalvikvm( 1246): Warning: tracked references remain post-initialization
W/dalvikvm( 1246): MAIN reference table (0x170be90) dump:
W/dalvikvm( 1246):   Last 1 entries (of 1):
E/dalvikvm( 1246): Class lookup Ljava/lang/Daemons; attempted with
exception pending
W/dalvikvm( 1246): Pending exception is:
I/dalvikvm( 1246): java.lang.ExceptionInInitializerError:
I/dalvikvm( 1246):      at
java.lang.ClassLoader.getSystemClassLoader(ClassLoader.java:125)
I/dalvikvm( 1246):      at dalvik.system.NativeStart.main(Native Method)
I/dalvikvm( 1246): Caused by:
I/dalvikvm( 1246): java.lang.ExceptionInInitializerError:
I/dalvikvm( 1246):      at
java.lang.ClassLoader.createSystemClassLoader(ClassLoader.java:100)
I/dalvikvm( 1246):      at java.lang.ClassLoader.access$000(ClassLoader.java:65)
I/dalvikvm( 1246):      at
java.lang.ClassLoader$SystemClassLoader.<clinit>(ClassLoader.java:81)
I/dalvikvm( 1246):      at
java.lang.ClassLoader.getSystemClassLoader(ClassLoader.java:125)
I/dalvikvm( 1246):      at dalvik.system.NativeStart.main(Native Method)
I/dalvikvm( 1246): Caused by:
I/dalvikvm( 1246): java.lang.NullPointerException:
I/dalvikvm( 1246):      at java.util.Hashtable.put(Hashtable.java:365)
I/dalvikvm( 1246):      at
java.lang.System.initSystemProperties(System.java:286)
I/dalvikvm( 1246):      at java.lang.System.getProperties(System.java:260)
I/dalvikvm( 1246):      at java.lang.System.getProperty(System.java:425)
I/dalvikvm( 1246):      at java.lang.System.getProperty(System.java:406)
I/dalvikvm( 1246):      at java.lang.System.<clinit>(System.java:90)
I/dalvikvm( 1246):      at
java.lang.ClassLoader.createSystemClassLoader(ClassLoader.java:100)
I/dalvikvm( 1246):      at java.lang.ClassLoader.access$000(ClassLoader.java:65)
I/dalvikvm( 1246):      at
java.lang.ClassLoader$SystemClassLoader.<clinit>(ClassLoader.java:81)
I/dalvikvm( 1246):      at
java.lang.ClassLoader.getSystemClassLoader(ClassLoader.java:125)
I/dalvikvm( 1246):      at dalvik.system.NativeStart.main(Native Method)


Regards,
Subbu

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
