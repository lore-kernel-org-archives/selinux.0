Return-Path: <SRS0=dV66=BO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E87EC433DF
	for <selinux@archiver.kernel.org>; Tue,  4 Aug 2020 16:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CCB52086A
	for <selinux@archiver.kernel.org>; Tue,  4 Aug 2020 16:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="TPdcIHuG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbgHDQOw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 4 Aug 2020 12:14:52 -0400
Received: from mailomta28-re.btinternet.com ([213.120.69.121]:50883 "EHLO
        re-prd-fep-046.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726027AbgHDQOw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 4 Aug 2020 12:14:52 -0400
Received: from re-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.54.4])
          by re-prd-fep-046.btinternet.com with ESMTP
          id <20200804161446.CWAO4657.re-prd-fep-046.btinternet.com@re-prd-rgout-001.btmx-prd.synchronoss.net>;
          Tue, 4 Aug 2020 17:14:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1596557686; 
        bh=ExVoKoBDLRPBQ7OYLKXWkrSj+mcVY+yxKEg4T9oMJvs=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:MIME-Version;
        b=TPdcIHuGWnmlG3O/Cf4hQjbRKZb/aHbkcFoiaN6G57sp4wDgtA0BA9KgZ9b144+ntxbNd23XBRgS0Ik3bqLdMJQPllgLzRDLeefE966lBp/Up5IsVD0UAIcC13NZSSQpG/ww6WS8ywmc2d0njiL5SNjKo6NYO0+hTQYykToRN5Zo96seTeqlpq23BQ9O4+w1bbXljo/nDJfRoWBitDkG8AbuKgPuJTN+cBFBlCv6m28lCBHc9ddir22dhIYIxRX4r2NO0R7EeRbvzPkkzWb+DDUtgUjuMvExN/JTAUVcL+LC4P4TPCvHYBso+w2lQohRxsG8qp95mbfHp0yqNg5dqg==
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [86.184.61.65]
X-OWM-Source-IP: 86.184.61.65 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrjeeigdellecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkffuhffvffgjfhgtfggggfesthekredttderjeenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhephfekgeehuddugefgffekheehteetgfejudeghffhveeuvdevudehtdeljeekudevnecukfhppeekiedrudekgedriedurdeiheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddukeegrdeiuddrieehpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeophgruhhlsehprghulhdqmhhoohhrvgdrtghomheqpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (86.184.61.65) by re-prd-rgout-001.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9BDD00A51939D; Tue, 4 Aug 2020 17:14:46 +0100
Message-ID: <837e782ff80f69e8e4d44bc49ff2ced54b0aef2c.camel@btinternet.com>
Subject: Re: [RFC,selinux-notebook PATCH 05/18] xperm_rules: fully convert
 to markdown
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org
Date:   Tue, 04 Aug 2020 17:14:46 +0100
In-Reply-To: <159650482872.8961.7516871249534865160.stgit@sifl>
References: <159650470076.8961.12721446818345626943.stgit@sifl>
         <159650482872.8961.7516871249534865160.stgit@sifl>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4 (3.36.4-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, 2020-08-03 at 21:33 -0400, Paul Moore wrote:
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  src/xperm_rules.md |  138 ++++++++++++++++++++++++----------------
> ------------
>  1 file changed, 64 insertions(+), 74 deletions(-)
> 
> diff --git a/src/xperm_rules.md b/src/xperm_rules.md
> index 48beb41..21878ea 100644
> --- a/src/xperm_rules.md
> +++ b/src/xperm_rules.md
> @@ -2,8 +2,8 @@
>  
>  There are three extended AV rules implemented from Policy version 30
>  with the target platform 'selinux' that expand the permission sets
> from
> -a fixed 32 bits to permission sets in 256 bit increments:
> `allowxperm`,
> -`dontauditxperm`, `auditallowxperm` and `neverallowxperm`.
> +a fixed 32 bits to permission sets in 256 bit increments:
> *allowxperm*,
> +*dontauditxperm*, *auditallowxperm* and *neverallowxperm*.
>  
>  The rules for extended permissions are subject to the 'operation'
> they
>  perform with Policy version 30 and kernels from 4.3 supporting ioctl
> @@ -16,66 +16,59 @@ libsepol 2.7 minimum is required).
>  
>  **Where:**
>  
> -<table>
> -<tbody>
> -<tr>
> -<td><code>rule_name</code></td>
> -<td>The applicable <code>allowxperm</code>,
> <code>dontauditxperm</code>, <code>auditallowxperm</code> or
> <code>neverallowxperm</code> rule keyword.</td>
> -</tr>
> -<tr>
> -<td><p><code>source_type</code></p>
> -<p><code>target_type</code></p></td>
> -<td><p>One or more source / target <code>type</code>,
> <code>typealias</code> or <code>attribute</code> identifiers.
> Multiple entries consist of a space separated list enclosed in braces
> '{}'. Entries can be excluded from the list by using the negative
> operator '-'.</p>
> -<p>The target_type can have the <code>self</code> keyword instead of
> <code>type</code>, <code>typealias</code> or <code>attribute</code>
> identifiers. This means that the <code>target_type</code> is the same
> as the <code>source_type</code>.</p></td>
> -</tr>
> -<tr>
> -<td><code>class</code></td>
> -<td>One or more object classes. Multiple entries consist of a space
> separated list enclosed in braces '{}'.</td>
> -</tr>
> -<tr>
> -<td><code>operation<code></td>
> -<td>A key word defining the operation to be implemented by the rule.
> Currently only the <code>ioctl</code> operation is supported by the
> kernel policy language and kernel as described in the  <a
> href="#ioctl-operation-rules"><code>ioctl</code> Operation Rules</a>
> section.</td>
> -</tr>
> -<tr>
> -<td><code>xperm_set</code></td>
> -<td><p>One or more extended permissions represented by numeric
> values (i.e. <code>0x8900</code> or <code>35072</code>). The usage is
> dependent on the specified <em>operation</em>.</p>
> -<p>Multiple entries consist of a space separated list enclosed in
> braces '{}'.</p>
> -<p>The complement operator '~' is used to specify all permissions
> except those explicitly listed.</p>
> -<p>The range operator '-' is used to specify all permissions within
> the <code>low – high</code> range.</p>
> -<p>An example is shown in the <a href="#ioctl-operation-
> rules"><code>ioctl</code> Operation Rules</a> section.</p></td>
> -</tr>
> -</tbody>
> -</table>
> +*rule_name*
> +
> +The applicable *allowxperm*, *dontauditxperm*, *auditallowxperm*
> +or *neverallowxperm* rule keyword.
> +
> +*source_type*
> +
> +One or more source / target *type*, *typealias* or *attribute*
> identifiers.
> +Multiple entries consist of a space separated list enclosed in
> braces \'{}\'.
> +Entries can be excluded from the list by using the negative operator
> \'-\'.
> +
> +*target_type*
> +
> +The target_type can have the *self* keyword instead of *type*,
> *typealias* or
> +*attribute* identifiers. This means that the *target_type* is the
> same as the
> +*source_type*.
> +
> +*class*
> +
> +One or more object classes. Multiple entries consist of a space
> separated list
> +enclosed in braces \'{}\'.

I've had a rethink on this and wonder if it would be clearer if the
descriptions were a bullet list:

*class*

- One or more object classes. Multiple ...


> +
> +*operation*
> +
> +A key word defining the operation to be implemented by the rule.
> Currently only
> +the *ioctl* operation is supported by the kernel policy language and
> kernel as
> +described in the [*ioctl* Operation Rules](#ioctl-operation-rules)
> section.
> +
> +*xperm_set*
> +
> +One or more extended permissions represented by numeric values (i.e.
> *0x8900*
> +or *35072*). The usage is dependent on the specified *operation*.
> Multiple
> +entries consist of a space separated list enclosed in braces \'{}\'.
> The
> +complement operator \'\~\' is used to specify all permissions except
> those
> +explicitly listed. The range operator \'-\' is used to specify all
> permissions
> +within the *low – high* range. An example is shown in the
> +[*ioctl* Operation Rules](#ioctl-operation-rules) section.
>  
>  **The statement is valid in:**
>  
> -<table style="text-align:center">
> -<tbody>
> -<tr style="background-color:#D3D3D3;">
> -<td><strong>Monolithic Policy</strong></td>
> -<td><strong>Base Policy</strong></td>
> -<td><strong>Module Policy</strong></td>
> -</tr>
> -<tr>
> -<td>Yes</td>
> -<td>Yes</td>
> -<td>Yes</td>
> -</tr>
> -<tr style="background-color:#D3D3D3;">
> -<td><strong>Conditional Policy <code>if</code>
> Statement</strong></td>
> -<td><strong><code>optional</code> Statement</strong></td>
> -<td><strong><code>require</code> Statement</strong></td>
> -</tr>
> -<tr>
> -<td>No</td>
> -<td>No</td>
> -<td>No</td>
> -</tr>
> -</tbody>
> -</table>
> -<br>
> -
> -### `ioctl` Operation Rules
> +Policy Type
> +
> +| Monolithic Policy       | Base Policy             | Module
> Policy           |
> +| ----------------------- | ----------------------- | --------------
> --------- |
> +| Yes                     | Yes                     |
> Yes                     |
> +
> +Conditional Policy Statements
> +
> +| *if* statement          | *optional* Statement    | *require*
> Statement     |
> +| ----------------------- | ----------------------- | --------------
> --------- |
> +| No                      | No                      |
> No                      |
> +
> +### *ioctl* Operation Rules
>  
>  Use cases and implementation details for ioctl command whitelisting
> are
>  described in detail at
> @@ -85,14 +78,14 @@ policy format changes shown in the example below
> with a brief overview
>  the final upstream kernel patch).
>  
>  Ioctl calls are generally used to get or set device options. Policy
> -versions &lt; 30 only controls whether an `ioctl` permission is
> allowed
> -or not, for example this rule allows the object class `tcp_socket`
> the
> -`ioctl` permission:
> +versions &lt; 30 only controls whether an *ioctl* permission is
> allowed
> +or not, for example this rule allows the object class *tcp_socket*
> the
> +*ioctl* permission:
>  
>  `allow src_t tgt_t : tcp_socket ioctl;`
>  
>  From Policy version 30 it is possible to control ***ioctl**(2)*
> -'*request*' parameters provided the `ioctl` permission is also
> allowed,
> +'*request*' parameters provided the *ioctl* permission is also
> allowed,
>  for example:
>  
>  ```
> @@ -101,14 +94,14 @@ allow src_t tgt_t : tcp_socket ioctl;
>  allowxperm src_t tgt_t : tcp_socket ioctl ~0x8927;
>  ```
>  
> -The `allowxperm` rule states that all ioctl request parameters are
> +The *allowxperm* rule states that all ioctl request parameters are
>  allowed for the source/target/class with the exception of the value
> -`0x8927` that (using *include/linux/sockios.h*) is
> **SIOCGIFHWADDR**, or
> +*0x8927* that (using *include/linux/sockios.h*) is
> **SIOCGIFHWADDR**, or
>  'get hardware address'.
>  
>  An example audit log entry denying an ioctl request to add a routing
> -table entry (**SIOCADDRT** - `ioctlcmd=890b`) for *goldfish_setup*
> on a
> -`udp_socket` is:
> +table entry (**SIOCADDRT** - *ioctlcmd=890b*) for *goldfish_setup*
> on a
> +*udp_socket* is:
>  
>  ```
>  type=1400 audit(1437408413.860:6): avc: denied { ioctl } for pid=81
> @@ -121,18 +114,15 @@ Notes:
>  
>  1.  Important: The ioctl operation is not 'deny all' ioctl requests
>      (hence whitelisting). It is targeted at the specific
> -    source/target/class set of ioctl commands. As no other
> `allowxperm`
> +    source/target/class set of ioctl commands. As no other
> *allowxperm*
>      rules have been defined in the example, all other ioctl calls
> may
>      continue to use any valid request parameters (provided there are
> -    `allow` rules for the `ioctl` permission).
> +    *allow* rules for the *ioctl* permission).
>  2.  As the ***ioctl**(2)* function requires a file descriptor, its
> -    context must match the process context otherwise the `fd { use
> }`
> +    context must match the process context otherwise the *fd { use
> }*
>      class/permission is required.
>  3.  To deny all ioctl requests for a specific source/target/class
> the
> -    `xperm_set` should be set to `0` or `0x0`.
> -
> -
> -<br>
> +    *xperm_set* should be set to *0* or *0x0*.
>  
>  <!-- %CUTHERE% -->
>  
> 

