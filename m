Return-Path: <SRS0=mP8O=3N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0A3C2D0DB
	for <selinux@archiver.kernel.org>; Fri, 24 Jan 2020 20:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 970B92077C
	for <selinux@archiver.kernel.org>; Fri, 24 Jan 2020 20:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="S9T/nOxC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404287AbgAXUQS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Jan 2020 15:16:18 -0500
Received: from UHIL19PA36.eemsg.mail.mil ([214.24.21.195]:19390 "EHLO
        UHIL19PA36.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404262AbgAXUQS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 Jan 2020 15:16:18 -0500
X-EEMSG-check-017: 70244311|UHIL19PA36_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,358,1574121600"; 
   d="scan'208";a="70244311"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UHIL19PA36.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 24 Jan 2020 20:16:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1579896967; x=1611432967;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=T++MBPfrgD1DdEAf+Di1sxVUbaKMuzTF/mX7/jvoSTM=;
  b=S9T/nOxCGOOAxUs4uScrdTnijYP+0BR5KD+Gekk51aT56HyVjMrwQbQb
   i40rU8LtRKxTtDbEw1FKuK3gFroc2DnMQV2SKe5VEE6bP5SPKobdWMFVz
   lkKfqqh/uVE9I9wKmehd4//QsMW3DxumOmAexsbSH2/51wjtRRckJpybH
   gig/JoJqXm/rum5MDCD4UZYN5L1zIgFsPtMBcO1hS+CMlVPlZmriSvnA8
   5hb+/4wyKJcHIpw36xR+7QpMa3ZDi0KsAlnYUslW6zY9kOaVt82uafD7L
   U6XuSzuzKO1F59DThcNXJ0Knst5TSW2hhPI+VVVUifPZBzDXneZVbWwAG
   w==;
X-IronPort-AV: E=Sophos;i="5.70,358,1574121600"; 
   d="scan'208";a="32316864"
IronPort-PHdr: =?us-ascii?q?9a23=3A7JghAhaWsCZWul++gAwgSdD/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZpsizYR7h7PlgxGXEQZ/co6odzbaP7+a6BCRAuc/H7ClZNsQUFl?=
 =?us-ascii?q?cssoY/p0QYGsmLCEn2frbBThcRO4B8bmJj5GyxKkNPGczzNBX4q3y26iMOSF?=
 =?us-ascii?q?2kbVImbuv6FZTPgMupyuu854PcYxlShDq6fLh+MAi6oR/eu8ULjoZuMLg9xx?=
 =?us-ascii?q?vUqXdMZ+ha2HlkKF2Okxvy/Mu84IJv/yFNsP896sBMVrn3cb4lRrJCFjQmNG?=
 =?us-ascii?q?415MzvtRbdSAaE+2URXGYLnBdWGgbJ9B71UIv/vSv8rep9xTKVPdbqQrAuWD?=
 =?us-ascii?q?St9LlkRRn1gyoaLTE58WXXisttjKJHpR+quhJyz5LIbIyTKfFzZb3Wc88ESm?=
 =?us-ascii?q?VdX8ZRTy1BDZ26b4sTFOoKIOJUo5Dgq1cSsReyAA+hC+31yj9Mm3T4w6s03e?=
 =?us-ascii?q?o8Gg3CxQAsAdYDvHHSod7oNqkdTPq1wbHVwzvdYfNY2TTz5obGfR8uo/6DQb?=
 =?us-ascii?q?1+fNHNyUQsDQ7JkkmcpILnMj6Ty+8Ds3Kb7+1lVe+3lmAntx9+oiCvxsgyjI?=
 =?us-ascii?q?nCm58bylXe+iV9xIY6O925Q1N8bN6/DZRQrDqXN5d2Q8w+Q2Fovzw2yrsduZ?=
 =?us-ascii?q?GhZiQKx5MnxwDGZvGBboOG4QrjWf6MLTp3i39pYrKyiwuo/US+xeDwSNO43E?=
 =?us-ascii?q?tMoyFYiNfDrGoN2AbW6sWfT/t9+Vqu1iiX2gDI7+FEPVg0la3GK5492rIwlo?=
 =?us-ascii?q?QcsUDEHiLuhEX5lrWWdkQ5+uiz8ejnY7PmppGbN49vlA7xLr4imtC/AOskMg?=
 =?us-ascii?q?gOWHKX+eKg27344UL1WrBKjvwykqXBsZDaI9oUprKhDgNI3Ysu5AyzAje73N?=
 =?us-ascii?q?gCg3UKI0xJdAiag4TxPlHBOvH4DfOxg1S2lzdrwujLPqb8DZXWNXXDjLfgcq?=
 =?us-ascii?q?p9605b0gYzy8tf6IhOBrEOJ/LzRFf9tMbEAR8hLwy03+HnBc1h2YwEQmKAHK?=
 =?us-ascii?q?+YPbjJsVCU5uIgOfSMZIERuDnjMfgp/uLhgmUjlVABeqmp2IMdaGqkEfR+P0?=
 =?us-ascii?q?WZfX3sj88dHmgQpQoxUuzrhEeZUTFPZ3a9Rb885j8/CI24F4fOXYGtgLqd3C?=
 =?us-ascii?q?ilGp1afHxJCleJEX3wbYWLR+8MaD6OIs9mijEEV72hS4g71RG0tQ/60KFqLu?=
 =?us-ascii?q?zO9S0dq53j1cJ55+rJlRE97TZ0FdiS03mRT2FomWMFXzs23KF5oUxgxVaPyL?=
 =?us-ascii?q?N4jOJEGtxO/fNJUxs6NJ7Fw+x/DND9Rx/BftOXR1u9XNWmDi8+Tsgrz98NfU?=
 =?us-ascii?q?l9AdOigQ7H3yawBL8VjbOLDoQu8q3Ax3jxO9p9y3He2ak6kVYmRspPNWu7hq?=
 =?us-ascii?q?9w7AXTGYHJnFuDl6qwdqQTwjTN9GGdwmqKpk1YVxRwUardV3AFekTWtcj55l?=
 =?us-ascii?q?/FT7K2CrQoLBVOydWeJatNbd3pjk5LS+vjONTEZGKxnmawBQuNxr+Wa4rqYW?=
 =?us-ascii?q?od1j3HCEcYiwAT4WqGNQ8mCyejpGLeDDpuGUjtY0Pr8elxsnW7TlQqwAGMdE?=
 =?us-ascii?q?Buy6C6+hgShfyaSvMcwqgLuCM7pzpoG1a92srcC8CcqAp5YKVcfdQ97U9f1W?=
 =?us-ascii?q?3HsQx9MYGgL6FkhlIHcAR4oVnu1xNpBYVEisUqrWomzA51KaKGzlxNbSiY0o?=
 =?us-ascii?q?rzOr3KMGn95gqja6jI1V3E0taW4r8F6O4kpFX7oAGpCk0i/m1/09ZPznuc4o?=
 =?us-ascii?q?7HDBIIXpLsVkY77h16p7bdYikn+YzYz2FjMa6xsmyK59V8L+I+xwfoRNxfOb?=
 =?us-ascii?q?6KEALoW5kRDtOjOcQxkFigcxwAMfoX/6dyNMSjIb/O06ewMfcmhzmmhHlJ5I?=
 =?us-ascii?q?1n+kOK6yd4DOXP2tJNwfSfxBGGTB/6hVKss4bwg48ALTUTGHevjDPpD5NLZ7?=
 =?us-ascii?q?FjOIMMBXqqLuWpydhkwZ3gQXhV8BikHVxCkNSkfRuUckzVwwJdzwIUrGahlC?=
 =?us-ascii?q?/+yCZ7wB8zqa/K5zDD2+TvclI8P2dPQGRzxQP3LZOck8ERXE/uaRMg0hSi+x?=
 =?us-ascii?q?CplOBguK1jIjyLEg9zdC/sIjQnC/Hhuw=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2BzAgC7TSte/wHyM5BdCBwBAQEBAQcBAREBBAQBAYF7g?=
 =?us-ascii?q?X2BbSASKoQSiQOGegaBEiWJb5FJCQEBAQEBAQEBATcBAYRAAoJGOBMCEAEBA?=
 =?us-ascii?q?QQBAQEBAQUDAQFshUOCOykBgnoBBSMPAQVBEAkCGAICJgICVwYBDAYCAQGCY?=
 =?us-ascii?q?z+CVyWSM5t3gTKFSoM7gT6BDiqMMXmBB4E4DAOCKDU+hCSDNYJeBJd6l16CQ?=
 =?us-ascii?q?4JMijqJKwYbmnyOYJ0eIoFYKwgCGAghD4MnUBgNiA0XjkEjAzCNVgEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 24 Jan 2020 20:16:03 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00OKF83E142203;
        Fri, 24 Jan 2020 15:15:10 -0500
Subject: Re: [PATCH v14 22/23] LSM: Add /proc attr entry for full LSM context
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
References: <20200124002306.3552-1-casey@schaufler-ca.com>
 <20200124002306.3552-23-casey@schaufler-ca.com>
 <1de8338a-9c1c-c13b-16f0-e47ebec0e7ea@tycho.nsa.gov>
 <f3dea066-1f6d-4b92-1a5b-dac25b58aae7@tycho.nsa.gov>
 <9afb8d9d-a590-0e13-bf46-53a347ea15dd@schaufler-ca.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <6bd3e393-e1df-7117-d15a-81cb1946807b@tycho.nsa.gov>
Date:   Fri, 24 Jan 2020 15:16:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <9afb8d9d-a590-0e13-bf46-53a347ea15dd@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/24/20 2:28 PM, Casey Schaufler wrote:
> On 1/24/2020 8:20 AM, Stephen Smalley wrote:
>> On 1/24/20 9:42 AM, Stephen Smalley wrote:
>>> On 1/23/20 7:23 PM, Casey Schaufler wrote:
>>>> Add an entry /proc/.../attr/context which displays the full
>>>> process security "context" in compound format:'
>>>>           lsm1\0value\0lsm2\0value\0...
>>>> This entry is not writable.
>>>>
>>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>>>> Cc: linux-api@vger.kernel.org
>>>
>>> As previously discussed, there are issues with AppArmor's implementation of getprocattr() particularly around the trailing newline that dbus-daemon and perhaps others would like to see go away in any new interface.  Hence, I don't think we should implement this new API using the existing getprocattr() hook lest it also be locked into the current behavior forever.
>>
>> Also, it would be good if whatever hook is introduced to support /proc/pid/attr/context could also be leveraged by the SO_PEERCONTEXT implementation in the future so that we are guaranteed a consistent result between the two interfaces, unlike the current situation for /proc/self/attr/current versus SO_PEERSEC.
> 
> I don't believe that a new hook is necessary, and that introducing one
> just to deal with a '\n' would be pedantic. We really have two rational
> options. AppArmor could drop the '\n' from their "context". Or, we can
> simply document that the /proc/pid/attr/context interface will trim any
> trailing whitespace. I understand that this would be a break from the
> notion that the LSM infrastructure does not constrain what a module uses
> for its own data. On the other hand, we have been saying that "context"s
> are strings, and ignoring trailing whitespace is usual behavior for
> strings.

Well, you can either introduce a new common underlying hook for use by 
/proc/pid/attr/context and SO_PEERCONTEXT to produce the string that is 
to be returned to userspace (in order to guarantee consistency in format 
and allowing them to be directly compared, which I think is what the 
dbus maintainers wanted), or you can modify every security module to 
provide that guarantee in its existing getprocattr and getpeersec* hook 
functions (SELinux already provides this guarantee; Smack and AppArmor 
produce slightly different results with respect to \0 and/or \n), or you 
can have the framework trim the values it gets from the security modules 
before composing them.  But you need to do one of those things before 
this interface gets merged upstream.

Aside from the trailing newline and \0 issues, AppArmor also has a 
whitespace-separated (mode) field that may or may not be present in the 
contexts it presently returns, ala "/usr/sbin/cupsd (enforce)".  Not 
sure what they want for the new interfaces.

