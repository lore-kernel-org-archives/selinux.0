Message-ID: <55101317.7020502@tresys.com>
Date: Mon, 23 Mar 2015 09:20:23 -0400
From: Steve Lawrence <slawrence@tresys.com>
MIME-Version: 1.0
To: Richard Haines <richard_c_haines@btinternet.com>, Daniel De Graaf
 <dgdegra@tycho.nsa.gov>, "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Re: [PATCH v3 0/3] Xen/FLASK policy updates for device contexts
References: <1426625004-7152-1-git-send-email-dgdegra@tycho.nsa.gov>
 <1426870746.22025.YahooMailNeo@web133202.mail.ir2.yahoo.com>
In-Reply-To: <1426870746.22025.YahooMailNeo@web133202.mail.ir2.yahoo.com>
Content-Type: text/plain; charset="windows-1252"
Cc: "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I think there may be a typo in the documentation update. It says:

Policy version 30 introduced the <literal><link
linkend="devicetreecon">context</link></literal>

Should "context" be "devicetreecon"?

Otherwise, this patch looks good to me.

As far as issue 2, I think I've tracked it down to an errant free() in
cil_destroy_devicetreecon. CIL uses string interning to reduce the
amount of memory used, so strings rarely need to be free'd. And if they
are, it results in a double free when the string intern pool is
destroyed. The below patch should fix it. Can you give it a test and
make sure it works for you?

- Steve


diff --git a/libsepol/cil/src/cil_build_ast.c
b/libsepol/cil/src/cil_build_ast.c
index 973b2d7..92c3e09 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -4583,8 +4583,6 @@ void cil_destroy_devicetreecon(struct
cil_devicetreecon *devicetreecon)
 		return;
 	}

-	free(devicetreecon->path);
-
 	if (devicetreecon->context_str == NULL && devicetreecon->context !=
NULL) {
 		cil_destroy_context(devicetreecon->context);
 	}



On 03/20/2015 12:59 PM, Richard Haines wrote:
> I've been testing this and found a few problems:
> 
> 1) I could not read a policy with sedispol (in the checkpolicy/test directory)
>     when the devicetreecon statement was included (checkpolicy built ok).
>     I've attached a patch that fixes this problem and included CIL Ref Guide
>    updates for the new features.
> 
> 2) When building policy with the CIL compiler secilc I get core dumps but
>     only if I include the devicetreecon statement. I think its related to not releasing
>     the devicetreepath "path" when sepol_policydb_free is called. I've been
>     trying to track it down and failed - any ideas !!!
>    sedispol will read the generated CIL policy with the above fix applied.
> 
> 
> Richard
> 
> 
> 
> ----- Original Message -----
>> From: Daniel De Graaf <dgdegra@tycho.nsa.gov>
>> To: selinux@tycho.nsa.gov
>> Cc: xen-devel@lists.xenproject.org
>> Sent: Tuesday, 17 March 2015, 20:43
>> Subject: [PATCH v3 0/3] Xen/FLASK policy updates for device contexts
>>
>> In order to support assigning security lables to ARM device tree nodes
>> in Xen's XSM policy, a new ocontext type is needed in the security
>> policy.
>>
>> In addition to adding the new ocontext, the existing I/O memory range
>> ocontext is expanded to 64 bits in order to support hardware with more
>> than 44 bits of physical address space (32-bit count of 4K pages).
>>
>> Changes from v2:
>> - Clean up printf format strings for 32-bit builds
>>
>> Changes from v1:
>> - Use policy version 30 instead of forking the version numbers for Xen;
>>    this removes the need for v1's patch 3.
>> - Report an error when attempting to use an I/O memory range that
>>    requires a 64-bit representation with an old policy output version
>>    that cannot support this
>> - Fix a few incorrect references to PCIDEVICECON
>> - Reorder patches to clarify the allowed characterset of device tree
>>    paths
>>
>> [PATCH 1/3] checkpolicy: Expand allowed character set in paths
>> [PATCH 2/3] libsepol, checkpolicy: widen Xen IOMEM ocontext entries
>> [PATCH 3/3] libsepol, checkpolicy: add device tree ocontext nodes to
>> _______________________________________________
>> Selinux mailing list
>> Selinux@tycho.nsa.gov
>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> To get help, send an email containing "help" to 
>> Selinux-request@tycho.nsa.gov.
>>
>>
>> _______________________________________________
>> Selinux mailing list
>> Selinux@tycho.nsa.gov
>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
