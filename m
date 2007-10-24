Message-ID: <471F8F8D.3040606@tycho.nsa.gov>
Date: Wed, 24 Oct 2007 14:31:41 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: SELinux List <selinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] libselinux: refactor AVC netlink code
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch removes duplication in the AVC netlink code
by introducing helper functions.

Did some basic testing and confirmed that messages are
received and processed.

More patches to follow.

Signed-off-by: Eamon Walsh <ewalsh@tycho.nsa.gov>
---

 avc_internal.c |  289 +++++++++++++++++++++------------------------------------
 1 file changed, 107 insertions(+), 182 deletions(-)


Index: libselinux/src/avc_internal.c
===================================================================
--- libselinux/src/avc_internal.c	(revision 2662)
+++ libselinux/src/avc_internal.c	(working copy)
@@ -89,221 +89,146 @@
 	close(fd);
 }
 
-int avc_netlink_check_nb(void)
+static int avc_netlink_receive(char *buf, unsigned buflen)
 {
 	int rc;
 	struct sockaddr_nl nladdr;
 	socklen_t nladdrlen = sizeof nladdr;
-	char buf[1024];
-	struct nlmsghdr *nlh;
+	struct nlmsghdr *nlh = (struct nlmsghdr *)buf;
 
-	while (1) {
-		rc = recvfrom(fd, buf, sizeof(buf), 0,
-			      (struct sockaddr *)&nladdr, &nladdrlen);
-		if (rc < 0) {
-			if (errno == EINTR)
-				continue;
-			if (errno != EAGAIN) {
-				avc_log("%s:  socket error during read: %d\n",
-					avc_prefix, errno);
-			} else {
-				errno = 0;
-				rc = 0;
-			}
-			goto out;
-		}
+	rc = recvfrom(fd, buf, buflen, 0, (struct sockaddr *)&nladdr,
+		      &nladdrlen);
+	if (rc < 0)
+		return rc;
 
-		if (nladdrlen != sizeof nladdr) {
-			avc_log
-			    ("%s:  warning: netlink address truncated, len %d?\n",
-			     avc_prefix, nladdrlen);
-			rc = -1;
-			goto out;
-		}
+	if (nladdrlen != sizeof nladdr) {
+		avc_log("%s:  warning: netlink address truncated, len %d?\n",
+			avc_prefix, nladdrlen);
+		return -1;
+	}
 
-		if (nladdr.nl_pid) {
-			avc_log
-			    ("%s:  warning: received spoofed netlink packet from: %d\n",
-			     avc_prefix, nladdr.nl_pid);
-			continue;
-		}
+	if (nladdr.nl_pid) {
+		avc_log("%s:  warning: received spoofed netlink packet from: %d\n",
+			avc_prefix, nladdr.nl_pid);
+		return -1;
+	}
 
-		if (rc == 0) {
-			avc_log("%s:  warning: received EOF on socket\n",
-				avc_prefix);
-			goto out;
-		}
+	if (rc == 0) {
+		avc_log("%s:  warning: received EOF on netlink socket\n",
+			avc_prefix);
+		errno = EBADFD;
+		return -1;
+	}
 
-		nlh = (struct nlmsghdr *)buf;
+	if (nlh->nlmsg_flags & MSG_TRUNC || nlh->nlmsg_len > (unsigned)rc) {
+		avc_log("%s:  warning: incomplete netlink message\n",
+			avc_prefix);
+		return -1;
+	}
 
-		if (nlh->nlmsg_flags & MSG_TRUNC
-		    || nlh->nlmsg_len > (unsigned)rc) {
-			avc_log("%s:  warning: incomplete netlink message\n",
-				avc_prefix);
-			goto out;
-		}
+	return 0;
+}
 
-		rc = 0;
-		switch (nlh->nlmsg_type) {
-		case NLMSG_ERROR:{
-				struct nlmsgerr *err = NLMSG_DATA(nlh);
+static int avc_netlink_process(char *buf)
+{
+	int rc;
+	struct nlmsghdr *nlh = (struct nlmsghdr *)buf;
 
-				/* Netlink ack */
-				if (err->error == 0)
-					break;
+	switch (nlh->nlmsg_type) {
+	case NLMSG_ERROR:{
+		struct nlmsgerr *err = NLMSG_DATA(nlh);
 
-				errno = -err->error;
-				avc_log("%s:  netlink error: %d\n", avc_prefix,
-					errno);
-				rc = -1;
-				goto out;
-			}
+		/* Netlink ack */
+		if (err->error == 0)
+			break;
 
-		case SELNL_MSG_SETENFORCE:{
-				struct selnl_msg_setenforce *msg =
-				    NLMSG_DATA(nlh);
-				avc_log
-				    ("%s:  received setenforce notice (enforcing=%d)\n",
-				     avc_prefix, msg->val);
-				avc_enforcing = msg->val;
-				if (avc_enforcing && (rc = avc_ss_reset(0)) < 0) {
-					avc_log
-					    ("%s:  cache reset returned %d (errno %d)\n",
-					     avc_prefix, rc, errno);
-					goto out;
-				}
-				break;
-			}
+		errno = -err->error;
+		avc_log("%s:  netlink error: %d\n", avc_prefix, errno);
+		return -1;
+	}
 
-		case SELNL_MSG_POLICYLOAD:{
-				struct selnl_msg_policyload *msg =
-				    NLMSG_DATA(nlh);
-				avc_log
-				    ("%s:  received policyload notice (seqno=%d)\n",
-				     avc_prefix, msg->seqno);
-				rc = avc_ss_reset(msg->seqno);
-				if (rc < 0) {
-					avc_log
-					    ("%s:  cache reset returned %d (errno %d)\n",
-					     avc_prefix, rc, errno);
-					goto out;
-				}
-				break;
-			}
+	case SELNL_MSG_SETENFORCE:{
+		struct selnl_msg_setenforce *msg = NLMSG_DATA(nlh);
+		avc_log("%s:  received setenforce notice (enforcing=%d)\n",
+			avc_prefix, msg->val);
+		avc_enforcing = msg->val;
+		if (avc_enforcing && (rc = avc_ss_reset(0)) < 0) {
+			avc_log("%s:  cache reset returned %d (errno %d)\n",
+				avc_prefix, rc, errno);
+			return rc;
+		}
+		break;
+	}
 
-		default:
-			avc_log("%s:  warning: unknown netlink message %d\n",
-				avc_prefix, nlh->nlmsg_type);
+	case SELNL_MSG_POLICYLOAD:{
+		struct selnl_msg_policyload *msg = NLMSG_DATA(nlh);
+		avc_log("%s:  received policyload notice (seqno=%d)\n",
+			avc_prefix, msg->seqno);
+		rc = avc_ss_reset(msg->seqno);
+		if (rc < 0) {
+			avc_log("%s:  cache reset returned %d (errno %d)\n",
+				avc_prefix, rc, errno);
+			return rc;
 		}
+		break;
 	}
-      out:
-	return rc;
+
+	default:
+		avc_log("%s:  warning: unknown netlink message %d\n",
+			avc_prefix, nlh->nlmsg_type);
+	}
+	return 0;
 }
 
-/* run routine for the netlink listening thread */
-void avc_netlink_loop(void)
+int avc_netlink_check_nb(void)
 {
-	int ret;
-	struct sockaddr_nl nladdr;
-	socklen_t nladdrlen = sizeof nladdr;
+	int rc;
 	char buf[1024];
-	struct nlmsghdr *nlh;
 
 	while (1) {
-		ret =
-		    recvfrom(fd, buf, sizeof(buf), 0,
-			     (struct sockaddr *)&nladdr, &nladdrlen);
-		if (ret < 0) {
-			if (errno == EINTR)
+		errno = 0;
+		rc = avc_netlink_receive(buf, sizeof(buf));
+		if (rc < 0) {
+			if (errno == EWOULDBLOCK)
+				return 0;
+			if (errno == 0 || errno == EINTR)
 				continue;
-			avc_log("%s:  netlink thread: recvfrom: error %d\n",
-				avc_prefix, errno);
-			goto out;
+			else {
+				avc_log("%s:  netlink recvfrom: error %d\n",
+					avc_prefix, errno);
+				return rc;
+			}
 		}
 
-		if (nladdrlen != sizeof nladdr) {
-			avc_log
-			    ("%s:  warning: netlink address truncated, len %d?\n",
-			     avc_prefix, nladdrlen);
-			ret = -1;
-			goto out;
-		}
+		(void)avc_netlink_process(buf);
+	}
+	return 0;
+}
 
-		if (nladdr.nl_pid) {
-			avc_log
-			    ("%s:  warning: received spoofed netlink packet from: %d\n",
-			     avc_prefix, nladdr.nl_pid);
-			continue;
-		}
+/* run routine for the netlink listening thread */
+void avc_netlink_loop(void)
+{
+	int rc;
+	char buf[1024];
 
-		if (ret == 0) {
-			avc_log("%s:  netlink thread: received EOF on socket\n",
-				avc_prefix);
-			goto out;
-		}
-
-		nlh = (struct nlmsghdr *)buf;
-
-		if (nlh->nlmsg_flags & MSG_TRUNC
-		    || nlh->nlmsg_len > (unsigned)ret) {
-			avc_log
-			    ("%s:  netlink thread: incomplete netlink message\n",
-			     avc_prefix);
-			goto out;
-		}
-
-		switch (nlh->nlmsg_type) {
-		case NLMSG_ERROR:{
-				struct nlmsgerr *err = NLMSG_DATA(nlh);
-
-				/* Netlink ack */
-				if (err->error == 0)
-					break;
-
-				avc_log("%s:  netlink thread: msg: error %d\n",
-					avc_prefix, -err->error);
-				goto out;
-			}
-
-		case SELNL_MSG_SETENFORCE:{
-				struct selnl_msg_setenforce *msg =
-				    NLMSG_DATA(nlh);
-				avc_log
-				    ("%s:  received setenforce notice (enforcing=%d)\n",
-				     avc_prefix, msg->val);
-				avc_enforcing = msg->val;
-				if (avc_enforcing && (ret = avc_ss_reset(0)) < 0) {
-					avc_log
-					    ("%s:  cache reset returned %d (errno %d)\n",
-					     avc_prefix, ret, errno);
-					goto out;
-				}
+	while (1) {
+		errno = 0;
+		rc = avc_netlink_receive(buf, sizeof(buf));
+		if (rc < 0) {
+			if (errno == 0 || errno == EINTR)
+				continue;
+			else {
+				avc_log("%s:  netlink recvfrom: error %d\n",
+					avc_prefix, errno);
 				break;
 			}
-
-		case SELNL_MSG_POLICYLOAD:{
-				struct selnl_msg_policyload *msg =
-				    NLMSG_DATA(nlh);
-				avc_log
-				    ("%s:  received policyload notice (seqno=%d)\n",
-				     avc_prefix, msg->seqno);
-				ret = avc_ss_reset(msg->seqno);
-				if (ret < 0) {
-					avc_log
-					    ("%s:  netlink thread: cache reset returned %d (errno %d)\n",
-					     avc_prefix, ret, errno);
-					goto out;
-				}
-				break;
-			}
-
-		default:
-			avc_log
-			    ("%s:  netlink thread: warning: unknown msg type %d\n",
-			     avc_prefix, nlh->nlmsg_type);
 		}
+
+		rc = avc_netlink_process(buf);
+		if (rc < 0)
+			break;
 	}
-      out:
+
 	close(fd);
 	avc_netlink_trouble = 1;
 	avc_log("%s:  netlink thread: errors encountered, terminating\n",

-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
