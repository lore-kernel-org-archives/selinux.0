Return-Path: <SRS0=jdxV=XO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 162E5C3A5A6
	for <selinux@archiver.kernel.org>; Thu, 19 Sep 2019 12:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5EC221929
	for <selinux@archiver.kernel.org>; Thu, 19 Sep 2019 12:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="dmPfk7l6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390109AbfISMLH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 19 Sep 2019 08:11:07 -0400
Received: from UHIL19PA37.eemsg.mail.mil ([214.24.21.196]:44455 "EHLO
        UHIL19PA37.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388551AbfISMLH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 19 Sep 2019 08:11:07 -0400
X-EEMSG-check-017: 27163680|UHIL19PA37_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,523,1559520000"; 
   d="scan'208";a="27163680"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UHIL19PA37.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 19 Sep 2019 12:11:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1568895064; x=1600431064;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=BsQHAqljsgLjTP/XOy9F98lUq/qRZnmn1pPzKaE3wsc=;
  b=dmPfk7l6va0oFFNNPx75cnrUXEimSKA+VDrDDtvv96C6Tt3JE0vrPOBJ
   1JglgT9mxfgjwrdSM7FVoYKR8fZyaOYUSeO5soIxrC+LNUAijJuwxkeP9
   NnVd7DKzLn8QGc64hRhC+Gfd0085k6CXIv0buU+adQt3a62DNefO3zGGA
   jz8vggHdGNQ805xUQbhzuBt28QNYpeZeTc2ct3Ac0/SBBX5A9Ev9jw/Q2
   gfGMHNIXVsJehokt/nv9qTSq02HW9tSIiBhuh4bhd/mJ9Ab04C6FEGkno
   tLU/dHKcOJ5zlZ/RuLJJCNmcE1OaJcvdJCkHe9ubfHyKqxatRCyYw7nIe
   A==;
X-IronPort-AV: E=Sophos;i="5.64,523,1559520000"; 
   d="scan'208";a="33060321"
IronPort-PHdr: =?us-ascii?q?9a23=3AGkBIUhKD8S/DAtn8s9mcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgfLfnxwZ3uMQTl6Ol3ixeRBMOHsqkC0bKd7/GoGTRZp8rY6jZaKN0Efi?=
 =?us-ascii?q?RGoP1epxYnDs+BBB+zB9/RRAt+Iv5/UkR49WqwK0lfFZW2TVTTpnqv8WxaQU?=
 =?us-ascii?q?2nZkJ6KevvB4Hdkdm82fys9J3PeQVIgye2ba9vIBmsogjdq8cbjZF8JqotxR?=
 =?us-ascii?q?fErX9FcPlSyW90OF6fhRnx6tqu8JJ57yhcp/ct/NNcXKvneKg1UaZWByk8PW?=
 =?us-ascii?q?Av483ruxjDTQ+R6XYZT24bjBlGDRXb4R/jRpv+vTf0ueR72CmBIM35Vqs0Vi?=
 =?us-ascii?q?i476dqUxDnliEKPCMk/W7Ni8xwiKVboA+9pxF63oXZbp2ZOOZ4c6jAZt4RW3?=
 =?us-ascii?q?ZPUdhNWCxAGoO8bpUAD+wdPeZDsoLxo0ICoQaiCQWwAe/izDFHhmXy3aYnze?=
 =?us-ascii?q?ovFw/I1xEkE94XrnjZqND5OaEPWu630abI1y3OYe5I1zfz6IbGcR4vrv+DUr?=
 =?us-ascii?q?1ybcXfxlIiFx/Hg1iKtYDpIz2Y2+YLvmOG7+RgT+Wvi2s/pg9svjig2N8sio?=
 =?us-ascii?q?nXiYIT11vK6CB5z5wxJd28VkF6YcOvHZxLty6HLIt7Wd8iQmF0tyY6zb0Ko5?=
 =?us-ascii?q?i7fDMQx5g9yB7fbOKHfpGO7xn+WuiRJjJ4i2hkeLK5nxuy8lavyvf6Vsaq1F?=
 =?us-ascii?q?ZGtC1FksPDtn0Lyhfd6dCHR+Ng8kqu1juDzQDe5vxeLUwqmqfXNYQtzqM2m5?=
 =?us-ascii?q?EOq0rMBDX2l1/zjKKOc0Uk/fWn5Pr/b7X9o5+cK5d0igbjMqQygsC/Afo3Mg?=
 =?us-ascii?q?wJX2WD5eSzzqfj/UzkQLVRlPE2jqnYv4zaJcQcvKK5BRNa0p0/5BqlCjem0d?=
 =?us-ascii?q?AYkWEGLFJDZh2Hk5DkN0zBLf33F/uyg0mgnC11y/3JILHtGIjBImDGkLj7fL?=
 =?us-ascii?q?Z970BcyBA0zdBa/59UEawOIOnoV0/ttN3XEh85Mwuuz+bhE9VyzJkSWW2IAq?=
 =?us-ascii?q?+HKK/Sq0OH5vozI+mQY48YoDH9K/0i5/71i382g0MScrey0JsNdn+3A/RmLF?=
 =?us-ascii?q?+FYXb2ntgBFmIKtBIkTOP2kF2CTSJTZ3GqUqIn+D47DIOmDYHeRoGim7GBwi?=
 =?us-ascii?q?i7EYNMZmxcCVCDD23od4OaVPcIci6SJdVhkjNXHYSmHqgn2QujtkffzKFhJ+?=
 =?us-ascii?q?HZ+WVMspfkz9587OD7jxw+9TVoSc+a1jfJB1pZmmIOWi9+2KFkvQQp0VqH0K?=
 =?us-ascii?q?5lk9RGGtFJofBESAE3Mdjb1eMsWP7oXQeURcuEUFarRJ2dBDg1St8gi4sVb1?=
 =?us-ascii?q?1VB8SpjheF2TGjRbASierYV9QP7qvA0i2pdI5GwHHc2fxk1gN3Tw=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2ARAQDpb4Nd/wHyM5BlHAEBAQQBAQcEAQGBVAYBAQsBg?=
 =?us-ascii?q?W0qbVIBMiqEIo8STQEBAQEBB4E2iXSPLYF7CQEBAQEBAQEBAS0HAQIBAYFLg?=
 =?us-ascii?q?nQCgwMjNQgOAgwBAQEEAQEBAQEFAwEBbIUtDII6KQGCZwEFIxVRCw4KAgImA?=
 =?us-ascii?q?gJXBgEMBgIBAYJfPwGBdhQPrXqBMoVMgzGBQwaBDCgBjAgYeIEHgTiCaz6BB?=
 =?us-ascii?q?AGBXASBPwEBgymCWASWAJcGgiyCLoRXjX0GG4I2i3CKfY4WiBGSfAI0gVgrC?=
 =?us-ascii?q?AIYCCEPgydQEBSBZohuhVskAzABAYEEAQGNKYJFAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 19 Sep 2019 12:11:02 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8JCB2kd001580;
        Thu, 19 Sep 2019 08:11:02 -0400
Subject: Re: [PATCH] policy: fix some build errors under refpolicy
To:     Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
References: <20190919081058.8860-1-omosnace@redhat.com>
 <CAFqZXNu30MVUACOkVxZWEvz4FjLQEg2YDfZ_7ZdvxotRtJqNjA@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <8e53d70c-f29c-f413-6e26-ca2bd589a4dc@tycho.nsa.gov>
Date:   Thu, 19 Sep 2019 08:11:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAFqZXNu30MVUACOkVxZWEvz4FjLQEg2YDfZ_7ZdvxotRtJqNjA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/19/19 4:33 AM, Ondrej Mosnacek wrote:
> On Thu, Sep 19, 2019 at 10:11 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>> Replace deprecated macros with new ones. Fedora's policy has both;
>> refpolicy just the new ones.
>>
>> Partially addresses issue #57.
>>
>> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>> ---
>>   policy/test_atsecure.te    | 4 ++--
>>   policy/test_capable_net.te | 2 +-
>>   policy/test_file.te        | 4 ++--
>>   policy/test_inherit.te     | 4 ++--
>>   policy/test_readlink.te    | 2 +-
>>   policy/test_rxdir.te       | 2 +-
>>   policy/test_setnice.te     | 4 ++--
>>   policy/test_stat.te        | 2 +-
>>   policy/test_transition.te  | 2 +-
>>   9 files changed, 13 insertions(+), 13 deletions(-)
> 
> (Forgot to specify in the subject that this is a testsuite patch -
> sorry, testing a new script...)
> 
> Tested by running the testuite on Fedora Rawhide along with Stephen's
> related patch ("selinux-testsuite: drop use of
> userdom_read_inherited_user_tmp_files"):
> 
> https://lore.kernel.org/selinux/CAFqZXNt4gtvgLbTj18=DW65SnQieaGA=++nKd0QLhzkQ6fERAg@mail.gmail.com/T/#t
> 
> Even with this + Stephen's patch the refpolicy build is still failing
> for me on missing 'userdom_search_admin_dir'.

That also looks like it isn't truly needed AFAICS.

> 
>>
>> diff --git a/policy/test_atsecure.te b/policy/test_atsecure.te
>> index 7255553..486faf6 100644
>> --- a/policy/test_atsecure.te
>> +++ b/policy/test_atsecure.te
>> @@ -32,8 +32,8 @@ corecmd_bin_entry_type(atsecuredomain)
>>   corecmd_shell_entry_type(atsecuredomain)
>>   corecmd_exec_bin(atsecuredomain)
>>   domain_entry_file(test_atsecure_newdomain_t, test_file_t)
>> -domain_trans(test_atsecure_denied_t, test_file_t, test_atsecure_newdomain_t)
>> -domain_trans(test_atsecure_allowed_t, test_file_t, test_atsecure_newdomain_t)
>> +domain_transition_pattern(test_atsecure_denied_t, test_file_t, test_atsecure_newdomain_t)
>> +domain_transition_pattern(test_atsecure_allowed_t, test_file_t, test_atsecure_newdomain_t)
>>   allow test_atsecure_newdomain_t test_atsecure_denied_t:fd use;
>>   allow test_atsecure_newdomain_t test_atsecure_allowed_t:fd use;
>>   allow_map(atsecuredomain, test_file_t, file)
>> diff --git a/policy/test_capable_net.te b/policy/test_capable_net.te
>> index fab6650..80559f6 100644
>> --- a/policy/test_capable_net.te
>> +++ b/policy/test_capable_net.te
>> @@ -53,7 +53,7 @@ sysadm_bin_spec_domtrans_to(capabledomain)
>>   require {
>>          type ifconfig_exec_t;
>>   }
>> -domain_trans(sysadm_t, ifconfig_exec_t, capabledomain)
>> +domain_transition_pattern(sysadm_t, ifconfig_exec_t, capabledomain)
>>   domain_entry_file(capabledomain, ifconfig_exec_t)
>>
>>   # Permissions for the good domain
>> diff --git a/policy/test_file.te b/policy/test_file.te
>> index 1f1da3a..828c0f4 100644
>> --- a/policy/test_file.te
>> +++ b/policy/test_file.te
>> @@ -67,13 +67,13 @@ corecmd_bin_entry_type(fileopdomain)
>>   sysadm_bin_spec_domtrans_to(fileopdomain)
>>
>>   domain_entry_file(fileop_t, fileop_exec_t)
>> -domain_auto_trans(test_fileop_t, fileop_exec_t, fileop_t)
>> +domain_auto_transition_pattern(test_fileop_t, fileop_exec_t, fileop_t)
>>   allow test_fileop_t fileop_t:fd use;
>>   allow fileop_t test_fileop_t:fd use;
>>   allow fileop_t test_fileop_t:fifo_file rw_file_perms;
>>   allow fileop_t test_fileop_t:process sigchld;
>>
>> -domain_auto_trans(test_nofileop_t, fileop_exec_t, fileop_t)
>> +domain_auto_transition_pattern(test_nofileop_t, fileop_exec_t, fileop_t)
>>   allow test_nofileop_t fileop_t:fd use;
>>   allow fileop_t test_nofileop_t:fd use;
>>   allow fileop_t test_nofileop_t:fifo_file rw_file_perms;
>> diff --git a/policy/test_inherit.te b/policy/test_inherit.te
>> index 28bfd63..8303fc5 100644
>> --- a/policy/test_inherit.te
>> +++ b/policy/test_inherit.te
>> @@ -47,7 +47,7 @@ userdom_sysadm_entry_spec_domtrans_to(inheritdomain)
>>   allow test_inherit_parent_t test_inherit_file_t:file rw_file_perms;
>>
>>   # Grant the necessary permissions for the child domain.
>> -domain_trans(test_inherit_parent_t, test_file_t, test_inherit_child_t)
>> +domain_transition_pattern(test_inherit_parent_t, test_file_t, test_inherit_child_t)
>>   allow test_inherit_parent_t test_inherit_child_t:fd use;
>>   allow test_inherit_child_t test_inherit_parent_t:fd use;
>>   allow test_inherit_child_t test_inherit_parent_t:fifo_file rw_file_perms;
>> @@ -60,7 +60,7 @@ allow test_inherit_nouse_t test_file_t:file { read getattr execute entrypoint };
>>   allow test_inherit_nouse_t test_inherit_file_t:file rw_file_perms;
>>
>>   # Grant the nowrite domain all of the same permissions except for file write.
>> -domain_trans(test_inherit_parent_t, test_file_t, test_inherit_nowrite_t)
>> +domain_transition_pattern(test_inherit_parent_t, test_file_t, test_inherit_nowrite_t)
>>   allow test_inherit_parent_t test_inherit_nowrite_t:fd use;
>>   allow test_inherit_nowrite_t test_inherit_parent_t:fd use;
>>   allow test_inherit_nowrite_t test_inherit_parent_t:fifo_file rw_file_perms;
>> diff --git a/policy/test_readlink.te b/policy/test_readlink.te
>> index 1126fd5..b0d8cd5 100644
>> --- a/policy/test_readlink.te
>> +++ b/policy/test_readlink.te
>> @@ -34,5 +34,5 @@ allow test_noreadlink_t test_readlink_link_t:lnk_file { getattr };
>>   require {
>>          type ls_exec_t;
>>   }
>> -domain_trans(sysadm_t, ls_exec_t, test_readlink_domain)
>> +domain_transition_pattern(sysadm_t, ls_exec_t, test_readlink_domain)
>>   domain_entry_file(test_readlink_domain, ls_exec_t)
>> diff --git a/policy/test_rxdir.te b/policy/test_rxdir.te
>> index cbe1897..50d5ad1 100644
>> --- a/policy/test_rxdir.te
>> +++ b/policy/test_rxdir.te
>> @@ -33,4 +33,4 @@ require {
>>          type ls_exec_t;
>>   }
>>   domain_entry_file(test_rxdir_domain, ls_exec_t)
>> -domain_trans(sysadm_t, ls_exec_t, test_rxdir_domain)
>> +domain_transition_pattern(sysadm_t, ls_exec_t, test_rxdir_domain)
>> diff --git a/policy/test_setnice.te b/policy/test_setnice.te
>> index dac0dc5..d956598 100644
>> --- a/policy/test_setnice.te
>> +++ b/policy/test_setnice.te
>> @@ -38,8 +38,8 @@ libs_exec_lib_files(setnicedomain)
>>   # Allow all of these domains to be entered from sysadm domain
>>   # via a shell script in the test directory or by....
>>   miscfiles_domain_entry_test_files(setnicedomain)
>> -domain_trans(sysadm_t, test_file_t, setnicedomain)
>> -domain_trans(test_setnice_change_t, test_file_t, {test_setnice_set_t test_setnice_noset_t})
>> +domain_transition_pattern(sysadm_t, test_file_t, setnicedomain)
>> +domain_transition_pattern(test_setnice_change_t, test_file_t, {test_setnice_set_t test_setnice_noset_t})
>>   allow test_setnice_change_t test_setnice_set_t:fd use;
>>   allow test_setnice_set_t test_setnice_change_t:fd use;
>>   allow test_setnice_set_t test_setnice_change_t:fifo_file rw_file_perms;
>> diff --git a/policy/test_stat.te b/policy/test_stat.te
>> index 2e068d1..0204e71 100644
>> --- a/policy/test_stat.te
>> +++ b/policy/test_stat.te
>> @@ -29,5 +29,5 @@ typeattribute test_nostat_t testdomain;
>>   require {
>>          type ls_exec_t;
>>   }
>> -domain_trans(sysadm_t, ls_exec_t, test_stat_domain)
>> +domain_transition_pattern(sysadm_t, ls_exec_t, test_stat_domain)
>>   domain_entry_file(test_stat_domain, ls_exec_t)
>> diff --git a/policy/test_transition.te b/policy/test_transition.te
>> index c487825..1eee2b4 100644
>> --- a/policy/test_transition.te
>> +++ b/policy/test_transition.te
>> @@ -28,7 +28,7 @@ typeattribute test_transition_todomain_t testdomain;
>>
>>   # Allow the fromdomain to transition to the new domain.
>>   corecmd_bin_entry_type(transitiondomain)
>> -domain_trans(test_transition_fromdomain_t,bin_t,test_transition_todomain_t)
>> +domain_transition_pattern(test_transition_fromdomain_t,bin_t,test_transition_todomain_t)
>>   allow test_transition_fromdomain_t test_transition_todomain_t:fd use;
>>   allow test_transition_todomain_t test_transition_fromdomain_t:fd use;
>>
>> --
>> 2.21.0
>>
> 
> 
> --
> Ondrej Mosnacek <omosnace at redhat dot com>
> Software Engineer, Security Technologies
> Red Hat, Inc.
> 

