Subject: [PATCH] policycoreutils: add support for keycreate attribute in
	secon
From: Michael LeMay <mdlemay@epoch.ncsc.mil>
To: sds@tycho.nsa.gov, eparis@parisplace.org,
        David Howells <dhowells@redhat.com>, selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Thu, 22 Jun 2006 11:04:15 -0400
Message-Id: <1150988655.4567.5.camel@moss-tarheels.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a patch to policycoreutils that adds support in secon for the keycreate
attribute that is visible in /proc/<pid>/attr/keycreate.  Specifically, it adds
four new command line arguments:
 --self/current-key, to address the keycreate attribute of the current process
 --parent-key, to address the keycreate attribute of the parent process
 --pid-key, to address the keycreate attribute in a specific process

I also rearranged the numbers that are used in the argument processing code to
retain their logical ordering.

---

 secon/secon.c |   67 ++++++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 54 insertions(+), 13 deletions(-)

diff -X dontdiff -uprN policycoreutils.orig/secon/secon.c policycoreutils/secon/secon.c
--- policycoreutils.orig/secon/secon.c	2006-06-21 12:33:49.000000000 -0400
+++ policycoreutils/secon/secon.c	2006-06-22 10:30:21.000000000 -0400
@@ -29,9 +29,11 @@
 #define OPTS_FROM_CUR      4
 #define OPTS_FROM_CUREXE   5
 #define OPTS_FROM_CURFS    6
-#define OPTS_FROM_PROC     7
-#define OPTS_FROM_PROCEXE  8
-#define OPTS_FROM_PROCFS   9
+#define OPTS_FROM_CURKEY   7
+#define OPTS_FROM_PROC     8
+#define OPTS_FROM_PROCEXE  9
+#define OPTS_FROM_PROCFS   10
+#define OPTS_FROM_PROCKEY  11
 
 struct 
 {
@@ -78,12 +80,15 @@ static void usage(const char *name, int 
 "          --self               Get the context for the current process.\n"
 "          --self-exec          Get the exec context for the current process.\n"
 "          --self-fs            Get the fs context for the current process.\n"
+"          --self-key           Get the key context for the current process.\n"
 "          --parent             Get the context for the parent process.\n"
 "          --parent-exec        Get the exec context for the parent process.\n"
 "          --parent-fs          Get the fs context for the parent process.\n"
+"          --parent-key         Get the key context for the parent process.\n"
 "          --pid       -p <arg> Use the context from the specified pid.\n"
 "          --pid-exec     <arg> Use the exec context from the specified pid.\n"
 "          --pid-fs       <arg> Use the fs context from the specified pid.\n"
+"          --pid-key      <arg> Use the key context from the specified pid.\n"
 "          --file      -f <arg> Use the context from the specified file.\n"
 "          --link      -L <arg> Use the context from the specified link.\n",
           name, SECON_OPTS_SM);
@@ -160,16 +165,20 @@ static void cmd_line(int argc, char *arg
      {"self-exec",    no_argument, NULL, 2},
      {"current-fs",   no_argument, NULL, 3},
      {"self-fs",      no_argument, NULL, 3},
+     {"current-key",   no_argument, NULL, 4},
+     {"self-key",      no_argument, NULL, 4},
      
-     {"parent",       no_argument, NULL, 4},
-     {"parent-exec",  no_argument, NULL, 5},
-     {"parent-fs",    no_argument, NULL, 6},
+     {"parent",       no_argument, NULL, 5},
+     {"parent-exec",  no_argument, NULL, 6},
+     {"parent-fs",    no_argument, NULL, 7},
+     {"parent-key",    no_argument, NULL, 8},
      
      {"file",     required_argument, NULL, 'f'},
      {"link",     required_argument, NULL, 'L'},
      {"pid",      required_argument, NULL, 'p'},
-     {"pid-exec", required_argument, NULL, 7},
-     {"pid-fs",   required_argument, NULL, 8},
+     {"pid-exec", required_argument, NULL, 9},
+     {"pid-fs",   required_argument, NULL, 10},
+     {"pid-key",   required_argument, NULL, 11},
      
      {NULL, 0, NULL, 0}
     };
@@ -203,19 +212,24 @@ static void cmd_line(int argc, char *arg
       case 1:   opts->from_type = OPTS_FROM_CUR;    break;
       case 2:   opts->from_type = OPTS_FROM_CUREXE; break;
       case 3:   opts->from_type = OPTS_FROM_CURFS;  break;
+      case 4:   opts->from_type = OPTS_FROM_CURKEY;  break;
         
-      case 4:
+      case 5:
         opts->from_type = OPTS_FROM_PROC;
         opts->f.pid     = getppid();
         break;
-      case 5:
+      case 6:
         opts->from_type = OPTS_FROM_PROCEXE;
         opts->f.pid     = getppid();
         break;
-      case 6:
+      case 7:
         opts->from_type = OPTS_FROM_PROCFS;
         opts->f.pid     = getppid();
         break;
+      case 8:
+        opts->from_type = OPTS_FROM_PROCKEY;
+        opts->f.pid     = getppid();
+        break;
         
       case 'f': opts->from_type = OPTS_FROM_FILE; opts->f.file = optarg; break;
       case 'L': opts->from_type = OPTS_FROM_LINK; opts->f.link = optarg; break;
@@ -223,14 +237,18 @@ static void cmd_line(int argc, char *arg
         opts->from_type = OPTS_FROM_PROC;
         opts->f.pid     = atoi(optarg);
         break;        
-      case 7:
+      case 9:
         opts->from_type = OPTS_FROM_PROCEXE;
         opts->f.pid     = atoi(optarg);
         break;
-      case 8:
+      case 10:
         opts->from_type = OPTS_FROM_PROCFS;
         opts->f.pid     = atoi(optarg);
         break;
+      case 11:
+        opts->from_type = OPTS_FROM_PROCKEY;
+        opts->f.pid     = atoi(optarg);
+        break;
         
       default:
         assert(FALSE);
@@ -309,6 +327,10 @@ static int my_getpidfscreatecon_raw(pid_
 {
   return (my_getXcon_raw(pid, con, "fscreate"));
 }
+static int my_getpidkeycreatecon_raw(pid_t pid, security_context_t *con)
+{
+  return (my_getXcon_raw(pid, con, "keycreate"));
+}
 
 static security_context_t get_scon(void)
 {
@@ -370,6 +392,15 @@ static security_context_t get_scon(void)
       if (!con)
         con = strdup(dummy_NIL);
       break;
+    case OPTS_FROM_CURKEY:
+      ret = getkeycreatecon_raw(&con);
+
+      if (ret == -1)
+        err(EXIT_FAILURE, " Couldn't get current key security context");
+
+      if (!con)
+        con = strdup(dummy_NIL);
+      break;
 
     case OPTS_FROM_PROC:
       ret = getpidcon_raw(opts->f.pid, &con);
@@ -403,6 +434,16 @@ static security_context_t get_scon(void)
         return (get_scon());
       } */
       break;
+    case OPTS_FROM_PROCKEY:
+      ret = my_getpidkeycreatecon_raw(opts->f.pid, &con);
+      
+      if (ret == -1)
+        err(EXIT_FAILURE, " Couldn't get security context for pid %lu",
+            (unsigned long)opts->f.pid);
+      
+      if (!con)
+        con = strdup(dummy_NIL);
+      break;
       
     case OPTS_FROM_FILE:
       ret = getfilecon_raw(opts->f.file, &con);



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
