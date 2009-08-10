Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7AFE1qs018250
	for <selinux@tycho.nsa.gov>; Mon, 10 Aug 2009 11:14:01 -0400
Received: from mx2.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n7AFDVre022786
	for <selinux@tycho.nsa.gov>; Mon, 10 Aug 2009 15:13:31 GMT
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n7AFDxJs018672
	for <selinux@tycho.nsa.gov>; Mon, 10 Aug 2009 11:13:59 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n7AFDwWl025547
	for <selinux@tycho.nsa.gov>; Mon, 10 Aug 2009 11:13:58 -0400
Received: from localhost.localdomain (dhcp-100-2-12.bos.redhat.com [10.16.2.12])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n7AFDvvn019708
	for <selinux@tycho.nsa.gov>; Mon, 10 Aug 2009 11:13:58 -0400
Message-ID: <4A803935.3040407@redhat.com>
Date: Mon, 10 Aug 2009 11:13:57 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Patch setfiles to only warn if add_remove fails to lstat on user
 initiated excludes.
Content-Type: multipart/mixed;
 boundary="------------000809070607020104070601"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000809070607020104070601
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Currently in F12 if you have file systems that root can not read

# restorecon -R -v /var/lib/libvirt/
Can't stat directory "/home/dwalsh/.gvfs", Permission denied.
Can't stat directory "/home/dwalsh/redhat", Permission denied.

After patch

# ./restorecon -R -v /var/lib/libvirt/

--------------000809070607020104070601
Content-Type: text/plain;
 name="policycoreutils-setfiles.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="policycoreutils-setfiles.patch"

diff -up policycoreutils-2.0.70/setfiles/setfiles.c~ policycoreutils-2.0.70/setfiles/setfiles.c
--- policycoreutils-2.0.70/setfiles/setfiles.c~	2009-08-05 15:11:11.000000000 -0400
+++ policycoreutils-2.0.70/setfiles/setfiles.c	2009-08-10 11:06:54.000000000 -0400
@@ -234,7 +234,7 @@ void filespec_destroy(void)
 	fl_head = NULL;
 }
 
-static int add_exclude(const char *directory)
+static int add_exclude(const char *directory, int warn)
 {
 	struct stat sb;
 	size_t len = 0;
@@ -244,8 +244,8 @@ static int add_exclude(const char *direc
 		return 1;
 	}
 	if (lstat(directory, &sb)) {
-		fprintf(stderr, "Can't stat directory \"%s\", %s.\n",
-			directory, strerror(errno));
+		if (warn) fprintf(stderr, "Can't stat directory \"%s\", %s.\n",
+				directory, strerror(errno));
 		return 0;
 	}
 	if ((sb.st_mode & S_IFDIR) == 0) {
@@ -727,7 +727,7 @@ static void exclude_non_seclabel_mounts(
 
 		/* exclude mount points without the seclabel option */
 		if (!found)
-			add_exclude(mount_info[1]);
+			add_exclude(mount_info[1], 0);
 	}
 
 	free(buf);
@@ -840,7 +840,7 @@ int main(int argc, char **argv)
 			}
 		case 'e':
 			remove_exclude(optarg);
-			if (add_exclude(optarg))
+			if (add_exclude(optarg, 1))
 				exit(1);
 			break;
 		case 'f':

--------------000809070607020104070601--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
