Return-Path: <SRS0=P1AD=VJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0981EC742D7
	for <selinux@archiver.kernel.org>; Fri, 12 Jul 2019 20:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9E3020989
	for <selinux@archiver.kernel.org>; Fri, 12 Jul 2019 20:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="UlqOi14i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbfGLUV6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 12 Jul 2019 16:21:58 -0400
Received: from usfb19pa16.eemsg.mail.mil ([214.24.26.87]:39698 "EHLO
        usfb19pa16.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727536AbfGLUV6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 12 Jul 2019 16:21:58 -0400
X-EEMSG-check-017: 218359944|USFB19PA16_EEMSG_MP12.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by usfb19pa16.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 12 Jul 2019 20:21:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1562962915; x=1594498915;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Oqp5T1ZSHZDqbEAUKE4fbiaD32+09ELK753w8tWa+tc=;
  b=UlqOi14iaekxN2FiEOm5lWK6lSHCHN6aiBsIvZ7zDG7QXVpgcuACmMtM
   iu12stFkNVZ/7SBv5ppN8qIOePzpY7/F0pK0YT5iSVFUuDK/VH1jMiloP
   ySSzw3SLEx1HxjncRasy3skLHwDZ6IPD/GGZFDPzWhcyVHhNPR3P7sraM
   vQWbL/VXiNSk4uGGWCoRZ2UlV4FIwFKXr7x6M/hvs3JPwqUn2e8FPOqGh
   pznXmAprwBp26pbKqFqAu0UzFw5+cLU+ergC+bI2OjauvtowP+C5dnO0x
   1oqUsMsagMuc3+dM90Xf3qMAZA60q9h5Ktgh47r8E0xn+X5q8GBNuJS6Z
   g==;
X-IronPort-AV: E=Sophos;i="5.63,483,1557187200"; 
   d="scan'208";a="25666980"
IronPort-PHdr: =?us-ascii?q?9a23=3A6kiCuhQ8Xx1083p3+ERHcCEQC9psv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa67YBWCt8tkgFKBZ4jH8fUM07OQ7/m6HzFYqs/d7DgrS99lb1?=
 =?us-ascii?q?c9k8IYnggtUoauKHbQC7rUVRE8B9lIT1R//nu2YgB/Ecf6YEDO8DXptWZBUh?=
 =?us-ascii?q?rwOhBoKevrB4Xck9q41/yo+53Ufg5EmCexbal9IRmrswndrMkbjZdtJqosxR?=
 =?us-ascii?q?bErWZDdvhLy29vOV+dhQv36N2q/J5k/SRQuvYh+NBFXK7nYak2TqFWASo/PW?=
 =?us-ascii?q?wt68LlqRfMTQ2U5nsBSWoWiQZHAxLE7B7hQJj8tDbxu/dn1ymbOc32Sq00WS?=
 =?us-ascii?q?in4qx2RhLklDsLOjgk+2zMlMd+kLxUrw6gpxxnwo7bfoeVNOZlfqjAed8WXH?=
 =?us-ascii?q?dNUtpNWyBEBI6zYZEPD+4cNuhGqYfzqUYFoR+nCQSsAO7jzzlFjWL006Inye?=
 =?us-ascii?q?QsCRzI0hIuH9wOs3raotv6O6gQXu+pw6fF1inDYvBM1Dvh9ITFfBIsrPeRVr?=
 =?us-ascii?q?xwa8rRzkwvGhvYgFWMt4PlJzOV2foLs2OG8uRgUPigi2ojqw5vojmk28Ahip?=
 =?us-ascii?q?LUiYIO0V3E6SV4z5o1Jd2/UkJ7Z8WkH4FKuyGVMIt2XNovTmd1syg50r0LoY?=
 =?us-ascii?q?O3cScFxZg9xxPTduaLf5aH7x79TuqdPDF1j29/dr2lnRa9602gx/X5VsmzzV?=
 =?us-ascii?q?lFsDJIksLJtnARzxzT7dWHSudl8kehxzmP0wfT5/lYIU8uj6rbKoMhwqUqmp?=
 =?us-ascii?q?oPsUXMAi/2mELsgK+Qakok4fSn5/7iYrXnop+QL450igfgPaQygsGzHOs1Pw?=
 =?us-ascii?q?cUU2Wb5OiwzqPv8ELnTLlQk/E6iqzZv4rbJcQfqK65GQhV0oM75hakEjimy8?=
 =?us-ascii?q?8VnWUHLV1ZeBKHiJLlO1fVIP/iF/u/jFOskClzy/DcIrLhGonNLmTEkLr5Yb?=
 =?us-ascii?q?ly8VVcxxQzzN1E/JJbFrEBL+juWk//sNzXEAU5PxWozOn9EtlyyoQeWWeXCK?=
 =?us-ascii?q?+DLKzSqUOI5v4oI+SUfI8aoiv9K/w+6v72l3A5hFsdcbCs3ZsQb3C4BOppL1?=
 =?us-ascii?q?+Fbnrrh9cLCX0KsRYmTOz2lF2CViZeZ22sUKI45zE7Dp+mDIjYS4Czj7yOwj?=
 =?us-ascii?q?27EodVZm9YEFCMF2nnd4GeV/cLciKSLddrkiYYWri5V48hyRauuRf+y7pmKO?=
 =?us-ascii?q?rU5yIZuYv41Ndr++LTiAsy9T1oD8Wdym2NSmZ0kX4VRz8ywq9yulJ9ylid3q?=
 =?us-ascii?q?himfBYFsJc5+lPUggkMZ7Q1et6C8r9WgjZZNeGVE6mQsm6ATE2Vt8xx8IOY1?=
 =?us-ascii?q?p6G9i5lB/D2jClDKMPmLyTBZw07rjT33zrK8Z71XnGyLErj0M6TctXKW2mmq?=
 =?us-ascii?q?l/+hDRB47MlEWZjbyqdaUH3CPW8meM12+Os19ZUAJqVqXFR38fbFPMrdvl/k?=
 =?us-ascii?q?PCU6OuCbM/PwtC18GNNLBKZcHujVVBR/fuI8jRY2Krm2e3ABaIx66MbI/wd2?=
 =?us-ascii?q?UaxiXdB1AOkxoP8naeKQg+GiChrnrFDDNwD1LvbF3j/PJ+qHyhSk80ywGLb0?=
 =?us-ascii?q?t727Wp/R4VgOSWS+kP0bIcpCchtzJ0EU6/39LRC9qAoRBtfKdbYdM9+lhH03?=
 =?us-ascii?q?nZuBJ7PpG7M69tnFgecwNxv0Pvyxp4EIFAndI2o3MtyQp4MbiY309ZdzOEwZ?=
 =?us-ascii?q?DwPaXaKmz1/BC1d67W3Vfe0NON96gT6PQ4sVLjvASoFko/9nVryd5V02GT5s?=
 =?us-ascii?q?aCMA1HepvqX1d/zBN6rqzUZiQnr9ff3GZhIIGvuT/LxtwtCfFgwR/mdNBaZu?=
 =?us-ascii?q?fMMg75E8oeDtPmBvYjnVOqJkYCPO5I/ahuF9+3fPuBnqiwNaBvmyzwySxf6Z?=
 =?us-ascii?q?15+lqF6i45T+nPxZtDyPadjSWdUDKpt0usqsD6n8h/YDgWGmeugXz/CJV5er?=
 =?us-ascii?q?x5fYFND3ynZcKw2IMt1NbWR3dE+Qv7VBs908izdE/XNgGs0A=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2DfAACE6ihd/wHyM5BbCh0BAQUBBwUBgVYFAQsBgWcFK?=
 =?us-ascii?q?oFuhESTMAEBAQEBAQaBCS2JYIl9hTGBZwkBAQEBAQEBAQE0AQIBAYRAAoJWI?=
 =?us-ascii?q?zcGDgEDAQEBBAEBAQEEAQFshUiCOikBgmYBAQEBAgEjDwEFNAoDEAsYAgIRF?=
 =?us-ascii?q?QICVwYBDAgBAYJfP4F3BQ+rcYEyhUeDMoFHgQwoAYteF3iBB4E4gjY1PoN/G?=
 =?us-ascii?q?mqCS4JYBIxRnhEJghuCH5FmBhuCLIswiistjQeZWyKBWCsIAhgIIQ+DKIJ3j?=
 =?us-ascii?q?ikjA4E2AQGPYgEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 12 Jul 2019 20:21:53 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x6CKLpkR025123;
        Fri, 12 Jul 2019 16:21:51 -0400
Subject: Re: [RFC PATCH] security, capability: pass object information to
 security_capable
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Nicholas Franck <nhfran2@tycho.nsa.gov>, paul@paul-moore.com
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        luto@amacapital.net, jmorris@namei.org, keescook@chromium.org,
        serge@hallyn.com, john.johansen@canonical.com, mortonm@chromium.org
References: <20190712173404.14417-1-nhfran2@tycho.nsa.gov>
 <680c35a8-1ee5-725d-b33c-7bdced39763c@schaufler-ca.com>
 <e8de4a1c-7e18-fc20-e372-67bbaa93fd42@tycho.nsa.gov>
 <16cade37-9467-ca7f-ddea-b8254c501f48@schaufler-ca.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <4fb3a599-b1d8-7cc2-759a-02195251e344@tycho.nsa.gov>
Date:   Fri, 12 Jul 2019 16:21:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <16cade37-9467-ca7f-ddea-b8254c501f48@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 7/12/19 3:54 PM, Casey Schaufler wrote:
> On 7/12/2019 11:25 AM, Stephen Smalley wrote:
>> On 7/12/19 1:58 PM, Casey Schaufler wrote:
>>> On 7/12/2019 10:34 AM, Nicholas Franck wrote:
>>>> At present security_capable does not pass any object information
>>>> and therefore can neither audit the particular object nor take it
>>>> into account. Augment the security_capable interface to support
>>>> passing supplementary data. Use this facility initially to convey
>>>> the inode for capability checks relevant to inodes. This only
>>>> addresses capable_wrt_inode_uidgid calls; other capability checks
>>>> relevant to inodes will be addressed in subsequent changes. In the
>>>> future, this will be further extended to pass object information for
>>>> other capability checks such as the target task for CAP_KILL.
>>>
>>> This seems wrong to me. The capability system has nothing to do
>>> with objects. Passing object information through security_capable()
>>> may be convenient, but isn't relevant to the purpose of the interface.
>>> It appears that there are very few places where the object information
>>> is actually useful.
>>
>> A fair number of capabilities are checked upon some attempted object access (often right after comparing UIDs or other per-object state), and the particular object can be very helpful in both audit and in access control.  More below.
> 
> I'm not disagreeing with that. What I'm saying is that the capability
> check interface is not the right place to pass that information. The
> capability check has no use for the object information. I would much
> rather see a security_pass_object_data() hook that gets called after
> (or before) the security_capable() hook in the places where you want
> the extra information.

I don't see how that would work or be advantageous.  Within the capable 
hook, the security module(s) decide whether or not to allow the 
capability, and generate any relevant LSM audit records.  It is 
precisely at those two points (deciding and auditing) that we need the 
information; both occur within the existing capable hooks.  Calling a 
separate hook before the capable call and e.g. saving the information in 
the task security structure for later consumption during the capable 
call offers only overhead, no benefit.  Calling a separate hook after 
the capable call is too late to be of use - the decision and auditing 
are already done.  And both hooks would be invoked from precisely the 
same function at the same point.  If the information wasn't already 
readily available at the point of the hook call, it might be a different 
matter, but that isn't the case here.

> 
>>>> In SELinux this new information is leveraged here to include the inode
>>>> in the audit message. In the future, it could also be used to perform
>>>> a per inode capability checks.
>>>
>>> I suggest that you want a mechanism for adding the inode information
>>> to the audit record instead.
>>
>> That is part of what we want, but not the entire picture.  But with respect to audit, the problem today is that one sees SELinux dac_read_search, dac_override, etc denials with no indication as to the particular file, which is unfortunate both from a security auditing perspective and from a policy development perspective.
> 
> I can see how that is a problem.
> 
>> The only option today to gain that information is by enabling system call audit and setting at least one audit filter so that the audit framework will collect that information and include it in the audit records that are emitted upon syscall exit after any such AVC denial.  Unfortunately, that is all disabled by default on most systems due to its associated performance overhead, and one doesn't even have the option of enabling it on some systems, e.g. Android devices.  And even when one can enable syscall audit, one must correlate the syscall audit record to the associated AVC record to identify the object rather than having the information directly included in the same record.
> 
> None of which gives any rationale for adding the information
> to the capability check. Sure, it's in the right place, but there
> is no object interaction with the capability call.

We introducing such an interaction - that's the point.

> 
>>> What would a "per inode" capability check be? Capability checks are
>>> process checks, not object checks.
>>
>> Ideally it would be possible to scope dac_override and other capabilities to specific objects rather than having to allow it for all or none.
> 
> That would require a major overhaul of the capability scheme,
> and you're going to get arguments from people like me about
> whether or not that would be ideal. Besides, isn't that what
> SELinux is all about, providing that sort of privilege granularity?

It only requires passing the information to the security modules at the 
point of the hook call, and then SELinux or other security modules can 
implement it themselves without any other changes to the kernel.  We 
aren't changing the way the base capabilities logic works.

We can't provide that degree of granularity without the additional 
information.  Let's say domain A needs DAC override for files of type B 
and for nothing else.  To support this requirement, SELinux policy has 
to include at least:
1) allow A self:capability dac_override;
2) allow A B:file { read write };

Let's say that A also reads from files of type C and writes to file of 
type D.  So SELinux policy also has to allow:
3) allow A C:file read;
4) allow A D:file write;

There are files within type C and within type D that are under different 
DAC ownerships or modes.  Only some of these files should be accessible 
to A.  But because dac_override is global and not scoped to specific 
sets of files, the combination of these permissions now allows A to 
override DAC on files of type C and of type D; thus it can read all 
files of type C and write to all files of type D even though it has no 
legitimate need to do so.


> 
>> Just because a process needs to override DAC on one file or one set of files is not a reason to allow it to do so on every file it can access at all.
> 
> That's an argument for privilege bracketing within the process.
> Not something I recommend (the oft referenced sendmail problems
> being but one example) but the only way to do it properly without
> delving into path based controls.

As you note, historically privilege bracketing hasn't worked so well, 
and fundamentally it puts the trust burden on userspace for something 
that could be enforced at the system level quite easily and in a 
race-free manner.

> 
>> If we want to apply least privilege, then this is a desirable facility.
> 
> The capability mechanism is object agnostic by design.

Some might argue that's a flawed design.

>> I understand that doesn't mesh with Smack's mental modelbut it would probably be useful to both SELinux and AppArmor, among others.
> 
> I'm perfectly happy to have the information transmitted.
> I think a separate interface for doing so is appropriate.

As above, I don't see any way to do that that isn't just adding overhead.
