Message-ID: <53BD7645.8060407@tycho.nsa.gov>
Date: Wed, 09 Jul 2014 13:05:09 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Sven Vermeulen <sven.vermeulen@siphos.be>
Subject: Re: pcre compiled context files invalid with pcre updates?
References: <20140709151216.GA8142@siphos.be> <53BD5F61.1040405@tycho.nsa.gov>
 <20140709153657.GA8570@siphos.be>
In-Reply-To: <20140709153657.GA8570@siphos.be>
Content-Type: multipart/mixed; boundary="------------030303010903070303010509"
Cc: Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a multi-part message in MIME format.
--------------030303010903070303010509
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 07/09/2014 11:36 AM, Sven Vermeulen wrote:
> On Wed, Jul 09, 2014 at 11:27:29AM -0400, Stephen Smalley wrote:
>>> Do you think the above analysis makes sense? The bug linked earlier on has a
>>> gdb backtrace for those interested. Any other pointers that might help us
>>> troubleshoot this would be appreciated.
>>
>> When this came up in:
>> http://marc.info/?t=137192124100002&r=1&w=2
>> the solution was to add a trigger to the selinux-policy package to
>> always rebuild the policy (which includes regenerating the .bin file) on
>> pcre upgrades.
>>
>> Are you not doing that in Gentoo?
> 
> Not yet, we're exploring our options.
> 
> I was hoping the previous time was a one-off, but apparently it's not.
> 
>> The issue came up again in the context of cross-compiling in:
>> http://marc.info/?t=139275881100002&r=1&w=2
>> and there was a willingness to add a version but I don't think anyone
>> proposed a patch to do so.  But even with the version, using the PCRE
>> version effectively just means that you'll need to regenerate on each
>> new library version anyway, right?  So what do we gain versus the
>> current approach of regenerating on pcre updates?
> 
> There's a small period between the pcre upgrade and the selinux-policy
> update in which we'll get these failures again (and in Gentoo, the
> installation of selinux-policy will fail because a relabeling operation on
> the files would occur which will segfault - but that's something we need to
> tackle in Gentoo).

I see.  How about the attached patch then?



--------------030303010903070303010509
Content-Type: text/x-patch;
 name="0001-Add-pcre-version-string-to-the-compiled-file_context.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-Add-pcre-version-string-to-the-compiled-file_context.pa";
 filename*1="tch"

>From ac33098a807671204720aae97d6bcf6429d3fa92 Mon Sep 17 00:00:00 2001
From: Stephen Smalley <sds@tycho.nsa.gov>
Date: Wed, 9 Jul 2014 13:02:46 -0400
Subject: [PATCH] Add pcre version string to the compiled file_contexts format.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libselinux/src/label_file.c           | 13 +++++++++++++
 libselinux/src/label_file.h           |  4 +++-
 libselinux/utils/sefcontext_compile.c | 11 +++++++++++
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 615aea9..7879e2f 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -314,6 +314,19 @@ static int load_mmap(struct selabel_handle *rec, const char *path, struct stat *
 		return -1;
 	addr += sizeof(uint32_t);
 
+	if (*section_len >= SELINUX_COMPILED_FCONTEXT_PCRE_VERS) {
+		len = strlen(pcre_version());
+		plen = (uint32_t *)addr;
+		if (*plen > mmap_area->len)
+			return -1; /* runs off the end of the map */
+		if (len != *plen)
+			return -1; /* pcre version length mismatch */
+		addr += sizeof(uint32_t);
+		if (memcmp((char *)addr, pcre_version(), len))
+			return -1; /* pcre version content mismatch */
+		addr += *plen;
+	}
+
 	/* allocate the stems_data array */
 	section_len = (uint32_t *)addr;
 	addr += sizeof(uint32_t);
diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index 0aad3e7..2c6b897 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -6,7 +6,9 @@
 #include "label_internal.h"
 
 #define SELINUX_MAGIC_COMPILED_FCONTEXT	0xf97cff8a
-#define SELINUX_COMPILED_FCONTEXT_MAX_VERS	1
+#define SELINUX_COMPILED_FCONTEXT_NOPCRE_VERS	1
+#define SELINUX_COMPILED_FCONTEXT_PCRE_VERS	2
+#define SELINUX_COMPILED_FCONTEXT_MAX_VERS	2
 
 /* Prior to verison 8.20, libpcre did not have pcre_free_study() */
 #if (PCRE_MAJOR < 8 || (PCRE_MAJOR == 8 && PCRE_MINOR < 20))
diff --git a/libselinux/utils/sefcontext_compile.c b/libselinux/utils/sefcontext_compile.c
index 0adc968..b414b50 100644
--- a/libselinux/utils/sefcontext_compile.c
+++ b/libselinux/utils/sefcontext_compile.c
@@ -127,6 +127,8 @@ static int process_file(struct saved_data *data, const char *filename)
  *
  * u32 - magic number
  * u32 - version
+ * u32 - length of pcre version EXCLUDING nul
+ * char - pcre version string EXCLUDING nul
  * u32 - number of stems
  * ** Stems
  * 	u32  - length of stem EXCLUDING nul
@@ -172,6 +174,15 @@ static int write_binary_file(struct saved_data *data, int fd)
 	if (len != 1)
 		goto err;
 
+	/* write the pcre version */
+	section_len = strlen(pcre_version());
+	len = fwrite(&section_len, sizeof(uint32_t), 1, bin_file);
+	if (len != 1)
+		goto err;
+	len = fwrite(pcre_version(), sizeof(char), section_len, bin_file);
+	if (len != section_len)
+		goto err;
+
 	/* write the number of stems coming */
 	section_len = data->num_stems;
 	len = fwrite(&section_len, sizeof(uint32_t), 1, bin_file);
-- 
1.8.3.1


--------------030303010903070303010509--
