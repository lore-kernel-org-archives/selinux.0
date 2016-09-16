Subject: Re: [PATCH v3] libselinux: correct error path to always try text
To: william.c.roberts@intel.com, selinux@tycho.nsa.gov,
 seandroid-list@tycho.nsa.gov, jwcart2@tycho.nsa.gov
References: <1473981238-11051-1-git-send-email-william.c.roberts@intel.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <da997806-a400-6fc8-b736-a7aca1b1dea9@tycho.nsa.gov>
Date: Fri, 16 Sep 2016 10:30:07 -0400
MIME-Version: 1.0
In-Reply-To: <1473981238-11051-1-git-send-email-william.c.roberts@intel.com>
Content-Type: multipart/mixed; boundary="------------3E0E2FEC11390E2FECACF944"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a multi-part message in MIME format.
--------------3E0E2FEC11390E2FECACF944
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 09/15/2016 07:13 PM, william.c.roberts@intel.com wrote:
> From: William Roberts <william.c.roberts@intel.com>
> 
> patch 5e15a52aaa cleans up the process_file() but introduced
> a bug. If the binary file cannot be opened, always attempt
> to fall back to the textual file, this was not occurring.
> 
> The logic should be:
> 1. Open the newest file based on base path + suffix vs
>    base_path + suffix + ".bin".
> 2. If anything fails, attempt base_path + suffix.
> 
> In the case that the file_contexts was the newest file and
> used for processing fails, it will attempt the same failure
> recovery, which will fail. It was decided to keep it this
> was for simplicity.

I don't like the approach.  What we want is:
- if .bin file exists and is not older, try to load it,
- if any of the above fails (i.e. .bin file does not exist, is older, or
cannot be loaded for any reason), then load the text file.

We shouldn't try loading the text file twice.

Also, attached is checkpatch output for your patch.  Please fix.

> 
> Signed-off-by: William Roberts <william.c.roberts@intel.com>
> ---
>  libselinux/src/label_file.c | 41 +++++++++++++++++++++++++++--------------
>  1 file changed, 27 insertions(+), 14 deletions(-)
> 
> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> index 9faecdb..0dee059 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
> @@ -447,7 +447,7 @@ static bool fcontext_is_binary(FILE *fp)
>  #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
>  
>  static FILE *open_file(const char *path, const char *suffix,
> -		       char *save_path, size_t len, struct stat *sb)
> +		       char *save_path, size_t len, struct stat *sb, bool force_text)
>  {
>  	unsigned int i;
>  	int rc;
> @@ -469,7 +469,11 @@ static FILE *open_file(const char *path, const char *suffix,
>  		return NULL;
>  	}
>  
> -	for (i = 0; i < ARRAY_SIZE(fdetails); i++) {
> +	size_t array_size = ARRAY_SIZE(fdetails);
> +	if (force_text)
> +		array_size--;
> +
> +	for (i = 0; i < array_size; i++) {
>  
>  		/* This handles the case if suffix is null */
>  		path = rolling_append(stack_path, fdetails[i].suffix,
> @@ -515,24 +519,33 @@ static int process_file(const char *path, const char *suffix,
>  			  const char *prefix, struct selabel_digest *digest)
>  {
>  	int rc;
> +	unsigned int i;
>  	struct stat sb;
>  	FILE *fp = NULL;
>  	char found_path[PATH_MAX];
>  
> -	fp = open_file(path, suffix, found_path, sizeof(found_path), &sb);
> -	if (fp == NULL)
> -		return -1;
> +	/*
> +	 * first path open the newest modified file, if it fails, the second
> +	 * pass falls through to the plain text file.
> +	 */
> +	for(i=0; i < 2; i++) {
> +		fp = open_file(path, suffix, found_path, sizeof(found_path), &sb,
> +				i > 0);
> +		if (fp == NULL)
> +			return -1;
>  
> -	rc = fcontext_is_binary(fp) ?
> -			load_mmap(fp, sb.st_size, rec, found_path) :
> -			process_text_file(fp, prefix, rec, found_path);
> -	if (rc < 0)
> -		goto out;
> +		rc = fcontext_is_binary(fp) ?
> +				load_mmap(fp, sb.st_size, rec, found_path) :
> +				process_text_file(fp, prefix, rec, found_path);
> +		if (!rc)
> +			rc = digest_add_specfile(digest, fp, NULL, sb.st_size, found_path);
>  
> -	rc = digest_add_specfile(digest, fp, NULL, sb.st_size, found_path);
> -out:
> -	fclose(fp);
> -	return rc;
> +		fclose(fp);
> +
> +		if(!rc)
> +			return 0;
> +	}
> +	return -1;
>  }
>  
>  static void closef(struct selabel_handle *rec);
> 


--------------3E0E2FEC11390E2FECACF944
Content-Type: text/plain; charset=UTF-8;
 name="checkpatch.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="checkpatch.txt"

V0FSTklORzogbGluZSBvdmVyIDgwIGNoYXJhY3RlcnMKIzg0OiBGSUxFOiBsaWJzZWxpbnV4
L3NyYy9sYWJlbF9maWxlLmM6NDUwOgorCQkgICAgICAgY2hhciAqc2F2ZV9wYXRoLCBzaXpl
X3QgbGVuLCBzdHJ1Y3Qgc3RhdCAqc2IsIGJvb2wgZm9yY2VfdGV4dCkKCldBUk5JTkc6IE1p
c3NpbmcgYSBibGFuayBsaW5lIGFmdGVyIGRlY2xhcmF0aW9ucwojOTQ6IEZJTEU6IGxpYnNl
bGludXgvc3JjL2xhYmVsX2ZpbGUuYzo0NzM6CisJc2l6ZV90IGFycmF5X3NpemUgPSBBUlJB
WV9TSVpFKGZkZXRhaWxzKTsKKwlpZiAoZm9yY2VfdGV4dCkKCkVSUk9SOiBzcGFjZXMgcmVx
dWlyZWQgYXJvdW5kIHRoYXQgJz0nIChjdHg6VnhWKQojMTE3OiBGSUxFOiBsaWJzZWxpbnV4
L3NyYy9sYWJlbF9maWxlLmM6NTMxOgorCWZvcihpPTA7IGkgPCAyOyBpKyspIHsKIAkgICAg
IF4KCkVSUk9SOiBzcGFjZSByZXF1aXJlZCBiZWZvcmUgdGhlIG9wZW4gcGFyZW50aGVzaXMg
JygnCiMxMTc6IEZJTEU6IGxpYnNlbGludXgvc3JjL2xhYmVsX2ZpbGUuYzo1MzE6CisJZm9y
KGk9MDsgaSA8IDI7IGkrKykgewoKV0FSTklORzogbGluZSBvdmVyIDgwIGNoYXJhY3RlcnMK
IzExODogRklMRTogbGlic2VsaW51eC9zcmMvbGFiZWxfZmlsZS5jOjUzMjoKKwkJZnAgPSBv
cGVuX2ZpbGUocGF0aCwgc3VmZml4LCBmb3VuZF9wYXRoLCBzaXplb2YoZm91bmRfcGF0aCks
ICZzYiwKCldBUk5JTkc6IGxpbmUgb3ZlciA4MCBjaGFyYWN0ZXJzCiMxMzI6IEZJTEU6IGxp
YnNlbGludXgvc3JjL2xhYmVsX2ZpbGUuYzo1NDE6CisJCQlyYyA9IGRpZ2VzdF9hZGRfc3Bl
Y2ZpbGUoZGlnZXN0LCBmcCwgTlVMTCwgc2Iuc3Rfc2l6ZSwgZm91bmRfcGF0aCk7CgpFUlJP
Ujogc3BhY2UgcmVxdWlyZWQgYmVmb3JlIHRoZSBvcGVuIHBhcmVudGhlc2lzICcoJwojMTQw
OiBGSUxFOiBsaWJzZWxpbnV4L3NyYy9sYWJlbF9maWxlLmM6NTQ1OgorCQlpZighcmMpCgp0
b3RhbDogMyBlcnJvcnMsIDQgd2FybmluZ3MsIDY1IGxpbmVzIGNoZWNrZWQKCk5PVEU6IEZv
ciBzb21lIG9mIHRoZSByZXBvcnRlZCBkZWZlY3RzLCBjaGVja3BhdGNoIG1heSBiZSBhYmxl
IHRvCiAgICAgIG1lY2hhbmljYWxseSBjb252ZXJ0IHRvIHRoZSB0eXBpY2FsIHN0eWxlIHVz
aW5nIC0tZml4IG9yIC0tZml4LWlucGxhY2UuCgouLi9bUEFUQ0ggdjNdIGxpYnNlbGludXg6
IGNvcnJlY3QgZXJyb3IgcGF0aCB0byBhbHdheXMgdHJ5IHRleHQuZW1sIGhhcyBzdHlsZSBw
cm9ibGVtcywgcGxlYXNlIHJldmlldy4KCk5PVEU6IElmIGFueSBvZiB0aGUgZXJyb3JzIGFy
ZSBmYWxzZSBwb3NpdGl2ZXMsIHBsZWFzZSByZXBvcnQKICAgICAgdGhlbSB0byB0aGUgbWFp
bnRhaW5lciwgc2VlIENIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCg==
--------------3E0E2FEC11390E2FECACF944--
