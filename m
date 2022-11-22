Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A2DC433FE
	for <selinux@archiver.kernel.org>; Tue, 22 Nov 2022 11:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbiKVLWm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 22 Nov 2022 06:22:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233435AbiKVLV5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 22 Nov 2022 06:21:57 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5FD1741F
        for <selinux@vger.kernel.org>; Tue, 22 Nov 2022 03:18:05 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AMBH2tn004801
        for <selinux@vger.kernel.org>; Tue, 22 Nov 2022 11:18:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=95K/6mp/RGeIcpRsuSHhnCamuAASYe6nPWT+D10TCuA=;
 b=A4gpWc4uEW8RfByeW02RYg3oscFSSl7K0Pp3vBqkIeoqKEuKeJzCOW3q/TF9dT/ZiopW
 3L9TshHUcI2VC4OiP6RDLJpLA+iRKqKK4ZavaBA4Ah3LTnioLweIZWcFR/T+Htl6C/gv
 fojyENA//fQlXkRrRPl29AknfOQatpz1KCvORfq8KN49CwwPFKyDmOi7qaIyQrxkcHUW
 T4DqZBgc7cLb5PgaIWc77J2so3Vxw52mQCAMec2PuyDHE39BAt3BHp+S1MMNTAZE9ZhG
 VsCqNxdkN4X8iIhhasW2UPZ9n1bKf7NWAhGtnVIDEqMBiye0HGWHQRCxAu8bSlxxfgxV oQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kxrac6rgk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <selinux@vger.kernel.org>; Tue, 22 Nov 2022 11:18:04 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AMBI3ma028611
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <selinux@vger.kernel.org>; Tue, 22 Nov 2022 11:18:03 GMT
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 22 Nov 2022 03:18:02 -0800
Received: from nalasex01b.na.qualcomm.com ([fe80::1348:ecca:19c2:8e2e]) by
 nalasex01b.na.qualcomm.com ([fe80::1348:ecca:19c2:8e2e%12]) with mapi id
 15.02.0986.036; Tue, 22 Nov 2022 03:18:02 -0800
From:   "Jaihind Yadav (QUIC)" <quic_jaihindy@quicinc.com>
To:     "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Subject: Kernel Panic while accessing avtab_search_node
Thread-Topic: Kernel Panic while accessing avtab_search_node
Thread-Index: Adj+VYWUk4KkQzwATnGJSwloxgquEQADmJyA
Date:   Tue, 22 Nov 2022 11:18:02 +0000
Message-ID: <0fad7bb5f511433ca59140a813e2d200@quicinc.com>
References: <90976d10374046f198e6777609554b23@quicinc.com>
In-Reply-To: <90976d10374046f198e6777609554b23@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.214.23.29]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: dFihnyZpAk4FbG6OiKv6QKvy9jTH6Yqy
X-Proofpoint-ORIG-GUID: dFihnyZpAk4FbG6OiKv6QKvy9jTH6Yqy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-22_04,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 mlxlogscore=889 adultscore=0 clxscore=1015
 mlxscore=0 phishscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211220082
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


Hi Selinux team,

We are getting kernel panic due to invalid memory access from avtab_search_=
node @231.

165.187593][T21313] Unable to handle kernel access to user memory outside u=
access routines at virtual address 0000000081000000
[=A0 165.265699][T22438] pc : avtab_search_node+0xe4/0x138
[=A0 165.265710][T22438] lr : context_struct_compute_av+0x260/0x908
[=A0 165.265715][T22438] sp : ffffffc0330a3920
[=A0 165.265717][T22438] x29: ffffffc0330a3a20 x28: ffffff804097ea40 x27: 0=
000000000000360
[=A0 165.265725][T22438] x26: ffffff803acab190 x25: ffffff803acab138 x24: f=
fffffc0330a3b60
[=A0 165.265732][T22438] x23: ffffff804097ea40 x22: ffffffc0330a3b48 x21: 0=
000000000000361
[=A0 165.265739][T22438] x20: 0000000000000360 x19: ffffff80409d3608 x18: f=
fffffc02ba1d070
[=A0 165.265746][T22438] x17: 000000008f58b13b x16: 000000005bbbfbe1 x15: 0=
0000000e6546b64
[=A0 165.265753][T22438] x14: 000000001b873593 x13: 0000000058a5459e x12: 0=
000000000000061
[=A0 165.265760][T22438] x11: 0000000000000707 x10: 0000000000000361 x9 : 0=
000000000000361
[=A0 165.265767][T22438] x8 : 0000000000000002 x7 : 0000000000000000 x6 : f=
fffffc0330a39ac
[=A0 165.265773][T22438] x5 : ffffffc0330a3b60 x4 : ffffffc0330a3b48 x3 : f=
fffffc0330a3b60
[=A0 165.265780][T22438] x2 : ffffffc0330a3b48 x1 : ffffffc0330a3960 x0 : 0=
000000081000000
[=A0 165.265787][T22438] Call trace:
[=A0 165.265789][T22438]=A0 avtab_search_node+0xe4/0x138
[=A0 165.265793][T22438]=A0 security_compute_av+0x18c/0x3f4
[=A0 165.265798][T22438]=A0 avc_compute_av+0x84/0xe4
[=A0 165.265804][T22438]=A0 avc_has_perm+0x188/0x1f4
[=A0 165.265808][T22438]=A0 selinux_task_alloc+0x48/0x58
[=A0 165.265812][T22438]=A0 security_task_alloc+0x84/0x150
[=A0 165.265816][T22438]=A0 copy_process+0x51c/0xe98
[=A0 165.265823][T22438]=A0 kernel_clone+0xb8/0x684
[=A0 165.265827][T22438]=A0 __arm64_sys_clone+0x5c/0x8c
[=A0 165.265831][T22438]=A0 invoke_syscall+0x60/0x150
[=A0 165.265836][T22438]=A0 el0_svc_common+0x98/0x114
[=A0 165.265840][T22438]=A0 do_el0_svc+0x28/0xa0
[=A0 165.265843][T22438]=A0 el0_svc+0x28/0x90
[=A0 165.265848][T22438]=A0 el0t_64_sync_handler+0x88/0xec
[=A0 165.265852][T22438]=A0 el0t_64_sync+0x1b4/0x1b8
[=A0 165.265858][T22438] Code: f86bd980 b4000260 79400c2b 1200396b (7940000=
c)=20
[=A0 165.265862][T22438] ---[ end trace 78d0a75f861b1c77 ]---

Kernel panic is coming while accessing cur @231 line from below code snippe=
t.

218 struct avtab_node *avtab_search_node(struct avtab *h,
219=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0const struct avtab_key *key)
220 {
221=A0=A0=A0=A0=A0=A0=A0 int hvalue;
222=A0=A0=A0=A0=A0=A0=A0 struct avtab_node *cur;
223=A0=A0=A0=A0=A0=A0=A0 u16 specified =3D key->specified & ~(AVTAB_ENABLED=
|AVTAB_ENABLED_OLD);
224=20
225=A0=A0=A0=A0=A0=A0=A0 if (!h || !h->nslot)
226=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 re=
turn NULL;
227=20
228=A0=A0=A0=A0=A0=A0=A0 hvalue =3D avtab_hash(key, h->mask);
229=A0=A0=A0=A0=A0=A0=A0 for (cur =3D h->htable[hvalue]; cur;
230=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cur =3D cur->next) {
231=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if=
 (key->source_type =3D=3D cur->key.source_type &&
232=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 key->target_type =3D=3D cur->key.target_type &&
233=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 key->target_class =3D=3D cur->key.target_class &&
234=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 (specified & cur->key.specified))
235=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return cur;

In the above code null check are properly handled So I am suspecting the ha=
shtable is getting modified by other thread/process when it is accessing th=
e code.

Can you please provide your expert opinion what could be the issue here and=
 how to fix this issue .

Thanks,
Jaihind Yadav
