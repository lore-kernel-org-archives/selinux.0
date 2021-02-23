Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF9BFC433E0
	for <selinux@archiver.kernel.org>; Tue, 23 Feb 2021 14:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7023864DE9
	for <selinux@archiver.kernel.org>; Tue, 23 Feb 2021 14:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbhBWOPj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Feb 2021 09:15:39 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39088 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230174AbhBWOPi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Feb 2021 09:15:38 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11NE3aMZ097181;
        Tue, 23 Feb 2021 09:14:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=X+C6oACWLWSxH9MVloXSSQ720jGP4d+zlsSm+Rwxu7g=;
 b=ZTsS8VcOJscxtS0wuQu6oPqboPkkfXTRYHgo0VZqgoOsPS9RbjiWntFZtymxFD4S/FWI
 ylkMiToKx5UGfXP8xac0FhMauqQ345x5HkKb9SkFmtE/9SXqt8o4vBnnTZAwPFd211gn
 zqwWp5oAQbQtRmh4khWfNcunGdGL5RYbJMygLy5XVVe5Zs887QagZwuWW6oqOy3pr+Dw
 gxIXlfo4m5uFHTb9hnm8v5aCOsRFeUjYTTmG2HwuscTEqEMUM8AaIEpedozAF149WWHK
 GvQFkTmqi9kJAgn2bHB6tY5nzXwy0z6lBP2gOS7G/5GTenE+nOIIOixInuHU6SPgalRO 7A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36vkg49pq8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Feb 2021 09:14:54 -0500
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 11NE4Akd101111;
        Tue, 23 Feb 2021 09:14:53 -0500
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36vkg49pmu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Feb 2021 09:14:53 -0500
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11NE7huE024401;
        Tue, 23 Feb 2021 14:14:51 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma01fra.de.ibm.com with ESMTP id 36tt289d3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Feb 2021 14:14:51 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11NEEaAE33227192
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Feb 2021 14:14:36 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D700E4C040;
        Tue, 23 Feb 2021 14:14:48 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 225284C046;
        Tue, 23 Feb 2021 14:14:47 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.65.43])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 23 Feb 2021 14:14:46 +0000 (GMT)
Message-ID: <e03dedaf6f3fc439d1d2240e6c6d5e66301441fd.camel@linux.ibm.com>
Subject: Re: [RFC PATCH 0/4] Split security_task_getsecid() into subj and
 obj variants
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     John Johansen <john.johansen@canonical.com>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com
Date:   Tue, 23 Feb 2021 09:14:45 -0500
In-Reply-To: <1ab6d635-53af-6dd9-fc29-482723c80c6a@schaufler-ca.com>
References: <161377712068.87807.12246856567527156637.stgit@sifl>
         <9ea5259b-fd84-e176-c042-c52a1c4fcc27@schaufler-ca.com>
         <CAHC9VhQBbep2WkD6JkCemtcXFLq7j5=AQeM9vVJ4_gmvi7hPQA@mail.gmail.com>
         <1ab6d635-53af-6dd9-fc29-482723c80c6a@schaufler-ca.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-23_07:2021-02-23,2021-02-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 mlxscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102230119
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, 2021-02-22 at 15:58 -0800, Casey Schaufler wrote:
> On 2/20/2021 6:41 AM, Paul Moore wrote:
> > On Fri, Feb 19, 2021 at 8:49 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >> On 2/19/2021 3:28 PM, Paul Moore wrote:
> >>> As discussed briefly on the list (lore link below), we are a little
> >>> sloppy when it comes to using task credentials, mixing both the
> >>> subjective and object credentials.  This patch set attempts to fix
> >>> this by replacing security_task_getsecid() with two new hooks that
> >>> return either the subjective (_subj) or objective (_obj) credentials.
> >>>
> >>> https://lore.kernel.org/linux-security-module/806848326.0ifERbkFSE@x2/T/
> >>>
> >>> Casey and John, I made a quick pass through the Smack and AppArmor
> >>> code in an effort to try and do the right thing, but I will admit
> >>> that I haven't tested those changes, just the SELinux code.  I
> >>> would really appreciate your help in reviewing those changes.  If
> >>> you find it easier, feel free to wholesale replace my Smack/AppArmor
> >>> patch with one of your own.
> >> A quick test pass didn't show up anything obviously
> >> amiss with the Smack changes. I have will do some more
> >> through inspection, but they look fine so far.
> > Thanks for testing it out and giving it a look.  Beyond the Smack
> > specific changes, I'm also interested in making sure all the hook
> > callers are correct; I believe I made the correct substitutions, but a
> > second (or third (or fourth ...)) set of eyes is never a bad idea.
> 
> I'm still not seeing anything that looks wrong. I'd suggest that Mimi
> have a look at the IMA bits.

Thanks, Casey, Paul.  The IMA changes look fine.  IMA policy rules are
normally written in terms of a file's LSM labels, the obj_type, so
hopefully this change has minimal, if any, impact.

Mimi

