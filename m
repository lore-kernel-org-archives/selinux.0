Message-ID: <4A14BE43.7070505@tycho.nsa.gov>
Date: Wed, 20 May 2009 22:36:51 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Dominick Grift <domg472@gmail.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SELinux@tycho.nsa.gov,
        Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: avc: denied null
References: <1242641994.470.5.camel@notebook2.grift.internal>	 <1242651013.29973.197.camel@localhost.localdomain>	 <1242651553.1057.0.camel@notebook2.grift.internal>	 <4A1374D5.6080504@tycho.nsa.gov> <1242817716.14664.3.camel@notebook2.grift.internal>
In-Reply-To: <1242817716.14664.3.camel@notebook2.grift.internal>
Content-Type: multipart/mixed;
 boundary="------------060903040802030300030602"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060903040802030300030602
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Dominick Grift wrote:
> On Tue, 2009-05-19 at 23:11 -0400, Eamon Walsh wrote:
>
>   
>> I found the cause of the "x_device" null avc's.  It was a bad hook call.
>>
>> I'm still stumped on the GLXMakeCurrent null avc's though.  I can't
>> reproduce the problem here running glxinfo/glxgears.  I suspect it
>> depends on the video driver / acceleration architecture being used.
>>     
>
> For what it is worth, that particular system has nvidia geforce 8600M GT and is using the proprietary blob (kmod-nvidia)
>
> Thanks
>   

If you're willing to compile the X server from source, you could apply
the attached patch and use gdb to attach to the running X server (this
has to be done over an ssh connection). 

Break on the SELinuxNullPermissionHappened function and reproduce the
GLXMakeCurrent avc, hopefully the breakpoint will fire and you can get a
backtrace.

Also there is another patch that will fix the x_device null avc's
(attached).


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--------------060903040802030300030602
Content-Type: text/x-patch;
 name="patch.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch.patch"

diff --git a/Xext/xselinux.c b/Xext/xselinux.c
index 3a6f096..c0b9c19 100644
--- a/Xext/xselinux.c
+++ b/Xext/xselinux.c
@@ -424,6 +424,13 @@ SELinuxTypeToClass(RESTYPE type)
     return knownTypes[type];
 }
 
+int
+SELinuxNullPermissionHappened(void)
+{
+    ErrorF("SELinux: null permission!\n");
+    return 0;
+}
+
 /*
  * Performs an SELinux permission check.
  */
@@ -438,6 +445,9 @@ SELinuxDoCheck(SELinuxSubjectRec *subj, SELinuxObjectRec *obj,
     auditdata->command = subj->command;
     errno = 0;
 
+    if (mode == DixUnknownAccess)
+	SELinuxNullPermissionHappened();
+
     if (avc_has_perm(subj->sid, obj->sid, class, mode, &subj->aeref,
 		     auditdata) < 0) {
 	if (mode == DixUnknownAccess)
diff --git a/configure.ac b/configure.ac
index daddd09..5fd9cb1 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1219,7 +1219,7 @@ PKG_CHECK_MODULES([XSERVERLIBS], [$REQUIRED_LIBS])
 # XSERVER_SYS_LIBS is the set of out-of-tree libraries which all servers
 # require.
 #
-XSERVER_CFLAGS="${XSERVERCFLAGS_CFLAGS} ${SHA1_CFLAGS}"
+XSERVER_CFLAGS="${XSERVERCFLAGS_CFLAGS} ${SHA1_CFLAGS} -O0 -g3"
 XSERVER_LIBS="$DIX_LIB $CONFIG_LIB $MI_LIB $OS_LIB"
 XSERVER_SYS_LIBS="${XSERVERLIBS_LIBS} ${SYS_LIBS} ${LIBS} ${SHA1_LIB}"
 AC_SUBST([XSERVER_LIBS])

--------------060903040802030300030602
Content-Type: text/x-patch;
 name="null_avc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="null_avc.patch"

commit 3cea176d5abcb0f14eefbdcbe17fed0847524dd4
Author: Eamon Walsh <ewalsh@tycho.nsa.gov>
Date:   Tue May 19 19:30:33 2009 -0400

    xace: Fix a bad device access hook call.
    
    Add a proper access mode, and reverse the logic of the return value.
    Zero ("Success") is returned on success from the hook calls.
    
    Signed-off-by: Eamon Walsh <ewalsh@tycho.nsa.gov>

diff --git a/dix/events.c b/dix/events.c
index 157f9a8..b3caec8 100644
--- a/dix/events.c
+++ b/dix/events.c
@@ -4088,10 +4088,10 @@ CoreFocusEvent(DeviceIntPtr dev, int type, int mode, int detail, WindowPtr pWin)
     {
         xKeymapEvent ke;
         ClientPtr client = clients[CLIENT_ID(pWin->drawable.id)];
-        if (XaceHook(XACE_DEVICE_ACCESS, client, dev, FALSE))
-            memmove((char *)&ke.map[0], (char *)&dev->key->down[1], 31);
-        else
+        if (XaceHook(XACE_DEVICE_ACCESS, client, dev, DixReadAccess))
             bzero((char *)&ke.map[0], 31);
+        else
+            memmove((char *)&ke.map[0], (char *)&dev->key->down[1], 31);
 
         ke.type = KeymapNotify;
         DeliverEventsToWindow(dev, pWin, (xEvent *)&ke, 1,

--------------060903040802030300030602--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
