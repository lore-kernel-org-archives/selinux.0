Message-ID: <51002308.3050709@tycho.nsa.gov>
Date: Wed, 23 Jan 2013 12:51:04 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Jan Stancek <jstancek@redhat.com>
CC: selinux@tycho.nsa.gov, serge@hallyn.com, jburke@redhat.com
Subject: Re: [selinux-testsuite][PATCH] use extfs ioctls only when running
 on ext[234]
References: <2101640213.3126557.1358959802946.JavaMail.root@redhat.com>
In-Reply-To: <2101640213.3126557.1358959802946.JavaMail.root@redhat.com>
Content-Type: multipart/mixed;
 boundary="------------060502070306080109050302"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060502070306080109050302
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Odd, I have the following diff locally.


On 01/23/2013 11:50 AM, Jan Stancek wrote:
>
>
> ----- Original Message -----
>> From: "Stephen Smalley" <sds@tycho.nsa.gov>
>> To: "Jan Stancek" <jstancek@redhat.com>
>> Cc: selinux@tycho.nsa.gov, serge@hallyn.com, jburke@redhat.com
>> Sent: Wednesday, 23 January, 2013 4:41:38 PM
>> Subject: Re: [selinux-testsuite][PATCH] use extfs ioctls only when running on ext[234]
>>
>> On 01/23/2013 08:27 AM, Jan Stancek wrote:
>>> EXT2_* ioctls are likely to fail on other filesystems,
>>> for example: xfs.
>>>
>>> Signed-off-by: Jan Stancek <jstancek@redhat.com>
>>> ---
>>>    tests/ioctl/Makefile       |    6 ++++++
>>>    tests/ioctl/test_ioctl.c   |    2 ++
>>>    tests/ioctl/test_noioctl.c |    2 ++
>>>    3 files changed, 10 insertions(+), 0 deletions(-)
>>
>> Shouldn't really be a compile-time flag but rather a runtime test of
>> the
>> filesystem type, right?  Otherwise it presumes you built it on the
>> same
>> system and in the same filesystem where you will run it.
>
> Correct, I assumed everyone is running it with 'make test'.
>
>>
>> I thought however that your earlier patch to switch it to using
>> FS_IOC_
>> command values would have
>> addressed the issue of other filesystem types already?  What error
>> are
>> you getting from xfs?
>
> ioctl(3, FS_IOC32_SETVERSION or FS_IOC_SETVERSION or SONYPI_IOCGBAT1CAP, 0x7fffb5eeac24) = -1 ENOTTY (Inappropriate ioctl for device)
>
>> The code already checks for one errno value to
>> distinguish the not-supported case.
>
> I can't see any check for errno in this test:
> $ grep "errno" -r tests/ioctl/
> $
>
> Regards,
> Jan
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>


--------------060502070306080109050302
Content-Type: text/x-patch;
 name="ioctl.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="ioctl.diff"

diff --git a/tests/ioctl/test_ioctl.c b/tests/ioctl/test_ioctl.c
index 0852f41..a0fe365 100644
--- a/tests/ioctl/test_ioctl.c
+++ b/tests/ioctl/test_ioctl.c
@@ -6,9 +6,7 @@
 #include <sys/stat.h>
 #include <linux/fs.h>
 #include <unistd.h>
-
-#define EXT2_IOC_GETVERSION FS_IOC_GETVERSION
-#define EXT2_IOC_SETVERSION FS_IOC_SETVERSION
+#include <errno.h>
 
 /*
  * Test the ioctl() calls on a file whose name is given as the first
@@ -30,37 +28,37 @@ int main(int argc, char **argv) {
 
   /* This one should hit the FILE__GETATTR or FILE__IOCTL test */
   rc = ioctl(fd, FIGETBSZ, &val);
-  if( rc != 0 ) {
+  if( rc < 0 ) {
     perror("test_ioctl:FIGETBSZ");
     exit(1);
   }
 
   /* This one should hit the FILE__IOCTL test */
   rc = ioctl(fd, FIOCLEX);
-  if( rc != 0 ) {
+  if( rc < 0 ) {
     perror("test_ioctl:FIOCLEX");
     exit(1);
   }
 
   /* This one should hit the FD__USE or FILE__IOCTL test */
   rc = ioctl(fd, FIONBIO, &val);
-  if( rc != 0 ) {
+  if( rc < 0 ) {
     perror("test_ioctl:FIONBIO");
     exit(1);
   }
 
   /* This one should hit the FILE__GETATTR or FILE__READ test */
-  rc = ioctl(fd, EXT2_IOC_GETVERSION, &val);
-  if( rc != 0 ) {
-    perror("test_ioctl:EXT2_IOC_GETVERSION");
+  rc = ioctl(fd, FS_IOC_GETVERSION, &val);
+  if( rc < 0 && errno != ENOTTY) {
+    perror("test_ioctl:FS_IOC_GETVERSION");
     exit(1);
   }
 
   /* This one should hit the FILE__SETATTR or FILE__WRITE test */
   val = 0;
-  rc = ioctl(fd, EXT2_IOC_SETVERSION, &val);
-  if( rc != 0 ) {
-    perror("test_ioctl:EXT2_IOC_SETVERSION");
+  rc = ioctl(fd, FS_IOC_SETVERSION, &val);
+  if( rc < 0 && errno != ENOTTY) {
+    perror("test_ioctl:FS_IOC_SETVERSION");
     exit(1);
   }
 
diff --git a/tests/ioctl/test_noioctl.c b/tests/ioctl/test_noioctl.c
index ef3fac5..f615054 100644
--- a/tests/ioctl/test_noioctl.c
+++ b/tests/ioctl/test_noioctl.c
@@ -11,9 +11,7 @@
 #include <sys/utsname.h>
 #include <unistd.h>
 #include <string.h>
-
-#define EXT2_IOC_GETVERSION FS_IOC_GETVERSION
-#define EXT2_IOC_SETVERSION FS_IOC_SETVERSION
+#include <errno.h>
 
 /*
  * Test the ioctl() calls on a file whose name is given as the first
@@ -25,7 +23,7 @@
 int main(int argc, char **argv) {
   struct utsname uts;
   int fd;
-  int rc, oldkernel = 1;
+  int rc, useaccessmode = 1;
   int val;
 
   if (uname(&uts) < 0) {
@@ -34,7 +32,7 @@ int main(int argc, char **argv) {
   }
 
   if (strverscmp(uts.release, "2.6.27") >= 0 && strverscmp(uts.release, "2.6.39") < 0)
-    oldkernel = 0;
+    useaccessmode = 0;
 
   fd = open(argv[1], O_RDONLY, 0);
  
@@ -59,11 +57,11 @@ int main(int argc, char **argv) {
 
   /*
    * This one depends on kernel version:
-   * New:  Should hit the FILE__IOCTL test and fail.
-   * Old:  Should only check FD__USE and succeed.
+   * >= 2.6.27 and < 2.6.39:  Should hit the FILE__IOCTL test and fail.
+   * < 2.6.27 or >= 2.6.39:  Should only check FD__USE and succeed.
    */
   rc = ioctl(fd, FIONBIO, &val);
-  if( !rc == !oldkernel ) {
+  if( !rc == !useaccessmode ) {
     printf("test_noioctl:FIONBIO");
     exit(1);
   }
@@ -73,17 +71,18 @@ int main(int argc, char **argv) {
    * New:  Should hit the FILE__READ test and succeed.
    * Old:  Should hit the FILE__GETATTR test and fail.
    */
-  rc = ioctl(fd, EXT2_IOC_GETVERSION, &val);
-  if( !rc != !oldkernel ) {
-    perror("test_noioctl:EXT2_IOC_GETVERSION");
+  rc = ioctl(fd, FS_IOC_GETVERSION, &val);
+  if( (useaccessmode && rc == 0) ||
+      (!useaccessmode && rc < 0 && errno != ENOTTY) ) {
+    perror("test_noioctl:FS_IOC_GETVERSION");
     exit(1);
   }
 
-  /* This one should hit the FILE__WRITE test and fail. */
+  /* This one should hit the FILE__WRITE or FILE_SETATTR test and fail. */
   val = 0;
-  rc = ioctl(fd, EXT2_IOC_SETVERSION, &val);
+  rc = ioctl(fd, FS_IOC_SETVERSION, &val);
   if( rc == 0 ) {
-    perror("test_noioctl:EXT2_IOC_SETVERSION");
+    perror("test_noioctl:FS_IOC_SETVERSION");
     exit(1);
   }
 

--------------060502070306080109050302--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
