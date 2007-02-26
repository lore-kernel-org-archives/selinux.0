Subject: Re: I think this is equivalent to what we have
	now	and	more	efficient.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve Grubb <sgrubb@redhat.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200702260944.35571.sgrubb@redhat.com>
References: <45DDAA80.80603@redhat.com>
	 <200702251436.38681.sgrubb@redhat.com>
	 <1172498136.19041.198.camel@moss-spartans.epoch.ncsc.mil>
	 <200702260944.35571.sgrubb@redhat.com>
Content-Type: text/plain
Date: Mon, 26 Feb 2007 09:58:25 -0500
Message-Id: <1172501905.19041.223.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-02-26 at 09:44 -0500, Steve Grubb wrote:
> > I think we'd want a separate selinuxfs node for that purpose to avoid
> > ambiguity between the presently loaded version and the maximum supported
> > one.
> 
> Agreed. (I would have thought this capability already existed. Otherwise 
> setstatus is just taking a wild guess and not basing its output on fact.) 
> What do you want to call this new node? loaded_policy_version?

I had a patch for it back in early 2005, called it "loadpolicyvers".
But I was only using it for testing, and we didn't have a real user for
it at the time.  It would have to be re-based.

Index: linux-2.6/security/selinux/selinuxfs.c
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/selinuxfs.c,v
retrieving revision 1.51
diff -u -p -r1.51 selinuxfs.c
--- linux-2.6/security/selinux/selinuxfs.c	2 Dec 2004 15:21:42 -0000	1.51
+++ linux-2.6/security/selinux/selinuxfs.c	14 Jan 2005 14:53:35 -0000
@@ -72,6 +72,7 @@ enum sel_inos {
 	SEL_DISABLE,	/* disable SELinux until next reboot */
 	SEL_AVC,	/* AVC management directory */
 	SEL_MEMBER,	/* compute polyinstantiation membership decision */
+	SEL_LOADPOLICYVERS,	/* return loaded policy version */
 };
 
 #define TMPBUFLEN	12
@@ -194,6 +195,23 @@ static struct file_operations sel_policy
 	.read		= sel_read_policyvers,
 };
 
+
+extern unsigned int policydb_loaded_version;
+
+static ssize_t sel_read_loadpolicyvers(struct file *filp, char __user *buf,
+				       size_t count, loff_t *ppos)
+{
+	char tmpbuf[TMPBUFLEN];
+	ssize_t length;
+
+	length = scnprintf(tmpbuf, TMPBUFLEN, "%u", policydb_loaded_version);
+	return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
+}
+
+static struct file_operations sel_loadpolicyvers_ops = {
+	.read		= sel_read_loadpolicyvers,
+};
+
 /* declaration for sel_write_load */
 static int sel_make_bools(void);
 
@@ -1182,6 +1200,7 @@ static int sel_fill_super(struct super_b
 		[SEL_MLS] = {"mls", &sel_mls_ops, S_IRUGO},
 		[SEL_DISABLE] = {"disable", &sel_disable_ops, S_IWUSR},
 		[SEL_MEMBER] = {"member", &transaction_ops, S_IRUGO|S_IWUGO},
+		[SEL_LOADPOLICYVERS] = {"loadpolicyvers", &sel_loadpolicyvers_ops, S_IRUGO},
 		/* last one */ {""}
 	};
 	ret = simple_fill_super(sb, SELINUX_MAGIC, selinux_files);

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
