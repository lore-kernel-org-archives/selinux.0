Message-ID: <1493391163.6177.3.camel@tycho.nsa.gov>
Subject: Re: [PATCH V2] libselinux: Add permissive= entry to avc audit log
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Richard Haines <richard_c_haines@btinternet.com>, selinux@tycho.nsa.gov
Date: Fri, 28 Apr 2017 10:52:43 -0400
In-Reply-To: <20170428130516.4021-1-richard_c_haines@btinternet.com>
References: <20170428130516.4021-1-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 2017-04-28 at 14:05 +0100, Richard Haines wrote:
> Add audit log entry to specify whether the decision was made in
> permissive mode/permissive domain or enforcing mode.
> 
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>

Thanks, applied.

> ---
> V2 changes: Remove utilities and follow the kernel way of detecting
> whether permissive or not.
> 
>  libselinux/src/avc.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/libselinux/src/avc.c b/libselinux/src/avc.c
> index b1ec57f..96b2678 100644
> --- a/libselinux/src/avc.c
> +++ b/libselinux/src/avc.c
> @@ -723,6 +723,10 @@ void avc_audit(security_id_t ssid, security_id_t
> tsid,
>  
>  	log_append(avc_audit_buf, " ");
>  	avc_dump_query(ssid, tsid, tclass);
> +
> +	if (denied)
> +		log_append(avc_audit_buf, " permissive=%u", result ?
> 0 : 1);
> +
>  	log_append(avc_audit_buf, "\n");
>  	avc_log(SELINUX_AVC, "%s", avc_audit_buf);
>  
