Return-Path: <SRS0=faga=6E=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E49B5C3815B
	for <selinux@archiver.kernel.org>; Mon, 20 Apr 2020 14:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A857120857
	for <selinux@archiver.kernel.org>; Mon, 20 Apr 2020 14:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729832AbgDTO02 convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Apr 2020 10:26:28 -0400
Received: from mga04.intel.com ([192.55.52.120]:45853 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbgDTO02 (ORCPT <rfc822;selinux@vger.kernel.org>);
        Mon, 20 Apr 2020 10:26:28 -0400
IronPort-SDR: r9yXOp9e6Iyz+b5COdF93vHKYiGivVTO85N34w/PNZjmQwCoIVZaXZjgnm02Sxa5hsNDMRhJ3Z
 qR3dg4gqYO9A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2020 07:26:25 -0700
IronPort-SDR: OWXfHekFJ9bcf2RSWAmpCaNkWmhjWZUBKrUSVPesYppYHVUQokafidRXZMwlN+5rmnAsPJu4p/
 SQkZJZgO5kLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,406,1580803200"; 
   d="scan'208";a="245381544"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by fmsmga007.fm.intel.com with ESMTP; 20 Apr 2020 07:26:25 -0700
Received: from orsmsx161.amr.corp.intel.com (10.22.240.84) by
 ORSMSX103.amr.corp.intel.com (10.22.225.130) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 20 Apr 2020 07:26:24 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.204]) by
 ORSMSX161.amr.corp.intel.com ([169.254.4.217]) with mapi id 14.03.0439.000;
 Mon, 20 Apr 2020 07:26:24 -0700
From:   "Roberts, William C" <william.c.roberts@intel.com>
To:     Nicolas Iooss <nicolas.iooss@m4x.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Subject: RE: [PATCH 1/1] libselinux,libsemanage: remove double blank lines
Thread-Topic: [PATCH 1/1] libselinux,libsemanage: remove double blank lines
Thread-Index: AQHWFlLb1W+hZtcLOkmWcy81OBzGg6iCEpxw
Date:   Mon, 20 Apr 2020 14:26:23 +0000
Message-ID: <476DC76E7D1DF2438D32BFADF679FC5649ED3B6A@ORSMSX101.amr.corp.intel.com>
References: <20200419140000.86031-1-nicolas.iooss@m4x.org>
In-Reply-To: <20200419140000.86031-1-nicolas.iooss@m4x.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org



> -----Original Message-----
> From: selinux-owner@vger.kernel.org [mailto:selinux-owner@vger.kernel.org]
> On Behalf Of Nicolas Iooss
> Sent: Sunday, April 19, 2020 9:00 AM
> To: selinux@vger.kernel.org
> Subject: [PATCH 1/1] libselinux,libsemanage: remove double blank lines
> 
> This looks cleaner.
> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>  libselinux/src/exception.sh                   |   3 +-
>  libselinux/src/selinuxswig_python_exception.i | 150 ----------
>  libsemanage/src/exception.sh                  |   3 +-
>  .../src/semanageswig_python_exception.i       | 265 ------------------
>  4 files changed, 2 insertions(+), 419 deletions(-)
> 
> diff --git a/libselinux/src/exception.sh b/libselinux/src/exception.sh index
> 644c7a05ec54..3b7f2450bfc6 100755
> --- a/libselinux/src/exception.sh
> +++ b/libselinux/src/exception.sh
> @@ -12,8 +12,7 @@ echo "
>       PyErr_SetFromErrno(PyExc_OSError);
>       SWIG_fail;
>    }
> -}
> -"
> +}"
>  ;;
>  esac
>  }
> diff --git a/libselinux/src/selinuxswig_python_exception.i
> b/libselinux/src/selinuxswig_python_exception.i
> index 9f1f86a5564d..237ea69ad5f5 100644
> --- a/libselinux/src/selinuxswig_python_exception.i
> +++ b/libselinux/src/selinuxswig_python_exception.i
> @@ -7,7 +7,6 @@
>    }
>  }
> 
> -
>  %exception is_selinux_mls_enabled {
>    $action
>    if (result < 0) {
> @@ -16,7 +15,6 @@
>    }
>  }
> 
> -
>  %exception getcon {
>    $action
>    if (result < 0) {
> @@ -25,7 +23,6 @@
>    }
>  }
> 
> -
>  %exception getcon_raw {
>    $action
>    if (result < 0) {
> @@ -34,7 +31,6 @@
>    }
>  }
> 
> -
>  %exception setcon {
>    $action
>    if (result < 0) {
> @@ -43,7 +39,6 @@
>    }
>  }
> 
> -
>  %exception setcon_raw {
>    $action
>    if (result < 0) {
> @@ -52,7 +47,6 @@
>    }
>  }
> 
> -
>  %exception getpidcon {
>    $action
>    if (result < 0) {
> @@ -61,7 +55,6 @@
>    }
>  }
> 
> -
>  %exception getpidcon_raw {
>    $action
>    if (result < 0) {
> @@ -70,7 +63,6 @@
>    }
>  }
> 
> -
>  %exception getprevcon {
>    $action
>    if (result < 0) {
> @@ -79,7 +71,6 @@
>    }
>  }
> 
> -
>  %exception getprevcon_raw {
>    $action
>    if (result < 0) {
> @@ -88,7 +79,6 @@
>    }
>  }
> 
> -
>  %exception getexeccon {
>    $action
>    if (result < 0) {
> @@ -97,7 +87,6 @@
>    }
>  }
> 
> -
>  %exception getexeccon_raw {
>    $action
>    if (result < 0) {
> @@ -106,7 +95,6 @@
>    }
>  }
> 
> -
>  %exception setexeccon {
>    $action
>    if (result < 0) {
> @@ -115,7 +103,6 @@
>    }
>  }
> 
> -
>  %exception setexeccon_raw {
>    $action
>    if (result < 0) {
> @@ -124,7 +111,6 @@
>    }
>  }
> 
> -
>  %exception getfscreatecon {
>    $action
>    if (result < 0) {
> @@ -133,7 +119,6 @@
>    }
>  }
> 
> -
>  %exception getfscreatecon_raw {
>    $action
>    if (result < 0) {
> @@ -142,7 +127,6 @@
>    }
>  }
> 
> -
>  %exception setfscreatecon {
>    $action
>    if (result < 0) {
> @@ -151,7 +135,6 @@
>    }
>  }
> 
> -
>  %exception setfscreatecon_raw {
>    $action
>    if (result < 0) {
> @@ -160,7 +143,6 @@
>    }
>  }
> 
> -
>  %exception getkeycreatecon {
>    $action
>    if (result < 0) {
> @@ -169,7 +151,6 @@
>    }
>  }
> 
> -
>  %exception getkeycreatecon_raw {
>    $action
>    if (result < 0) {
> @@ -178,7 +159,6 @@
>    }
>  }
> 
> -
>  %exception setkeycreatecon {
>    $action
>    if (result < 0) {
> @@ -187,7 +167,6 @@
>    }
>  }
> 
> -
>  %exception setkeycreatecon_raw {
>    $action
>    if (result < 0) {
> @@ -196,7 +175,6 @@
>    }
>  }
> 
> -
>  %exception getsockcreatecon {
>    $action
>    if (result < 0) {
> @@ -205,7 +183,6 @@
>    }
>  }
> 
> -
>  %exception getsockcreatecon_raw {
>    $action
>    if (result < 0) {
> @@ -214,7 +191,6 @@
>    }
>  }
> 
> -
>  %exception setsockcreatecon {
>    $action
>    if (result < 0) {
> @@ -223,7 +199,6 @@
>    }
>  }
> 
> -
>  %exception setsockcreatecon_raw {
>    $action
>    if (result < 0) {
> @@ -232,7 +207,6 @@
>    }
>  }
> 
> -
>  %exception getfilecon {
>    $action
>    if (result < 0) {
> @@ -241,7 +215,6 @@
>    }
>  }
> 
> -
>  %exception getfilecon_raw {
>    $action
>    if (result < 0) {
> @@ -250,7 +223,6 @@
>    }
>  }
> 
> -
>  %exception lgetfilecon {
>    $action
>    if (result < 0) {
> @@ -259,7 +231,6 @@
>    }
>  }
> 
> -
>  %exception lgetfilecon_raw {
>    $action
>    if (result < 0) {
> @@ -268,7 +239,6 @@
>    }
>  }
> 
> -
>  %exception fgetfilecon {
>    $action
>    if (result < 0) {
> @@ -277,7 +247,6 @@
>    }
>  }
> 
> -
>  %exception fgetfilecon_raw {
>    $action
>    if (result < 0) {
> @@ -286,7 +255,6 @@
>    }
>  }
> 
> -
>  %exception setfilecon {
>    $action
>    if (result < 0) {
> @@ -295,7 +263,6 @@
>    }
>  }
> 
> -
>  %exception setfilecon_raw {
>    $action
>    if (result < 0) {
> @@ -304,7 +271,6 @@
>    }
>  }
> 
> -
>  %exception lsetfilecon {
>    $action
>    if (result < 0) {
> @@ -313,7 +279,6 @@
>    }
>  }
> 
> -
>  %exception lsetfilecon_raw {
>    $action
>    if (result < 0) {
> @@ -322,7 +287,6 @@
>    }
>  }
> 
> -
>  %exception fsetfilecon {
>    $action
>    if (result < 0) {
> @@ -331,7 +295,6 @@
>    }
>  }
> 
> -
>  %exception fsetfilecon_raw {
>    $action
>    if (result < 0) {
> @@ -340,7 +303,6 @@
>    }
>  }
> 
> -
>  %exception getpeercon {
>    $action
>    if (result < 0) {
> @@ -349,7 +311,6 @@
>    }
>  }
> 
> -
>  %exception getpeercon_raw {
>    $action
>    if (result < 0) {
> @@ -358,7 +319,6 @@
>    }
>  }
> 
> -
>  %exception security_compute_av {
>    $action
>    if (result < 0) {
> @@ -367,7 +327,6 @@
>    }
>  }
> 
> -
>  %exception security_compute_av_raw {
>    $action
>    if (result < 0) {
> @@ -376,7 +335,6 @@
>    }
>  }
> 
> -
>  %exception security_compute_av_flags {
>    $action
>    if (result < 0) {
> @@ -385,7 +343,6 @@
>    }
>  }
> 
> -
>  %exception security_compute_av_flags_raw {
>    $action
>    if (result < 0) {
> @@ -394,7 +351,6 @@
>    }
>  }
> 
> -
>  %exception security_compute_create {
>    $action
>    if (result < 0) {
> @@ -403,7 +359,6 @@
>    }
>  }
> 
> -
>  %exception security_compute_create_raw {
>    $action
>    if (result < 0) {
> @@ -412,7 +367,6 @@
>    }
>  }
> 
> -
>  %exception security_compute_create_name {
>    $action
>    if (result < 0) {
> @@ -421,7 +375,6 @@
>    }
>  }
> 
> -
>  %exception security_compute_create_name_raw {
>    $action
>    if (result < 0) {
> @@ -430,7 +383,6 @@
>    }
>  }
> 
> -
>  %exception security_compute_relabel {
>    $action
>    if (result < 0) {
> @@ -439,7 +391,6 @@
>    }
>  }
> 
> -
>  %exception security_compute_relabel_raw {
>    $action
>    if (result < 0) {
> @@ -448,7 +399,6 @@
>    }
>  }
> 
> -
>  %exception security_compute_member {
>    $action
>    if (result < 0) {
> @@ -457,7 +407,6 @@
>    }
>  }
> 
> -
>  %exception security_compute_member_raw {
>    $action
>    if (result < 0) {
> @@ -466,7 +415,6 @@
>    }
>  }
> 
> -
>  %exception security_compute_user {
>    $action
>    if (result < 0) {
> @@ -475,7 +423,6 @@
>    }
>  }
> 
> -
>  %exception security_compute_user_raw {
>    $action
>    if (result < 0) {
> @@ -484,7 +431,6 @@
>    }
>  }
> 
> -
>  %exception security_validatetrans {
>    $action
>    if (result < 0) {
> @@ -493,7 +439,6 @@
>    }
>  }
> 
> -
>  %exception security_validatetrans_raw {
>    $action
>    if (result < 0) {
> @@ -502,7 +447,6 @@
>    }
>  }
> 
> -
>  %exception security_load_policy {
>    $action
>    if (result < 0) {
> @@ -511,7 +455,6 @@
>    }
>  }
> 
> -
>  %exception security_get_initial_context {
>    $action
>    if (result < 0) {
> @@ -520,7 +463,6 @@
>    }
>  }
> 
> -
>  %exception security_get_initial_context_raw {
>    $action
>    if (result < 0) {
> @@ -529,7 +471,6 @@
>    }
>  }
> 
> -
>  %exception selinux_mkload_policy {
>    $action
>    if (result < 0) {
> @@ -538,7 +479,6 @@
>    }
>  }
> 
> -
>  %exception selinux_init_load_policy {
>    $action
>    if (result < 0) {
> @@ -547,7 +487,6 @@
>    }
>  }
> 
> -
>  %exception security_set_boolean_list {
>    $action
>    if (result < 0) {
> @@ -556,7 +495,6 @@
>    }
>  }
> 
> -
>  %exception security_load_booleans {
>    $action
>    if (result < 0) {
> @@ -565,7 +503,6 @@
>    }
>  }
> 
> -
>  %exception security_check_context {
>    $action
>    if (result < 0) {
> @@ -574,7 +511,6 @@
>    }
>  }
> 
> -
>  %exception security_check_context_raw {
>    $action
>    if (result < 0) {
> @@ -583,7 +519,6 @@
>    }
>  }
> 
> -
>  %exception security_canonicalize_context {
>    $action
>    if (result < 0) {
> @@ -592,7 +527,6 @@
>    }
>  }
> 
> -
>  %exception security_canonicalize_context_raw {
>    $action
>    if (result < 0) {
> @@ -601,7 +535,6 @@
>    }
>  }
> 
> -
>  %exception security_getenforce {
>    $action
>    if (result < 0) {
> @@ -610,7 +543,6 @@
>    }
>  }
> 
> -
>  %exception security_setenforce {
>    $action
>    if (result < 0) {
> @@ -619,7 +551,6 @@
>    }
>  }
> 
> -
>  %exception security_reject_unknown {
>    $action
>    if (result < 0) {
> @@ -628,7 +559,6 @@
>    }
>  }
> 
> -
>  %exception security_deny_unknown {
>    $action
>    if (result < 0) {
> @@ -637,7 +567,6 @@
>    }
>  }
> 
> -
>  %exception security_get_checkreqprot {
>    $action
>    if (result < 0) {
> @@ -646,7 +575,6 @@
>    }
>  }
> 
> -
>  %exception security_disable {
>    $action
>    if (result < 0) {
> @@ -655,7 +583,6 @@
>    }
>  }
> 
> -
>  %exception security_policyvers {
>    $action
>    if (result < 0) {
> @@ -664,7 +591,6 @@
>    }
>  }
> 
> -
>  %exception security_get_boolean_names {
>    $action
>    if (result < 0) {
> @@ -673,7 +599,6 @@
>    }
>  }
> 
> -
>  %exception security_get_boolean_pending {
>    $action
>    if (result < 0) {
> @@ -682,7 +607,6 @@
>    }
>  }
> 
> -
>  %exception security_get_boolean_active {
>    $action
>    if (result < 0) {
> @@ -691,7 +615,6 @@
>    }
>  }
> 
> -
>  %exception security_set_boolean {
>    $action
>    if (result < 0) {
> @@ -700,7 +623,6 @@
>    }
>  }
> 
> -
>  %exception security_commit_booleans {
>    $action
>    if (result < 0) {
> @@ -709,7 +631,6 @@
>    }
>  }
> 
> -
>  %exception selinux_set_mapping {
>    $action
>    if (result < 0) {
> @@ -718,7 +639,6 @@
>    }
>  }
> 
> -
>  %exception security_av_string {
>    $action
>    if (result < 0) {
> @@ -727,7 +647,6 @@
>    }
>  }
> 
> -
>  %exception matchpathcon_init {
>    $action
>    if (result < 0) {
> @@ -736,7 +655,6 @@
>    }
>  }
> 
> -
>  %exception matchpathcon_init_prefix {
>    $action
>    if (result < 0) {
> @@ -745,7 +663,6 @@
>    }
>  }
> 
> -
>  %exception realpath_not_final {
>    $action
>    if (result < 0) {
> @@ -754,7 +671,6 @@
>    }
>  }
> 
> -
>  %exception matchpathcon {
>    $action
>    if (result < 0) {
> @@ -763,7 +679,6 @@
>    }
>  }
> 
> -
>  %exception matchpathcon_index {
>    $action
>    if (result < 0) {
> @@ -772,7 +687,6 @@
>    }
>  }
> 
> -
>  %exception matchpathcon_filespec_add {
>    $action
>    if (result < 0) {
> @@ -781,7 +695,6 @@
>    }
>  }
> 
> -
>  %exception matchmediacon {
>    $action
>    if (result < 0) {
> @@ -790,7 +703,6 @@
>    }
>  }
> 
> -
>  %exception selinux_getenforcemode {
>    $action
>    if (result < 0) {
> @@ -799,7 +711,6 @@
>    }
>  }
> 
> -
>  %exception selinux_getpolicytype {
>    $action
>    if (result < 0) {
> @@ -808,7 +719,6 @@
>    }
>  }
> 
> -
>  %exception selinux_set_policy_root {
>    $action
>    if (result < 0) {
> @@ -817,7 +727,6 @@
>    }
>  }
> 
> -
>  %exception selinux_check_access {
>    $action
>    if (result < 0) {
> @@ -826,7 +735,6 @@
>    }
>  }
> 
> -
>  %exception selinux_check_passwd_access {
>    $action
>    if (result < 0) {
> @@ -835,7 +743,6 @@
>    }
>  }
> 
> -
>  %exception checkPasswdAccess {
>    $action
>    if (result < 0) {
> @@ -844,7 +751,6 @@
>    }
>  }
> 
> -
>  %exception selinux_check_securetty_context {
>    $action
>    if (result < 0) {
> @@ -853,7 +759,6 @@
>    }
>  }
> 
> -
>  %exception selinuxfs_exists {
>    $action
>    if (result < 0) {
> @@ -862,7 +767,6 @@
>    }
>  }
> 
> -
>  %exception setexecfilecon {
>    $action
>    if (result < 0) {
> @@ -871,7 +775,6 @@
>    }
>  }
> 
> -
>  %exception rpm_execcon {
>    $action
>    if (result < 0) {
> @@ -880,7 +783,6 @@
>    }
>  }
> 
> -
>  %exception is_context_customizable {
>    $action
>    if (result < 0) {
> @@ -889,7 +791,6 @@
>    }
>  }
> 
> -
>  %exception selinux_trans_to_raw_context {
>    $action
>    if (result < 0) {
> @@ -898,7 +799,6 @@
>    }
>  }
> 
> -
>  %exception selinux_raw_to_trans_context {
>    $action
>    if (result < 0) {
> @@ -907,7 +807,6 @@
>    }
>  }
> 
> -
>  %exception selinux_raw_context_to_color {
>    $action
>    if (result < 0) {
> @@ -916,7 +815,6 @@
>    }
>  }
> 
> -
>  %exception getseuserbyname {
>    $action
>    if (result < 0) {
> @@ -925,7 +823,6 @@
>    }
>  }
> 
> -
>  %exception getseuser {
>    $action
>    if (result < 0) {
> @@ -934,7 +831,6 @@
>    }
>  }
> 
> -
>  %exception selinux_file_context_verify {
>    $action
>    if (result < 0) {
> @@ -943,7 +839,6 @@
>    }
>  }
> 
> -
>  %exception selinux_lsetfilecon_default {
>    $action
>    if (result < 0) {
> @@ -952,7 +847,6 @@
>    }
>  }
> 
> -
>  %exception avc_sid_to_context {
>    $action
>    if (result < 0) {
> @@ -961,7 +855,6 @@
>    }
>  }
> 
> -
>  %exception avc_sid_to_context_raw {
>    $action
>    if (result < 0) {
> @@ -970,7 +863,6 @@
>    }
>  }
> 
> -
>  %exception avc_context_to_sid {
>    $action
>    if (result < 0) {
> @@ -979,7 +871,6 @@
>    }
>  }
> 
> -
>  %exception avc_context_to_sid_raw {
>    $action
>    if (result < 0) {
> @@ -988,7 +879,6 @@
>    }
>  }
> 
> -
>  %exception sidget {
>    $action
>    if (result < 0) {
> @@ -997,7 +887,6 @@
>    }
>  }
> 
> -
>  %exception sidput {
>    $action
>    if (result < 0) {
> @@ -1006,7 +895,6 @@
>    }
>  }
> 
> -
>  %exception avc_get_initial_sid {
>    $action
>    if (result < 0) {
> @@ -1015,7 +903,6 @@
>    }
>  }
> 
> -
>  %exception avc_init {
>    $action
>    if (result < 0) {
> @@ -1024,7 +911,6 @@
>    }
>  }
> 
> -
>  %exception avc_open {
>    $action
>    if (result < 0) {
> @@ -1033,7 +919,6 @@
>    }
>  }
> 
> -
>  %exception avc_reset {
>    $action
>    if (result < 0) {
> @@ -1042,7 +927,6 @@
>    }
>  }
> 
> -
>  %exception avc_has_perm_noaudit {
>    $action
>    if (result < 0) {
> @@ -1051,7 +935,6 @@
>    }
>  }
> 
> -
>  %exception avc_has_perm {
>    $action
>    if (result < 0) {
> @@ -1060,7 +943,6 @@
>    }
>  }
> 
> -
>  %exception avc_compute_create {
>    $action
>    if (result < 0) {
> @@ -1069,7 +951,6 @@
>    }
>  }
> 
> -
>  %exception avc_compute_member {
>    $action
>    if (result < 0) {
> @@ -1078,7 +959,6 @@
>    }
>  }
> 
> -
>  %exception avc_add_callback {
>    $action
>    if (result < 0) {
> @@ -1087,7 +967,6 @@
>    }
>  }
> 
> -
>  %exception avc_netlink_open {
>    $action
>    if (result < 0) {
> @@ -1096,7 +975,6 @@
>    }
>  }
> 
> -
>  %exception avc_netlink_acquire_fd {
>    $action
>    if (result < 0) {
> @@ -1105,7 +983,6 @@
>    }
>  }
> 
> -
>  %exception avc_netlink_check_nb {
>    $action
>    if (result < 0) {
> @@ -1114,7 +991,6 @@
>    }
>  }
> 
> -
>  %exception selinux_status_open {
>    $action
>    if (result < 0) {
> @@ -1123,7 +999,6 @@
>    }
>  }
> 
> -
>  %exception selinux_status_updated {
>    $action
>    if (result < 0) {
> @@ -1132,7 +1007,6 @@
>    }
>  }
> 
> -
>  %exception selinux_status_getenforce {
>    $action
>    if (result < 0) {
> @@ -1141,7 +1015,6 @@
>    }
>  }
> 
> -
>  %exception selinux_status_policyload {
>    $action
>    if (result < 0) {
> @@ -1150,7 +1023,6 @@
>    }
>  }
> 
> -
>  %exception selinux_status_deny_unknown {
>    $action
>    if (result < 0) {
> @@ -1159,7 +1031,6 @@
>    }
>  }
> 
> -
>  %exception context_type_set {
>    $action
>    if (result < 0) {
> @@ -1168,7 +1039,6 @@
>    }
>  }
> 
> -
>  %exception context_range_set {
>    $action
>    if (result < 0) {
> @@ -1177,7 +1047,6 @@
>    }
>  }
> 
> -
>  %exception context_role_set {
>    $action
>    if (result < 0) {
> @@ -1186,7 +1055,6 @@
>    }
>  }
> 
> -
>  %exception context_user_set {
>    $action
>    if (result < 0) {
> @@ -1195,7 +1063,6 @@
>    }
>  }
> 
> -
>  %exception get_ordered_context_list {
>    $action
>    if (result < 0) {
> @@ -1204,7 +1071,6 @@
>    }
>  }
> 
> -
>  %exception get_ordered_context_list_with_level {
>    $action
>    if (result < 0) {
> @@ -1213,7 +1079,6 @@
>    }
>  }
> 
> -
>  %exception get_default_context {
>    $action
>    if (result < 0) {
> @@ -1222,7 +1087,6 @@
>    }
>  }
> 
> -
>  %exception get_default_context_with_level {
>    $action
>    if (result < 0) {
> @@ -1231,7 +1095,6 @@
>    }
>  }
> 
> -
>  %exception get_default_context_with_role {
>    $action
>    if (result < 0) {
> @@ -1240,7 +1103,6 @@
>    }
>  }
> 
> -
>  %exception get_default_context_with_rolelevel {
>    $action
>    if (result < 0) {
> @@ -1249,7 +1111,6 @@
>    }
>  }
> 
> -
>  %exception query_user_context {
>    $action
>    if (result < 0) {
> @@ -1258,7 +1119,6 @@
>    }
>  }
> 
> -
>  %exception manual_user_enter_context {
>    $action
>    if (result < 0) {
> @@ -1267,7 +1127,6 @@
>    }
>  }
> 
> -
>  %exception get_default_type {
>    $action
>    if (result < 0) {
> @@ -1276,7 +1135,6 @@
>    }
>  }
> 
> -
>  %exception selabel_lookup {
>    $action
>    if (result < 0) {
> @@ -1285,7 +1143,6 @@
>    }
>  }
> 
> -
>  %exception selabel_lookup_raw {
>    $action
>    if (result < 0) {
> @@ -1294,7 +1151,6 @@
>    }
>  }
> 
> -
>  %exception selabel_lookup_best_match {
>    $action
>    if (result < 0) {
> @@ -1303,7 +1159,6 @@
>    }
>  }
> 
> -
>  %exception selabel_lookup_best_match_raw {
>    $action
>    if (result < 0) {
> @@ -1312,7 +1167,6 @@
>    }
>  }
> 
> -
>  %exception selabel_digest {
>    $action
>    if (result < 0) {
> @@ -1321,7 +1175,6 @@
>    }
>  }
> 
> -
>  %exception selinux_restorecon {
>    $action
>    if (result < 0) {
> @@ -1330,7 +1183,6 @@
>    }
>  }
> 
> -
>  %exception selinux_restorecon_set_alt_rootpath {
>    $action
>    if (result < 0) {
> @@ -1339,7 +1191,6 @@
>    }
>  }
> 
> -
>  %exception selinux_restorecon_xattr {
>    $action
>    if (result < 0) {
> @@ -1347,4 +1198,3 @@
>       SWIG_fail;
>    }
>  }
> -
> diff --git a/libsemanage/src/exception.sh b/libsemanage/src/exception.sh index
> fc1d4035a9cd..e1d01b5943f7 100644
> --- a/libsemanage/src/exception.sh
> +++ b/libsemanage/src/exception.sh
> @@ -6,8 +6,7 @@ echo "
>       PyErr_SetFromErrno(PyExc_OSError);
>       SWIG_fail;
>    }
> -}
> -"
> +}"
>  }
>  if ! ${CC:-gcc} -x c -c -I../include -o temp.o - -aux-info temp.aux <
> ../include/semanage/semanage.h  then diff --git
> a/libsemanage/src/semanageswig_python_exception.i
> b/libsemanage/src/semanageswig_python_exception.i
> index 06c60267e265..372ec948866a 100644
> --- a/libsemanage/src/semanageswig_python_exception.i
> +++ b/libsemanage/src/semanageswig_python_exception.i
> @@ -7,7 +7,6 @@
>    }
>  }
> 
> -
>  %exception semanage_get_hll_compiler_path {
>    $action
>    if (result < 0) {
> @@ -16,7 +15,6 @@
>    }
>  }
> 
> -
>  %exception semanage_get_disable_dontaudit {
>    $action
>    if (result < 0) {
> @@ -25,7 +23,6 @@
>    }
>  }
> 
> -
>  %exception semanage_set_default_priority {
>    $action
>    if (result < 0) {
> @@ -34,7 +31,6 @@
>    }
>  }
> 
> -
>  %exception semanage_is_managed {
>    $action
>    if (result < 0) {
> @@ -43,7 +39,6 @@
>    }
>  }
> 
> -
>  %exception semanage_connect {
>    $action
>    if (result < 0) {
> @@ -52,7 +47,6 @@
>    }
>  }
> 
> -
>  %exception semanage_disconnect {
>    $action
>    if (result < 0) {
> @@ -61,7 +55,6 @@
>    }
>  }
> 
> -
>  %exception semanage_begin_transaction {
>    $action
>    if (result < 0) {
> @@ -70,7 +63,6 @@
>    }
>  }
> 
> -
>  %exception semanage_commit {
>    $action
>    if (result < 0) {
> @@ -79,7 +71,6 @@
>    }
>  }
> 
> -
>  %exception semanage_access_check {
>    $action
>    if (result < 0) {
> @@ -88,7 +79,6 @@
>    }
>  }
> 
> -
>  %exception semanage_is_connected {
>    $action
>    if (result < 0) {
> @@ -97,7 +87,6 @@
>    }
>  }
> 
> -
>  %exception semanage_mls_enabled {
>    $action
>    if (result < 0) {
> @@ -106,7 +95,6 @@
>    }
>  }
> 
> -
>  %exception semanage_set_root {
>    $action
>    if (result < 0) {
> @@ -115,7 +103,6 @@
>    }
>  }
> 
> -
>  %exception semanage_get_preserve_tunables {
>    $action
>    if (result < 0) {
> @@ -124,7 +111,6 @@
>    }
>  }
> 
> -
>  %exception semanage_get_ignore_module_cache {
>    $action
>    if (result < 0) {
> @@ -133,7 +119,6 @@
>    }
>  }
> 
> -
>  %exception select {
>    $action
>    if (result < 0) {
> @@ -142,7 +127,6 @@
>    }
>  }
> 
> -
>  %exception pselect {
>    $action
>    if (result < 0) {
> @@ -151,7 +135,6 @@
>    }
>  }
> 
> -
>  %exception semanage_module_install {
>    $action
>    if (result < 0) {
> @@ -160,7 +143,6 @@
>    }
>  }
> 
> -
>  %exception semanage_module_install_file {
>    $action
>    if (result < 0) {
> @@ -169,7 +151,6 @@
>    }
>  }
> 
> -
>  %exception semanage_module_remove {
>    $action
>    if (result < 0) {
> @@ -178,7 +159,6 @@
>    }
>  }
> 
> -
>  %exception semanage_module_extract {
>    $action
>    if (result < 0) {
> @@ -187,7 +167,6 @@
>    }
>  }
> 
> -
>  %exception semanage_module_list {
>    $action
>    if (result < 0) {
> @@ -196,7 +175,6 @@
>    }
>  }
> 
> -
>  %exception semanage_module_info_create {
>    $action
>    if (result < 0) {
> @@ -205,7 +183,6 @@
>    }
>  }
> 
> -
>  %exception semanage_module_info_destroy {
>    $action
>    if (result < 0) {
> @@ -214,7 +191,6 @@
>    }
>  }
> 
> -
>  %exception semanage_module_info_get_priority {
>    $action
>    if (result < 0) {
> @@ -223,7 +199,6 @@
>    }
>  }
> 
> -
>  %exception semanage_module_info_get_name {
>    $action
>    if (result < 0) {
> @@ -232,7 +207,6 @@
>    }
>  }
> 
> -
>  %exception semanage_module_info_get_lang_ext {
>    $action
>    if (result < 0) {
> @@ -241,7 +215,6 @@
>    }
>  }
> 
> -
>  %exception semanage_module_info_get_enabled {
>    $action
>    if (result < 0) {
> @@ -250,7 +223,6 @@
>    }
>  }
> 
> -
>  %exception semanage_module_info_set_priority {
>    $action
>    if (result < 0) {
> @@ -259,7 +231,6 @@
>    }
>  }
> 
> -
>  %exception semanage_module_info_set_name {
>    $action
>    if (result < 0) {
> @@ -268,7 +239,6 @@
>    }
>  }
> 
> -
>  %exception semanage_module_info_set_lang_ext {
>    $action
>    if (result < 0) {
> @@ -277,7 +247,6 @@
>    }
>  }
> 
> -
>  %exception semanage_module_info_set_enabled {
>    $action
>    if (result < 0) {
> @@ -286,7 +255,6 @@
>    }
>  }
> 
> -
>  %exception semanage_module_key_create {
>    $action
>    if (result < 0) {
> @@ -295,7 +263,6 @@
>    }
>  }
> 
> -
>  %exception semanage_module_key_destroy {
>    $action
>    if (result < 0) {
> @@ -304,7 +271,6 @@
>    }
>  }
> 
> -
>  %exception semanage_module_key_get_name {
>    $action
>    if (result < 0) {
> @@ -313,7 +279,6 @@
>    }
>  }
> 
> -
>  %exception semanage_module_key_get_priority {
>    $action
>    if (result < 0) {
> @@ -322,7 +287,6 @@
>    }
>  }
> 
> -
>  %exception semanage_module_key_set_name {
>    $action
>    if (result < 0) {
> @@ -331,7 +295,6 @@
>    }
>  }
> 
> -
>  %exception semanage_module_key_set_priority {
>    $action
>    if (result < 0) {
> @@ -340,7 +303,6 @@
>    }
>  }
> 
> -
>  %exception semanage_module_set_enabled {
>    $action
>    if (result < 0) {
> @@ -349,7 +311,6 @@
>    }
>  }
> 
> -
>  %exception semanage_module_get_module_info {
>    $action
>    if (result < 0) {
> @@ -358,7 +319,6 @@
>    }
>  }
> 
> -
>  %exception semanage_module_list_all {
>    $action
>    if (result < 0) {
> @@ -367,7 +327,6 @@
>    }
>  }
> 
> -
>  %exception semanage_module_install_info {
>    $action
>    if (result < 0) {
> @@ -376,7 +335,6 @@
>    }
>  }
> 
> -
>  %exception semanage_module_remove_key {
>    $action
>    if (result < 0) {
> @@ -385,7 +343,6 @@
>    }
>  }
> 
> -
>  %exception semanage_module_get_enabled {
>    $action
>    if (result < 0) {
> @@ -394,7 +351,6 @@
>    }
>  }
> 
> -
>  %exception semanage_msg_get_level {
>    $action
>    if (result < 0) {
> @@ -403,7 +359,6 @@
>    }
>  }
> 
> -
>  %exception semanage_bool_key_create {
>    $action
>    if (result < 0) {
> @@ -412,7 +367,6 @@
>    }
>  }
> 
> -
>  %exception semanage_bool_key_extract {
>    $action
>    if (result < 0) {
> @@ -421,7 +375,6 @@
>    }
>  }
> 
> -
>  %exception semanage_bool_compare {
>    $action
>    if (result < 0) {
> @@ -430,7 +383,6 @@
>    }
>  }
> 
> -
>  %exception semanage_bool_compare2 {
>    $action
>    if (result < 0) {
> @@ -439,7 +391,6 @@
>    }
>  }
> 
> -
>  %exception semanage_bool_set_name {
>    $action
>    if (result < 0) {
> @@ -448,7 +399,6 @@
>    }
>  }
> 
> -
>  %exception semanage_bool_get_value {
>    $action
>    if (result < 0) {
> @@ -457,7 +407,6 @@
>    }
>  }
> 
> -
>  %exception semanage_bool_create {
>    $action
>    if (result < 0) {
> @@ -466,7 +415,6 @@
>    }
>  }
> 
> -
>  %exception semanage_bool_clone {
>    $action
>    if (result < 0) {
> @@ -475,7 +423,6 @@
>    }
>  }
> 
> -
>  %exception semanage_user_key_create {
>    $action
>    if (result < 0) {
> @@ -484,7 +431,6 @@
>    }
>  }
> 
> -
>  %exception semanage_user_key_extract {
>    $action
>    if (result < 0) {
> @@ -493,7 +439,6 @@
>    }
>  }
> 
> -
>  %exception semanage_user_compare {
>    $action
>    if (result < 0) {
> @@ -502,7 +447,6 @@
>    }
>  }
> 
> -
>  %exception semanage_user_compare2 {
>    $action
>    if (result < 0) {
> @@ -511,7 +455,6 @@
>    }
>  }
> 
> -
>  %exception semanage_user_set_name {
>    $action
>    if (result < 0) {
> @@ -520,7 +463,6 @@
>    }
>  }
> 
> -
>  %exception semanage_user_set_prefix {
>    $action
>    if (result < 0) {
> @@ -529,7 +471,6 @@
>    }
>  }
> 
> -
>  %exception semanage_user_set_mlslevel {
>    $action
>    if (result < 0) {
> @@ -538,7 +479,6 @@
>    }
>  }
> 
> -
>  %exception semanage_user_set_mlsrange {
>    $action
>    if (result < 0) {
> @@ -547,7 +487,6 @@
>    }
>  }
> 
> -
>  %exception semanage_user_get_num_roles {
>    $action
>    if (result < 0) {
> @@ -556,7 +495,6 @@
>    }
>  }
> 
> -
>  %exception semanage_user_add_role {
>    $action
>    if (result < 0) {
> @@ -565,7 +503,6 @@
>    }
>  }
> 
> -
>  %exception semanage_user_has_role {
>    $action
>    if (result < 0) {
> @@ -574,7 +511,6 @@
>    }
>  }
> 
> -
>  %exception semanage_user_get_roles {
>    $action
>    if (result < 0) {
> @@ -583,7 +519,6 @@
>    }
>  }
> 
> -
>  %exception semanage_user_set_roles {
>    $action
>    if (result < 0) {
> @@ -592,7 +527,6 @@
>    }
>  }
> 
> -
>  %exception semanage_user_create {
>    $action
>    if (result < 0) {
> @@ -601,7 +535,6 @@
>    }
>  }
> 
> -
>  %exception semanage_user_clone {
>    $action
>    if (result < 0) {
> @@ -610,7 +543,6 @@
>    }
>  }
> 
> -
>  %exception semanage_seuser_key_create {
>    $action
>    if (result < 0) {
> @@ -619,7 +551,6 @@
>    }
>  }
> 
> -
>  %exception semanage_seuser_key_extract {
>    $action
>    if (result < 0) {
> @@ -628,7 +559,6 @@
>    }
>  }
> 
> -
>  %exception semanage_seuser_compare {
>    $action
>    if (result < 0) {
> @@ -637,7 +567,6 @@
>    }
>  }
> 
> -
>  %exception semanage_seuser_compare2 {
>    $action
>    if (result < 0) {
> @@ -646,7 +575,6 @@
>    }
>  }
> 
> -
>  %exception semanage_seuser_set_name {
>    $action
>    if (result < 0) {
> @@ -655,7 +583,6 @@
>    }
>  }
> 
> -
>  %exception semanage_seuser_set_sename {
>    $action
>    if (result < 0) {
> @@ -664,7 +591,6 @@
>    }
>  }
> 
> -
>  %exception semanage_seuser_set_mlsrange {
>    $action
>    if (result < 0) {
> @@ -673,7 +599,6 @@
>    }
>  }
> 
> -
>  %exception semanage_seuser_create {
>    $action
>    if (result < 0) {
> @@ -682,7 +607,6 @@
>    }
>  }
> 
> -
>  %exception semanage_seuser_clone {
>    $action
>    if (result < 0) {
> @@ -691,7 +615,6 @@
>    }
>  }
> 
> -
>  %exception semanage_context_set_user {
>    $action
>    if (result < 0) {
> @@ -700,7 +623,6 @@
>    }
>  }
> 
> -
>  %exception semanage_context_set_role {
>    $action
>    if (result < 0) {
> @@ -709,7 +631,6 @@
>    }
>  }
> 
> -
>  %exception semanage_context_set_type {
>    $action
>    if (result < 0) {
> @@ -718,7 +639,6 @@
>    }
>  }
> 
> -
>  %exception semanage_context_set_mls {
>    $action
>    if (result < 0) {
> @@ -727,7 +647,6 @@
>    }
>  }
> 
> -
>  %exception semanage_context_create {
>    $action
>    if (result < 0) {
> @@ -736,7 +655,6 @@
>    }
>  }
> 
> -
>  %exception semanage_context_clone {
>    $action
>    if (result < 0) {
> @@ -745,7 +663,6 @@
>    }
>  }
> 
> -
>  %exception semanage_context_from_string {
>    $action
>    if (result < 0) {
> @@ -754,7 +671,6 @@
>    }
>  }
> 
> -
>  %exception semanage_context_to_string {
>    $action
>    if (result < 0) {
> @@ -763,7 +679,6 @@
>    }
>  }
> 
> -
>  %exception semanage_iface_compare {
>    $action
>    if (result < 0) {
> @@ -772,7 +687,6 @@
>    }
>  }
> 
> -
>  %exception semanage_iface_compare2 {
>    $action
>    if (result < 0) {
> @@ -781,7 +695,6 @@
>    }
>  }
> 
> -
>  %exception semanage_iface_key_create {
>    $action
>    if (result < 0) {
> @@ -790,7 +703,6 @@
>    }
>  }
> 
> -
>  %exception semanage_iface_key_extract {
>    $action
>    if (result < 0) {
> @@ -799,7 +711,6 @@
>    }
>  }
> 
> -
>  %exception semanage_iface_set_name {
>    $action
>    if (result < 0) {
> @@ -808,7 +719,6 @@
>    }
>  }
> 
> -
>  %exception semanage_iface_set_ifcon {
>    $action
>    if (result < 0) {
> @@ -817,7 +727,6 @@
>    }
>  }
> 
> -
>  %exception semanage_iface_set_msgcon {
>    $action
>    if (result < 0) {
> @@ -826,7 +735,6 @@
>    }
>  }
> 
> -
>  %exception semanage_iface_create {
>    $action
>    if (result < 0) {
> @@ -835,7 +743,6 @@
>    }
>  }
> 
> -
>  %exception semanage_iface_clone {
>    $action
>    if (result < 0) {
> @@ -844,7 +751,6 @@
>    }
>  }
> 
> -
>  %exception semanage_port_compare {
>    $action
>    if (result < 0) {
> @@ -853,7 +759,6 @@
>    }
>  }
> 
> -
>  %exception semanage_port_compare2 {
>    $action
>    if (result < 0) {
> @@ -862,7 +767,6 @@
>    }
>  }
> 
> -
>  %exception semanage_port_key_create {
>    $action
>    if (result < 0) {
> @@ -871,7 +775,6 @@
>    }
>  }
> 
> -
>  %exception semanage_port_key_extract {
>    $action
>    if (result < 0) {
> @@ -880,7 +783,6 @@
>    }
>  }
> 
> -
>  %exception semanage_port_get_proto {
>    $action
>    if (result < 0) {
> @@ -889,7 +791,6 @@
>    }
>  }
> 
> -
>  %exception semanage_port_get_low {
>    $action
>    if (result < 0) {
> @@ -898,7 +799,6 @@
>    }
>  }
> 
> -
>  %exception semanage_port_get_high {
>    $action
>    if (result < 0) {
> @@ -907,7 +807,6 @@
>    }
>  }
> 
> -
>  %exception semanage_port_set_con {
>    $action
>    if (result < 0) {
> @@ -916,7 +815,6 @@
>    }
>  }
> 
> -
>  %exception semanage_port_create {
>    $action
>    if (result < 0) {
> @@ -925,7 +823,6 @@
>    }
>  }
> 
> -
>  %exception semanage_port_clone {
>    $action
>    if (result < 0) {
> @@ -934,7 +831,6 @@
>    }
>  }
> 
> -
>  %exception semanage_ibpkey_compare {
>    $action
>    if (result < 0) {
> @@ -943,7 +839,6 @@
>    }
>  }
> 
> -
>  %exception semanage_ibpkey_compare2 {
>    $action
>    if (result < 0) {
> @@ -952,7 +847,6 @@
>    }
>  }
> 
> -
>  %exception semanage_ibpkey_key_create {
>    $action
>    if (result < 0) {
> @@ -961,7 +855,6 @@
>    }
>  }
> 
> -
>  %exception semanage_ibpkey_key_extract {
>    $action
>    if (result < 0) {
> @@ -970,7 +863,6 @@
>    }
>  }
> 
> -
>  %exception semanage_ibpkey_get_subnet_prefix {
>    $action
>    if (result < 0) {
> @@ -979,7 +871,6 @@
>    }
>  }
> 
> -
>  %exception semanage_ibpkey_set_subnet_prefix {
>    $action
>    if (result < 0) {
> @@ -988,7 +879,6 @@
>    }
>  }
> 
> -
>  %exception semanage_ibpkey_get_low {
>    $action
>    if (result < 0) {
> @@ -997,7 +887,6 @@
>    }
>  }
> 
> -
>  %exception semanage_ibpkey_get_high {
>    $action
>    if (result < 0) {
> @@ -1006,7 +895,6 @@
>    }
>  }
> 
> -
>  %exception semanage_ibpkey_set_con {
>    $action
>    if (result < 0) {
> @@ -1015,7 +903,6 @@
>    }
>  }
> 
> -
>  %exception semanage_ibpkey_create {
>    $action
>    if (result < 0) {
> @@ -1024,7 +911,6 @@
>    }
>  }
> 
> -
>  %exception semanage_ibpkey_clone {
>    $action
>    if (result < 0) {
> @@ -1033,7 +919,6 @@
>    }
>  }
> 
> -
>  %exception semanage_ibendport_compare {
>    $action
>    if (result < 0) {
> @@ -1042,7 +927,6 @@
>    }
>  }
> 
> -
>  %exception semanage_ibendport_compare2 {
>    $action
>    if (result < 0) {
> @@ -1051,7 +935,6 @@
>    }
>  }
> 
> -
>  %exception semanage_ibendport_key_create {
>    $action
>    if (result < 0) {
> @@ -1060,7 +943,6 @@
>    }
>  }
> 
> -
>  %exception semanage_ibendport_key_extract {
>    $action
>    if (result < 0) {
> @@ -1069,7 +951,6 @@
>    }
>  }
> 
> -
>  %exception semanage_ibendport_get_ibdev_name {
>    $action
>    if (result < 0) {
> @@ -1078,7 +959,6 @@
>    }
>  }
> 
> -
>  %exception semanage_ibendport_set_ibdev_name {
>    $action
>    if (result < 0) {
> @@ -1087,7 +967,6 @@
>    }
>  }
> 
> -
>  %exception semanage_ibendport_get_port {
>    $action
>    if (result < 0) {
> @@ -1096,7 +975,6 @@
>    }
>  }
> 
> -
>  %exception semanage_ibendport_set_con {
>    $action
>    if (result < 0) {
> @@ -1105,7 +983,6 @@
>    }
>  }
> 
> -
>  %exception semanage_ibendport_create {
>    $action
>    if (result < 0) {
> @@ -1114,7 +991,6 @@
>    }
>  }
> 
> -
>  %exception semanage_ibendport_clone {
>    $action
>    if (result < 0) {
> @@ -1123,7 +999,6 @@
>    }
>  }
> 
> -
>  %exception semanage_node_compare {
>    $action
>    if (result < 0) {
> @@ -1132,7 +1007,6 @@
>    }
>  }
> 
> -
>  %exception semanage_node_compare2 {
>    $action
>    if (result < 0) {
> @@ -1141,7 +1015,6 @@
>    }
>  }
> 
> -
>  %exception semanage_node_key_create {
>    $action
>    if (result < 0) {
> @@ -1150,7 +1023,6 @@
>    }
>  }
> 
> -
>  %exception semanage_node_key_extract {
>    $action
>    if (result < 0) {
> @@ -1159,7 +1031,6 @@
>    }
>  }
> 
> -
>  %exception semanage_node_get_addr {
>    $action
>    if (result < 0) {
> @@ -1168,7 +1039,6 @@
>    }
>  }
> 
> -
>  %exception semanage_node_get_addr_bytes {
>    $action
>    if (result < 0) {
> @@ -1177,7 +1047,6 @@
>    }
>  }
> 
> -
>  %exception semanage_node_set_addr {
>    $action
>    if (result < 0) {
> @@ -1186,7 +1055,6 @@
>    }
>  }
> 
> -
>  %exception semanage_node_set_addr_bytes {
>    $action
>    if (result < 0) {
> @@ -1195,7 +1063,6 @@
>    }
>  }
> 
> -
>  %exception semanage_node_get_mask {
>    $action
>    if (result < 0) {
> @@ -1204,7 +1071,6 @@
>    }
>  }
> 
> -
>  %exception semanage_node_get_mask_bytes {
>    $action
>    if (result < 0) {
> @@ -1213,7 +1079,6 @@
>    }
>  }
> 
> -
>  %exception semanage_node_set_mask {
>    $action
>    if (result < 0) {
> @@ -1222,7 +1087,6 @@
>    }
>  }
> 
> -
>  %exception semanage_node_set_mask_bytes {
>    $action
>    if (result < 0) {
> @@ -1231,7 +1095,6 @@
>    }
>  }
> 
> -
>  %exception semanage_node_get_proto {
>    $action
>    if (result < 0) {
> @@ -1240,7 +1103,6 @@
>    }
>  }
> 
> -
>  %exception semanage_node_set_con {
>    $action
>    if (result < 0) {
> @@ -1249,7 +1111,6 @@
>    }
>  }
> 
> -
>  %exception semanage_node_create {
>    $action
>    if (result < 0) {
> @@ -1258,7 +1119,6 @@
>    }
>  }
> 
> -
>  %exception semanage_node_clone {
>    $action
>    if (result < 0) {
> @@ -1267,7 +1127,6 @@
>    }
>  }
> 
> -
>  %exception semanage_bool_modify_local {
>    $action
>    if (result < 0) {
> @@ -1276,7 +1135,6 @@
>    }
>  }
> 
> -
>  %exception semanage_bool_del_local {
>    $action
>    if (result < 0) {
> @@ -1285,7 +1143,6 @@
>    }
>  }
> 
> -
>  %exception semanage_bool_query_local {
>    $action
>    if (result < 0) {
> @@ -1294,7 +1151,6 @@
>    }
>  }
> 
> -
>  %exception semanage_bool_exists_local {
>    $action
>    if (result < 0) {
> @@ -1303,7 +1159,6 @@
>    }
>  }
> 
> -
>  %exception semanage_bool_count_local {
>    $action
>    if (result < 0) {
> @@ -1312,7 +1167,6 @@
>    }
>  }
> 
> -
>  %exception semanage_bool_iterate_local {
>    $action
>    if (result < 0) {
> @@ -1321,7 +1175,6 @@
>    }
>  }
> 
> -
>  %exception semanage_bool_list_local {
>    $action
>    if (result < 0) {
> @@ -1330,7 +1183,6 @@
>    }
>  }
> 
> -
>  %exception semanage_bool_query {
>    $action
>    if (result < 0) {
> @@ -1339,7 +1191,6 @@
>    }
>  }
> 
> -
>  %exception semanage_bool_exists {
>    $action
>    if (result < 0) {
> @@ -1348,7 +1199,6 @@
>    }
>  }
> 
> -
>  %exception semanage_bool_count {
>    $action
>    if (result < 0) {
> @@ -1357,7 +1207,6 @@
>    }
>  }
> 
> -
>  %exception semanage_bool_iterate {
>    $action
>    if (result < 0) {
> @@ -1366,7 +1215,6 @@
>    }
>  }
> 
> -
>  %exception semanage_bool_list {
>    $action
>    if (result < 0) {
> @@ -1375,7 +1223,6 @@
>    }
>  }
> 
> -
>  %exception semanage_bool_set_active {
>    $action
>    if (result < 0) {
> @@ -1384,7 +1231,6 @@
>    }
>  }
> 
> -
>  %exception semanage_bool_query_active {
>    $action
>    if (result < 0) {
> @@ -1393,7 +1239,6 @@
>    }
>  }
> 
> -
>  %exception semanage_bool_exists_active {
>    $action
>    if (result < 0) {
> @@ -1402,7 +1247,6 @@
>    }
>  }
> 
> -
>  %exception semanage_bool_count_active {
>    $action
>    if (result < 0) {
> @@ -1411,7 +1255,6 @@
>    }
>  }
> 
> -
>  %exception semanage_bool_iterate_active {
>    $action
>    if (result < 0) {
> @@ -1420,7 +1263,6 @@
>    }
>  }
> 
> -
>  %exception semanage_bool_list_active {
>    $action
>    if (result < 0) {
> @@ -1429,7 +1271,6 @@
>    }
>  }
> 
> -
>  %exception semanage_user_modify_local {
>    $action
>    if (result < 0) {
> @@ -1438,7 +1279,6 @@
>    }
>  }
> 
> -
>  %exception semanage_user_del_local {
>    $action
>    if (result < 0) {
> @@ -1447,7 +1287,6 @@
>    }
>  }
> 
> -
>  %exception semanage_user_query_local {
>    $action
>    if (result < 0) {
> @@ -1456,7 +1295,6 @@
>    }
>  }
> 
> -
>  %exception semanage_user_exists_local {
>    $action
>    if (result < 0) {
> @@ -1465,7 +1303,6 @@
>    }
>  }
> 
> -
>  %exception semanage_user_count_local {
>    $action
>    if (result < 0) {
> @@ -1474,7 +1311,6 @@
>    }
>  }
> 
> -
>  %exception semanage_user_iterate_local {
>    $action
>    if (result < 0) {
> @@ -1483,7 +1319,6 @@
>    }
>  }
> 
> -
>  %exception semanage_user_list_local {
>    $action
>    if (result < 0) {
> @@ -1492,7 +1327,6 @@
>    }
>  }
> 
> -
>  %exception semanage_user_query {
>    $action
>    if (result < 0) {
> @@ -1501,7 +1335,6 @@
>    }
>  }
> 
> -
>  %exception semanage_user_exists {
>    $action
>    if (result < 0) {
> @@ -1510,7 +1343,6 @@
>    }
>  }
> 
> -
>  %exception semanage_user_count {
>    $action
>    if (result < 0) {
> @@ -1519,7 +1351,6 @@
>    }
>  }
> 
> -
>  %exception semanage_user_iterate {
>    $action
>    if (result < 0) {
> @@ -1528,7 +1359,6 @@
>    }
>  }
> 
> -
>  %exception semanage_user_list {
>    $action
>    if (result < 0) {
> @@ -1537,7 +1367,6 @@
>    }
>  }
> 
> -
>  %exception semanage_fcontext_compare {
>    $action
>    if (result < 0) {
> @@ -1546,7 +1375,6 @@
>    }
>  }
> 
> -
>  %exception semanage_fcontext_compare2 {
>    $action
>    if (result < 0) {
> @@ -1555,7 +1383,6 @@
>    }
>  }
> 
> -
>  %exception semanage_fcontext_key_create {
>    $action
>    if (result < 0) {
> @@ -1564,7 +1391,6 @@
>    }
>  }
> 
> -
>  %exception semanage_fcontext_key_extract {
>    $action
>    if (result < 0) {
> @@ -1573,7 +1399,6 @@
>    }
>  }
> 
> -
>  %exception semanage_fcontext_set_expr {
>    $action
>    if (result < 0) {
> @@ -1582,7 +1407,6 @@
>    }
>  }
> 
> -
>  %exception semanage_fcontext_get_type {
>    $action
>    if (result < 0) {
> @@ -1591,7 +1415,6 @@
>    }
>  }
> 
> -
>  %exception semanage_fcontext_set_con {
>    $action
>    if (result < 0) {
> @@ -1600,7 +1423,6 @@
>    }
>  }
> 
> -
>  %exception semanage_fcontext_create {
>    $action
>    if (result < 0) {
> @@ -1609,7 +1431,6 @@
>    }
>  }
> 
> -
>  %exception semanage_fcontext_clone {
>    $action
>    if (result < 0) {
> @@ -1618,7 +1439,6 @@
>    }
>  }
> 
> -
>  %exception semanage_fcontext_modify_local {
>    $action
>    if (result < 0) {
> @@ -1627,7 +1447,6 @@
>    }
>  }
> 
> -
>  %exception semanage_fcontext_del_local {
>    $action
>    if (result < 0) {
> @@ -1636,7 +1455,6 @@
>    }
>  }
> 
> -
>  %exception semanage_fcontext_query_local {
>    $action
>    if (result < 0) {
> @@ -1645,7 +1463,6 @@
>    }
>  }
> 
> -
>  %exception semanage_fcontext_exists_local {
>    $action
>    if (result < 0) {
> @@ -1654,7 +1471,6 @@
>    }
>  }
> 
> -
>  %exception semanage_fcontext_count_local {
>    $action
>    if (result < 0) {
> @@ -1663,7 +1479,6 @@
>    }
>  }
> 
> -
>  %exception semanage_fcontext_iterate_local {
>    $action
>    if (result < 0) {
> @@ -1672,7 +1487,6 @@
>    }
>  }
> 
> -
>  %exception semanage_fcontext_list_local {
>    $action
>    if (result < 0) {
> @@ -1681,7 +1495,6 @@
>    }
>  }
> 
> -
>  %exception semanage_fcontext_query {
>    $action
>    if (result < 0) {
> @@ -1690,7 +1503,6 @@
>    }
>  }
> 
> -
>  %exception semanage_fcontext_exists {
>    $action
>    if (result < 0) {
> @@ -1699,7 +1511,6 @@
>    }
>  }
> 
> -
>  %exception semanage_fcontext_count {
>    $action
>    if (result < 0) {
> @@ -1708,7 +1519,6 @@
>    }
>  }
> 
> -
>  %exception semanage_fcontext_iterate {
>    $action
>    if (result < 0) {
> @@ -1717,7 +1527,6 @@
>    }
>  }
> 
> -
>  %exception semanage_fcontext_list {
>    $action
>    if (result < 0) {
> @@ -1726,7 +1535,6 @@
>    }
>  }
> 
> -
>  %exception semanage_fcontext_list_homedirs {
>    $action
>    if (result < 0) {
> @@ -1735,7 +1543,6 @@
>    }
>  }
> 
> -
>  %exception semanage_seuser_modify_local {
>    $action
>    if (result < 0) {
> @@ -1744,7 +1551,6 @@
>    }
>  }
> 
> -
>  %exception semanage_seuser_del_local {
>    $action
>    if (result < 0) {
> @@ -1753,7 +1559,6 @@
>    }
>  }
> 
> -
>  %exception semanage_seuser_query_local {
>    $action
>    if (result < 0) {
> @@ -1762,7 +1567,6 @@
>    }
>  }
> 
> -
>  %exception semanage_seuser_exists_local {
>    $action
>    if (result < 0) {
> @@ -1771,7 +1575,6 @@
>    }
>  }
> 
> -
>  %exception semanage_seuser_count_local {
>    $action
>    if (result < 0) {
> @@ -1780,7 +1583,6 @@
>    }
>  }
> 
> -
>  %exception semanage_seuser_iterate_local {
>    $action
>    if (result < 0) {
> @@ -1789,7 +1591,6 @@
>    }
>  }
> 
> -
>  %exception semanage_seuser_list_local {
>    $action
>    if (result < 0) {
> @@ -1798,7 +1599,6 @@
>    }
>  }
> 
> -
>  %exception semanage_seuser_query {
>    $action
>    if (result < 0) {
> @@ -1807,7 +1607,6 @@
>    }
>  }
> 
> -
>  %exception semanage_seuser_exists {
>    $action
>    if (result < 0) {
> @@ -1816,7 +1615,6 @@
>    }
>  }
> 
> -
>  %exception semanage_seuser_count {
>    $action
>    if (result < 0) {
> @@ -1825,7 +1623,6 @@
>    }
>  }
> 
> -
>  %exception semanage_seuser_iterate {
>    $action
>    if (result < 0) {
> @@ -1834,7 +1631,6 @@
>    }
>  }
> 
> -
>  %exception semanage_seuser_list {
>    $action
>    if (result < 0) {
> @@ -1843,7 +1639,6 @@
>    }
>  }
> 
> -
>  %exception semanage_port_modify_local {
>    $action
>    if (result < 0) {
> @@ -1852,7 +1647,6 @@
>    }
>  }
> 
> -
>  %exception semanage_port_del_local {
>    $action
>    if (result < 0) {
> @@ -1861,7 +1655,6 @@
>    }
>  }
> 
> -
>  %exception semanage_port_query_local {
>    $action
>    if (result < 0) {
> @@ -1870,7 +1663,6 @@
>    }
>  }
> 
> -
>  %exception semanage_port_exists_local {
>    $action
>    if (result < 0) {
> @@ -1879,7 +1671,6 @@
>    }
>  }
> 
> -
>  %exception semanage_port_count_local {
>    $action
>    if (result < 0) {
> @@ -1888,7 +1679,6 @@
>    }
>  }
> 
> -
>  %exception semanage_port_iterate_local {
>    $action
>    if (result < 0) {
> @@ -1897,7 +1687,6 @@
>    }
>  }
> 
> -
>  %exception semanage_port_list_local {
>    $action
>    if (result < 0) {
> @@ -1906,7 +1695,6 @@
>    }
>  }
> 
> -
>  %exception semanage_port_query {
>    $action
>    if (result < 0) {
> @@ -1915,7 +1703,6 @@
>    }
>  }
> 
> -
>  %exception semanage_port_exists {
>    $action
>    if (result < 0) {
> @@ -1924,7 +1711,6 @@
>    }
>  }
> 
> -
>  %exception semanage_port_count {
>    $action
>    if (result < 0) {
> @@ -1933,7 +1719,6 @@
>    }
>  }
> 
> -
>  %exception semanage_port_iterate {
>    $action
>    if (result < 0) {
> @@ -1942,7 +1727,6 @@
>    }
>  }
> 
> -
>  %exception semanage_port_list {
>    $action
>    if (result < 0) {
> @@ -1951,7 +1735,6 @@
>    }
>  }
> 
> -
>  %exception semanage_ibpkey_modify_local {
>    $action
>    if (result < 0) {
> @@ -1960,7 +1743,6 @@
>    }
>  }
> 
> -
>  %exception semanage_ibpkey_del_local {
>    $action
>    if (result < 0) {
> @@ -1969,7 +1751,6 @@
>    }
>  }
> 
> -
>  %exception semanage_ibpkey_query_local {
>    $action
>    if (result < 0) {
> @@ -1978,7 +1759,6 @@
>    }
>  }
> 
> -
>  %exception semanage_ibpkey_exists_local {
>    $action
>    if (result < 0) {
> @@ -1987,7 +1767,6 @@
>    }
>  }
> 
> -
>  %exception semanage_ibpkey_count_local {
>    $action
>    if (result < 0) {
> @@ -1996,7 +1775,6 @@
>    }
>  }
> 
> -
>  %exception semanage_ibpkey_iterate_local {
>    $action
>    if (result < 0) {
> @@ -2005,7 +1783,6 @@
>    }
>  }
> 
> -
>  %exception semanage_ibpkey_list_local {
>    $action
>    if (result < 0) {
> @@ -2014,7 +1791,6 @@
>    }
>  }
> 
> -
>  %exception semanage_ibendport_modify_local {
>    $action
>    if (result < 0) {
> @@ -2023,7 +1799,6 @@
>    }
>  }
> 
> -
>  %exception semanage_ibendport_del_local {
>    $action
>    if (result < 0) {
> @@ -2032,7 +1807,6 @@
>    }
>  }
> 
> -
>  %exception semanage_ibendport_query_local {
>    $action
>    if (result < 0) {
> @@ -2041,7 +1815,6 @@
>    }
>  }
> 
> -
>  %exception semanage_ibendport_exists_local {
>    $action
>    if (result < 0) {
> @@ -2050,7 +1823,6 @@
>    }
>  }
> 
> -
>  %exception semanage_ibendport_count_local {
>    $action
>    if (result < 0) {
> @@ -2059,7 +1831,6 @@
>    }
>  }
> 
> -
>  %exception semanage_ibendport_iterate_local {
>    $action
>    if (result < 0) {
> @@ -2068,7 +1839,6 @@
>    }
>  }
> 
> -
>  %exception semanage_ibendport_list_local {
>    $action
>    if (result < 0) {
> @@ -2077,7 +1847,6 @@
>    }
>  }
> 
> -
>  %exception semanage_ibendport_query {
>    $action
>    if (result < 0) {
> @@ -2086,7 +1855,6 @@
>    }
>  }
> 
> -
>  %exception semanage_ibendport_exists {
>    $action
>    if (result < 0) {
> @@ -2095,7 +1863,6 @@
>    }
>  }
> 
> -
>  %exception semanage_ibendport_count {
>    $action
>    if (result < 0) {
> @@ -2104,7 +1871,6 @@
>    }
>  }
> 
> -
>  %exception semanage_ibendport_iterate {
>    $action
>    if (result < 0) {
> @@ -2113,7 +1879,6 @@
>    }
>  }
> 
> -
>  %exception semanage_ibendport_list {
>    $action
>    if (result < 0) {
> @@ -2122,7 +1887,6 @@
>    }
>  }
> 
> -
>  %exception semanage_ibpkey_query {
>    $action
>    if (result < 0) {
> @@ -2131,7 +1895,6 @@
>    }
>  }
> 
> -
>  %exception semanage_ibpkey_exists {
>    $action
>    if (result < 0) {
> @@ -2140,7 +1903,6 @@
>    }
>  }
> 
> -
>  %exception semanage_ibpkey_count {
>    $action
>    if (result < 0) {
> @@ -2149,7 +1911,6 @@
>    }
>  }
> 
> -
>  %exception semanage_ibpkey_iterate {
>    $action
>    if (result < 0) {
> @@ -2158,7 +1919,6 @@
>    }
>  }
> 
> -
>  %exception semanage_ibpkey_list {
>    $action
>    if (result < 0) {
> @@ -2167,7 +1927,6 @@
>    }
>  }
> 
> -
>  %exception semanage_iface_modify_local {
>    $action
>    if (result < 0) {
> @@ -2176,7 +1935,6 @@
>    }
>  }
> 
> -
>  %exception semanage_iface_del_local {
>    $action
>    if (result < 0) {
> @@ -2185,7 +1943,6 @@
>    }
>  }
> 
> -
>  %exception semanage_iface_query_local {
>    $action
>    if (result < 0) {
> @@ -2194,7 +1951,6 @@
>    }
>  }
> 
> -
>  %exception semanage_iface_exists_local {
>    $action
>    if (result < 0) {
> @@ -2203,7 +1959,6 @@
>    }
>  }
> 
> -
>  %exception semanage_iface_count_local {
>    $action
>    if (result < 0) {
> @@ -2212,7 +1967,6 @@
>    }
>  }
> 
> -
>  %exception semanage_iface_iterate_local {
>    $action
>    if (result < 0) {
> @@ -2221,7 +1975,6 @@
>    }
>  }
> 
> -
>  %exception semanage_iface_list_local {
>    $action
>    if (result < 0) {
> @@ -2230,7 +1983,6 @@
>    }
>  }
> 
> -
>  %exception semanage_iface_query {
>    $action
>    if (result < 0) {
> @@ -2239,7 +1991,6 @@
>    }
>  }
> 
> -
>  %exception semanage_iface_exists {
>    $action
>    if (result < 0) {
> @@ -2248,7 +1999,6 @@
>    }
>  }
> 
> -
>  %exception semanage_iface_count {
>    $action
>    if (result < 0) {
> @@ -2257,7 +2007,6 @@
>    }
>  }
> 
> -
>  %exception semanage_iface_iterate {
>    $action
>    if (result < 0) {
> @@ -2266,7 +2015,6 @@
>    }
>  }
> 
> -
>  %exception semanage_iface_list {
>    $action
>    if (result < 0) {
> @@ -2275,7 +2023,6 @@
>    }
>  }
> 
> -
>  %exception semanage_node_modify_local {
>    $action
>    if (result < 0) {
> @@ -2284,7 +2031,6 @@
>    }
>  }
> 
> -
>  %exception semanage_node_del_local {
>    $action
>    if (result < 0) {
> @@ -2293,7 +2039,6 @@
>    }
>  }
> 
> -
>  %exception semanage_node_query_local {
>    $action
>    if (result < 0) {
> @@ -2302,7 +2047,6 @@
>    }
>  }
> 
> -
>  %exception semanage_node_exists_local {
>    $action
>    if (result < 0) {
> @@ -2311,7 +2055,6 @@
>    }
>  }
> 
> -
>  %exception semanage_node_count_local {
>    $action
>    if (result < 0) {
> @@ -2320,7 +2063,6 @@
>    }
>  }
> 
> -
>  %exception semanage_node_iterate_local {
>    $action
>    if (result < 0) {
> @@ -2329,7 +2071,6 @@
>    }
>  }
> 
> -
>  %exception semanage_node_list_local {
>    $action
>    if (result < 0) {
> @@ -2338,7 +2079,6 @@
>    }
>  }
> 
> -
>  %exception semanage_node_query {
>    $action
>    if (result < 0) {
> @@ -2347,7 +2087,6 @@
>    }
>  }
> 
> -
>  %exception semanage_node_exists {
>    $action
>    if (result < 0) {
> @@ -2356,7 +2095,6 @@
>    }
>  }
> 
> -
>  %exception semanage_node_count {
>    $action
>    if (result < 0) {
> @@ -2365,7 +2103,6 @@
>    }
>  }
> 
> -
>  %exception semanage_node_iterate {
>    $action
>    if (result < 0) {
> @@ -2374,7 +2111,6 @@
>    }
>  }
> 
> -
>  %exception semanage_node_list {
>    $action
>    if (result < 0) {
> @@ -2382,4 +2118,3 @@
>       SWIG_fail;
>    }
>  }
> -
> --
> 2.26.0

Thanks.

Acked-by: William Roberts <william.c.roberts@intel.com>
