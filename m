Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7C5C433EF
	for <selinux@archiver.kernel.org>; Thu, 16 Jun 2022 18:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376878AbiFPSIR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Jun 2022 14:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359622AbiFPSIP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Jun 2022 14:08:15 -0400
X-Greylist: delayed 300 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 16 Jun 2022 11:08:11 PDT
Received: from aib29ajc196.phx1.oracleemaildelivery.com (aib29ajc196.phx1.oracleemaildelivery.com [192.29.103.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A42D50015
        for <selinux@vger.kernel.org>; Thu, 16 Jun 2022 11:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-phx-20191217;
 d=phx1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=jeZQtiCBfQxO4hrTX457ReT7Ubn6lDyxl4iWol4JPHo=;
 b=JlAQmGwC38rvV6MGEYpIEI+YBai8meY3SGNLfW4AHL6B2gCrwV6dtSjRHXuF6vxz3GVJrT7OO+V2
   DhcQwfgeq1ccIe92ZT0ZP+2vFy628lH4xmh4IsmEKlWq4wND2+YAMMieEQQqE2qswYgyuCaR/ZJi
   kc+1YrMqMvsTY0hAAysrm/N0Ks5IbWEHPTI4b/l5ZwuOkWBQyILrHwzYUfUsdvsWOBBoDeDO/zxm
   BvtbWNhV3Nyl+xUzh5KfZXUog0bkIebhUOIclU1PBy0Ld8vOSOCoV7/Y3sWC5/rH4y++VX4cywwF
   df5yNSqBKHfW4C2d4w+8xuOdlhogqVqJP6DYAA==
Received: by omta-ad2-fd1-202-us-phoenix-1.omtaad2.vcndpphx.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20220531 64bit (built May 31
 2022))
 with ESMTPS id <0RDL00IP10TA9870@omta-ad2-fd1-202-us-phoenix-1.omtaad2.vcndpphx.oraclevcn.com> for
 selinux@vger.kernel.org; Thu, 16 Jun 2022 18:03:10 +0000 (GMT)
Authentication-results: mail.spots.edu (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=mx.spots.edu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mx.spots.edu; h=
        x-mailer:to:message-id:subject:date:mime-version
        :content-transfer-encoding:content-type:from; s=dkim; t=        1655402588;
 x=1657994589; bh=qrGJqDL0n85C+RXuos6MNEDD94sfON4Y7qX   7IId5JqI=;
 b=nrZmcflYpyKTYKNVcj5UEbSN/xqnG4SHV19RLZ5F+XAl8/meZOa
        bYEDF0gJC3WXuTBnmHgfxLdAch8keXH9H2yl5UP0snFRIa9uuUtAR8DtTPDjsrNk
        kotx/0yQp2V2CWfzAUtnug9DBpCJqcIuKAcBRI6cVLmd1v5R1jXduPKc3gSSyBuK
        2Cs0O88JDZkP3Eqm+ookaGzH/uaB3Ton13v5Wfvd86eTyA5ChZnbOCkykXZ6UKNe
        4EtUUhBT1lV+omWVwewrcF9d5lroYeSNBcb5KQjNHClcvv/lrQWEgcSlJun7enGL
        7qvm3rlVEQVTOSKQKb/h3xjkCKPJOGC+4Iw==
From:   Father Vlasie <fv@spots.edu>
Content-type: text/plain;       charset=us-ascii
Content-transfer-encoding: quoted-printable
MIME-version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Date:   Thu, 16 Jun 2022 11:03:04 -0700
Subject: PHP-FPM restriction bug
Message-id: <9F285127-0DCC-42F2-B808-63129C440A54@spots.edu>
To:     selinux@vger.kernel.org
X-Mailer: Apple Mail (2.3696.100.31)
Reporting-Meta: AAFJfVELPR+GZlE4BBjN8DMz4vnFqnVa3jkNvffb4TND91w+9O3e/JD9iW0b6jWK
 newOxGdstboazBl+NelkSBLYJEIc2Z+hVUNovPk3liCHR0eXRIRn9d6Supqb4uNN
 M/v88VOeZ29JL/9tHYAswWOaQuB066cVzbocuDtiPYLbyt2HTHJoPH36rCh0tKXO
 gXuLExhpu9Gjr5XjbADAeQ0sfy/T6nx8CKPJERZQARMiyRi17aJRIhx6ktf26foy
 WH34Kpfq6bRayTt798N4R0DN+ANWTW3fQ06A1TxJ86cm5lo5lTi72LptpUEoTaBF
 s9LJRuEN8Y7udYt9nJ/09ks/D6T4iHJ7Su79Z3nl2u8lrvNNKiy+2KbqIixVGPfp
 BEDvdHWGPAYp/7YiJRUumMPZChzVkanWABLDKU1xTzFHaWd5AsPO/Np2Av279iIw
 fMuGjqJ5O7/zaxMU03sQSMQgAL8ovaGZvwIQ+QJpHvoN92Jd0dgGl1vsdHIb
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

I am trying to run Magento on Oracle Linux 8. I have found php-fpm will =
not run because of an SELinux policy.

Please see report below:

--------------------------------

SELinux is preventing php-fpm from execmod access on the file =
/usr/sbin/php-fpm.

*****  Plugin catchall (100. confidence) suggests   =
**************************

If you believe that php-fpm should be allowed execmod access on the =
php-fpm file by default.
Then you should report this as a bug.
You can generate a local policy module to allow this access.
Do
allow this access for now by executing:
# ausearch -c 'php-fpm' --raw | audit2allow -M my-phpfpm
# semodule -X 300 -i my-phpfpm.pp


Additional Information:
Source Context                system_u:system_r:httpd_t:s0
Target Context                system_u:object_r:httpd_exec_t:s0
Target Objects                /usr/sbin/php-fpm [ file ]
Source                        php-fpm
Source Path                   php-fpm
Port                          <Unknown>
Host                          <Unknown>
Source RPM Packages          =20
Target RPM Packages           php-
                              =
fpm-7.4.19-2.module+el8.6.0+20552+0a59ce9f.aarch64
SELinux Policy RPM            =
selinux-policy-targeted-3.14.3-95.0.1.el8.noarch
Local Policy RPM              =
selinux-policy-targeted-3.14.3-95.0.1.el8.noarch
Selinux Enabled               True
Policy Type                   targeted
Enforcing Mode                Permissive
Host Name                     staging
Platform                      Linux staging =
5.4.17-2136.308.9.el8uek.aarch64 #2
                              SMP Mon Jun 13 21:08:46 PDT 2022 aarch64 =
aarch64
Alert Count                   1
First Seen                    2022-06-16 10:47:38 PDT
Last Seen                     2022-06-16 10:47:38 PDT
Local ID                      2fe0bf84-2db7-4517-8c7e-4a4156f23d1f

Raw Audit Messages
type=3DAVC msg=3Daudit(1655401658.658:32659): avc:  denied  { execmod } =
for  pid=3D66257 comm=3D"php-fpm" path=3D"/usr/sbin/php-fpm" dev=3D"dm-0" =
ino=3D2409990 scontext=3Dsystem_u:system_r:httpd_t:s0 =
tcontext=3Dsystem_u:object_r:httpd_exec_t:s0 tclass=3Dfile permissive=3D1


Hash: php-fpm,httpd_t,httpd_exec_t,file,execmod=
