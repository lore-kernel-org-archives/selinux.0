Subject: Re: wrong magic number (using old sources)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux770@tortenboxer.de
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20070815154407.250820@gmx.net>
References: <20070810101003.128080@gmx.net>
	 <1186746338.7233.11.camel@moss-spartans.epoch.ncsc.mil>
	 <20070810121259.128050@gmx.net>
	 <1186748504.7233.34.camel@moss-spartans.epoch.ncsc.mil>
	 <20070810130703.128070@gmx.net>
	 <1186751971.7233.70.camel@moss-spartans.epoch.ncsc.mil>
	 <20070810141236.128070@gmx.net>  <20070811180730.308640@gmx.net>
	 <1187009718.26008.19.camel@moss-spartans.epoch.ncsc.mil>
	 <20070815154407.250820@gmx.net>
Content-Type: text/plain
Date: Wed, 15 Aug 2007 14:33:51 -0400
Message-Id: <1187202831.20485.66.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-08-15 at 17:44 +0200, selinux770@tortenboxer.de wrote:
> > Are you cross-compiling from a system with different endianness?
> Don't think so. I think both systems are little endian.
> 
> I played a little bit with the sources and i found a strange error:
> Actuallay, the generated magic number is correct. I checked that with an hex editor and also within the next_entry() method in private.h
> the buffer, the next_entry method returns is:
> buffer[0]: 8c
> buffer[1]: ff
> buffer[2]: 7c
> buffer[3]: f9
> buffer[4]: 8
> buffer[5]: 0
> buffer[6]: 0
> buffer[7]: 0
> 
> The method returns a void pointer, that is interpreted as an uint32_t (4 bytes) pointer (*buf). Printing the first two buffer entries now, i get:
> *** before conversion: buf[0] : 7cff8c
> ***  after conversion: buf[0] : 8c007cff
> *** before conversion: buf[1] : f9000008
> ***  after conversion: buf[1] : 8f90000
> 
> Whereas "before conversion" shows the hex interpretation of buf[i] before le32_to_cpu(buf[i]) is called, and "after conversion" shows the value afterwards. Something wents completely wrong. It seems like a 00 is added at the beginning of buf[0]. The magic number would be correct if we would drop this 00 and take the first byte of buf[1] instead. The strange thing is that, when i declare a 
>    char *tmpbuf;
> and set it to
>    tmpbuf=(char *)buf;
> the content is correct again:
> ***  buf as char: tmpbuf[0] : 8c
> ***  buf as char: tmpbuf[1] : ff
> ***  buf as char: tmpbuf[2] : 7c
> ***  buf as char: tmpbuf[3] : f9
> ***  buf as char: tmpbuf[4] : 8
> ***  buf as char: tmpbuf[5] : 0
> ***  buf as char: tmpbuf[6] : 0
> ***  buf as char: tmpbuf[7] : 0
> 
> I don't get the problem... why is
>          buf[0]     = (00) 7c ff 8c and
> (char *) buf[3...0] =  f9  7c ff 8c
> ?
> 
> This is obviously not an error within the selinux sources, but maybe you could help me anyway?!
> 
> Thanks in advance.

I suspect that what we are doing isn't safe/portable.

The corresponding kernel code was converted a while back to avoid
unaligned access problems, so possibly a similar transformation should
happen here.

See:
http://marc.info/?l=selinux&m=110252376515271&w=2

As a simple test of whether this is related, you might try the following
patch for libsepol (and then rebuild checkpolicy against the updated
libsepol) and see if it gets you past the magic number check.  If so,
then the next step would be to apply the same change to the entire
policydb_read code.

Index: libsepol/src/policydb.c
===================================================================
--- libsepol/src/policydb.c	(revision 2517)
+++ libsepol/src/policydb.c	(working copy)
@@ -2938,36 +2938,37 @@
 {
 
 	unsigned int i, j, r_policyvers;
-	uint32_t *buf, config;
+	uint32_t *buf, buf2[8], config;
 	size_t len, nprim, nel;
 	char *policydb_str, *target_str = NULL;
 	struct policydb_compat_info *info;
 	unsigned int policy_type, bufindex;
 	ebitmap_node_t *tnode;
+	int rc;
 
 	config = 0;
 
 	/* Read the magic number and string length. */
-	buf = next_entry(fp, sizeof(uint32_t) * 2);
-	if (!buf)
+	rc = next_entry2(buf2, fp, sizeof(uint32_t) * 2);
+	if (rc < 0)
 		return POLICYDB_ERROR;
 	for (i = 0; i < 2; i++)
-		buf[i] = le32_to_cpu(buf[i]);
+		buf2[i] = le32_to_cpu(buf2[i]);
 
-	if (buf[0] == POLICYDB_MAGIC) {
+	if (buf2[0] == POLICYDB_MAGIC) {
 		policy_type = POLICY_KERN;
 		target_str = POLICYDB_STRING;
-	} else if (buf[0] == POLICYDB_MOD_MAGIC) {
+	} else if (buf2[0] == POLICYDB_MOD_MAGIC) {
 		policy_type = POLICY_MOD;
 		target_str = POLICYDB_MOD_STRING;
 	} else {
 		ERR(fp->handle, "policydb magic number %#08x does not "
 		    "match expected magic number %#08x or %#08x",
-		    buf[0], POLICYDB_MAGIC, POLICYDB_MOD_MAGIC);
+		    buf2[0], POLICYDB_MAGIC, POLICYDB_MOD_MAGIC);
 		return POLICYDB_ERROR;
 	}
 
-	len = buf[1];
+	len = buf2[1];
 	if (len != strlen(target_str)) {
 		ERR(fp->handle, "policydb string length %zu does not match "
 		    "expected length %zu", len, strlen(target_str));
Index: libsepol/src/private.h
===================================================================
--- libsepol/src/private.h	(revision 2517)
+++ libsepol/src/private.h	(working copy)
@@ -64,6 +64,29 @@
 	return buffer;
 }
 
+static inline int next_entry2(void *buf, struct policy_file *fp, size_t bytes)
+{
+	size_t nread;
+
+	switch (fp->type) {
+	case PF_USE_STDIO:
+		nread = fread(buf, bytes, 1, fp->fp);
+		if (nread != 1)
+			return -1;
+		break;
+	case PF_USE_MEMORY:
+		if (bytes > fp->len)
+			return -1;
+		memcpy(buf, fp->data, bytes);
+		fp->data += bytes;
+		fp->len -= bytes;
+		break;
+	default:
+		return -1;
+	}
+	return 0;
+}
+
 static inline size_t put_entry(const void *ptr, size_t size, size_t n,
 			       struct policy_file *fp)
 {


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
