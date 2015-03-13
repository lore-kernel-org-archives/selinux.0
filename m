Message-ID: <5502E02C.7060306@tycho.nsa.gov>
Date: Fri, 13 Mar 2015 09:03:40 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Petr Lautrbach <plautrba@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] Fix -Wformat errors
References: <1426251329-23672-1-git-send-email-plautrba@redhat.com>
In-Reply-To: <1426251329-23672-1-git-send-email-plautrba@redhat.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/13/2015 08:55 AM, Petr Lautrbach wrote:
> Fixes two types of errors which appear when building with gcc-5.0.0
> 
> - format ‘%d’ expects argument of type ‘int’, but argument X has type ‘unsigned int’
> - format ‘%a’ expects argument of type ‘float *’, but argument X has type ‘char **’

%a is the dynamic allocation conversion specified in glibc, at least
prior to glibc 2.7, and is available if _GNU_SOURCE is specified (which
is set in CFLAGS in libselinux/src/Makefile).  So your change will break
on older glibc IIUC.

> 
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> ---
>  libselinux/src/avc.c                    | 4 ++--
>  libselinux/src/avc_internal.c           | 6 +++---
>  libselinux/src/avc_sidtab.c             | 2 +-
>  libselinux/src/label_android_property.c | 8 ++++----
>  libselinux/src/label_db.c               | 6 +++---
>  libselinux/src/label_file.c             | 8 ++++----
>  libselinux/src/label_media.c            | 4 ++--
>  libselinux/src/label_x.c                | 6 +++---
>  libselinux/src/matchpathcon.c           | 2 +-
>  libselinux/utils/sefcontext_compile.c   | 2 +-
>  libselinux/utils/togglesebool.c         | 2 +-
>  policycoreutils/newrole/newrole.c       | 2 +-
>  12 files changed, 26 insertions(+), 26 deletions(-)
> 
> diff --git a/libselinux/src/avc.c b/libselinux/src/avc.c
> index 2bd7d13..b1ec57f 100644
> --- a/libselinux/src/avc.c
> +++ b/libselinux/src/avc.c
> @@ -288,7 +288,7 @@ void avc_av_stats(void)
>  
>  	avc_release_lock(avc_lock);
>  
> -	avc_log(SELINUX_INFO, "%s:  %d AV entries and %d/%d buckets used, "
> +	avc_log(SELINUX_INFO, "%s:  %u AV entries and %d/%d buckets used, "
>  		"longest chain length %d\n", avc_prefix,
>  		avc_cache.active_nodes,
>  		slots_used, AVC_CACHE_SLOTS, max_chain_len);
> @@ -471,7 +471,7 @@ static int avc_insert(security_id_t ssid, security_id_t tsid,
>  
>  	if (ae->avd.seqno < avc_cache.latest_notif) {
>  		avc_log(SELINUX_WARNING,
> -			"%s:  seqno %d < latest_notif %d\n", avc_prefix,
> +			"%s:  seqno %u < latest_notif %u\n", avc_prefix,
>  			ae->avd.seqno, avc_cache.latest_notif);
>  		errno = EAGAIN;
>  		rc = -1;
> diff --git a/libselinux/src/avc_internal.c b/libselinux/src/avc_internal.c
> index f735e73..be94857 100644
> --- a/libselinux/src/avc_internal.c
> +++ b/libselinux/src/avc_internal.c
> @@ -125,14 +125,14 @@ static int avc_netlink_receive(char *buf, unsigned buflen, int blocking)
>  
>  	if (nladdrlen != sizeof nladdr) {
>  		avc_log(SELINUX_WARNING,
> -			"%s:  warning: netlink address truncated, len %d?\n",
> +			"%s:  warning: netlink address truncated, len %u?\n",
>  			avc_prefix, nladdrlen);
>  		return -1;
>  	}
>  
>  	if (nladdr.nl_pid) {
>  		avc_log(SELINUX_WARNING,
> -			"%s:  warning: received spoofed netlink packet from: %d\n",
> +			"%s:  warning: received spoofed netlink packet from: %u\n",
>  			avc_prefix, nladdr.nl_pid);
>  		return -1;
>  	}
> @@ -197,7 +197,7 @@ static int avc_netlink_process(char *buf)
>  	case SELNL_MSG_POLICYLOAD:{
>  		struct selnl_msg_policyload *msg = NLMSG_DATA(nlh);
>  		avc_log(SELINUX_INFO,
> -			"%s:  received policyload notice (seqno=%d)\n",
> +			"%s:  received policyload notice (seqno=%u)\n",
>  			avc_prefix, msg->seqno);
>  		rc = avc_ss_reset(msg->seqno);
>  		if (rc < 0) {
> diff --git a/libselinux/src/avc_sidtab.c b/libselinux/src/avc_sidtab.c
> index 52f21df..9669264 100644
> --- a/libselinux/src/avc_sidtab.c
> +++ b/libselinux/src/avc_sidtab.c
> @@ -124,7 +124,7 @@ void sidtab_sid_stats(struct sidtab *h, char *buf, int buflen)
>  	}
>  
>  	snprintf(buf, buflen,
> -		 "%s:  %d SID entries and %d/%d buckets used, longest "
> +		 "%s:  %u SID entries and %d/%d buckets used, longest "
>  		 "chain length %d\n", avc_prefix, h->nel, slots_used,
>  		 SIDTAB_SIZE, max_chain_len);
>  }
> diff --git a/libselinux/src/label_android_property.c b/libselinux/src/label_android_property.c
> index 8568784..1a29356 100644
> --- a/libselinux/src/label_android_property.c
> +++ b/libselinux/src/label_android_property.c
> @@ -101,7 +101,7 @@ static int process_line(struct selabel_handle *rec,
>  	items = sscanf(line_buf, "%255s %255s", prop, context);
>  	if (items != 2) {
>  		selinux_log(SELINUX_WARNING,
> -			    "%s:  line %d is missing fields, skipping\n", path,
> +			    "%s:  line %u is missing fields, skipping\n", path,
>  			    lineno);
>  		return 0;
>  	}
> @@ -111,7 +111,7 @@ static int process_line(struct selabel_handle *rec,
>  		spec_arr[nspec].property_key = strdup(prop);
>  		if (!spec_arr[nspec].property_key) {
>  			selinux_log(SELINUX_WARNING,
> -				    "%s:  out of memory at line %d on prop %s\n",
> +				    "%s:  out of memory at line %u on prop %s\n",
>  				    path, lineno, prop);
>  			return -1;
>  
> @@ -120,7 +120,7 @@ static int process_line(struct selabel_handle *rec,
>  		spec_arr[nspec].lr.ctx_raw = strdup(context);
>  		if (!spec_arr[nspec].lr.ctx_raw) {
>  			selinux_log(SELINUX_WARNING,
> -				    "%s:  out of memory at line %d on context %s\n",
> +				    "%s:  out of memory at line %u on context %s\n",
>  				    path, lineno, context);
>  			return -1;
>  		}
> @@ -128,7 +128,7 @@ static int process_line(struct selabel_handle *rec,
>  		if (rec->validating) {
>  			if (selabel_validate(rec, &spec_arr[nspec].lr) < 0) {
>  				selinux_log(SELINUX_WARNING,
> -					    "%s:  line %d has invalid context %s\n",
> +					    "%s:  line %u has invalid context %s\n",
>  					    path, lineno, spec_arr[nspec].lr.ctx_raw);
>  			}
>  		}
> diff --git a/libselinux/src/label_db.c b/libselinux/src/label_db.c
> index 999dd46..1b48735 100644
> --- a/libselinux/src/label_db.c
> +++ b/libselinux/src/label_db.c
> @@ -105,12 +105,12 @@ process_line(const char *path, char *line_buf, unsigned int line_num,
>  	 *   <object class> <object name> <security context>
>  	 */
>  	type = key = context = temp = NULL;
> -	items = sscanf(line_buf, "%as %as %as %as",
> +	items = sscanf(line_buf, "%ms %ms %ms %ms",
>  		       &type, &key, &context, &temp);
>  	if (items != 3) {
>  		if (items > 0)
>  			selinux_log(SELINUX_WARNING,
> -				    "%s:  line %d has invalid format, skipped",
> +				    "%s:  line %u has invalid format, skipped",
>  				    path, line_num);
>  		goto skip;
>  	}
> @@ -146,7 +146,7 @@ process_line(const char *path, char *line_buf, unsigned int line_num,
>  		spec->type = SELABEL_DB_DATATYPE;
>  	else {
>  		selinux_log(SELINUX_WARNING,
> -			    "%s:  line %d has invalid object type %s\n",
> +			    "%s:  line %u has invalid object type %s\n",
>  			    path, line_num, type);
>  		goto skip;
>  	}
> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> index 9d116eb..4563015 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
> @@ -170,10 +170,10 @@ static int process_line(struct selabel_handle *rec,
>  	/* Skip comment lines and empty lines. */
>  	if (*buf_p == '#' || *buf_p == 0)
>  		return 0;
> -	items = sscanf(line_buf, "%as %as %as", &regex, &type, &context);
> +	items = sscanf(line_buf, "%ms %ms %ms", &regex, &type, &context);
>  	if (items < 2) {
>  		COMPAT_LOG(SELINUX_WARNING,
> -			    "%s:  line %d is missing fields, skipping\n", path,
> +			    "%s:  line %u is missing fields, skipping\n", path,
>  			    lineno);
>  		if (items == 1)
>  			free(regex);
> @@ -204,7 +204,7 @@ static int process_line(struct selabel_handle *rec,
>  	spec_arr[nspec].stem_id = find_stem_from_spec(data, regex);
>  	spec_arr[nspec].regex_str = regex;
>  	if (rec->validating && compile_regex(data, &spec_arr[nspec], &errbuf)) {
> -		COMPAT_LOG(SELINUX_WARNING, "%s:  line %d has invalid regex %s:  %s\n",
> +		COMPAT_LOG(SELINUX_WARNING, "%s:  line %u has invalid regex %s:  %s\n",
>  			   path, lineno, regex, (errbuf ? errbuf : "out of memory"));
>  	}
>  
> @@ -214,7 +214,7 @@ static int process_line(struct selabel_handle *rec,
>  	if (type) {
>  		mode_t mode = string_to_mode(type);
>  		if (mode == (mode_t)-1) {
> -			COMPAT_LOG(SELINUX_WARNING, "%s:  line %d has invalid file type %s\n",
> +			COMPAT_LOG(SELINUX_WARNING, "%s:  line %u has invalid file type %s\n",
>  				   path, lineno, type);
>  			mode = 0;
>  		}
> diff --git a/libselinux/src/label_media.c b/libselinux/src/label_media.c
> index 227785f..a09486b 100644
> --- a/libselinux/src/label_media.c
> +++ b/libselinux/src/label_media.c
> @@ -44,10 +44,10 @@ static int process_line(const char *path, char *line_buf, int pass,
>  	/* Skip comment lines and empty lines. */
>  	if (*buf_p == '#' || *buf_p == 0)
>  		return 0;
> -	items = sscanf(line_buf, "%as %as ", &key, &context);
> +	items = sscanf(line_buf, "%ms %ms ", &key, &context);
>  	if (items < 2) {
>  		selinux_log(SELINUX_WARNING,
> -			  "%s:  line %d is missing fields, skipping\n", path,
> +			  "%s:  line %u is missing fields, skipping\n", path,
>  			  lineno);
>  		if (items == 1)
>  			free(key);
> diff --git a/libselinux/src/label_x.c b/libselinux/src/label_x.c
> index 896ef02..8435b76 100644
> --- a/libselinux/src/label_x.c
> +++ b/libselinux/src/label_x.c
> @@ -46,10 +46,10 @@ static int process_line(const char *path, char *line_buf, int pass,
>  	/* Skip comment lines and empty lines. */
>  	if (*buf_p == '#' || *buf_p == 0)
>  		return 0;
> -	items = sscanf(line_buf, "%as %as %as ", &type, &key, &context);
> +	items = sscanf(line_buf, "%ms %ms %ms ", &type, &key, &context);
>  	if (items < 3) {
>  		selinux_log(SELINUX_WARNING,
> -			    "%s:  line %d is missing fields, skipping\n", path,
> +			    "%s:  line %u is missing fields, skipping\n", path,
>  			    lineno);
>  		if (items > 0)
>  			free(type);
> @@ -76,7 +76,7 @@ static int process_line(const char *path, char *line_buf, int pass,
>  			data->spec_arr[data->nspec].type = SELABEL_X_POLYSELN;
>  		else {
>  			selinux_log(SELINUX_WARNING,
> -				    "%s:  line %d has invalid object type %s\n",
> +				    "%s:  line %u has invalid object type %s\n",
>  				    path, lineno, type);
>  			return 0;
>  		}
> diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathcon.c
> index 3b96b1d..5b495a0 100644
> --- a/libselinux/src/matchpathcon.c
> +++ b/libselinux/src/matchpathcon.c
> @@ -541,7 +541,7 @@ int compat_validate(struct selabel_handle *rec,
>  		if (rc < 0) {
>  			if (lineno) {
>  				COMPAT_LOG(SELINUX_WARNING,
> -					    "%s: line %d has invalid context %s\n",
> +					    "%s: line %u has invalid context %s\n",
>  						path, lineno, *ctx);
>  			} else {
>  				COMPAT_LOG(SELINUX_WARNING,
> diff --git a/libselinux/utils/sefcontext_compile.c b/libselinux/utils/sefcontext_compile.c
> index b359e1c..e6d93d4 100644
> --- a/libselinux/utils/sefcontext_compile.c
> +++ b/libselinux/utils/sefcontext_compile.c
> @@ -73,7 +73,7 @@ static int process_file(struct saved_data *data, const char *filename)
>  		spec->lr.ctx_raw = context;
>  		spec->mode = string_to_mode(mode);
>  		if (spec->mode == (mode_t)-1) {
> -			fprintf(stderr, "%s: line %d has invalid file type %s\n",
> +			fprintf(stderr, "%s: line %u has invalid file type %s\n",
>  				regex, line_num + 1, mode);
>  			spec->mode = 0;
>  		}
> diff --git a/libselinux/utils/togglesebool.c b/libselinux/utils/togglesebool.c
> index ad0d2a2..309f83b 100644
> --- a/libselinux/utils/togglesebool.c
> +++ b/libselinux/utils/togglesebool.c
> @@ -86,7 +86,7 @@ int main(int argc, char **argv)
>  					       argv[i], pwd->pw_name);
>  				else
>  					syslog(LOG_NOTICE,
> -					       "The %s policy boolean was toggled by uid:%d",
> +					       "The %s policy boolean was toggled by uid:%u",
>  					       argv[i], getuid());
>  
>  			}
> diff --git a/policycoreutils/newrole/newrole.c b/policycoreutils/newrole/newrole.c
> index 94794e9..02dee60 100644
> --- a/policycoreutils/newrole/newrole.c
> +++ b/policycoreutils/newrole/newrole.c
> @@ -278,7 +278,7 @@ static int process_pam_config(FILE * cfg)
>  			continue;
>  
>  		app = service = NULL;
> -		ret = sscanf(buffer, "%as %as\n", &app, &service);
> +		ret = sscanf(buffer, "%ms %ms\n", &app, &service);
>  		if (ret < 2 || !app || !service)
>  			goto err;
>  
> 
