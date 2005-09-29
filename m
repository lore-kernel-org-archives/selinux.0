Subject: Re: seinfo and binary policy endianness
From: George Wilson <ltcgcw@us.ibm.com>
Reply-To: ltcgcw@us.ibm.com
To: SELinux <SELinux@tycho.nsa.gov>
Cc: Karl MacMillan <kmacmillan@tresys.com>,
   Emily Ratliff <ratliff@austin.ibm.com>
In-Reply-To: <20050929222619.GA21890@us.ibm.com>
References: <20050929222619.GA21890@us.ibm.com>
Content-Type: multipart/mixed; boundary="=-5EDXw0o73CkzgELdQY++"
Date: Thu, 29 Sep 2005 17:55:46 -0500
Message-Id: <1128034546.6256.15.camel@ea.austin.ibm.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-5EDXw0o73CkzgELdQY++
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2005-09-29 at 17:26 -0500, George Wilson wrote:
> Hello,
> 
> Our test team has run into a problem with seinfo on big endian platforms.
> Seinfo compares the unswapped SELINUX_MAGIC defined in borrowed.h with it's
> little endian counterpart at the top of the binary policy.  So it doesn't
> recognize binary policies.  It's easy enough to fix by #ifdef'ing swapped and
> unswapped definitions in borrrowed.h.  But shouldn't SELINUX_MAGIC be defined
> in a single place and used throughout to write and read the policy?
> 
> So, as a side issue, should one expect policies to be portable across
> platforms with differing endianness?  It may work--I haven't tried.  Portability
> would be useful for cross-compile environments, for analysis when one has no
> access to the platform that generated the policy, and for cross-platform
> deployment of a single binary policy.  It looks like binary policies are always
> little endian so portability may not be an issue.  I must test that.  Also,
> might it not be nice to have the policies in big endian (network byte order)?
> I know that would be busy work.  But big endian just feels right for portable
> files.
> 

Attached is Emily's patch, which is far more elegant than a borrowed.h
hack.  It seems like borrowed.h should really go away.

-- 
George Wilson
IBM Linux Technology Center
<ltcgcw@us.ibm.com>

--=-5EDXw0o73CkzgELdQY++
Content-Disposition: attachment; filename=setools-endian.patch
Content-Type: text/x-patch; name=setools-endian.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit

diff -Naur setools-1.5.1/libapol/binpol/binpol.c setools-1.5.1-fix/libapol/binpol/binpol.c
--- setools-1.5.1/libapol/binpol/binpol.c	2004-11-04 14:48:20.000000000 -0600
+++ setools-1.5.1-fix/libapol/binpol/binpol.c	2005-09-29 11:39:05.024200592 -0500
@@ -1435,6 +1435,7 @@
 	/* magic # and sz of policy string */
 	buf = ap_read_fbuf(fb, sizeof(__u32)*2, fp);
 	if(buf == NULL) { rt = fb->err; goto err_return; }
+	buf[0] = le32_to_cpu(buf[0]);
 	if (buf[0] != SELINUX_MAGIC) { rt = -2; goto err_return; }
 	
 	len = le32_to_cpu(buf[1]);
@@ -1740,6 +1741,7 @@
 	if(sz != 1)
 		rt = FALSE; /* problem reading file */
 
+	ubuf = le32_to_cpu(ubuf);
 	if(ubuf == SELINUX_MAGIC) 
 		rt = TRUE;
 	else
@@ -1773,6 +1775,7 @@
 	/* magic # and sz of policy string */
 	buf = ap_read_fbuf(fb, sizeof(__u32)*2, fp);
 	if (buf == NULL) { rt = fb->err; goto err_return; }
+	buf[0] = le32_to_cpu(buf[0]);
 	if (buf[0] != SELINUX_MAGIC) { rt = -2; goto err_return; }
 	
 	len = le32_to_cpu(buf[1]);

--=-5EDXw0o73CkzgELdQY++--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
