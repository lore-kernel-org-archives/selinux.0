Subject: Re: [PATCH] libsepol: Add missing return to sepol_node_query()
To: Petr Lautrbach <plautrba@redhat.com>, selinux@tycho.nsa.gov
References: <1468238367-31812-1-git-send-email-plautrba@redhat.com>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <19dc4f02-5270-af3c-b119-34c43115ff73@tycho.nsa.gov>
Date: Tue, 12 Jul 2016 14:31:47 -0400
MIME-Version: 1.0
In-Reply-To: <1468238367-31812-1-git-send-email-plautrba@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Unsubscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/options/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=unsubscribe>
List-Archive: <http://prometheus.infosec.tycho.ncsc.mil/pipermail/selinux/>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>
List-Subscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/listinfo/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=subscribe>

On 07/11/2016 07:59 AM, Petr Lautrbach wrote:
> Due to the missing return in sepol_node_query(), the function always
> set *response to NULL whenever a protocol was SEPOL_PROTO_IP6
>
> Fixes:
> sudo semanage node -a -M ::1 -p ipv6 -t node_t ::1
> sudo semanage node -m -M ::1 -p ipv6 -t node_t ::1
> [1]    12968 segmentation fault (core dumped)  semanage node -m -M ::1 -p ipv6 -t node_t ::1
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Applied.

Thanks,

> ---
>  libsepol/src/nodes.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/libsepol/src/nodes.c b/libsepol/src/nodes.c
> index 50cf21d..820346d 100644
> --- a/libsepol/src/nodes.c
> +++ b/libsepol/src/nodes.c
> @@ -273,6 +273,7 @@ int sepol_node_query(sepol_handle_t * handle,
>  							   c, SEPOL_PROTO_IP6,
>  							   response) < 0)
>  						goto err;
> +					return STATUS_SUCCESS;
>  				}
>  			}
>  			break;
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
