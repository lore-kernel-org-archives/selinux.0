Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4BDa1Rb021638
	for <selinux@tycho.nsa.gov>; Tue, 11 May 2004 09:36:01 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4BDXf5b017722
	for <selinux@tycho.nsa.gov>; Tue, 11 May 2004 13:33:41 GMT
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by jazzswing.ncsc.mil  with ESMTP id i4BDXeql017719
	for <selinux@tycho.nsa.gov>; Tue, 11 May 2004 13:33:40 GMT
Date: Tue, 11 May 2004 09:35:46 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
To: =?gb2312?B?wO7A9sa8?= <llp@ercist.iscas.ac.cn>
cc: selinux <selinux@tycho.nsa.gov>
Subject: Re: selopt  &   dsi
In-Reply-To: <hoic78cgsptv81w.110520041038@ercist.iscas.ac.cn>
Message-ID: <Xine.LNX.4.44.0405110934330.6146-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 11 May 2004, [gb2312] ÀîÀöÆ¼ wrote:

> 
> How do you think about DSI (Distributed Security Infrastructure)? I
> think selopt can do better if it is developed to support labeled
> communication between different security perimeters.
> 
> Is there any working still continue to develop SeLopt on distributed
> network area?

No, because the network hooks required are not available in the 2.6
kernel.  The future direction may be to use implicit labeling under IPsec.


- James
-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
