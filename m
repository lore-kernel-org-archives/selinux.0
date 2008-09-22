Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8MHoctp022906
	for <selinux@tycho.nsa.gov>; Mon, 22 Sep 2008 13:50:38 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m8MHng5U026674
	for <selinux@tycho.nsa.gov>; Mon, 22 Sep 2008 17:49:43 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m8MHoN72014929
	for <selinux@tycho.nsa.gov>; Mon, 22 Sep 2008 13:50:37 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [10.16.255.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m8MHoMcL011121
	for <selinux@tycho.nsa.gov>; Mon, 22 Sep 2008 13:50:22 -0400
Received: from localhost.localdomain (redsox.boston.devel.redhat.com [10.16.60.53])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id m8MHoLTM025411
	for <selinux@tycho.nsa.gov>; Mon, 22 Sep 2008 13:50:22 -0400
Message-ID: <48D7DAE2.5010505@redhat.com>
Date: Mon, 22 Sep 2008 13:50:26 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Latest flask definitions for libselinux.
Content-Type: multipart/mixed;
 boundary="------------090801000107060403050301"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090801000107060403050301
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Adds open, X Definitions and nlmsg_tty_audit for netlink_audit_socket
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkjX2uIACgkQrlYvE4MpobON1QCgiyFHHYJGEz9OgLp/WA8lViLo
zQsAoOU8yzanBCUfFLkBJ1lbPsrJhqT7
=Us2A
-----END PGP SIGNATURE-----

--------------090801000107060403050301
Content-Type: text/plain;
 name="libselinux-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libselinux-rhat.patch"

diff --exclude-from=exclude -N -u -r nsalibselinux/include/selinux/av_permissions.h libselinux-2.0.71/include/selinux/av_permissions.h
--- nsalibselinux/include/selinux/av_permissions.h	2008-08-28 09:34:24.000000000 -0400
+++ libselinux-2.0.71/include/selinux/av_permissions.h	2008-09-22 13:27:27.000000000 -0400
@@ -85,6 +85,7 @@
 #define DIR__REPARENT                             0x00080000UL
 #define DIR__SEARCH                               0x00100000UL
 #define DIR__RMDIR                                0x00200000UL
+#define DIR__OPEN                                 0x00400000UL
 #define FILE__IOCTL                               0x00000001UL
 #define FILE__READ                                0x00000002UL
 #define FILE__WRITE                               0x00000004UL
@@ -105,6 +106,7 @@
 #define FILE__EXECUTE_NO_TRANS                    0x00020000UL
 #define FILE__ENTRYPOINT                          0x00040000UL
 #define FILE__EXECMOD                             0x00080000UL
+#define FILE__OPEN                                0x00100000UL
 #define LNK_FILE__IOCTL                           0x00000001UL
 #define LNK_FILE__READ                            0x00000002UL
 #define LNK_FILE__WRITE                           0x00000004UL
@@ -142,6 +144,7 @@
 #define CHR_FILE__EXECUTE_NO_TRANS                0x00020000UL
 #define CHR_FILE__ENTRYPOINT                      0x00040000UL
 #define CHR_FILE__EXECMOD                         0x00080000UL
+#define CHR_FILE__OPEN                            0x00100000UL
 #define BLK_FILE__IOCTL                           0x00000001UL
 #define BLK_FILE__READ                            0x00000002UL
 #define BLK_FILE__WRITE                           0x00000004UL
@@ -159,6 +162,7 @@
 #define BLK_FILE__SWAPON                          0x00004000UL
 #define BLK_FILE__QUOTAON                         0x00008000UL
 #define BLK_FILE__MOUNTON                         0x00010000UL
+#define BLK_FILE__OPEN                            0x00020000UL
 #define SOCK_FILE__IOCTL                          0x00000001UL
 #define SOCK_FILE__READ                           0x00000002UL
 #define SOCK_FILE__WRITE                          0x00000004UL
@@ -193,6 +197,7 @@
 #define FIFO_FILE__SWAPON                         0x00004000UL
 #define FIFO_FILE__QUOTAON                        0x00008000UL
 #define FIFO_FILE__MOUNTON                        0x00010000UL
+#define FIFO_FILE__OPEN                           0x00020000UL
 #define FD__USE                                   0x00000001UL
 #define SOCKET__IOCTL                             0x00000001UL
 #define SOCKET__READ                              0x00000002UL
@@ -547,91 +552,102 @@
 #define PASSWD__CHSH                              0x00000004UL
 #define PASSWD__ROOTOK                            0x00000008UL
 #define PASSWD__CRONTAB                           0x00000010UL
-#define DRAWABLE__CREATE                          0x00000001UL
-#define DRAWABLE__DESTROY                         0x00000002UL
-#define DRAWABLE__DRAW                            0x00000004UL
-#define DRAWABLE__COPY                            0x00000008UL
-#define DRAWABLE__GETATTR                         0x00000010UL
-#define GC__CREATE                                0x00000001UL
-#define GC__FREE                                  0x00000002UL
-#define GC__GETATTR                               0x00000004UL
-#define GC__SETATTR                               0x00000008UL
-#define WINDOW__ADDCHILD                          0x00000001UL
-#define WINDOW__CREATE                            0x00000002UL
-#define WINDOW__DESTROY                           0x00000004UL
-#define WINDOW__MAP                               0x00000008UL
-#define WINDOW__UNMAP                             0x00000010UL
-#define WINDOW__CHSTACK                           0x00000020UL
-#define WINDOW__CHPROPLIST                        0x00000040UL
-#define WINDOW__CHPROP                            0x00000080UL
-#define WINDOW__LISTPROP                          0x00000100UL
-#define WINDOW__GETATTR                           0x00000200UL
-#define WINDOW__SETATTR                           0x00000400UL
-#define WINDOW__SETFOCUS                          0x00000800UL
-#define WINDOW__MOVE                              0x00001000UL
-#define WINDOW__CHSELECTION                       0x00002000UL
-#define WINDOW__CHPARENT                          0x00004000UL
-#define WINDOW__CTRLLIFE                          0x00008000UL
-#define WINDOW__ENUMERATE                         0x00010000UL
-#define WINDOW__TRANSPARENT                       0x00020000UL
-#define WINDOW__MOUSEMOTION                       0x00040000UL
-#define WINDOW__CLIENTCOMEVENT                    0x00080000UL
-#define WINDOW__INPUTEVENT                        0x00100000UL
-#define WINDOW__DRAWEVENT                         0x00200000UL
-#define WINDOW__WINDOWCHANGEEVENT                 0x00400000UL
-#define WINDOW__WINDOWCHANGEREQUEST               0x00800000UL
-#define WINDOW__SERVERCHANGEEVENT                 0x01000000UL
-#define WINDOW__EXTENSIONEVENT                    0x02000000UL
-#define FONT__LOAD                                0x00000001UL
-#define FONT__FREE                                0x00000002UL
-#define FONT__GETATTR                             0x00000004UL
-#define FONT__USE                                 0x00000008UL
-#define COLORMAP__CREATE                          0x00000001UL
-#define COLORMAP__FREE                            0x00000002UL
-#define COLORMAP__INSTALL                         0x00000004UL
-#define COLORMAP__UNINSTALL                       0x00000008UL
-#define COLORMAP__LIST                            0x00000010UL
-#define COLORMAP__READ                            0x00000020UL
-#define COLORMAP__STORE                           0x00000040UL
-#define COLORMAP__GETATTR                         0x00000080UL
-#define COLORMAP__SETATTR                         0x00000100UL
-#define PROPERTY__CREATE                          0x00000001UL
-#define PROPERTY__FREE                            0x00000002UL
-#define PROPERTY__READ                            0x00000004UL
-#define PROPERTY__WRITE                           0x00000008UL
-#define CURSOR__CREATE                            0x00000001UL
-#define CURSOR__CREATEGLYPH                       0x00000002UL
-#define CURSOR__FREE                              0x00000004UL
-#define CURSOR__ASSIGN                            0x00000008UL
-#define CURSOR__SETATTR                           0x00000010UL
-#define XCLIENT__KILL                             0x00000001UL
-#define XINPUT__LOOKUP                            0x00000001UL
-#define XINPUT__GETATTR                           0x00000002UL
-#define XINPUT__SETATTR                           0x00000004UL
-#define XINPUT__SETFOCUS                          0x00000008UL
-#define XINPUT__WARPPOINTER                       0x00000010UL
-#define XINPUT__ACTIVEGRAB                        0x00000020UL
-#define XINPUT__PASSIVEGRAB                       0x00000040UL
-#define XINPUT__UNGRAB                            0x00000080UL
-#define XINPUT__BELL                              0x00000100UL
-#define XINPUT__MOUSEMOTION                       0x00000200UL
-#define XINPUT__RELABELINPUT                      0x00000400UL
-#define XSERVER__SCREENSAVER                      0x00000001UL
-#define XSERVER__GETHOSTLIST                      0x00000002UL
-#define XSERVER__SETHOSTLIST                      0x00000004UL
-#define XSERVER__GETFONTPATH                      0x00000008UL
-#define XSERVER__SETFONTPATH                      0x00000010UL
-#define XSERVER__GETATTR                          0x00000020UL
-#define XSERVER__GRAB                             0x00000040UL
-#define XSERVER__UNGRAB                           0x00000080UL
-#define XEXTENSION__QUERY                         0x00000001UL
-#define XEXTENSION__USE                           0x00000002UL
-#define PAX__PAGEEXEC                             0x00000001UL
-#define PAX__EMUTRAMP                             0x00000002UL
-#define PAX__MPROTECT                             0x00000004UL
-#define PAX__RANDMMAP                             0x00000008UL
-#define PAX__RANDEXEC                             0x00000010UL
-#define PAX__SEGMEXEC                             0x00000020UL
+#define X_DRAWABLE__CREATE                        0x00000001UL
+#define X_DRAWABLE__DESTROY                       0x00000002UL
+#define X_DRAWABLE__READ                          0x00000004UL
+#define X_DRAWABLE__WRITE                         0x00000008UL
+#define X_DRAWABLE__BLEND                         0x00000010UL
+#define X_DRAWABLE__GETATTR                       0x00000020UL
+#define X_DRAWABLE__SETATTR                       0x00000040UL
+#define X_DRAWABLE__LIST_CHILD                    0x00000080UL
+#define X_DRAWABLE__ADD_CHILD                     0x00000100UL
+#define X_DRAWABLE__REMOVE_CHILD                  0x00000200UL
+#define X_DRAWABLE__LIST_PROPERTY                 0x00000400UL
+#define X_DRAWABLE__GET_PROPERTY                  0x00000800UL
+#define X_DRAWABLE__SET_PROPERTY                  0x00001000UL
+#define X_DRAWABLE__MANAGE                        0x00002000UL
+#define X_DRAWABLE__OVERRIDE                      0x00004000UL
+#define X_DRAWABLE__SHOW                          0x00008000UL
+#define X_DRAWABLE__HIDE                          0x00010000UL
+#define X_DRAWABLE__SEND                          0x00020000UL
+#define X_DRAWABLE__RECEIVE                       0x00040000UL
+#define X_SCREEN__GETATTR                         0x00000001UL
+#define X_SCREEN__SETATTR                         0x00000002UL
+#define X_SCREEN__HIDE_CURSOR                     0x00000004UL
+#define X_SCREEN__SHOW_CURSOR                     0x00000008UL
+#define X_SCREEN__SAVER_GETATTR                   0x00000010UL
+#define X_SCREEN__SAVER_SETATTR                   0x00000020UL
+#define X_SCREEN__SAVER_HIDE                      0x00000040UL
+#define X_SCREEN__SAVER_SHOW                      0x00000080UL
+#define X_GC__CREATE                              0x00000001UL
+#define X_GC__DESTROY                             0x00000002UL
+#define X_GC__GETATTR                             0x00000004UL
+#define X_GC__SETATTR                             0x00000008UL
+#define X_GC__USE                                 0x00000010UL
+#define X_FONT__CREATE                            0x00000001UL
+#define X_FONT__DESTROY                           0x00000002UL
+#define X_FONT__GETATTR                           0x00000004UL
+#define X_FONT__ADD_GLYPH                         0x00000008UL
+#define X_FONT__REMOVE_GLYPH                      0x00000010UL
+#define X_FONT__USE                               0x00000020UL
+#define X_COLORMAP__CREATE                        0x00000001UL
+#define X_COLORMAP__DESTROY                       0x00000002UL
+#define X_COLORMAP__READ                          0x00000004UL
+#define X_COLORMAP__WRITE                         0x00000008UL
+#define X_COLORMAP__GETATTR                       0x00000010UL
+#define X_COLORMAP__ADD_COLOR                     0x00000020UL
+#define X_COLORMAP__REMOVE_COLOR                  0x00000040UL
+#define X_COLORMAP__INSTALL                       0x00000080UL
+#define X_COLORMAP__UNINSTALL                     0x00000100UL
+#define X_COLORMAP__USE                           0x00000200UL
+#define X_PROPERTY__CREATE                        0x00000001UL
+#define X_PROPERTY__DESTROY                       0x00000002UL
+#define X_PROPERTY__READ                          0x00000004UL
+#define X_PROPERTY__WRITE                         0x00000008UL
+#define X_PROPERTY__APPEND                        0x00000010UL
+#define X_PROPERTY__GETATTR                       0x00000020UL
+#define X_PROPERTY__SETATTR                       0x00000040UL
+#define X_SELECTION__READ                         0x00000001UL
+#define X_SELECTION__WRITE                        0x00000002UL
+#define X_SELECTION__GETATTR                      0x00000004UL
+#define X_SELECTION__SETATTR                      0x00000008UL
+#define X_CURSOR__CREATE                          0x00000001UL
+#define X_CURSOR__DESTROY                         0x00000002UL
+#define X_CURSOR__READ                            0x00000004UL
+#define X_CURSOR__WRITE                           0x00000008UL
+#define X_CURSOR__GETATTR                         0x00000010UL
+#define X_CURSOR__SETATTR                         0x00000020UL
+#define X_CURSOR__USE                             0x00000040UL
+#define X_CLIENT__DESTROY                         0x00000001UL
+#define X_CLIENT__GETATTR                         0x00000002UL
+#define X_CLIENT__SETATTR                         0x00000004UL
+#define X_CLIENT__MANAGE                          0x00000008UL
+#define X_DEVICE__GETATTR                         0x00000001UL
+#define X_DEVICE__SETATTR                         0x00000002UL
+#define X_DEVICE__USE                             0x00000004UL
+#define X_DEVICE__READ                            0x00000008UL
+#define X_DEVICE__WRITE                           0x00000010UL
+#define X_DEVICE__GETFOCUS                        0x00000020UL
+#define X_DEVICE__SETFOCUS                        0x00000040UL
+#define X_DEVICE__BELL                            0x00000080UL
+#define X_DEVICE__FORCE_CURSOR                    0x00000100UL
+#define X_DEVICE__FREEZE                          0x00000200UL
+#define X_DEVICE__GRAB                            0x00000400UL
+#define X_DEVICE__MANAGE                          0x00000800UL
+#define X_SERVER__GETATTR                         0x00000001UL
+#define X_SERVER__SETATTR                         0x00000002UL
+#define X_SERVER__RECORD                          0x00000004UL
+#define X_SERVER__DEBUG                           0x00000008UL
+#define X_SERVER__GRAB                            0x00000010UL
+#define X_SERVER__MANAGE                          0x00000020UL
+#define X_EXTENSION__QUERY                        0x00000001UL
+#define X_EXTENSION__USE                          0x00000002UL
+#define X_RESOURCE__READ                          0x00000001UL
+#define X_RESOURCE__WRITE                         0x00000002UL
+#define X_EVENT__SEND                             0x00000001UL
+#define X_EVENT__RECEIVE                          0x00000002UL
+#define X_SYNTHETIC_EVENT__SEND                   0x00000001UL
+#define X_SYNTHETIC_EVENT__RECEIVE                0x00000002UL
 #define NETLINK_ROUTE_SOCKET__IOCTL               0x00000001UL
 #define NETLINK_ROUTE_SOCKET__READ                0x00000002UL
 #define NETLINK_ROUTE_SOCKET__WRITE               0x00000004UL
@@ -798,6 +814,7 @@
 #define NETLINK_AUDIT_SOCKET__NLMSG_WRITE         0x00800000UL
 #define NETLINK_AUDIT_SOCKET__NLMSG_RELAY         0x01000000UL
 #define NETLINK_AUDIT_SOCKET__NLMSG_READPRIV      0x02000000UL
+#define NETLINK_AUDIT_SOCKET__NLMSG_TTY_AUDIT     0x04000000UL
 #define NETLINK_IP6FW_SOCKET__IOCTL               0x00000001UL
 #define NETLINK_IP6FW_SOCKET__READ                0x00000002UL
 #define NETLINK_IP6FW_SOCKET__WRITE               0x00000004UL
@@ -1004,3 +1021,6 @@
 #define DB_BLOB__IMPORT                           0x00000100UL
 #define DB_BLOB__EXPORT                           0x00000200UL
 #define PEER__RECV                                0x00000001UL
+#define X_APPLICATION_DATA__PASTE                 0x00000001UL
+#define X_APPLICATION_DATA__PASTE_AFTER_CONFIRM   0x00000002UL
+#define X_APPLICATION_DATA__COPY                  0x00000004UL
diff --exclude-from=exclude -N -u -r nsalibselinux/include/selinux/flask.h libselinux-2.0.71/include/selinux/flask.h
--- nsalibselinux/include/selinux/flask.h	2008-08-28 09:34:24.000000000 -0400
+++ libselinux-2.0.71/include/selinux/flask.h	2008-09-22 13:28:05.000000000 -0400
@@ -35,18 +35,18 @@
 #define SECCLASS_SHM                                     28
 #define SECCLASS_IPC                                     29
 #define SECCLASS_PASSWD                                  30
-#define SECCLASS_DRAWABLE                                31
-#define SECCLASS_WINDOW                                  32
-#define SECCLASS_GC                                      33
-#define SECCLASS_FONT                                    34
-#define SECCLASS_COLORMAP                                35
-#define SECCLASS_PROPERTY                                36
-#define SECCLASS_CURSOR                                  37
-#define SECCLASS_XCLIENT                                 38
-#define SECCLASS_XINPUT                                  39
-#define SECCLASS_XSERVER                                 40
-#define SECCLASS_XEXTENSION                              41
-#define SECCLASS_PAX                                     42
+#define SECCLASS_X_DRAWABLE                              31
+#define SECCLASS_X_SCREEN                                32
+#define SECCLASS_X_GC                                    33
+#define SECCLASS_X_FONT                                  34
+#define SECCLASS_X_COLORMAP                              35
+#define SECCLASS_X_PROPERTY                              36
+#define SECCLASS_X_SELECTION                             37
+#define SECCLASS_X_CURSOR                                38
+#define SECCLASS_X_CLIENT                                39
+#define SECCLASS_X_DEVICE                                40
+#define SECCLASS_X_SERVER                                41
+#define SECCLASS_X_EXTENSION                             42
 #define SECCLASS_NETLINK_ROUTE_SOCKET                    43
 #define SECCLASS_NETLINK_FIREWALL_SOCKET                 44
 #define SECCLASS_NETLINK_TCPDIAG_SOCKET                  45
@@ -74,6 +74,10 @@
 #define SECCLASS_DB_BLOB                                 67
 #define SECCLASS_PEER                                    68
 #define SECCLASS_CAPABILITY2                             69
+#define SECCLASS_X_RESOURCE                              70
+#define SECCLASS_X_EVENT                                 71
+#define SECCLASS_X_SYNTHETIC_EVENT                       72
+#define SECCLASS_X_APPLICATION_DATA                      73
 
 /*
  * Security identifier indices for initial entities
diff --exclude-from=exclude -N -u -r nsalibselinux/src/av_perm_to_string.h libselinux-2.0.71/src/av_perm_to_string.h
--- nsalibselinux/src/av_perm_to_string.h	2008-08-28 09:34:24.000000000 -0400
+++ libselinux-2.0.71/src/av_perm_to_string.h	2008-09-22 13:42:50.000000000 -0400
@@ -14,12 +14,17 @@
    S_(SECCLASS_DIR, DIR__REPARENT, "reparent")
    S_(SECCLASS_DIR, DIR__SEARCH, "search")
    S_(SECCLASS_DIR, DIR__RMDIR, "rmdir")
+   S_(SECCLASS_DIR, DIR__OPEN, "open")
    S_(SECCLASS_FILE, FILE__EXECUTE_NO_TRANS, "execute_no_trans")
    S_(SECCLASS_FILE, FILE__ENTRYPOINT, "entrypoint")
    S_(SECCLASS_FILE, FILE__EXECMOD, "execmod")
+   S_(SECCLASS_FILE, FILE__OPEN, "open")
    S_(SECCLASS_CHR_FILE, CHR_FILE__EXECUTE_NO_TRANS, "execute_no_trans")
    S_(SECCLASS_CHR_FILE, CHR_FILE__ENTRYPOINT, "entrypoint")
    S_(SECCLASS_CHR_FILE, CHR_FILE__EXECMOD, "execmod")
+   S_(SECCLASS_CHR_FILE, CHR_FILE__OPEN, "open")
+   S_(SECCLASS_BLK_FILE, BLK_FILE__OPEN, "open")
+   S_(SECCLASS_FIFO_FILE, FIFO_FILE__OPEN, "open")
    S_(SECCLASS_FD, FD__USE, "use")
    S_(SECCLASS_TCP_SOCKET, TCP_SOCKET__CONNECTTO, "connectto")
    S_(SECCLASS_TCP_SOCKET, TCP_SOCKET__NEWCONN, "newconn")
@@ -140,91 +145,102 @@
    S_(SECCLASS_PASSWD, PASSWD__CHSH, "chsh")
    S_(SECCLASS_PASSWD, PASSWD__ROOTOK, "rootok")
    S_(SECCLASS_PASSWD, PASSWD__CRONTAB, "crontab")
-   S_(SECCLASS_DRAWABLE, DRAWABLE__CREATE, "create")
-   S_(SECCLASS_DRAWABLE, DRAWABLE__DESTROY, "destroy")
-   S_(SECCLASS_DRAWABLE, DRAWABLE__DRAW, "draw")
-   S_(SECCLASS_DRAWABLE, DRAWABLE__COPY, "copy")
-   S_(SECCLASS_DRAWABLE, DRAWABLE__GETATTR, "getattr")
-   S_(SECCLASS_GC, GC__CREATE, "create")
-   S_(SECCLASS_GC, GC__FREE, "free")
-   S_(SECCLASS_GC, GC__GETATTR, "getattr")
-   S_(SECCLASS_GC, GC__SETATTR, "setattr")
-   S_(SECCLASS_WINDOW, WINDOW__ADDCHILD, "addchild")
-   S_(SECCLASS_WINDOW, WINDOW__CREATE, "create")
-   S_(SECCLASS_WINDOW, WINDOW__DESTROY, "destroy")
-   S_(SECCLASS_WINDOW, WINDOW__MAP, "map")
-   S_(SECCLASS_WINDOW, WINDOW__UNMAP, "unmap")
-   S_(SECCLASS_WINDOW, WINDOW__CHSTACK, "chstack")
-   S_(SECCLASS_WINDOW, WINDOW__CHPROPLIST, "chproplist")
-   S_(SECCLASS_WINDOW, WINDOW__CHPROP, "chprop")
-   S_(SECCLASS_WINDOW, WINDOW__LISTPROP, "listprop")
-   S_(SECCLASS_WINDOW, WINDOW__GETATTR, "getattr")
-   S_(SECCLASS_WINDOW, WINDOW__SETATTR, "setattr")
-   S_(SECCLASS_WINDOW, WINDOW__SETFOCUS, "setfocus")
-   S_(SECCLASS_WINDOW, WINDOW__MOVE, "move")
-   S_(SECCLASS_WINDOW, WINDOW__CHSELECTION, "chselection")
-   S_(SECCLASS_WINDOW, WINDOW__CHPARENT, "chparent")
-   S_(SECCLASS_WINDOW, WINDOW__CTRLLIFE, "ctrllife")
-   S_(SECCLASS_WINDOW, WINDOW__ENUMERATE, "enumerate")
-   S_(SECCLASS_WINDOW, WINDOW__TRANSPARENT, "transparent")
-   S_(SECCLASS_WINDOW, WINDOW__MOUSEMOTION, "mousemotion")
-   S_(SECCLASS_WINDOW, WINDOW__CLIENTCOMEVENT, "clientcomevent")
-   S_(SECCLASS_WINDOW, WINDOW__INPUTEVENT, "inputevent")
-   S_(SECCLASS_WINDOW, WINDOW__DRAWEVENT, "drawevent")
-   S_(SECCLASS_WINDOW, WINDOW__WINDOWCHANGEEVENT, "windowchangeevent")
-   S_(SECCLASS_WINDOW, WINDOW__WINDOWCHANGEREQUEST, "windowchangerequest")
-   S_(SECCLASS_WINDOW, WINDOW__SERVERCHANGEEVENT, "serverchangeevent")
-   S_(SECCLASS_WINDOW, WINDOW__EXTENSIONEVENT, "extensionevent")
-   S_(SECCLASS_FONT, FONT__LOAD, "load")
-   S_(SECCLASS_FONT, FONT__FREE, "free")
-   S_(SECCLASS_FONT, FONT__GETATTR, "getattr")
-   S_(SECCLASS_FONT, FONT__USE, "use")
-   S_(SECCLASS_COLORMAP, COLORMAP__CREATE, "create")
-   S_(SECCLASS_COLORMAP, COLORMAP__FREE, "free")
-   S_(SECCLASS_COLORMAP, COLORMAP__INSTALL, "install")
-   S_(SECCLASS_COLORMAP, COLORMAP__UNINSTALL, "uninstall")
-   S_(SECCLASS_COLORMAP, COLORMAP__LIST, "list")
-   S_(SECCLASS_COLORMAP, COLORMAP__READ, "read")
-   S_(SECCLASS_COLORMAP, COLORMAP__STORE, "store")
-   S_(SECCLASS_COLORMAP, COLORMAP__GETATTR, "getattr")
-   S_(SECCLASS_COLORMAP, COLORMAP__SETATTR, "setattr")
-   S_(SECCLASS_PROPERTY, PROPERTY__CREATE, "create")
-   S_(SECCLASS_PROPERTY, PROPERTY__FREE, "free")
-   S_(SECCLASS_PROPERTY, PROPERTY__READ, "read")
-   S_(SECCLASS_PROPERTY, PROPERTY__WRITE, "write")
-   S_(SECCLASS_CURSOR, CURSOR__CREATE, "create")
-   S_(SECCLASS_CURSOR, CURSOR__CREATEGLYPH, "createglyph")
-   S_(SECCLASS_CURSOR, CURSOR__FREE, "free")
-   S_(SECCLASS_CURSOR, CURSOR__ASSIGN, "assign")
-   S_(SECCLASS_CURSOR, CURSOR__SETATTR, "setattr")
-   S_(SECCLASS_XCLIENT, XCLIENT__KILL, "kill")
-   S_(SECCLASS_XINPUT, XINPUT__LOOKUP, "lookup")
-   S_(SECCLASS_XINPUT, XINPUT__GETATTR, "getattr")
-   S_(SECCLASS_XINPUT, XINPUT__SETATTR, "setattr")
-   S_(SECCLASS_XINPUT, XINPUT__SETFOCUS, "setfocus")
-   S_(SECCLASS_XINPUT, XINPUT__WARPPOINTER, "warppointer")
-   S_(SECCLASS_XINPUT, XINPUT__ACTIVEGRAB, "activegrab")
-   S_(SECCLASS_XINPUT, XINPUT__PASSIVEGRAB, "passivegrab")
-   S_(SECCLASS_XINPUT, XINPUT__UNGRAB, "ungrab")
-   S_(SECCLASS_XINPUT, XINPUT__BELL, "bell")
-   S_(SECCLASS_XINPUT, XINPUT__MOUSEMOTION, "mousemotion")
-   S_(SECCLASS_XINPUT, XINPUT__RELABELINPUT, "relabelinput")
-   S_(SECCLASS_XSERVER, XSERVER__SCREENSAVER, "screensaver")
-   S_(SECCLASS_XSERVER, XSERVER__GETHOSTLIST, "gethostlist")
-   S_(SECCLASS_XSERVER, XSERVER__SETHOSTLIST, "sethostlist")
-   S_(SECCLASS_XSERVER, XSERVER__GETFONTPATH, "getfontpath")
-   S_(SECCLASS_XSERVER, XSERVER__SETFONTPATH, "setfontpath")
-   S_(SECCLASS_XSERVER, XSERVER__GETATTR, "getattr")
-   S_(SECCLASS_XSERVER, XSERVER__GRAB, "grab")
-   S_(SECCLASS_XSERVER, XSERVER__UNGRAB, "ungrab")
-   S_(SECCLASS_XEXTENSION, XEXTENSION__QUERY, "query")
-   S_(SECCLASS_XEXTENSION, XEXTENSION__USE, "use")
-   S_(SECCLASS_PAX, PAX__PAGEEXEC, "pageexec")
-   S_(SECCLASS_PAX, PAX__EMUTRAMP, "emutramp")
-   S_(SECCLASS_PAX, PAX__MPROTECT, "mprotect")
-   S_(SECCLASS_PAX, PAX__RANDMMAP, "randmmap")
-   S_(SECCLASS_PAX, PAX__RANDEXEC, "randexec")
-   S_(SECCLASS_PAX, PAX__SEGMEXEC, "segmexec")
+   S_(SECCLASS_X_DRAWABLE, X_DRAWABLE__CREATE, "create")
+   S_(SECCLASS_X_DRAWABLE, X_DRAWABLE__DESTROY, "destroy")
+   S_(SECCLASS_X_DRAWABLE, X_DRAWABLE__READ, "read")
+   S_(SECCLASS_X_DRAWABLE, X_DRAWABLE__WRITE, "write")
+   S_(SECCLASS_X_DRAWABLE, X_DRAWABLE__BLEND, "blend")
+   S_(SECCLASS_X_DRAWABLE, X_DRAWABLE__GETATTR, "getattr")
+   S_(SECCLASS_X_DRAWABLE, X_DRAWABLE__SETATTR, "setattr")
+   S_(SECCLASS_X_DRAWABLE, X_DRAWABLE__LIST_CHILD, "list_child")
+   S_(SECCLASS_X_DRAWABLE, X_DRAWABLE__ADD_CHILD, "add_child")
+   S_(SECCLASS_X_DRAWABLE, X_DRAWABLE__REMOVE_CHILD, "remove_child")
+   S_(SECCLASS_X_DRAWABLE, X_DRAWABLE__LIST_PROPERTY, "list_property")
+   S_(SECCLASS_X_DRAWABLE, X_DRAWABLE__GET_PROPERTY, "get_property")
+   S_(SECCLASS_X_DRAWABLE, X_DRAWABLE__SET_PROPERTY, "set_property")
+   S_(SECCLASS_X_DRAWABLE, X_DRAWABLE__MANAGE, "manage")
+   S_(SECCLASS_X_DRAWABLE, X_DRAWABLE__OVERRIDE, "override")
+   S_(SECCLASS_X_DRAWABLE, X_DRAWABLE__SHOW, "show")
+   S_(SECCLASS_X_DRAWABLE, X_DRAWABLE__HIDE, "hide")
+   S_(SECCLASS_X_DRAWABLE, X_DRAWABLE__SEND, "send")
+   S_(SECCLASS_X_DRAWABLE, X_DRAWABLE__RECEIVE, "receive")
+   S_(SECCLASS_X_SCREEN, X_SCREEN__GETATTR, "getattr")
+   S_(SECCLASS_X_SCREEN, X_SCREEN__SETATTR, "setattr")
+   S_(SECCLASS_X_SCREEN, X_SCREEN__HIDE_CURSOR, "hide_cursor")
+   S_(SECCLASS_X_SCREEN, X_SCREEN__SHOW_CURSOR, "show_cursor")
+   S_(SECCLASS_X_SCREEN, X_SCREEN__SAVER_GETATTR, "saver_getattr")
+   S_(SECCLASS_X_SCREEN, X_SCREEN__SAVER_SETATTR, "saver_setattr")
+   S_(SECCLASS_X_SCREEN, X_SCREEN__SAVER_HIDE, "saver_hide")
+   S_(SECCLASS_X_SCREEN, X_SCREEN__SAVER_SHOW, "saver_show")
+   S_(SECCLASS_X_GC, X_GC__CREATE, "create")
+   S_(SECCLASS_X_GC, X_GC__DESTROY, "destroy")
+   S_(SECCLASS_X_GC, X_GC__GETATTR, "getattr")
+   S_(SECCLASS_X_GC, X_GC__SETATTR, "setattr")
+   S_(SECCLASS_X_GC, X_GC__USE, "use")
+   S_(SECCLASS_X_FONT, X_FONT__CREATE, "create")
+   S_(SECCLASS_X_FONT, X_FONT__DESTROY, "destroy")
+   S_(SECCLASS_X_FONT, X_FONT__GETATTR, "getattr")
+   S_(SECCLASS_X_FONT, X_FONT__ADD_GLYPH, "add_glyph")
+   S_(SECCLASS_X_FONT, X_FONT__REMOVE_GLYPH, "remove_glyph")
+   S_(SECCLASS_X_FONT, X_FONT__USE, "use")
+   S_(SECCLASS_X_COLORMAP, X_COLORMAP__CREATE, "create")
+   S_(SECCLASS_X_COLORMAP, X_COLORMAP__DESTROY, "destroy")
+   S_(SECCLASS_X_COLORMAP, X_COLORMAP__READ, "read")
+   S_(SECCLASS_X_COLORMAP, X_COLORMAP__WRITE, "write")
+   S_(SECCLASS_X_COLORMAP, X_COLORMAP__GETATTR, "getattr")
+   S_(SECCLASS_X_COLORMAP, X_COLORMAP__ADD_COLOR, "add_color")
+   S_(SECCLASS_X_COLORMAP, X_COLORMAP__REMOVE_COLOR, "remove_color")
+   S_(SECCLASS_X_COLORMAP, X_COLORMAP__INSTALL, "install")
+   S_(SECCLASS_X_COLORMAP, X_COLORMAP__UNINSTALL, "uninstall")
+   S_(SECCLASS_X_COLORMAP, X_COLORMAP__USE, "use")
+   S_(SECCLASS_X_PROPERTY, X_PROPERTY__CREATE, "create")
+   S_(SECCLASS_X_PROPERTY, X_PROPERTY__DESTROY, "destroy")
+   S_(SECCLASS_X_PROPERTY, X_PROPERTY__READ, "read")
+   S_(SECCLASS_X_PROPERTY, X_PROPERTY__WRITE, "write")
+   S_(SECCLASS_X_PROPERTY, X_PROPERTY__APPEND, "append")
+   S_(SECCLASS_X_PROPERTY, X_PROPERTY__GETATTR, "getattr")
+   S_(SECCLASS_X_PROPERTY, X_PROPERTY__SETATTR, "setattr")
+   S_(SECCLASS_X_SELECTION, X_SELECTION__READ, "read")
+   S_(SECCLASS_X_SELECTION, X_SELECTION__WRITE, "write")
+   S_(SECCLASS_X_SELECTION, X_SELECTION__GETATTR, "getattr")
+   S_(SECCLASS_X_SELECTION, X_SELECTION__SETATTR, "setattr")
+   S_(SECCLASS_X_CURSOR, X_CURSOR__CREATE, "create")
+   S_(SECCLASS_X_CURSOR, X_CURSOR__DESTROY, "destroy")
+   S_(SECCLASS_X_CURSOR, X_CURSOR__READ, "read")
+   S_(SECCLASS_X_CURSOR, X_CURSOR__WRITE, "write")
+   S_(SECCLASS_X_CURSOR, X_CURSOR__GETATTR, "getattr")
+   S_(SECCLASS_X_CURSOR, X_CURSOR__SETATTR, "setattr")
+   S_(SECCLASS_X_CURSOR, X_CURSOR__USE, "use")
+   S_(SECCLASS_X_CLIENT, X_CLIENT__DESTROY, "destroy")
+   S_(SECCLASS_X_CLIENT, X_CLIENT__GETATTR, "getattr")
+   S_(SECCLASS_X_CLIENT, X_CLIENT__SETATTR, "setattr")
+   S_(SECCLASS_X_CLIENT, X_CLIENT__MANAGE, "manage")
+   S_(SECCLASS_X_DEVICE, X_DEVICE__GETATTR, "getattr")
+   S_(SECCLASS_X_DEVICE, X_DEVICE__SETATTR, "setattr")
+   S_(SECCLASS_X_DEVICE, X_DEVICE__USE, "use")
+   S_(SECCLASS_X_DEVICE, X_DEVICE__READ, "read")
+   S_(SECCLASS_X_DEVICE, X_DEVICE__WRITE, "write")
+   S_(SECCLASS_X_DEVICE, X_DEVICE__GETFOCUS, "getfocus")
+   S_(SECCLASS_X_DEVICE, X_DEVICE__SETFOCUS, "setfocus")
+   S_(SECCLASS_X_DEVICE, X_DEVICE__BELL, "bell")
+   S_(SECCLASS_X_DEVICE, X_DEVICE__FORCE_CURSOR, "force_cursor")
+   S_(SECCLASS_X_DEVICE, X_DEVICE__FREEZE, "freeze")
+   S_(SECCLASS_X_DEVICE, X_DEVICE__GRAB, "grab")
+   S_(SECCLASS_X_DEVICE, X_DEVICE__MANAGE, "manage")
+   S_(SECCLASS_X_SERVER, X_SERVER__GETATTR, "getattr")
+   S_(SECCLASS_X_SERVER, X_SERVER__SETATTR, "setattr")
+   S_(SECCLASS_X_SERVER, X_SERVER__RECORD, "record")
+   S_(SECCLASS_X_SERVER, X_SERVER__DEBUG, "debug")
+   S_(SECCLASS_X_SERVER, X_SERVER__GRAB, "grab")
+   S_(SECCLASS_X_SERVER, X_SERVER__MANAGE, "manage")
+   S_(SECCLASS_X_EXTENSION, X_EXTENSION__QUERY, "query")
+   S_(SECCLASS_X_EXTENSION, X_EXTENSION__USE, "use")
+   S_(SECCLASS_X_RESOURCE, X_RESOURCE__READ, "read")
+   S_(SECCLASS_X_RESOURCE, X_RESOURCE__WRITE, "write")
+   S_(SECCLASS_X_EVENT, X_EVENT__SEND, "send")
+   S_(SECCLASS_X_EVENT, X_EVENT__RECEIVE, "receive")
+   S_(SECCLASS_X_SYNTHETIC_EVENT, X_SYNTHETIC_EVENT__SEND, "send")
+   S_(SECCLASS_X_SYNTHETIC_EVENT, X_SYNTHETIC_EVENT__RECEIVE, "receive")
    S_(SECCLASS_NETLINK_ROUTE_SOCKET, NETLINK_ROUTE_SOCKET__NLMSG_READ, "nlmsg_read")
    S_(SECCLASS_NETLINK_ROUTE_SOCKET, NETLINK_ROUTE_SOCKET__NLMSG_WRITE, "nlmsg_write")
    S_(SECCLASS_NETLINK_FIREWALL_SOCKET, NETLINK_FIREWALL_SOCKET__NLMSG_READ, "nlmsg_read")
@@ -237,6 +253,7 @@
    S_(SECCLASS_NETLINK_AUDIT_SOCKET, NETLINK_AUDIT_SOCKET__NLMSG_WRITE, "nlmsg_write")
    S_(SECCLASS_NETLINK_AUDIT_SOCKET, NETLINK_AUDIT_SOCKET__NLMSG_RELAY, "nlmsg_relay")
    S_(SECCLASS_NETLINK_AUDIT_SOCKET, NETLINK_AUDIT_SOCKET__NLMSG_READPRIV, "nlmsg_readpriv")
+   S_(SECCLASS_NETLINK_AUDIT_SOCKET, NETLINK_AUDIT_SOCKET__NLMSG_TTY_AUDIT, "nlmsg_tty_audit")
    S_(SECCLASS_NETLINK_IP6FW_SOCKET, NETLINK_IP6FW_SOCKET__NLMSG_READ, "nlmsg_read")
    S_(SECCLASS_NETLINK_IP6FW_SOCKET, NETLINK_IP6FW_SOCKET__NLMSG_WRITE, "nlmsg_write")
    S_(SECCLASS_DBUS, DBUS__ACQUIRE_SVC, "acquire_svc")
@@ -303,3 +320,6 @@
    S_(SECCLASS_DB_BLOB, DB_BLOB__IMPORT, "import")
    S_(SECCLASS_DB_BLOB, DB_BLOB__EXPORT, "export")
    S_(SECCLASS_PEER, PEER__RECV, "recv")
+   S_(SECCLASS_X_APPLICATION_DATA, X_APPLICATION_DATA__PASTE, "paste")
+   S_(SECCLASS_X_APPLICATION_DATA, X_APPLICATION_DATA__PASTE_AFTER_CONFIRM, "paste_after_confirm")
+   S_(SECCLASS_X_APPLICATION_DATA, X_APPLICATION_DATA__COPY, "copy")
diff --exclude-from=exclude -N -u -r nsalibselinux/src/class_to_string.h libselinux-2.0.71/src/class_to_string.h
--- nsalibselinux/src/class_to_string.h	2008-08-28 09:34:24.000000000 -0400
+++ libselinux-2.0.71/src/class_to_string.h	2008-09-22 13:43:02.000000000 -0400
@@ -33,18 +33,18 @@
     S_("shm")
     S_("ipc")
     S_("passwd")
-    S_("drawable")
-    S_("window")
-    S_("gc")
-    S_("font")
-    S_("colormap")
-    S_("property")
-    S_("cursor")
-    S_("xclient")
-    S_("xinput")
-    S_("xserver")
-    S_("xextension")
-    S_("pax")
+    S_("x_drawable")
+    S_("x_screen")
+    S_("x_gc")
+    S_("x_font")
+    S_("x_colormap")
+    S_("x_property")
+    S_("x_selection")
+    S_("x_cursor")
+    S_("x_client")
+    S_("x_device")
+    S_("x_server")
+    S_("x_extension")
     S_("netlink_route_socket")
     S_("netlink_firewall_socket")
     S_("netlink_tcpdiag_socket")
@@ -72,3 +72,7 @@
     S_("db_blob")
     S_("peer")
     S_("capability2")
+    S_("x_resource")
+    S_("x_event")
+    S_("x_synthetic_event")
+    S_("x_application_data")

--------------090801000107060403050301
Content-Type: application/octet-stream;
 name="libselinux-rhat.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="libselinux-rhat.patch.sig"

iEYEABECAAYFAkjX2uIACgkQrlYvE4MpobMFvgCfUz/vGgkcJFglp5uUAgmbFVmHA2kAoM64
pMWyL3VZyveSOpRk4bENXufQ
--------------090801000107060403050301--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
