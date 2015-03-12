Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t2CHYsZ0002667
 for <selinux@tycho.nsa.gov>; Thu, 12 Mar 2015 13:34:54 -0400
Received: by wesw55 with SMTP id w55so18010796wes.3
 for <selinux@tycho.nsa.gov>; Thu, 12 Mar 2015 10:34:39 -0700 (PDT)
Message-ID: <5501CE14.5060800@linaro.org>
Date: Thu, 12 Mar 2015 17:34:12 +0000
From: Julien Grall <julien.grall@linaro.org>
MIME-Version: 1.0
To: Daniel De Graaf <dgdegra@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: [Xen-devel] [PATCH 1/4] Expand Xen IOMEMCON to 64 bits
References: <1426180350-16259-1-git-send-email-dgdegra@tycho.nsa.gov>
 <1426180350-16259-2-git-send-email-dgdegra@tycho.nsa.gov>
In-Reply-To: <1426180350-16259-2-git-send-email-dgdegra@tycho.nsa.gov>
Content-Type: text/plain; charset=windows-1252
Cc: xen-devel@lists.xenproject.org
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi Daniel,

On 12/03/15 17:12, Daniel De Graaf wrote:
> diff --git a/libsepol/src/write.c b/libsepol/src/write.c
> index d03dc20..d98a5eb 100644
> --- a/libsepol/src/write.c
> +++ b/libsepol/src/write.c
> @@ -1252,13 +1252,24 @@ static int ocontext_write_xen(struct policydb_compat_info *info, policydb_t *p,
>  					return POLICYDB_ERROR;
>  				break;
>  			case OCON_XEN_IOMEM:
> -				buf[0] = c->u.iomem.low_iomem;
> -				buf[1] = c->u.iomem.high_iomem;
> -				for (j = 0; j < 2; j++)
> -					buf[j] = cpu_to_le32(buf[j]);
> -				items = put_entry(buf, sizeof(uint32_t), 2, fp);
> -				if (items != 2)
> -					return POLICYDB_ERROR;
> +				if (p->policyvers >= POLICYDB_XEN_VERSION_AARCH) {
> +					uint64_t b64[2];
> +					b64[0] = c->u.iomem.low_iomem;
> +					b64[1] = c->u.iomem.high_iomem;
> +					for (j = 0; j < 2; j++)
> +						b64[j] = cpu_to_le64(b64[j]);
> +					items = put_entry(b64, sizeof(uint64_t), 2, fp);
> +					if (items != 2)
> +						return POLICYDB_ERROR;
> +				} else {
> +					buf[0] = c->u.iomem.low_iomem;
> +					buf[1] = c->u.iomem.high_iomem;
> +					for (j = 0; j < 2; j++)
> +						buf[j] = cpu_to_le32(buf[j]);
> +					items = put_entry(buf, sizeof(uint32_t), 2, fp);
> +					if (items != 2)
> +						return POLICYDB_ERROR;

If low_iomem/high_iomem doesn't fit in an uint32_t it will be truncated
and therefore we may, by mistake, give access to wrong MMIO region.

Shouldn't we at least add a warning, if not throwing an error?

Regards,

-- 
Julien Grall
