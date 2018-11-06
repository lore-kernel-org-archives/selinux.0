Return-Path: <SRS0=i/ur=NR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D8F3C32789
	for <selinux@archiver.kernel.org>; Tue,  6 Nov 2018 19:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC06F20830
	for <selinux@archiver.kernel.org>; Tue,  6 Nov 2018 19:43:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC06F20830
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbeKGFKF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 7 Nov 2018 00:10:05 -0500
Received: from ucol19pa10.eemsg.mail.mil ([214.24.24.83]:45419 "EHLO
        UCOL19PA10.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725198AbeKGFKF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 7 Nov 2018 00:10:05 -0500
X-EEMSG-check-008: 611102565|UCOL19PA10_EEMSG_MP8.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.54,472,1534809600"; 
   d="scan'208";a="611102565"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UCOL19PA10.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 06 Nov 2018 19:43:16 +0000
X-IronPort-AV: E=Sophos;i="5.54,472,1534809600"; 
   d="scan'208";a="20345724"
IronPort-PHdr: =?us-ascii?q?9a23=3AcsYQuxBS419l+AT5vxPdUyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSPX/pMbcNUDSrc9gkEXOFd2Cra4c1KyO6+jJYi8p2d65qncMcZhBBV?=
 =?us-ascii?q?cuqP49uEgeOvODElDxN/XwbiY3T4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx?=
 =?us-ascii?q?7xKRR6JvjvGo7Vks+7y/2+94fcbglUhjexe69+IAmrpgjNq8cahpdvJLwswR?=
 =?us-ascii?q?XTuHtIfOpWxWJsJV2Nmhv3+9m98p1+/SlOovwt78FPX7n0cKQ+VrxYES8pM3?=
 =?us-ascii?q?sp683xtBnMVhWA630BWWgLiBVIAgzF7BbnXpfttybxq+Rw1DWGMcDwULs7Vy?=
 =?us-ascii?q?6i76N2QxH2jikJOSMy/GXOhsBukK5XpRSsrAF9zYHJeoGYLOdwcL3Tfd0aRm?=
 =?us-ascii?q?RPUMheWCNDDYygYIUCFPYBMOVCooXhu1cDoxmzCA+xD+3v0D9IgXr20LUn3e?=
 =?us-ascii?q?Q9Dw7GxAwgEMwIsH/Jsdv1Mb0dUeSxzKbWzTTIcvRb2Szg54jTaR0hvfGNUq?=
 =?us-ascii?q?5wccrW00UvERjFgU+KpYzqODOVyP0Avm6G5ORjTeKik3Mrpg5+rzS1xsogl5?=
 =?us-ascii?q?PFipwax1za7yl13YA4LsCiRkFhe96rCp5QujmfN4txX8wtXXlluD0/yr0aoZ?=
 =?us-ascii?q?67ezUKyIg/yx7fdfOHd4+I7wr/VOmLOzd4hW9leKmlixau8Umv1u38Vs6u3F?=
 =?us-ascii?q?ZMsiVFicXDumoI1xzS7siLUvp9/kG/1jaTzw3f9+5JLE8umafbNpIt2KA8m5?=
 =?us-ascii?q?UNvUjZAyP6gED2g7WXdkUg9Oio8ePnYrD+q5+HKoB0kRrzMrgum8OjAeQ4NR?=
 =?us-ascii?q?ICX26A+eumzrHj8kr5QKtSgv0sjqbZqIzaJdgcpqOhGQ9V1Z0j6xalADegzt?=
 =?us-ascii?q?sUh3gHLElFeB2dlYjmIUrDIP/9DfilglSslC1nyOzBPr3kGp/NNGTMkK/9fb?=
 =?us-ascii?q?Zh7E5R0Bc8zN5F6JJQEbEBIOn+WlXvu9PFDh82KRC0z/z7B9V604MUQXiPDb?=
 =?us-ascii?q?OBMKPOrV+I4foiI/KSa48RuTb9LeUl5vH1gH8nll8SY7Op0YEUaH+mBPRmJV?=
 =?us-ascii?q?uWYX72jtcGC2cKsVl2cOu/qUaCWCRaL1i/RaQ14D08QNa8CpzDT4agxr2a3C?=
 =?us-ascii?q?6hF7VZY2lHDhaHFnK+M82IRP4IcyK6OMJtkjUYE7OmTstpzhyqtQnn25J7P+?=
 =?us-ascii?q?HU/Wserpul299ro6XImBUz8yFkJ9qS3nvLTGxumG4MATgs0/NRu0t4n2yf3L?=
 =?us-ascii?q?B4jvoQLtla4/dEQ09uLpLH5/BrAND1HATad5GGT0jwEYbuOi04Ut9km4xGWE?=
 =?us-ascii?q?16Adj3y0qb0g=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2A6AgCU7eFb/wHyM5BkHAEBAQQBAQcEAQGBVAQBAQsBg?=
 =?us-ascii?q?VopZk8zJ4N2lDBMAQEBAQEBBoE1iRGOM4FmOAGEQAKDWCI3Cg0BAwEBAQEBA?=
 =?us-ascii?q?QIBbCiCNiSCYQEFIw8BBVEJAg4KAgIUDAYCAlcGAQwGAgEBgl4/AYF0DY15m?=
 =?us-ascii?q?0+BLoNAgXyEa4ELim0XeYEHgTiCa4RGgQeCNYJXAo9uj0kJkQwGGIFWiCKGb?=
 =?us-ascii?q?JQihQIigVUrCAIYCCEPO4JsgicXjjohAzCBBQEBikOCKQEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 06 Nov 2018 19:43:15 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id wA6JhFIx009173;
        Tue, 6 Nov 2018 14:43:15 -0500
Subject: Re: SELinux MLS for Apache Process
To:     Ishara Fernando <roshane.ishara@gmail.com>, dwalsh@redhat.com,
        selinux@tycho.nsa.gov, selinux@vger.kernel.org
References: <CAOQ2Cef9DMjJeFf2wwhaLx54mLDsHdTRouie4gXQJ3B7qZe7_g@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <ddc4e042-522f-4aa2-84a3-15af58c95e3b@tycho.nsa.gov>
Date:   Tue, 6 Nov 2018 14:45:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAOQ2Cef9DMjJeFf2wwhaLx54mLDsHdTRouie4gXQJ3B7qZe7_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/6/18 9:33 AM, Ishara Fernando wrote:
> Dear all ,
> 
> I have been trying to test and see how SELinux MLS works with Apache , 
> this is what I did to test
> 
> *1) As we're aware if we start apache process as the default SELinux 
> user (i.e: Just as root user) , it will obtain a security context which 
> has all the range of sensitivities and categories (i.e : s0-s15 , 
> C0-C1023) *
> 
> [root@msc-ishara-system1 ~]# id -Z
> system_u:system_r:sshd_t:*s0-s15:c0.c1023*
> 
> [root@msc-ishara-system1 ~]# ps auxZ | grep -i http
> system_u:system_r:sshd_t:*s0-s15:c0.c1023* root 29161 0.0  0.4 262888 
> 9248 ?     Ss   00:16   0:00 /usr/sbin/httpd
> system_u:system_r:sshd_t:*s0-s15:c0.c1023* apache 29164 0.0  0.2 262888 
> 5264 ?   S    00:16   0:00 /usr/sbin/httpd
> 
> 
> *2) Then what I did was stop apache and then Switch to a new SELinux 
> role (s4-s5:c1,c2) and start Apache process as follows , apache will 
> also get the same security contexts as the User ( s4-s5:c1,c2 ) *
> 
> [root@msc-ishara-system1 ~]# newrole -l s4-s5:c1,c2
> Password:
> 
> [root@msc-ishara-system1 ~]# id -Z
> system_u:system_r:sshd_t:*s4-s5:c1,c2
> *
> [root@msc-ishara-system1 ~]# /etc/init.d/httpd start
> 
> 
> [root@msc-ishara-system1 ~]# ps auxZ  |  grep -i httpd
> system_u:system_r:sshd_t:*s4-s5:c1,c2* root 29220 0.0  0.4 262888  9244 
> ?        Ss   00:18   0:00 /usr/sbin/httpd
> system_u:system_r:sshd_t:*s4-s5:c1,c2* apache 29223 0.0  0.2 262888 5264 
> ?       S    00:18   0:00 /usr/sbin/httpd
> 
> *3) And now I created a file 'info.php' under /var/www/html , and then i 
> changed the security context of this file as follows
> *
> 
> touch  /var/www/html/info.php
> chcat s0:c3 /var/www/html/info.php
> 
> *4) Now that we know the apache process is running in s4-s5:c1,c2 
> security context and the file /var/www/html/info.php has s0:c3 context , 
> then apache process shouldn't be able to read the /var/www/html/info.php 
> file as c3 isn't read into c1,c2 apache process according to the Bell 
> Lapadula model which is the security policy in SELinux MLS , but however 
> when i run a curl on the apache process , it produces an output (Which 
> shows the php version and stuff)
> *
> 
> *curl http://localhost/info.php*
> 
> !DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
> "DTD/xhtml1-transitional.dtd">
> <html><head>
> <style type="text/css">
> body {background-color: #ffffff; color: #000000;}
> body, td, th, h1, h2 {font-family: sans-serif;}
> pre {margin: 0px; font-family: monospace;}
> a:link {color: #000099; text-decoration: none; background-color: #ffffff;}
> a:hover {text-decoration: underline;}
> table {border-collapse: collapse;}
> .center {text-align: center;}
> 
> 5) What i need to understand is am I testing this wrong ? When I run 
> curl command I run it as the same user in which switched roles to (i.e : 
> s4-s5:c1,c2) , so still c3 isn't read into c1,c2 . But I still get an 
> output for the curl .
> 
> What I am trying to achieve is show that Apache process will not be able 
> to read the file /var/www/html/info.php according to the Bell Lapadula 
> model , have i missed any step in here ? Awaiting your kind guidance and 
> inputs . Thank you

First, note that selinux@tycho.nsa.gov has moved to 
selinux@vger.kernel.org.  The old list still exists but will eventually 
be shut down sometime.  I have cc'd the new list above.

Second, it would help if you provided information about your 
distribution, release, policy package, etc. sestatus -v output would 
also be helpful.

Third, your httpd processes are running in the wrong domain (sshd_t vs 
httpd_t), which indicates something else is wrong with your 
configuration / set up.  And sshd_t appears to be allowed mlsfileread in 
the Fedora -mls policy, so it is exempted from MLS constraints on file 
reading, which would explain the behavior you are seeing.








