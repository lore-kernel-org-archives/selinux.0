Subject: Re: [PATCH] secilc: Update test policy and documentation for
 Infiniband
To: Richard Haines <richard_c_haines@btinternet.com>, selinux@tycho.nsa.gov
References: <20170612083140.5096-1-richard_c_haines@btinternet.com>
From: jwcart2 <jwcart2@tycho.nsa.gov>
Message-ID: <63821d1c-1823-b3ad-a94c-213581ac6770@tycho.nsa.gov>
Date: Mon, 12 Jun 2017 11:18:19 -0400
MIME-Version: 1.0
In-Reply-To: <20170612083140.5096-1-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/12/2017 04:31 AM, Richard Haines wrote:
> CIL updates to support the InfiniBand development.
> 
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>

I was just thinking about doing this myself. Applied.
Thanks,
Jim

> ---
>   secilc/docs/Makefile                     |  1 +
>   secilc/docs/README.md                    |  4 ++
>   secilc/docs/cil_infiniband_statements.md | 90 ++++++++++++++++++++++++++++++++
>   secilc/test/policy.cil                   |  6 +++
>   4 files changed, 101 insertions(+)
>   create mode 100644 secilc/docs/cil_infiniband_statements.md
> 
> diff --git a/secilc/docs/Makefile b/secilc/docs/Makefile
> index 52c7435..c0fa6b7 100644
> --- a/secilc/docs/Makefile
> +++ b/secilc/docs/Makefile
> @@ -23,6 +23,7 @@ FILE_LIST ?= cil_introduction.md \
>   	cil_sid_statements.md \
>   	cil_type_statements.md \
>   	cil_user_statements.md \
> +	cil_infiniband_statements.md \
>   	cil_xen_statements.md
>   
>   PANDOC_FILE_LIST = $(addprefix $(TMPDIR)/,$(FILE_LIST))
> diff --git a/secilc/docs/README.md b/secilc/docs/README.md
> index aada78f..3f1838e 100644
> --- a/secilc/docs/README.md
> +++ b/secilc/docs/README.md
> @@ -144,6 +144,10 @@ CIL (Common Intermediate Language)
>     * [selinuxuser](cil_user_statements.md#selinuxuser)
>     * [selinuxuserdefault](cil_user_statements.md#selinuxuserdefault)
>   
> +* [Infiniband Statements](cil_infiniband_statements.md#infiniband-statements)
> +  * [ibpkeycon](cil_infiniband_statements.md#ibpkeycon)
> +  * [ibendportcon](cil_infiniband_statements.md#ibendportcon)
> +
>   * [Xen Statements](cil_xen_statements.md#xen-statements)
>     * [iomemcon](cil_xen_statements.md#iomemcon)
>     * [ioportcon](cil_xen_statements.md#ioportcon)
> diff --git a/secilc/docs/cil_infiniband_statements.md b/secilc/docs/cil_infiniband_statements.md
> new file mode 100644
> index 0000000..38c15bd
> --- /dev/null
> +++ b/secilc/docs/cil_infiniband_statements.md
> @@ -0,0 +1,90 @@
> +Infiniband Statements
> +=====================
> +
> +To support access control for InfiniBand (IB) partitions and subnet management, security contexts are provided for: Partition Keys (Pkey) that are 16 bit numbers assigned to subnets and their IB end ports. An overview of the SELinux IB implementation can be found at: [http://marc.info/?l=selinux&m=149519833917911&w=2](http://marc.info/?l=selinux&m=149519833917911&w=2).
> +
> +ibpkeycon
> +---------
> +
> +Label IB partition keys. This may be a single key or a range.
> +
> +**Statement definition:**
> +
> +    (ibpkeycon subnet pkey|(pkey_low pkey_high)  context_id)
> +
> +**Where:**
> +
> +<table>
> +<colgroup>
> +<col width="25%" />
> +<col width="75%" />
> +</colgroup>
> +<tbody>
> +<tr class="odd">
> +<td align="left"><p><code>ibpkeycon</code></p></td>
> +<td align="left"><p>The <code>ibpkeycon</code> keyword.</p></td>
> +</tr>
> +<tr class="even">
> +<td align="left"><p><code>subnet</code></p>
> +<td align="left"><p>IP address in IPv6 format.</p>
> +</tr>
> +<tr class="odd">
> +<td align="left"><p><code>pkey | (pkey_low pkey_high)</code></p>
> +<td align="left"><p>A single partition key or a range of partition keys.</p>
> +</tr>
> +<tr class="even">
> +<td align="left"><p><code>context_id</code></p></td>
> +<td align="left"><p>A previously declared <code>context</code> identifier or an anonymous security context (<code>user role type levelrange</code>), the range MUST be defined whether the policy is MLS/MCS enabled or not.</p></td>
> +</tr>
> +</tbody>
> +</table>
> +
> +**Example:**
> +
> +An anonymous context for a partition key range of `0x0-0x10` assigned to an IPv6 subnet:
> +
> +    (ibpkeycon fe80:: (0 0x10) (system_u system_r kernel_t (low (s3 (cats01 cats02)))))
> +
> +
> +ibendportcon
> +------------
> +
> +Label IB end ports.
> +
> +**Statement definition:**
> +
> +    (ibendportcon device_id port context_id)
> +
> +**Where:**
> +
> +<table>
> +<colgroup>
> +<col width="27%" />
> +<col width="72%" />
> +</colgroup>
> +<tbody>
> +<tr class="odd">
> +<td align="left"><p><code>ibendportcon</code></p></td>
> +<td align="left"><p>The <code>ibendportcon</code> keyword.</p></td>
> +</tr>
> +<tr class="even">
> +<td align="left"><p><code>device_id</code></p>
> +<td align="left"><p>A single device identifier.</p>
> +</tr>
> +<tr class="odd">
> +<td align="left"><p><code>port</code></p>
> +<td align="left"><p>A single port number.</p>
> +</tr>
> +<tr class="even">
> +<td align="left"><p><code>context_id</code></p></td>
> +<td align="left"><p>A previously declared <code>context</code> identifier or an anonymous security context (<code>user role type levelrange</code>), the range MUST be defined whether the policy is MLS/MCS enabled or not.</p></td>
> +</tr>
> +</tbody>
> +</table>
> +
> +**Example:**
> +
> +A named context for device `mlx5_0` on port `1`:
> +
> +    (ibendportcon mlx5_0 1 system_u_bin_t_l2h)
> +
> diff --git a/secilc/test/policy.cil b/secilc/test/policy.cil
> index 2078399..4c37ecc 100644
> --- a/secilc/test/policy.cil
> +++ b/secilc/test/policy.cil
> @@ -282,6 +282,12 @@
>   	(pcidevicecon 345 system_u_bin_t_l2h)
>   	(devicetreecon "/this is/a/path" system_u_bin_t_l2h)
>   
> +	; InfiniBand
> +	(ibpkeycon fe80:: (0 0x10) system_u_bin_t_l2h)
> +	(ibpkeycon fe80::7629:afff:fe0f:8e5d (15 25) (system_u system_r kernel_t (low (s3 (cats01 cats02)))))
> +	(ibendportcon mlx5_0 1 system_u_bin_t_l2h)
> +	(ibendportcon mlx4_3 5 (system_u system_r kernel_t (low (s3 (cats01 cats02)))))
> +
>   	(constrain (files (read)) (not (or (and (eq t1 exec_t) (eq t2 bin_t)) (eq r1 r2))))
>   	(constrain char_w (not (or (and (eq t1 exec_t) (eq t2 bin_t)) (eq r1 r2))))
>   
> 


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
