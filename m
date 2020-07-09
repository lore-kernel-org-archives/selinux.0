Return-Path: <SRS0=XbfQ=AU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE1EFC433E0
	for <selinux@archiver.kernel.org>; Thu,  9 Jul 2020 14:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88AA82073A
	for <selinux@archiver.kernel.org>; Thu,  9 Jul 2020 14:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="MajkvhxJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgGIOO6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Jul 2020 10:14:58 -0400
Received: from mailomta20-re.btinternet.com ([213.120.69.113]:59218 "EHLO
        re-prd-fep-048.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726371AbgGIOO6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Jul 2020 10:14:58 -0400
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])
          by re-prd-fep-048.btinternet.com with ESMTP
          id <20200709141455.MKJW4701.re-prd-fep-048.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>;
          Thu, 9 Jul 2020 15:14:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1594304095; 
        bh=Vfr90p/G8gRfC2jxM24U2QuAHCdmBF8s1ah1g6w89jU=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:MIME-Version;
        b=MajkvhxJZqv0dYOqrHPw84Mk1dUGp/bO5NctftafrF/gxOo00DvVPrbXY5LQPFqbLWA3AtSY1dFfI6NJbbs8Cu7z0LXTPQ598SuI1QFkCCDqjfOMJu9+djuEyO4e6zsX7BNEyQtTx/hdSvjefkzh9wkNjefxkOhYpiXhQn2nN4q2yjApYGer722Ohs0kVKRS0LV0NXj9YwTpQ++YoXUe4mbAY7DVY4ZH+MklBi8+yj2X8Wqg6IlQFpjBanaRiT2jUjvRCU23rJpQykVFgxHnt9CoRxupNIHOmIdRTlp7rvTdqst+XCKC4PkasZFTbxsGojEiC+xntgTWIpsIJ5g62A==
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [109.158.127.33]
X-OWM-Source-IP: 109.158.127.33 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrudelgdejhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepffdtjeevfffggfetvdffveeuteehgeeihfeiffdutdehjefhveetgfelhfetjeegnecuffhomhgrihhnpehrvgguhhgrthdrtghomhenucfkphepuddtledrudehkedruddvjedrfeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghlohepnhhfshdqtghlihgvnhhtpdhinhgvthepuddtledrudehkedruddvjedrfeefpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeoughomhhinhhitghkrdhgrhhifhhtseguvghfvghnshgvtgdrnhhlqedprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from nfs-client (109.158.127.33) by re-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9C2FD060194CF; Thu, 9 Jul 2020 15:14:55 +0100
Message-ID: <4dda5d887f71fa8fa8aa55c458d85faa958eae98.camel@btinternet.com>
Subject: Re: [SELinux-notebook PATCH] pam_login.md: pam_selinux_permit is
 known as pam_sepermit upstream
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Dominick Grift <dominick.grift@defensec.nl>,
        selinux@vger.kernel.org
Date:   Thu, 09 Jul 2020 15:14:54 +0100
In-Reply-To: <20200709114149.1705657-1-dominick.grift@defensec.nl>
References: <20200709114149.1705657-1-dominick.grift@defensec.nl>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, 2020-07-09 at 13:41 +0200, Dominick Grift wrote:
> Change references to pam_selinux_permit to pam_sepermit
> Replace gdm-password with sshd PAM configuration (from Fedora 33) as
> pam_sepermit in the existing example might not always work correctly
> when called from the auth section:
> https://bugzilla.redhat.com/show_bug.cgi?id=1492313
> Reference the pam_selinux(8) and pam_sepermit(8) manuals
> 
> Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
> ---
>  src/pam_login.md | 50 ++++++++++++++++++++++----------------------
> ----
>  1 file changed, 23 insertions(+), 27 deletions(-)
> 

Acked-by: Richard Haines <richard_c_haines@btinternet.com>

> diff --git a/src/pam_login.md b/src/pam_login.md
> index 0c5a256..213a9f3 100644
> --- a/src/pam_login.md
> +++ b/src/pam_login.md
> @@ -68,41 +68,37 @@ consist of multiple lines of information that are
> formatted as follows:
>  </tbody>
>  </table>
>  
> -The */etc/pam.d/gdm-password* PAM configuration file for the Gnome
> login
> +The */etc/pam.d/sshd* PAM configuration file for the OpenSSH
>  service is as follows:
>  
>  ```
> -auth     [success=done ignore=ignore default=bad]
> pam_selinux_permit.so
> -auth        substack      password-auth
> -auth        optional      pam_gnome_keyring.so
> -auth        include       postlogin
> -
> -account     required      pam_nologin.so
> -account     include       password-auth
> -
> -password    substack       password-auth
> --password   optional       pam_gnome_keyring.so use_authtok
> -
> -session     required      pam_selinux.so close
> -session     required      pam_loginuid.so
> -session     optional      pam_console.so
> -session     required      pam_selinux.so open
> -session     optional      pam_keyinit.so force revoke
> -session     required      pam_namespace.so
> -session     include       password-auth
> -session     optional      pam_gnome_keyring.so auto_start
> -session     include       postlogin
> +#%PAM-1.0
> +
> +auth       substack     password-auth
> +auth       include      postlogin
> +account    required     pam_sepermit.so
> +account    required     pam_nologin.so
> +account    include      password-auth
> +password   include      password-auth
> +session    required     pam_selinux.so close
> +session    required     pam_loginuid.so
> +session    required     pam_selinux.so open
> +session    required     pam_namespace.so
> +session    optional     pam_keyinit.so force revoke
> +session    optional     pam_motd.so
> +session    include      password-auth
> +session    include      postlogin
>  ```
>  
>  The core services are provided by PAM, however other library modules
> can
>  be written to manage specific services such as support for SELinux.
> The
> -SELinux PAM modules use the *libselinux* API to obtain its
> configuration
> -information and the three SELinux PAM entries highlighted in the
> above
> -configuration file perform the following functions:
> +***pam_sepermit**(8)* and ***pam_selinux**(8)* SELinux PAM modules
> use
> +the *libselinux* API to obtain its configuration information and the
> +three SELinux PAM entries highlighted in the above configuration
> file
> +perform the following functions:
>  
> --   ***pam_selinux_permit.so*** - Allows pre-defined users the
> ability to
> -    logon without a password provided that SELinux is in enforcing
> mode (see
> -    the
> +-   ***pam_sepermit.so*** - Allows pre-defined users the ability to
> +    logon provided that SELinux is in enforcing mode (see the
>      [*/etc/security/sepermit.conf*](global_config_files.md#etcsecuri
> tysepermit.conf)
>      section).
>  -   ***pam_selinux.so open*** - Allows a security context to be set
> up for

