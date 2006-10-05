Message-ID: <452549BF.6000302@trustedcs.com>
Date: Thu, 05 Oct 2006 13:06:55 -0500
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: SELinux List <selinux@tycho.nsa.gov>
CC: Daniel Walsh <dwalsh@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        Joshua Brindle <jbrindle@tresys.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Linda Knippers <linda.knippers@hp.com>,
        Christopher PeBenito <cpebenito@tresys.com>
Subject: [RFC PATCH 2/3] libselinux: define the "context" security class
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Define a new security class "context" and its permission "translate" for
use by the context translation daemon.  The files are generated from the
current reference policy and have been altered by "make indent".  Note
the change in blank lines in av_permissions.h - should libselinux change,
should the script in the policy change, or should there be a manual
conversion?  The "polmatch" perm on the association class was also pulled
in from the policy.


---


diff -ruNp --exclude=.svn selinux-base/libselinux/include/selinux/av_permissions.h selinux/libselinux/include/selinux/av_permissions.h
--- selinux-base/libselinux/include/selinux/av_permissions.h	2006-10-03 05:08:16.000000000 -0500
+++ selinux/libselinux/include/selinux/av_permissions.h	2006-10-05 03:25:59.000000000 -0500
@@ -16,7 +16,6 @@
 #define COMMON_FILE__SWAPON                              0x00004000UL
 #define COMMON_FILE__QUOTAON                             0x00008000UL
 #define COMMON_FILE__MOUNTON                             0x00010000UL
-
 #define COMMON_SOCKET__IOCTL                             0x00000001UL
 #define COMMON_SOCKET__READ                              0x00000002UL
 #define COMMON_SOCKET__WRITE                             0x00000004UL
@@ -39,7 +38,6 @@
 #define COMMON_SOCKET__RECV_MSG                          0x00080000UL
 #define COMMON_SOCKET__SEND_MSG                          0x00100000UL
 #define COMMON_SOCKET__NAME_BIND                         0x00200000UL
-
 #define COMMON_IPC__CREATE                               0x00000001UL
 #define COMMON_IPC__DESTROY                              0x00000002UL
 #define COMMON_IPC__GETATTR                              0x00000004UL
@@ -49,7 +47,6 @@
 #define COMMON_IPC__ASSOCIATE                            0x00000040UL
 #define COMMON_IPC__UNIX_READ                            0x00000080UL
 #define COMMON_IPC__UNIX_WRITE                           0x00000100UL
-
 #define FILESYSTEM__MOUNT                         0x00000001UL
 #define FILESYSTEM__REMOUNT                       0x00000002UL
 #define FILESYSTEM__UNMOUNT                       0x00000004UL
@@ -60,7 +57,6 @@
 #define FILESYSTEM__ASSOCIATE                     0x00000080UL
 #define FILESYSTEM__QUOTAMOD                      0x00000100UL
 #define FILESYSTEM__QUOTAGET                      0x00000200UL
-
 #define DIR__IOCTL                                0x00000001UL
 #define DIR__READ                                 0x00000002UL
 #define DIR__WRITE                                0x00000004UL
@@ -78,13 +74,11 @@
 #define DIR__SWAPON                               0x00004000UL
 #define DIR__QUOTAON                              0x00008000UL
 #define DIR__MOUNTON                              0x00010000UL
-
 #define DIR__ADD_NAME                             0x00020000UL
 #define DIR__REMOVE_NAME                          0x00040000UL
 #define DIR__REPARENT                             0x00080000UL
 #define DIR__SEARCH                               0x00100000UL
 #define DIR__RMDIR                                0x00200000UL
-
 #define FILE__IOCTL                               0x00000001UL
 #define FILE__READ                                0x00000002UL
 #define FILE__WRITE                               0x00000004UL
@@ -102,11 +96,9 @@
 #define FILE__SWAPON                              0x00004000UL
 #define FILE__QUOTAON                             0x00008000UL
 #define FILE__MOUNTON                             0x00010000UL
-
 #define FILE__EXECUTE_NO_TRANS                    0x00020000UL
 #define FILE__ENTRYPOINT                          0x00040000UL
 #define FILE__EXECMOD                             0x00080000UL
-
 #define LNK_FILE__IOCTL                           0x00000001UL
 #define LNK_FILE__READ                            0x00000002UL
 #define LNK_FILE__WRITE                           0x00000004UL
@@ -124,7 +116,6 @@
 #define LNK_FILE__SWAPON                          0x00004000UL
 #define LNK_FILE__QUOTAON                         0x00008000UL
 #define LNK_FILE__MOUNTON                         0x00010000UL
-
 #define CHR_FILE__IOCTL                           0x00000001UL
 #define CHR_FILE__READ                            0x00000002UL
 #define CHR_FILE__WRITE                           0x00000004UL
@@ -142,11 +133,9 @@
 #define CHR_FILE__SWAPON                          0x00004000UL
 #define CHR_FILE__QUOTAON                         0x00008000UL
 #define CHR_FILE__MOUNTON                         0x00010000UL
-
 #define CHR_FILE__EXECUTE_NO_TRANS                0x00020000UL
 #define CHR_FILE__ENTRYPOINT                      0x00040000UL
 #define CHR_FILE__EXECMOD                         0x00080000UL
-
 #define BLK_FILE__IOCTL                           0x00000001UL
 #define BLK_FILE__READ                            0x00000002UL
 #define BLK_FILE__WRITE                           0x00000004UL
@@ -164,7 +153,6 @@
 #define BLK_FILE__SWAPON                          0x00004000UL
 #define BLK_FILE__QUOTAON                         0x00008000UL
 #define BLK_FILE__MOUNTON                         0x00010000UL
-
 #define SOCK_FILE__IOCTL                          0x00000001UL
 #define SOCK_FILE__READ                           0x00000002UL
 #define SOCK_FILE__WRITE                          0x00000004UL
@@ -182,7 +170,6 @@
 #define SOCK_FILE__SWAPON                         0x00004000UL
 #define SOCK_FILE__QUOTAON                        0x00008000UL
 #define SOCK_FILE__MOUNTON                        0x00010000UL
-
 #define FIFO_FILE__IOCTL                          0x00000001UL
 #define FIFO_FILE__READ                           0x00000002UL
 #define FIFO_FILE__WRITE                          0x00000004UL
@@ -200,9 +187,7 @@
 #define FIFO_FILE__SWAPON                         0x00004000UL
 #define FIFO_FILE__QUOTAON                        0x00008000UL
 #define FIFO_FILE__MOUNTON                        0x00010000UL
-
 #define FD__USE                                   0x00000001UL
-
 #define SOCKET__IOCTL                             0x00000001UL
 #define SOCKET__READ                              0x00000002UL
 #define SOCKET__WRITE                             0x00000004UL
@@ -225,7 +210,6 @@
 #define SOCKET__RECV_MSG                          0x00080000UL
 #define SOCKET__SEND_MSG                          0x00100000UL
 #define SOCKET__NAME_BIND                         0x00200000UL
-
 #define TCP_SOCKET__IOCTL                         0x00000001UL
 #define TCP_SOCKET__READ                          0x00000002UL
 #define TCP_SOCKET__WRITE                         0x00000004UL
@@ -248,13 +232,11 @@
 #define TCP_SOCKET__RECV_MSG                      0x00080000UL
 #define TCP_SOCKET__SEND_MSG                      0x00100000UL
 #define TCP_SOCKET__NAME_BIND                     0x00200000UL
-
 #define TCP_SOCKET__CONNECTTO                     0x00400000UL
 #define TCP_SOCKET__NEWCONN                       0x00800000UL
 #define TCP_SOCKET__ACCEPTFROM                    0x01000000UL
 #define TCP_SOCKET__NODE_BIND                     0x02000000UL
 #define TCP_SOCKET__NAME_CONNECT                  0x04000000UL
-
 #define UDP_SOCKET__IOCTL                         0x00000001UL
 #define UDP_SOCKET__READ                          0x00000002UL
 #define UDP_SOCKET__WRITE                         0x00000004UL
@@ -277,9 +259,7 @@
 #define UDP_SOCKET__RECV_MSG                      0x00080000UL
 #define UDP_SOCKET__SEND_MSG                      0x00100000UL
 #define UDP_SOCKET__NAME_BIND                     0x00200000UL
-
 #define UDP_SOCKET__NODE_BIND                     0x00400000UL
-
 #define RAWIP_SOCKET__IOCTL                       0x00000001UL
 #define RAWIP_SOCKET__READ                        0x00000002UL
 #define RAWIP_SOCKET__WRITE                       0x00000004UL
@@ -302,9 +282,7 @@
 #define RAWIP_SOCKET__RECV_MSG                    0x00080000UL
 #define RAWIP_SOCKET__SEND_MSG                    0x00100000UL
 #define RAWIP_SOCKET__NAME_BIND                   0x00200000UL
-
 #define RAWIP_SOCKET__NODE_BIND                   0x00400000UL
-
 #define NODE__TCP_RECV                            0x00000001UL
 #define NODE__TCP_SEND                            0x00000002UL
 #define NODE__UDP_RECV                            0x00000004UL
@@ -312,14 +290,12 @@
 #define NODE__RAWIP_RECV                          0x00000010UL
 #define NODE__RAWIP_SEND                          0x00000020UL
 #define NODE__ENFORCE_DEST                        0x00000040UL
-
 #define NETIF__TCP_RECV                           0x00000001UL
 #define NETIF__TCP_SEND                           0x00000002UL
 #define NETIF__UDP_RECV                           0x00000004UL
 #define NETIF__UDP_SEND                           0x00000008UL
 #define NETIF__RAWIP_RECV                         0x00000010UL
 #define NETIF__RAWIP_SEND                         0x00000020UL
-
 #define NETLINK_SOCKET__IOCTL                     0x00000001UL
 #define NETLINK_SOCKET__READ                      0x00000002UL
 #define NETLINK_SOCKET__WRITE                     0x00000004UL
@@ -342,7 +318,6 @@
 #define NETLINK_SOCKET__RECV_MSG                  0x00080000UL
 #define NETLINK_SOCKET__SEND_MSG                  0x00100000UL
 #define NETLINK_SOCKET__NAME_BIND                 0x00200000UL
-
 #define PACKET_SOCKET__IOCTL                      0x00000001UL
 #define PACKET_SOCKET__READ                       0x00000002UL
 #define PACKET_SOCKET__WRITE                      0x00000004UL
@@ -365,7 +340,6 @@
 #define PACKET_SOCKET__RECV_MSG                   0x00080000UL
 #define PACKET_SOCKET__SEND_MSG                   0x00100000UL
 #define PACKET_SOCKET__NAME_BIND                  0x00200000UL
-
 #define KEY_SOCKET__IOCTL                         0x00000001UL
 #define KEY_SOCKET__READ                          0x00000002UL
 #define KEY_SOCKET__WRITE                         0x00000004UL
@@ -388,7 +362,6 @@
 #define KEY_SOCKET__RECV_MSG                      0x00080000UL
 #define KEY_SOCKET__SEND_MSG                      0x00100000UL
 #define KEY_SOCKET__NAME_BIND                     0x00200000UL
-
 #define UNIX_STREAM_SOCKET__IOCTL                 0x00000001UL
 #define UNIX_STREAM_SOCKET__READ                  0x00000002UL
 #define UNIX_STREAM_SOCKET__WRITE                 0x00000004UL
@@ -411,11 +384,9 @@
 #define UNIX_STREAM_SOCKET__RECV_MSG              0x00080000UL
 #define UNIX_STREAM_SOCKET__SEND_MSG              0x00100000UL
 #define UNIX_STREAM_SOCKET__NAME_BIND             0x00200000UL
-
 #define UNIX_STREAM_SOCKET__CONNECTTO             0x00400000UL
 #define UNIX_STREAM_SOCKET__NEWCONN               0x00800000UL
 #define UNIX_STREAM_SOCKET__ACCEPTFROM            0x01000000UL
-
 #define UNIX_DGRAM_SOCKET__IOCTL                  0x00000001UL
 #define UNIX_DGRAM_SOCKET__READ                   0x00000002UL
 #define UNIX_DGRAM_SOCKET__WRITE                  0x00000004UL
@@ -438,7 +409,6 @@
 #define UNIX_DGRAM_SOCKET__RECV_MSG               0x00080000UL
 #define UNIX_DGRAM_SOCKET__SEND_MSG               0x00100000UL
 #define UNIX_DGRAM_SOCKET__NAME_BIND              0x00200000UL
-
 #define PROCESS__FORK                             0x00000001UL
 #define PROCESS__TRANSITION                       0x00000002UL
 #define PROCESS__SIGCHLD                          0x00000004UL
@@ -468,8 +438,6 @@
 #define PROCESS__EXECSTACK                        0x04000000UL
 #define PROCESS__EXECHEAP                         0x08000000UL
 #define PROCESS__SETKEYCREATE                     0x10000000UL
-#define PROCESS__SETSOCKCREATE                    0x20000000UL
-
 #define IPC__CREATE                               0x00000001UL
 #define IPC__DESTROY                              0x00000002UL
 #define IPC__GETATTR                              0x00000004UL
@@ -479,7 +447,6 @@
 #define IPC__ASSOCIATE                            0x00000040UL
 #define IPC__UNIX_READ                            0x00000080UL
 #define IPC__UNIX_WRITE                           0x00000100UL
-
 #define SEM__CREATE                               0x00000001UL
 #define SEM__DESTROY                              0x00000002UL
 #define SEM__GETATTR                              0x00000004UL
@@ -489,7 +456,6 @@
 #define SEM__ASSOCIATE                            0x00000040UL
 #define SEM__UNIX_READ                            0x00000080UL
 #define SEM__UNIX_WRITE                           0x00000100UL
-
 #define MSGQ__CREATE                              0x00000001UL
 #define MSGQ__DESTROY                             0x00000002UL
 #define MSGQ__GETATTR                             0x00000004UL
@@ -499,12 +465,9 @@
 #define MSGQ__ASSOCIATE                           0x00000040UL
 #define MSGQ__UNIX_READ                           0x00000080UL
 #define MSGQ__UNIX_WRITE                          0x00000100UL
-
 #define MSGQ__ENQUEUE                             0x00000200UL
-
 #define MSG__SEND                                 0x00000001UL
 #define MSG__RECEIVE                              0x00000002UL
-
 #define SHM__CREATE                               0x00000001UL
 #define SHM__DESTROY                              0x00000002UL
 #define SHM__GETATTR                              0x00000004UL
@@ -514,9 +477,7 @@
 #define SHM__ASSOCIATE                            0x00000040UL
 #define SHM__UNIX_READ                            0x00000080UL
 #define SHM__UNIX_WRITE                           0x00000100UL
-
 #define SHM__LOCK                                 0x00000200UL
-
 #define SECURITY__COMPUTE_AV                      0x00000001UL
 #define SECURITY__COMPUTE_CREATE                  0x00000002UL
 #define SECURITY__COMPUTE_MEMBER                  0x00000004UL
@@ -528,12 +489,10 @@
 #define SECURITY__SETBOOL                         0x00000100UL
 #define SECURITY__SETSECPARAM                     0x00000200UL
 #define SECURITY__SETCHECKREQPROT                 0x00000400UL
-
 #define SYSTEM__IPC_INFO                          0x00000001UL
 #define SYSTEM__SYSLOG_READ                       0x00000002UL
 #define SYSTEM__SYSLOG_MOD                        0x00000004UL
 #define SYSTEM__SYSLOG_CONSOLE                    0x00000008UL
-
 #define CAPABILITY__CHOWN                         0x00000001UL
 #define CAPABILITY__DAC_OVERRIDE                  0x00000002UL
 #define CAPABILITY__DAC_READ_SEARCH               0x00000004UL
@@ -565,24 +524,20 @@
 #define CAPABILITY__LEASE                         0x10000000UL
 #define CAPABILITY__AUDIT_WRITE                   0x20000000UL
 #define CAPABILITY__AUDIT_CONTROL                 0x40000000UL
-
 #define PASSWD__PASSWD                            0x00000001UL
 #define PASSWD__CHFN                              0x00000002UL
 #define PASSWD__CHSH                              0x00000004UL
 #define PASSWD__ROOTOK                            0x00000008UL
 #define PASSWD__CRONTAB                           0x00000010UL
-
 #define DRAWABLE__CREATE                          0x00000001UL
 #define DRAWABLE__DESTROY                         0x00000002UL
 #define DRAWABLE__DRAW                            0x00000004UL
 #define DRAWABLE__COPY                            0x00000008UL
 #define DRAWABLE__GETATTR                         0x00000010UL
-
 #define GC__CREATE                                0x00000001UL
 #define GC__FREE                                  0x00000002UL
 #define GC__GETATTR                               0x00000004UL
 #define GC__SETATTR                               0x00000008UL
-
 #define WINDOW__ADDCHILD                          0x00000001UL
 #define WINDOW__CREATE                            0x00000002UL
 #define WINDOW__DESTROY                           0x00000004UL
@@ -609,12 +564,10 @@
 #define WINDOW__WINDOWCHANGEREQUEST               0x00800000UL
 #define WINDOW__SERVERCHANGEEVENT                 0x01000000UL
 #define WINDOW__EXTENSIONEVENT                    0x02000000UL
-
 #define FONT__LOAD                                0x00000001UL
 #define FONT__FREE                                0x00000002UL
 #define FONT__GETATTR                             0x00000004UL
 #define FONT__USE                                 0x00000008UL
-
 #define COLORMAP__CREATE                          0x00000001UL
 #define COLORMAP__FREE                            0x00000002UL
 #define COLORMAP__INSTALL                         0x00000004UL
@@ -624,20 +577,16 @@
 #define COLORMAP__STORE                           0x00000040UL
 #define COLORMAP__GETATTR                         0x00000080UL
 #define COLORMAP__SETATTR                         0x00000100UL
-
 #define PROPERTY__CREATE                          0x00000001UL
 #define PROPERTY__FREE                            0x00000002UL
 #define PROPERTY__READ                            0x00000004UL
 #define PROPERTY__WRITE                           0x00000008UL
-
 #define CURSOR__CREATE                            0x00000001UL
 #define CURSOR__CREATEGLYPH                       0x00000002UL
 #define CURSOR__FREE                              0x00000004UL
 #define CURSOR__ASSIGN                            0x00000008UL
 #define CURSOR__SETATTR                           0x00000010UL
-
 #define XCLIENT__KILL                             0x00000001UL
-
 #define XINPUT__LOOKUP                            0x00000001UL
 #define XINPUT__GETATTR                           0x00000002UL
 #define XINPUT__SETATTR                           0x00000004UL
@@ -649,7 +598,6 @@
 #define XINPUT__BELL                              0x00000100UL
 #define XINPUT__MOUSEMOTION                       0x00000200UL
 #define XINPUT__RELABELINPUT                      0x00000400UL
-
 #define XSERVER__SCREENSAVER                      0x00000001UL
 #define XSERVER__GETHOSTLIST                      0x00000002UL
 #define XSERVER__SETHOSTLIST                      0x00000004UL
@@ -658,17 +606,14 @@
 #define XSERVER__GETATTR                          0x00000020UL
 #define XSERVER__GRAB                             0x00000040UL
 #define XSERVER__UNGRAB                           0x00000080UL
-
 #define XEXTENSION__QUERY                         0x00000001UL
 #define XEXTENSION__USE                           0x00000002UL
-
 #define PAX__PAGEEXEC                             0x00000001UL
 #define PAX__EMUTRAMP                             0x00000002UL
 #define PAX__MPROTECT                             0x00000004UL
 #define PAX__RANDMMAP                             0x00000008UL
 #define PAX__RANDEXEC                             0x00000010UL
 #define PAX__SEGMEXEC                             0x00000020UL
-
 #define NETLINK_ROUTE_SOCKET__IOCTL               0x00000001UL
 #define NETLINK_ROUTE_SOCKET__READ                0x00000002UL
 #define NETLINK_ROUTE_SOCKET__WRITE               0x00000004UL
@@ -691,10 +636,8 @@
 #define NETLINK_ROUTE_SOCKET__RECV_MSG            0x00080000UL
 #define NETLINK_ROUTE_SOCKET__SEND_MSG            0x00100000UL
 #define NETLINK_ROUTE_SOCKET__NAME_BIND           0x00200000UL
-
 #define NETLINK_ROUTE_SOCKET__NLMSG_READ          0x00400000UL
 #define NETLINK_ROUTE_SOCKET__NLMSG_WRITE         0x00800000UL
-
 #define NETLINK_FIREWALL_SOCKET__IOCTL            0x00000001UL
 #define NETLINK_FIREWALL_SOCKET__READ             0x00000002UL
 #define NETLINK_FIREWALL_SOCKET__WRITE            0x00000004UL
@@ -717,10 +660,8 @@
 #define NETLINK_FIREWALL_SOCKET__RECV_MSG         0x00080000UL
 #define NETLINK_FIREWALL_SOCKET__SEND_MSG         0x00100000UL
 #define NETLINK_FIREWALL_SOCKET__NAME_BIND        0x00200000UL
-
 #define NETLINK_FIREWALL_SOCKET__NLMSG_READ       0x00400000UL
 #define NETLINK_FIREWALL_SOCKET__NLMSG_WRITE      0x00800000UL
-
 #define NETLINK_TCPDIAG_SOCKET__IOCTL             0x00000001UL
 #define NETLINK_TCPDIAG_SOCKET__READ              0x00000002UL
 #define NETLINK_TCPDIAG_SOCKET__WRITE             0x00000004UL
@@ -743,10 +684,8 @@
 #define NETLINK_TCPDIAG_SOCKET__RECV_MSG          0x00080000UL
 #define NETLINK_TCPDIAG_SOCKET__SEND_MSG          0x00100000UL
 #define NETLINK_TCPDIAG_SOCKET__NAME_BIND         0x00200000UL
-
 #define NETLINK_TCPDIAG_SOCKET__NLMSG_READ        0x00400000UL
 #define NETLINK_TCPDIAG_SOCKET__NLMSG_WRITE       0x00800000UL
-
 #define NETLINK_NFLOG_SOCKET__IOCTL               0x00000001UL
 #define NETLINK_NFLOG_SOCKET__READ                0x00000002UL
 #define NETLINK_NFLOG_SOCKET__WRITE               0x00000004UL
@@ -769,7 +708,6 @@
 #define NETLINK_NFLOG_SOCKET__RECV_MSG            0x00080000UL
 #define NETLINK_NFLOG_SOCKET__SEND_MSG            0x00100000UL
 #define NETLINK_NFLOG_SOCKET__NAME_BIND           0x00200000UL
-
 #define NETLINK_XFRM_SOCKET__IOCTL                0x00000001UL
 #define NETLINK_XFRM_SOCKET__READ                 0x00000002UL
 #define NETLINK_XFRM_SOCKET__WRITE                0x00000004UL
@@ -792,10 +730,8 @@
 #define NETLINK_XFRM_SOCKET__RECV_MSG             0x00080000UL
 #define NETLINK_XFRM_SOCKET__SEND_MSG             0x00100000UL
 #define NETLINK_XFRM_SOCKET__NAME_BIND            0x00200000UL
-
 #define NETLINK_XFRM_SOCKET__NLMSG_READ           0x00400000UL
 #define NETLINK_XFRM_SOCKET__NLMSG_WRITE          0x00800000UL
-
 #define NETLINK_SELINUX_SOCKET__IOCTL             0x00000001UL
 #define NETLINK_SELINUX_SOCKET__READ              0x00000002UL
 #define NETLINK_SELINUX_SOCKET__WRITE             0x00000004UL
@@ -818,7 +754,6 @@
 #define NETLINK_SELINUX_SOCKET__RECV_MSG          0x00080000UL
 #define NETLINK_SELINUX_SOCKET__SEND_MSG          0x00100000UL
 #define NETLINK_SELINUX_SOCKET__NAME_BIND         0x00200000UL
-
 #define NETLINK_AUDIT_SOCKET__IOCTL               0x00000001UL
 #define NETLINK_AUDIT_SOCKET__READ                0x00000002UL
 #define NETLINK_AUDIT_SOCKET__WRITE               0x00000004UL
@@ -841,12 +776,10 @@
 #define NETLINK_AUDIT_SOCKET__RECV_MSG            0x00080000UL
 #define NETLINK_AUDIT_SOCKET__SEND_MSG            0x00100000UL
 #define NETLINK_AUDIT_SOCKET__NAME_BIND           0x00200000UL
-
 #define NETLINK_AUDIT_SOCKET__NLMSG_READ          0x00400000UL
 #define NETLINK_AUDIT_SOCKET__NLMSG_WRITE         0x00800000UL
 #define NETLINK_AUDIT_SOCKET__NLMSG_RELAY         0x01000000UL
 #define NETLINK_AUDIT_SOCKET__NLMSG_READPRIV      0x02000000UL
-
 #define NETLINK_IP6FW_SOCKET__IOCTL               0x00000001UL
 #define NETLINK_IP6FW_SOCKET__READ                0x00000002UL
 #define NETLINK_IP6FW_SOCKET__WRITE               0x00000004UL
@@ -869,10 +802,8 @@
 #define NETLINK_IP6FW_SOCKET__RECV_MSG            0x00080000UL
 #define NETLINK_IP6FW_SOCKET__SEND_MSG            0x00100000UL
 #define NETLINK_IP6FW_SOCKET__NAME_BIND           0x00200000UL
-
 #define NETLINK_IP6FW_SOCKET__NLMSG_READ          0x00400000UL
 #define NETLINK_IP6FW_SOCKET__NLMSG_WRITE         0x00800000UL
-
 #define NETLINK_DNRT_SOCKET__IOCTL                0x00000001UL
 #define NETLINK_DNRT_SOCKET__READ                 0x00000002UL
 #define NETLINK_DNRT_SOCKET__WRITE                0x00000004UL
@@ -895,10 +826,8 @@
 #define NETLINK_DNRT_SOCKET__RECV_MSG             0x00080000UL
 #define NETLINK_DNRT_SOCKET__SEND_MSG             0x00100000UL
 #define NETLINK_DNRT_SOCKET__NAME_BIND            0x00200000UL
-
 #define DBUS__ACQUIRE_SVC                         0x00000001UL
 #define DBUS__SEND_MSG                            0x00000002UL
-
 #define NSCD__GETPWD                              0x00000001UL
 #define NSCD__GETGRP                              0x00000002UL
 #define NSCD__GETHOST                             0x00000004UL
@@ -907,12 +836,10 @@
 #define NSCD__SHMEMPWD                            0x00000020UL
 #define NSCD__SHMEMGRP                            0x00000040UL
 #define NSCD__SHMEMHOST                           0x00000080UL
-
 #define ASSOCIATION__SENDTO                       0x00000001UL
 #define ASSOCIATION__RECVFROM                     0x00000002UL
 #define ASSOCIATION__SETCONTEXT                   0x00000004UL
 #define ASSOCIATION__POLMATCH                     0x00000008UL
-
 #define NETLINK_KOBJECT_UEVENT_SOCKET__IOCTL      0x00000001UL
 #define NETLINK_KOBJECT_UEVENT_SOCKET__READ       0x00000002UL
 #define NETLINK_KOBJECT_UEVENT_SOCKET__WRITE      0x00000004UL
@@ -935,7 +862,6 @@
 #define NETLINK_KOBJECT_UEVENT_SOCKET__RECV_MSG   0x00080000UL
 #define NETLINK_KOBJECT_UEVENT_SOCKET__SEND_MSG   0x00100000UL
 #define NETLINK_KOBJECT_UEVENT_SOCKET__NAME_BIND  0x00200000UL
-
 #define APPLETALK_SOCKET__IOCTL                   0x00000001UL
 #define APPLETALK_SOCKET__READ                    0x00000002UL
 #define APPLETALK_SOCKET__WRITE                   0x00000004UL
@@ -958,11 +884,9 @@
 #define APPLETALK_SOCKET__RECV_MSG                0x00080000UL
 #define APPLETALK_SOCKET__SEND_MSG                0x00100000UL
 #define APPLETALK_SOCKET__NAME_BIND               0x00200000UL
-
 #define PACKET__SEND                              0x00000001UL
 #define PACKET__RECV                              0x00000002UL
 #define PACKET__RELABELTO                         0x00000004UL
-
 #define KEY__VIEW                                 0x00000001UL
 #define KEY__READ                                 0x00000002UL
 #define KEY__WRITE                                0x00000004UL
@@ -970,3 +894,4 @@
 #define KEY__LINK                                 0x00000010UL
 #define KEY__SETATTR                              0x00000020UL
 #define KEY__CREATE                               0x00000040UL
+#define CONTEXT__TRANSLATE                        0x00000001UL
diff -ruNp --exclude=.svn selinux-base/libselinux/include/selinux/flask.h selinux/libselinux/include/selinux/flask.h
--- selinux-base/libselinux/include/selinux/flask.h	2006-10-03 05:08:16.000000000 -0500
+++ selinux/libselinux/include/selinux/flask.h	2006-10-05 03:25:59.000000000 -0500
@@ -63,6 +63,7 @@
 #define SECCLASS_APPLETALK_SOCKET                        56
 #define SECCLASS_PACKET                                  57
 #define SECCLASS_KEY                                     58
+#define SECCLASS_CONTEXT                                 59
 
 /*
  * Security identifier indices for initial entities
diff -ruNp --exclude=.svn selinux-base/libselinux/src/av_perm_to_string.h selinux/libselinux/src/av_perm_to_string.h
--- selinux-base/libselinux/src/av_perm_to_string.h	2006-10-03 05:08:17.000000000 -0500
+++ selinux/libselinux/src/av_perm_to_string.h	2006-10-05 03:25:58.000000000 -0500
@@ -253,6 +253,7 @@ S_(SECCLASS_FILESYSTEM, FILESYSTEM__MOUN
     S_(SECCLASS_ASSOCIATION, ASSOCIATION__SENDTO, "sendto")
     S_(SECCLASS_ASSOCIATION, ASSOCIATION__RECVFROM, "recvfrom")
     S_(SECCLASS_ASSOCIATION, ASSOCIATION__SETCONTEXT, "setcontext")
+    S_(SECCLASS_ASSOCIATION, ASSOCIATION__POLMATCH, "polmatch")
     S_(SECCLASS_PACKET, PACKET__SEND, "send")
     S_(SECCLASS_PACKET, PACKET__RECV, "recv")
     S_(SECCLASS_PACKET, PACKET__RELABELTO, "relabelto")
@@ -263,3 +264,4 @@ S_(SECCLASS_FILESYSTEM, FILESYSTEM__MOUN
     S_(SECCLASS_KEY, KEY__LINK, "link")
     S_(SECCLASS_KEY, KEY__SETATTR, "setattr")
     S_(SECCLASS_KEY, KEY__CREATE, "create")
+    S_(SECCLASS_CONTEXT, CONTEXT__TRANSLATE, "translate")
diff -ruNp --exclude=.svn selinux-base/libselinux/src/class_to_string.h selinux/libselinux/src/class_to_string.h
--- selinux-base/libselinux/src/class_to_string.h	2006-10-03 05:08:17.000000000 -0500
+++ selinux/libselinux/src/class_to_string.h	2006-10-05 03:25:58.000000000 -0500
@@ -61,3 +61,4 @@ S_("null")
     S_("appletalk_socket")
     S_("packet")
     S_("key")
+    S_("context")

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
