Return-Path: <SRS0=9nT4=R4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD46C43381
	for <selinux@archiver.kernel.org>; Mon, 25 Mar 2019 22:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5846E20811
	for <selinux@archiver.kernel.org>; Mon, 25 Mar 2019 22:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="I04B20hF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730412AbfCYWWD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 25 Mar 2019 18:22:03 -0400
Received: from sonic306-28.consmr.mail.ne1.yahoo.com ([66.163.189.90]:59190
        "EHLO sonic306-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729297AbfCYWWD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 25 Mar 2019 18:22:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1553552522; bh=huphfhhXaPIQrWKA4E0hrAsdMmi5/7DiRACMIWpHb4Q=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=I04B20hFyrtbPAodR7bgSq1Pcnb5gnnaX25MaH+9t77x3BQj9N6JarDDOgITMI9G5edr4cwqTh1R3AJ1Lw/7kdvK09NclqqWt88kEw/yNVXbTH6ZTBQD5UUojQQi+rC7EHg750pPj6Rdjt1rDYD9q3aAk04rPDfRJbhqoTESqPdpe0DeLL2I3PODKS3GH9z4Tq2F+jQHASOodJeCoroOojKOol02Pnhc7REwjDwnLXzXBbEGpI7WJHgPMzxS9I63WmUl+9dzA7Jvu4lYBC5vwGMKKQTi/OuZTAy34kwrrKp1KufMkHO2I5lSH4q2FpdvwO2VpBjy4vGOc4fpscKjUw==
X-YMail-OSG: RKLHxAwVM1m85p0UvO7jwhU_NGES8hH1OET3nyCe2lHoaieZ0lWo3PKZdOEJTXO
 rT5uLHojwIqRhTzRwdjVRLBsq9JfRaFLFiGfEeaSHssCrsvJFtnmIdcNYO4ZBtsB0HmC7Lz7hHT6
 Rh63qbf.D_QAzq6wdhd3_ij3O040O5T5l8hUkdsbcxrm2ISnpBHypjyDfr5Q0tRYLHsYcNRTAX7G
 CCnHJQBTyu463gordEjlMq8WT1_Zess6HA_RB.w.GCM78h1dWZho2SihrEYC6picM2iSWQfzJnkc
 T7.MnR5sgJbFAKO3Li8SLTMetwve8Jov8dV0Zp2Ocy3A6Xsh.sMVOzKr2VE54kY24_QjOFf0XcfV
 .agtpNx81RDmyKtq8z2BVUinLd9pYr5WH4QSVRYzeStYF_w1mGFUEs.VjSUooIx9bFNv8rTDoTll
 aq9QJEMdlEYXHoBich78UR1xVnVNqT0sQ2Jwil3ZOrKKuzTBXEmkF3I1Ts3UniomxwVZa4_4SxJ4
 1x3i8sWSNNBV7SClId7.KcyD_q4YkzsfApcLFW.j1zQySuClk3jVhMQEl8GcZZCHAhjNxeLsK1xS
 B4uDia1f2j.8.IIwJHF4VjPM9XdtG1Cf7t53jfHSJ7ADgsG1Cyr1i6g4gjL5bi.1Qi50As9JCTdg
 xqboElYxDvmTyVFBLtctVFIp.FYewNC3qQBIOFKunWjUFo84K9aHcya9UwxKSBSjzEXiiUkINZEj
 XSl1hT8iXLsdB5D4iphD.yO_akD4ExdBZWguebqOOtMvxYequEMINXpQKhBNGYNyfWPaidKKZFbM
 FqMKRVGteYe8s6_cWm1uqDCKHQYc2vpjCzzzOEyrQMMNTAiWzm.9X5rj4HmynmzzLNA_kVAt3jg3
 ygNqcvmomDh0OCp6FiDSJ1WnEJx_ta8QTPbzy89.4A_3IWQyxuQcl9dZq1ABNSpfCUCdFDjlfIJB
 fZ3EPWBb78Yqn_gqIEoVHTABFM4L8UuTs63O7ssP3DH4wMUi2L5lVAEVsDMSkLz5_3BT6B4LDmqD
 8Uu5.6PCh_eNi9mdqPPUS2hrtbTKsAf0XC7sSlT28N_8RjgSfXEn57Oj3SyDIm_Tf1FEx_SHkmnR
 DXOH8fevlalQrweXTRT75AUssZjNaM5AwtA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Mon, 25 Mar 2019 22:22:02 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([67.169.65.224])
          by smtp430.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID e43541f9cfc62ac12a314441605f3998;
          Mon, 25 Mar 2019 22:21:59 +0000 (UTC)
Subject: Re: [PATCH] Bad file pattern in MAINTAINERS section 'SELINUX SECURITY
 MODULE'
To:     Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
References: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
 <20190325212756.27603-1-joe@perches.com>
 <a0847fd8-0b9b-69f5-e9b8-1e1cd3b5052d@schaufler-ca.com>
 <8a54298538371340d0a7fe762e742a88e12f43ba.camel@perches.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <cc84bd48-a07b-e68d-a3a8-3bbc5955d765@schaufler-ca.com>
Date:   Mon, 25 Mar 2019 15:22:00 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <8a54298538371340d0a7fe762e742a88e12f43ba.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 3/25/2019 3:02 PM, Joe Perches wrote:
> On Mon, 2019-03-25 at 14:58 -0700, Casey Schaufler wrote:
>> The include/linux/selinux.h file has been removed.
>> Remove the entry from the MAINTAINERS file.
> This looks like it doesn't apply correctly as there
> are one too many spaces before each context lines.

Oops. New version of Thunderbird. Looks like there's
configuration tuning required. I'll try again

