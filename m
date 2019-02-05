Return-Path: <SRS0=HD60=QM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0623BC282CC
	for <selinux@archiver.kernel.org>; Tue,  5 Feb 2019 10:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6F0C217D6
	for <selinux@archiver.kernel.org>; Tue,  5 Feb 2019 10:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oVsFW5VF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729040AbfBEKVA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 5 Feb 2019 05:21:00 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:38096 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727969AbfBEKU5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 5 Feb 2019 05:20:57 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x15AJCDK188816;
        Tue, 5 Feb 2019 10:20:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=aDlW7UeLSCWlk9DikGQLdWmzjijs+KmOEW2ZH4+fgYs=;
 b=oVsFW5VFvoCDwf+fDdxTeGrFdPYDXm4thnaerP4jjwE6e3bCPbNS0YzIOpXKhxwD+oKB
 z5PrvAxbSFDMYBgWHaUFo5PIJhBJLCAY9yFSm49q7TYhqkXrntuesoAve49X58u4Wey1
 AOMDF7DucHYKvvMln1Ymu1pEHZ/ovN5fsGwvdnyqR2DKKwxf90Eny6QbT/HMoz5S8TJ2
 IFYuWl++zQ7aFK22tPkKKDyhadXxkjWcS+le20Sycpp6CFOtMHnPhQ08mPTUX3saue6M
 TDr6JFLGX2QyzgR1QWxDZ0eO2huvlbxicFb/jiocpJpgwTC0MNnvZls1saJaNWK7cyYj wQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2qd9ara37n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Feb 2019 10:20:56 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x15AKoon010989
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Feb 2019 10:20:50 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x15AKoAA025091;
        Tue, 5 Feb 2019 10:20:50 GMT
Received: from kadam (/197.157.0.31)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 05 Feb 2019 10:20:22 +0000
Date:   Tue, 5 Feb 2019 13:20:06 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     viro@zeniv.linux.org.uk
Cc:     selinux@vger.kernel.org
Subject: [bug report] selinux: kill selinux_sb_get_mnt_opts()
Message-ID: <20190205102006.GA6230@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9157 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=592 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902050083
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello Al Viro,

The patch e3489f8974e1: "selinux: kill selinux_sb_get_mnt_opts()"
from Dec 13, 2018, leads to the following static checker warning:

	security/selinux/hooks.c:1075 show_sid()
	error: we previously assumed 'context' could be null (see line 1070)

security/selinux/hooks.c
    1061 static int show_sid(struct seq_file *m, u32 sid)
    1062 {
    1063 	char *context = NULL;
    1064 	u32 len;
    1065 	int rc;
    1066 
    1067 	rc = security_sid_to_context(&selinux_state, sid,
    1068 					     &context, &len);
    1069 	if (!rc) {
    1070 		bool has_comma = context && strchr(context, ',');
                                         ^^^^^^^
Can context be NULL?

    1071 
    1072 		seq_putc(m, '=');
    1073 		if (has_comma)
    1074 			seq_putc(m, '\"');
--> 1075 		seq_escape(m, context, "\"\n\\");
                                      ^^^^^^^
Because if it is, then we're toasted when we pass it to seq_escape().

    1076 		if (has_comma)
    1077 			seq_putc(m, '\"');
    1078 	}
    1079 	kfree(context);
    1080 	return rc;
    1081 }

regards,
dan carpenter
