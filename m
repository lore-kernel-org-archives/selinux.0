Return-Path: <SRS0=BfnB=EE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104B3C2D0A3
	for <selinux@archiver.kernel.org>; Thu, 29 Oct 2020 11:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3D012076B
	for <selinux@archiver.kernel.org>; Thu, 29 Oct 2020 11:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbgJ2L01 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 29 Oct 2020 07:26:27 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54316 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgJ2L00 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 29 Oct 2020 07:26:26 -0400
Received: from static-50-53-41-238.bvtn.or.frontiernet.net ([50.53.41.238] helo=[192.168.192.153])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <john.johansen@canonical.com>)
        id 1kY64K-0007jz-Pq; Thu, 29 Oct 2020 11:26:13 +0000
Subject: Re: [PATCH v21 00/23] LSM: Module stacking for AppArmor
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     linux-audit@redhat.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
References: <20201012201924.71463-1-casey.ref@schaufler-ca.com>
 <20201012201924.71463-1-casey@schaufler-ca.com>
From:   John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; prefer-encrypt=mutual; keydata=
 LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCgptUUlOQkU1bXJQb0JFQURB
 azE5UHNnVmdCS2tJbW1SMmlzUFE2bzdLSmhUVEtqSmR3VmJrV1NuTm4rbzZVcDVrCm5LUDFm
 NDlFQlFsY2VXZzF5cC9Od2JSOGFkK2VTRU8vdW1hL0srUHFXdkJwdEtDOVNXRDk3Rkc0dUI0
 L2Nhb20KTEVVOTdzTFFNdG52R1dkeHJ4VlJHTTRhbnpXWU1neno1VFptSWlWVFo0M091NVZw
 YVMxVnoxWlN4UDNoL3hLTgpaci9UY1c1V1FhaTh1M1BXVm5ia2poU1pQSHYxQmdoTjY5cXhF
 UG9tckpCbTFnbXR4M1ppVm1GWGx1d1RtVGdKCk9rcEZvbDduYkowaWxuWUhyQTdTWDNDdFIx
 dXBlVXBNYS9XSWFuVk85NldkVGpISElhNDNmYmhtUXViZTR0eFMKM0ZjUUxPSlZxUXN4NmxF
 OUI3cUFwcG05aFExMHFQV3dkZlB5LyswVzZBV3ROdTVBU2lHVkNJbld6bDJIQnFZZAovWmxs
 OTN6VXErTklvQ244c0RBTTlpSCt3dGFHRGNKeXdJR0luK2VkS050SzcyQU1nQ2hUZy9qMVpv
 V0g2WmVXClBqdVVmdWJWelp0bzFGTW9HSi9TRjRNbWRRRzFpUU50ZjRzRlpiRWdYdXk5Y0dp
 MmJvbUYwenZ5QkpTQU5weGwKS05CRFlLek42S3owOUhVQWtqbEZNTmdvbUwvY2pxZ0FCdEF4
 NTlMK2RWSVpmYUYyODFwSWNVWnp3dmg1K0pvRwplT1c1dUJTTWJFN0wzOG5zem9veWtJSjVY
 ckFjaGtKeE5mejdrK0ZuUWVLRWtOekVkMkxXYzNRRjRCUVpZUlQ2ClBISGdhM1JneWtXNSsx
 d1RNcUpJTGRtdGFQYlhyRjNGdm5WMExSUGN2NHhLeDdCM2ZHbTd5Z2Rvb3dBUkFRQUIKdEIx
 S2IyaHVJRXB2YUdGdWMyVnVJRHhxYjJodVFHcHFiWGd1Ym1WMFBva0NPZ1FUQVFvQUpBSWJB
 d1VMQ1FnSApBd1VWQ2drSUN3VVdBZ01CQUFJZUFRSVhnQVVDVG8wWVZ3SVpBUUFLQ1JBRkx6
 WndHTlhEMkx4SkQvOVRKWkNwCndsbmNUZ1llcmFFTWVEZmtXdjhjMUlzTTFqMEFtRTRWdEwr
 ZkU3ODBaVlA5Z2tqZ2tkWVN4dDdlY0VUUFRLTWEKWlNpc3JsMVJ3cVUwb29nWGRYUVNweHJH
 SDAxaWN1LzJuMGpjWVNxWUtnZ1B4eTc4QkdzMkxacTRYUGZKVFptSApaR25YR3EvZURyL21T
 bmowYWF2QkptTVo2amJpUHo2eUh0QllQWjlmZG84YnRjendQNDFZZVdvSXUyNi84SUk2CmYw
 WG0zVkM1b0FhOHY3UmQrUldaYThUTXdsaHpIRXh4ZWwzanRJN0l6ek9zbm1FOS84RG0wQVJE
 NWlUTENYd1IKMWN3SS9KOUJGL1MxWHY4UE4xaHVUM0l0Q05kYXRncDh6cW9Ka2dQVmptdnlM
 NjRRM2ZFa1liZkhPV3NhYmE5LwprQVZ0Qk56OVJURmg3SUhEZkVDVmFUb3VqQmQ3QnRQcXIr
 cUlqV0ZhZEpEM0k1ZUxDVkp2VnJyb2xyQ0FUbEZ0Ck4zWWtRczZKbjFBaUlWSVUzYkhSOEdq
 ZXZnejVMbDZTQ0dIZ1Jya3lScG5TWWFVL3VMZ24zN042QVl4aS9RQUwKK2J5M0N5RUZManpX
 QUV2eVE4YnEzSXVjbjdKRWJoUy9KLy9kVXFMb2VVZjh0c0dpMDB6bXJJVFpZZUZZQVJoUQpN
 dHNmaXpJclZEdHoxaVBmL1pNcDVnUkJuaXlqcFhuMTMxY20zTTNndjZIclFzQUdubjhBSnJ1
 OEdEaTVYSllJCmNvLzEreC9xRWlOMm5DbGFBT3BiaHpOMmVVdlBEWTVXMHEzYkEvWnAybWZH
 NTJ2YlJJK3RRMEJyMUhkL3ZzbnQKVUhPOTAzbU1aZXAyTnpOM0JaNXFFdlB2RzRyVzVacTJE
 cHliV2JRclNtOW9iaUJLYjJoaGJuTmxiaUE4YW05bwpiaTVxYjJoaGJuTmxia0JqWVc1dmJt
 bGpZV3d1WTI5dFBva0NOd1FUQVFvQUlRVUNUbzBYV2dJYkF3VUxDUWdICkF3VVZDZ2tJQ3dV
 V0FnTUJBQUllQVFJWGdBQUtDUkFGTHpad0dOWEQySXRNRC85anliYzg3ZE00dUFIazZ5Tk0K
 TjBZL0JGbW10VFdWc09CaHFPbm9iNGkzOEJyRE8yQzFoUUNQQ1FlNExMczEvNHB0ZW92UXQ4
 QjJGeXJQVmp3Zwo3alpUSE5LNzRyNmxDQ1Z4eDN5dTFCN1U5UG80VlRrY3NsVmIxL3FtV3V4
 OFhXY040eXZrVHFsTCtHeHB5Sm45CjlaWmZmWEpjNk9oNlRtT2ZiS0d2TXV1djVhclNJQTNK
 SEZMZjlhTHZadEExaXNKVXI3cFM5YXBnOXVUVUdVcDcKd2ZWMFdUNlQzZUczbXRVVTJ1cDVK
 VjQ4NTBMMDVqSFM2dVdpZS9ZK3lmSk9iaXlyeE4vNlpxVzVHb25oTEJxLwptc3pjVjV2QlQz
 QkRWZTNSdkY2WGRNOU9oUG4xK1k4MXg1NCt2UTExM044aUx3RjdHR2ExNFp5SVZBTlpEMEkw
 CkhqUnZhMmsvUnFJUlR6S3l1UEg1cGtsY0tIVlBFRk1tT3pNVCtGT294Tmp2Uys3K3dHMktN
 RFlFbUhQcjFQSkIKWlNaZUh6SzE5dGZhbFBNcHBGeGkrc3lZTGFnTjBtQjdKSFF3WTdjclV1
 T0RoeWNxNjBZVnoxdGFFeWd1M1l2MgoyL0kxRUNHSHZLSEc2d2M5MG80M0MvZWxIRUNYbkVo
 N3RLcGxEY3BJQytPQ21NeEtIaFI0NitYY1p2Z3c0RGdiCjdjYTgzZVFSM0NHODlMdlFwVzJM
 TEtFRUJEajdoWmhrTGJra1BSWm0zdzhKWTQ0YXc4VnRneFdkblNFTUNMeEwKSU9OaDZ1Wjcv
 L0RZVnRjSWFNSllrZWJhWnRHZENwMElnVVpiMjQvVmR2WkNZYk82MkhrLzNWbzFuWHdIVUVz
 Mwo2RC92MWJUMFJaRmk2OUxnc0NjT2N4NGdZTGtDRFFST1pxejZBUkFBb3F3NmtrQmhXeU0x
 ZnZnYW1BVmplWjZuCktFZm5SV2JrQzk0TDFFc0pMdXAzV2IyWDBBQk5PSFNrYlNENHBBdUMy
 dEtGL0VHQnQ1Q1A3UWRWS1JHY1F6QWQKNmIyYzFJZHk5Ukx3Nnc0Z2krbm4vZDFQbTFra1lo
 a1NpNXpXYUlnMG01UlFVaytFbDh6a2Y1dGNFLzFOMFo1TwpLMkpoandGdTViWDBhMGw0Y0ZH
 V1ZRRWNpVk1ES1J0eE1qRXRrM1N4RmFsbTZaZFEycHAyODIyY2xucTR6WjltCld1MWQyd2F4
 aXorYjVJYTR3ZURZYTduNDFVUmNCRVViSkFnbmljSmtKdENUd3lJeElXMktuVnlPcmp2a1F6
 SUIKdmFQMEZkUDJ2dlpvUE1kbENJek9sSWtQTGd4RTBJV3VlVFhlQkpoTnMwMXBiOGJMcW1U
 SU1sdTRMdkJFTEEvdgplaWFqajVzOHk1NDJIL2FIc2ZCZjRNUVVoSHhPL0JaVjdoMDZLU1Vm
 SWFZN09nQWdLdUdOQjNVaWFJVVM1K2E5CmduRU9RTER4S1J5L2E3UTF2OVMrTnZ4KzdqOGlI
 M2prUUpoeFQ2WkJoWkdSeDBna0gzVCtGMG5ORG01TmFKVXMKYXN3Z0pycUZaa1VHZDJNcm0x
 cW5Ld1hpQXQ4U0ljRU5kcTMzUjBLS0tSQzgwWGd3ajhKbjMwdlhMU0crTk8xRwpIMFVNY0F4
 TXd5L3B2azZMVTVKR2paUjczSjVVTFZoSDRNTGJEZ2dEM21QYWlHOCtmb3RUckpVUHFxaGc5
 aHlVCkVQcFlHN3NxdDc0WG43OStDRVpjakxIenlsNnZBRkUyVzBreGxMdFF0VVpVSE8zNmFm
 RnY4cUdwTzNacVB2akIKVXVhdFhGNnR2VVFDd2YzSDZYTUFFUUVBQVlrQ0h3UVlBUW9BQ1FV
 Q1RtYXMrZ0liREFBS0NSQUZMelp3R05YRAoyRC9YRC8wZGRNLzRhaTFiK1RsMWp6bkthalgz
 a0crTWVFWWVJNGY0MHZjbzNyT0xyblJHRk9jYnl5ZlZGNjlNCktlcGllNE93b0kxamNUVTBB
 RGVjbmJXbkROSHByMFNjenhCTXJvM2Juckxoc212anVuVFlJdnNzQlp0QjRhVkoKanVMSUxQ
 VWxuaEZxYTdmYlZxMFpRamJpVi9ydDJqQkVOZG05cGJKWjZHam5wWUljQWJQQ0NhL2ZmTDQv
 U1FSUwpZSFhvaEdpaVM0eTVqQlRtSzVsdGZld0xPdzAyZmtleEgrSUpGcnJHQlhEU2c2bjJT
 Z3hubisrTkYzNGZYY205CnBpYXczbUtzSUNtKzBoZE5oNGFmR1o2SVdWOFBHMnRlb29WRHA0
 ZFlpaCsreFgvWFM4ekJDYzFPOXc0bnpsUDIKZ0t6bHFTV2JoaVdwaWZSSkJGYTRXdEFlSlRk
 WFlkMzdqL0JJNFJXV2hueXc3YUFQTkdqMzN5dEdITlVmNlJvMgovanRqNHRGMXkvUUZYcWpK
 Ry93R2pwZHRSZmJ0VWpxTEhJc3ZmUE5OSnEvOTU4cDc0bmRBQ2lkbFdTSHpqK09wCjI2S3Bi
 Rm5td05PMHBzaVVzbmh2SEZ3UE8vdkFibDNSc1I1KzBSbytodnMyY0VtUXV2OXIvYkRsQ2Zw
 enAydDMKY0srcmh4VXFpc094OERaZnoxQm5rYW9DUkZidnZ2ays3TC9mb21QbnRHUGtxSmNp
 WUU4VEdIa1p3MWhPa3UrNApPb00yR0I1bkVEbGorMlRGL2pMUStFaXBYOVBrUEpZdnhmUmxD
 NmRLOFBLS2ZYOUtkZm1BSWNnSGZuVjFqU24rCjh5SDJkakJQdEtpcVcwSjY5YUlzeXg3aVYv
 MDNwYVBDakpoN1hxOXZBenlkTjVVL1VBPT0KPTZQL2IKLS0tLS1FTkQgUEdQIFBVQkxJQyBL
 RVkgQkxPQ0stLS0tLQo=
Organization: Canonical
Message-ID: <35308586-8bfa-b22d-6a67-5bcf897baeed@canonical.com>
Date:   Thu, 29 Oct 2020 04:26:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201012201924.71463-1-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

A backport of v20 of this series has landed in the ubuntu 20.10 kernel.
It defaults to just apparmor as the major LSM so stacking of apparmor
with selinux or smack is not being tested by default, but it is
exercising the LSM changes.


On 10/12/20 1:19 PM, Casey Schaufler wrote:
> This patchset provides the changes required for
> the AppArmor security module to stack safely with any other.
> 
> v21: Rebase to 5.9-rc4
>      Incorporate feedback from v20
>      - Further revert UDS SO_PEERSEC to use scaffolding around
>        the interfaces that use lsmblobs and store only a single
>        secid. The possibility of multiple security modules
>        requiring data here is still a future problem.
>      - Incorporate Richard Guy Briggs' non-syscall auxiliary
>        records patch (patch 0019-0021) in place of my "supplimental"
>        records implementation. [I'm not sure I've given proper
>        attestation. I will correct as appropriate]
> v20: Rebase to 5.9-rc1
>      Change the BPF security module to use the lsmblob data. (patch 0002)
>      Repair length logic in subject label processing (patch 0015)
>      Handle -EINVAL from the empty BPF setprocattr hook (patch 0020)
>      Correct length processing in append_ctx() (patch 0022)
> v19: Rebase to 5.8-rc6
>      Incorporate feedback from v18
>      - Revert UDS SO_PEERSEC implementation to use lsmblobs
>        directly, rather than allocating as needed. The correct
>        treatment of out-of-memory conditions in the later case
>        is difficult to define. (patch 0005)
>      - Use a size_t in append_ctx() (patch 0021)
>      - Fix a memory leak when creating compound contexts. (patch 0021)
>      Fix build error when CONFIG_SECURITY isn't set (patch 0013)
>      Fix build error when CONFIG_SECURITY isn't set (patch 0020)
>      Fix build error when CONFIG_SECURITY isn't set (patch 0021)
> 
> v18: Rebase to 5.8-rc3
>      Incorporate feedback from v17
>      - Null pointer checking in UDS (patch 0005)
>      Match changes in IMA code (patch 0012)
>      Fix the behavior of LSM context supplimental audit
>      records so that there's always exactly one when it's
>      appropriate for there to be one. This is a substantial
>      change that requires extention of the audit_context beyond
>      syscall events. (patch 0020)
> 
> v17: Rebase to 5.7-rc4
> 
> v16: Rebase to 5.6
>      Incorporate feedback from v15 - Thanks Stephen, Mimi and Paul
>      - Generally improve commit messages WRT scaffolding
>      - Comment ima_lsm_isset() (patch 0002)
>      - Some question may remain on IMA warning (patch 0002)
>      - Mark lsm_slot as __lsm_ro_after_init not __init_data (patch 0002)
>      - Change name of lsmblob variable in ima_match_rules() (patch 0003)
>      - Instead of putting a struct lsmblob into the unix_skb_parms
>        structure put a pointer to an allocated instance. There is
>        currently only space for 5 u32's in unix_skb_parms and it is
>        likely to get even tighter. Fortunately, the lifecycle
>        management of the allocated lsmblob is simple. (patch 0005)
>      - Dropped Acks due to the above change (patch 0005)
>      - Improved commentary on secmark labeling scaffolding. (patch 0006)
>      - Reduced secmark related labeling scaffolding. (patch 0006)
>      - Replace use of the zeroth entry of an lsmblob in scaffolding
>        with a function lsmblob_value() to hopefully make it less
>        obscure. (patch 0006)
>      - Convert security_secmark_relabel_packet to use lsmblob as
>        this reduces much of the most contentious scaffolding. (patch 0006)
>      - Dropped Acks due to the above change (patch 0006)
>      - Added BUILD_BUG_ON() for CIPSO tag 6. (patch 0018)
>      - Reworked audit subject information. Instead of adding fields in
>        the middle of existing records add a new record to the event. When
>        a separate record is required use subj="?". (patch 0020)
>      - Dropped Acks due to the above change (patch 0020)
>      - Reworked audit object information. Instead of adding fields in
>        the middle of existing records add a new record to the event. When
>        a separate record is required use obj="?". (patch 0021)
>      - Dropped Acks due to the above change (patch 0021)
>      - Enhanced documentation (patch 0022)
>      - Removed unnecessary error code check in security_getprocattr()
>        (patch 0021)
> 
> v15: Rebase to 5.6-rc1
>      - Revise IMA data use (patch 0002)
>      Incorporate feedback from v14
>      - Fix lockdown module registration naming (patch 0002)
>      - Revise how /proc/self/attr/context is gathered. (patch 0022)
>      - Revise access modes on /proc/self/attr/context. (patch 0022)
>      - Revise documentation on LSM external interfaces. (patch 0022)
> 
> v14: Rebase to 5.5-rc5
>      Incorporate feedback from v13
>      - Use an array of audit rules (patch 0002)
>      - Significant change, removed Acks (patch 0002)
>      - Remove unneeded include (patch 0013)
>      - Use context.len correctly (patch 0015)
>      - Reorder code to be more sensible (patch 0016)
>      - Drop SO_PEERCONTEXT as it's not needed yet (patch 0023)
> 
> v13: Rebase to 5.5-rc2
>      Incorporate feedback from v12
>      - Print lsmblob size with %z (Patch 0002)
>      - Convert lockdown LSM initialization. (Patch 0002)
>      - Restore error check in nft_secmark_compute_secid (Patch 0006)
>      - Correct blob scaffolding in ima_must_appraise() (Patch 0009)
>      - Make security_setprocattr() clearer (Patch 0013)
>      - Use lsm_task_display more widely (Patch 0013)
>      - Use passed size in lsmcontext_init() (Patch 0014)
>      - Don't add a smack_release_secctx() hook (Patch 0014)
>      - Don't print warning in security_release_secctx() (Patch 0014)
>      - Don't duplicate the label in nfs4_label_init_security() (Patch 0016)
>      - Remove reviewed-by as code has significant change (Patch 0016)
>      - Send the entire lsmblob for Tag 6 (Patch 0019)
>      - Fix description of socket_getpeersec_stream parameters (Patch 0023)
>      - Retain LSMBLOB_FIRST. What was I thinking? (Patch 0023)
>      - Add compound context to LSM documentation (Patch 0023)
> 
> v12: Rebase to 5.5-rc1
>      Fixed a couple of incorrect contractions in the text.
> 
> v11: Rebase to 5.4-rc6
>      Incorporate feedback from v10
>      - Disambiguate reading /proc/.../attr/display by restricting
>        all use of the interface to the current process.
>      - Fix a merge error in AppArmor's display attribute check
> 
> v10: Ask the security modules if the display can be changed.
> 
> v9: There is no version 9
> 
> v8: Incorporate feedback from v7
>     - Minor clean-up in display value management
>     - refactor "compound" context creation to use a common
>       append_ctx() function.
> 
> v7: Incorporate feedback from v6
>     - Make setting the display a privileged operation. The
>       availability of compound contexts reduces the need for
>       setting the display.
> 
> v6: Incorporate feedback from v5
>     - Add subj_<lsm>= and obj_<lsm>= fields to audit records
>     - Add /proc/.../attr/context to get the full context in
>       lsmname\0value\0... format as suggested by Simon McVittie
>     - Add SO_PEERCONTEXT for getsockopt() to get the full context
>       in the same format, also suggested by Simon McVittie.
>     - Add /sys/kernel/security/lsm_display_default to provide
>       the display default value.
> 
> v5: Incorporate feedback from v4
>     - Initialize the lsmcontext in security_secid_to_secctx()
>     - Clear the lsmcontext in all security_release_secctx() cases
>     - Don't use the "display" on strictly internal context
>       interfaces.
>     - The SELinux binder hooks check for cases where the context
>       "display" isn't compatible with SELinux.
> 
> v4: Incorporate feedback from v3
>     - Mark new lsm_<blob>_alloc functions static
>     - Replace the lsm and slot fields of the security_hook_list
>       with a pointer to a LSM allocated lsm_id structure. The
>       LSM identifies if it needs a slot explicitly. Use the
>       lsm_id rather than make security_add_hooks return the
>       slot value.
>     - Validate slot values used in security.c
>     - Reworked the "display" process attribute handling so that
>       it works right and doesn't use goofy list processing.
>     - fix display value check in dentry_init_security
>     - Replace audit_log of secids with '?' instead of deleting
>       the audit log
> 
> v3: Incorporate feedback from v2
>     - Make lsmblob parameter and variable names more
>       meaningful, changing "le" and "l" to "blob".
>     - Improve consistency of constant naming.
>     - Do more sanity checking during LSM initialization.
>     - Be a bit clearer about what is temporary scaffolding.
>     - Rather than clutter security_getpeersec_dgram with
>       otherwise unnecessary checks remove the apparmor
>       stub, which does nothing useful.
> 
> Patch 0001 moves management of the sock security blob
> from the individual modules to the infrastructure.
> 
> Patches 0002-0011 replace system use of a "secid" with
> a structure "lsmblob" containing information from the
> security modules to be held and reused later. At this
> point lsmblob contains an array of u32 secids, one "slot"
> for each of the security modules compiled into the
> kernel that used secids. A "slot" is allocated when
> a security module requests one.
> The infrastructure is changed to use the slot number
> to pass the correct secid to or from the security module
> hooks.
> 
> It is important that the lsmblob be a fixed size entity
> that does not have to be allocated. Several of the places
> where it is used would have performance and/or locking
> issues with dynamic allocation.
> 
> Patch 0012 provides a mechanism for a process to
> identify which security module's hooks should be used
> when displaying or converting a security context string.
> A new interface /proc/self/attr/display contains the name
> of the security module to show. Reading from this file
> will present the name of the module, while writing to
> it will set the value. Only names of active security
> modules are accepted. Internally, the name is translated
> to the appropriate "slot" number for the module which
> is then stored in the task security blob. Setting the
> display requires that all modules using the /proc interfaces
> allow the transition. The "display" of other processess
> can be neither read nor written. All suggested cases
> for reading the display of a different process have race
> conditions.
> 
> Patch 0013 Starts the process of changing how a security
> context is represented. Since it is possible for a
> security context to have been generated by more than one
> security module it is now necessary to note which module
> created a security context so that the correct "release"
> hook can be called. There are several places where the
> module that created a security context cannot be inferred.
> 
> This is achieved by introducing a "lsmcontext" structure
> which contains the context string, its length and the
> "slot" number of the security module that created it.
> The security_release_secctx() interface is changed,
> replacing the (string,len) pointer pair with a lsmcontext
> pointer.
> 
> Patches 0014-0016 convert the security interfaces from
> (string,len) pointer pairs to a lsmcontext pointer.
> The slot number identifying the creating module is
> added by the infrastructure. Where the security context
> is stored for extended periods the data type is changed.
> 
> The Netlabel code is converted to save lsmblob structures
> instead of secids in Patch 0017. This is not strictly
> necessary as there can only be one security module that
> uses Netlabel at this point. Using a lsmblob is much
> cleaner, as the interfaces that use the data have all
> been converted.
> 
> Patch 0018 adds checks to the binder hooks which verify
> that both ends of a transaction use the same "display".
> 
> Patches 0019-0021 add addition audit records for subject
> and object LSM data when there are multiple security modules
> with such data. The AUDIT_MAC_TASK_CONTEXTS record is
> used in conjuction with a "subj=?" field to identify the
> subject data. The AUDIT_MAC_OBJ_CONTEXTS record is used in
> conjuction with a "obj=?" field to identify the object data.
> The AUDIT_MAC_TASK_CONTEXTS record identifies the security
> module with the data: "subj_selinux=xyz_t subj_apparmor=abc".
> The AUDIT_MAC_OBJ_CONTEXTS record identifies the security
> module with the data: "obj_selinux=xyz_t obj_apparmor=abc".
> While AUDIT_MAC_TASK_CONTEXTS records will always contain
> an entry for each possible security modules, AUDIT_MAC_OBJ_CONTEXTS
> records will only contain entries for security modules for
> which the object in question has data.
> 
> An example of the MAC_TASK_CONTEXTS (1420) record is:
> 
>     type=UNKNOWN[1420]
>     msg=audit(1600880931.832:113)
>     subj_apparmor==unconfined
>     subj_smack=_
> 
> An example of the MAC_OBJ_CONTEXTS (1421) record is:
> 
>     type=UNKNOWN[1421] 
>     msg=audit(1601152467.009:1050):
>     obj_selinux=unconfined_u:object_r:user_home_t:s0
> 
> Patch 0022 adds a new interface for getting the
> compound security contexts, /proc/self/attr/context.
> An example of the content of this file is:
> 
>     selinux\0one_u:one_r:one_t:s0-s0:c0.c1023\0apparmor\0unconfined\0
> 
> Finally, with all interference on the AppArmor hooks
> removed, Patch 0023 removes the exclusive bit from
> AppArmor. An unnecessary stub hook was also removed.
> 
> The Ubuntu project is using an earlier version of
> this patchset in their distribution to enable stacking
> for containers.
> 
> Performance measurements to date have the change
> within the "noise". The sockperf and dbench results
> are on the order of 0.2% to 0.8% difference, with
> better performance being as common as worse. The
> benchmarks were run with AppArmor and Smack on Ubuntu.
> 
> https://github.com/cschaufler/lsm-stacking.git#stack-5.9-rc4-v21
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
> 

