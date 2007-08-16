Subject: Re: wrong magic number (using old sources)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux770@tortenboxer.de
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20070816080523.135750@gmx.net>
References: <20070810101003.128080@gmx.net>
	 <1186746338.7233.11.camel@moss-spartans.epoch.ncsc.mil>
	 <20070810121259.128050@gmx.net>
	 <1186748504.7233.34.camel@moss-spartans.epoch.ncsc.mil>
	 <20070810130703.128070@gmx.net>
	 <1186751971.7233.70.camel@moss-spartans.epoch.ncsc.mil>
	 <20070810141236.128070@gmx.net>  <20070811180730.308640@gmx.net>
	 <1187009718.26008.19.camel@moss-spartans.epoch.ncsc.mil>
	 <20070815154407.250820@gmx.net>
	 <1187202831.20485.66.camel@moss-spartans.epoch.ncsc.mil>
	 <20070816080523.135750@gmx.net>
Content-Type: text/plain
Date: Thu, 16 Aug 2007 08:59:24 -0400
Message-Id: <1187269164.909.8.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-16 at 10:05 +0200, selinux770@tortenboxer.de wrote:
> > I suspect that what we are doing isn't safe/portable.
> > 
> > The corresponding kernel code was converted a while back to avoid
> > unaligned access problems, so possibly a similar transformation should
> > happen here.
> > 
> > See:
> > http://marc.info/?l=selinux&m=110252376515271&w=2
> > 
> > As a simple test of whether this is related, you might try the following
> > patch for libsepol (and then rebuild checkpolicy against the updated
> > libsepol) and see if it gets you past the magic number check.  If so,
> > then the next step would be to apply the same change to the entire
> > policydb_read code.
> 
> That's it. After applying the changes in source code i get past the magic number check. Now, my policyversion number is wrong but i would suggest, that this error is related to the problem you described. I included also a printf for buf2[] to check the values after conversion:
> # make
> ( cd domains/program/ ; for n in *.te ; do echo "define(\`$n')"; done ) > tmp/program_used_flags.te.tmp
> ( cd domains/misc/ ; for n in *.te ; do echo "define(\`$n')"; done ) >> tmp/program_used_flags.te.tmp
> mv tmp/program_used_flags.te.tmp tmp/program_used_flags.te
> Building policy.conf ...
> [...] > policy.conf.tmp
> Building file contexts files...
> /usr/bin/checkpolicy  -o policy.20 policy.conf
> /usr/bin/checkpolicy:  loading policy configuration from policy.conf
> /usr/bin/checkpolicy:  policy configuration loaded
> /usr/bin/checkpolicy:  writing binary representation (version 21) to policy.20
> Validating file contexts files ...
> /usr/sbin/setfiles -q -c policy.20 file_contexts/file_contexts
>  buf2[0]: f97cff8c
>  buf2[1]: 8
>  buf2[2]: bea60574
>  buf2[3]: bea60560
>  buf2[4]: 4004a304
>  buf2[5]: 400469a4
>  buf2[6]: 0
>  buf2[7]: 400a26f0
> libsepol.policydb_read: policydb version 352321536 does not match my version range 15-21
> libsepol.sepol_set_policydb_from_file: can't read binary policy: Success
> Error reading policy policy.20: Success
> make: *** [policy.20] Error 1
> 
> I think it is only necessary to declare unint32_t buf2[] of size 2 and not 8, isn't it?

Ok, so libsepol needs to be fixed in the same way the kernel was to
eliminate unaligned accesses.  Might take a little bit to work through
all the code.  The size of the buffer has to be large enough for the
largest next_entry() request.

As a possible short term work around, you might try this patch instead.
It just converts the static buffer used within libsepol from unsigned
char to uint32_t so that the buffer will be aligned (at least for u32).
That avoids changing all the callers.

Index: libsepol/src/private.h
===================================================================
--- libsepol/src/private.h	(revision 2517)
+++ libsepol/src/private.h	(working copy)
@@ -5,6 +5,7 @@
 #include <byteswap.h>
 #include <endian.h>
 #include <sepol/policydb/policydb.h>
+#include <stdint.h>
 
 #if __BYTE_ORDER == __LITTLE_ENDIAN
 #define cpu_to_le16(x) (x)
@@ -39,7 +40,7 @@
 /* Reading from a policy "file". */
 static inline void *next_entry(struct policy_file *fp, size_t bytes)
 {
-	static unsigned char buffer[BUFSIZ];
+	static uint32_t buffer[20];
 	size_t nread;
 
 	if (bytes > sizeof buffer)

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
