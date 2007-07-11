Message-ID: <4694ED82.5050605@redhat.com>
Date: Wed, 11 Jul 2007 10:47:30 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: libselinux patch for new flask.h/access_vectors.h
Content-Type: multipart/mixed;
 boundary="------------090201090400020402080106"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090201090400020402080106
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

These changes are required to match what is in reference policy along 
with new changes in nscd.

--------------090201090400020402080106
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsalibselinux/include/selinux/av_permissions.h libselinux-2.0.23/include/selinux/av_permissions.h
--- nsalibselinux/include/selinux/av_permissions.h	2006-11-16 17:15:18.000000000 -0500
+++ libselinux-2.0.23/include/selinux/av_permissions.h	2007-07-11 10:06:56.000000000 -0400
@@ -290,12 +290,16 @@
 #define NODE__RAWIP_RECV                          0x00000010UL
 #define NODE__RAWIP_SEND                          0x00000020UL
 #define NODE__ENFORCE_DEST                        0x00000040UL
+#define NODE__DCCP_RECV                           0x00000080UL
+#define NODE__DCCP_SEND                           0x00000100UL
 #define NETIF__TCP_RECV                           0x00000001UL
 #define NETIF__TCP_SEND                           0x00000002UL
 #define NETIF__UDP_RECV                           0x00000004UL
 #define NETIF__UDP_SEND                           0x00000008UL
 #define NETIF__RAWIP_RECV                         0x00000010UL
 #define NETIF__RAWIP_SEND                         0x00000020UL
+#define NETIF__DCCP_RECV                          0x00000040UL
+#define NETIF__DCCP_SEND                          0x00000080UL
 #define NETLINK_SOCKET__IOCTL                     0x00000001UL
 #define NETLINK_SOCKET__READ                      0x00000002UL
 #define NETLINK_SOCKET__WRITE                     0x00000004UL
@@ -837,6 +841,8 @@
 #define NSCD__SHMEMPWD                            0x00000020UL
 #define NSCD__SHMEMGRP                            0x00000040UL
 #define NSCD__SHMEMHOST                           0x00000080UL
+#define NSCD__GETSERV                             0x00000100UL
+#define NSCD__SHMEMSERV                           0x00000200UL
 #define ASSOCIATION__SENDTO                       0x00000001UL
 #define ASSOCIATION__RECVFROM                     0x00000002UL
 #define ASSOCIATION__SETCONTEXT                   0x00000004UL
@@ -897,3 +903,28 @@
 #define KEY__CREATE                               0x00000040UL
 #define CONTEXT__TRANSLATE                        0x00000001UL
 #define CONTEXT__CONTAINS                         0x00000002UL
+#define DCCP_SOCKET__IOCTL                        0x00000001UL
+#define DCCP_SOCKET__READ                         0x00000002UL
+#define DCCP_SOCKET__WRITE                        0x00000004UL
+#define DCCP_SOCKET__CREATE                       0x00000008UL
+#define DCCP_SOCKET__GETATTR                      0x00000010UL
+#define DCCP_SOCKET__SETATTR                      0x00000020UL
+#define DCCP_SOCKET__LOCK                         0x00000040UL
+#define DCCP_SOCKET__RELABELFROM                  0x00000080UL
+#define DCCP_SOCKET__RELABELTO                    0x00000100UL
+#define DCCP_SOCKET__APPEND                       0x00000200UL
+#define DCCP_SOCKET__BIND                         0x00000400UL
+#define DCCP_SOCKET__CONNECT                      0x00000800UL
+#define DCCP_SOCKET__LISTEN                       0x00001000UL
+#define DCCP_SOCKET__ACCEPT                       0x00002000UL
+#define DCCP_SOCKET__GETOPT                       0x00004000UL
+#define DCCP_SOCKET__SETOPT                       0x00008000UL
+#define DCCP_SOCKET__SHUTDOWN                     0x00010000UL
+#define DCCP_SOCKET__RECVFROM                     0x00020000UL
+#define DCCP_SOCKET__SENDTO                       0x00040000UL
+#define DCCP_SOCKET__RECV_MSG                     0x00080000UL
+#define DCCP_SOCKET__SEND_MSG                     0x00100000UL
+#define DCCP_SOCKET__NAME_BIND                    0x00200000UL
+#define DCCP_SOCKET__NODE_BIND                    0x00400000UL
+#define DCCP_SOCKET__NAME_CONNECT                 0x00800000UL
+#define MEMPROTECT__MMAP_ZERO                     0x00000001UL
diff --exclude-from=exclude -N -u -r nsalibselinux/include/selinux/flask.h libselinux-2.0.23/include/selinux/flask.h
--- nsalibselinux/include/selinux/flask.h	2006-11-16 17:15:18.000000000 -0500
+++ libselinux-2.0.23/include/selinux/flask.h	2007-07-11 10:07:03.000000000 -0400
@@ -64,6 +64,8 @@
 #define SECCLASS_PACKET                                  57
 #define SECCLASS_KEY                                     58
 #define SECCLASS_CONTEXT                                 59
+#define SECCLASS_DCCP_SOCKET                             60
+#define SECCLASS_MEMPROTECT                              61
 
 /*
  * Security identifier indices for initial entities

--------------090201090400020402080106--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
