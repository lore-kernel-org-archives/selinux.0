Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w2LIY6kQ008509
 for <selinux@tycho.nsa.gov>; Wed, 21 Mar 2018 14:34:06 -0400
Received: by mail-qt0-f180.google.com with SMTP id a20so6327416qtj.3
 for <selinux@tycho.nsa.gov>; Wed, 21 Mar 2018 11:33:50 -0700 (PDT)
To: Richard Haines <richard_c_haines@btinternet.com>, selinux@tycho.nsa.gov
References: <20180320174930.3207-1-richard_c_haines@btinternet.com>
From: Chris PeBenito <pebenito@ieee.org>
Message-ID: <c843f45f-7bbc-5d1b-d49e-91f31d9bbbd4@ieee.org>
Date: Wed, 21 Mar 2018 14:24:58 -0400
MIME-Version: 1.0
In-Reply-To: <20180320174930.3207-1-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH] setools: Add sctp portcon support
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/20/2018 01:49 PM, Richard Haines via Selinux wrote:
> Allow setools to interpret SCTP portcon policy statements
> 
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
>   libqpol/policy_define.c         | 2 ++
>   setools/policyrep/netcontext.py | 3 ++-
>   2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/libqpol/policy_define.c b/libqpol/policy_define.c
> index dcc69fc..bffe451 100644
> --- a/libqpol/policy_define.c
> +++ b/libqpol/policy_define.c
> @@ -4933,6 +4933,8 @@ int define_port_context(unsigned int low, unsigned int high)
>   		protocol = IPPROTO_UDP;
>   	} else if ((strcmp(id, "dccp") == 0) || (strcmp(id, "DCCP") == 0)) {
>   		protocol = IPPROTO_DCCP;
> +	} else if ((strcmp(id, "sctp") == 0) || (strcmp(id, "SCTP") == 0)) {
> +		protocol = IPPROTO_SCTP;
>   	} else {
>   		yyerror2("unrecognized protocol %s", id);
>   		goto bad;
> diff --git a/setools/policyrep/netcontext.py b/setools/policyrep/netcontext.py
> index c7076d2..1793677 100644
> --- a/setools/policyrep/netcontext.py
> +++ b/setools/policyrep/netcontext.py
> @@ -17,7 +17,7 @@
>   # License along with SETools.  If not, see
>   # <http://www.gnu.org/licenses/>.
>   #
> -from socket import AF_INET, AF_INET6, IPPROTO_TCP, IPPROTO_UDP, getprotobyname
> +from socket import AF_INET, AF_INET6, IPPROTO_TCP, IPPROTO_UDP, IPPROTO_SCTP, getprotobyname
>   from collections import namedtuple
>   from ipaddress import ip_address, ip_network
>   
> @@ -196,6 +196,7 @@ class PortconProtocol(int, PolicyEnum):
>       tcp = IPPROTO_TCP
>       udp = IPPROTO_UDP
>       dccp = IPPROTO_DCCP
> +    sctp = IPPROTO_SCTP
>   
>   
>   class Portcon(NetContext):

Thanks for the patch, but I'm reimplementing the SETools policyrep, so 
I've added the equivalent support already.

-- 
Chris PeBenito
