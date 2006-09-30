Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8U00Qv5007623
	for <selinux@tycho.nsa.gov>; Fri, 29 Sep 2006 20:00:26 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8TNxp9n008853
	for <selinux@tycho.nsa.gov>; Fri, 29 Sep 2006 23:59:52 GMT
From: Steve Grubb <sgrubb@redhat.com>
To: paul.moore@hp.com
Subject: Re: [PATCH 1/1] NetLabel: audit fixups due to delayed feedback
Date: Fri, 29 Sep 2006 20:00:42 -0400
Cc: netdev@vger.kernel.org, linux-audit@redhat.com, selinux@tycho.nsa.gov
References: <20060929223948.975556000@hp.com> <20060929224355.253290000@hp.com>
In-Reply-To: <20060929224355.253290000@hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200609292000.42544.sgrubb@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 29 September 2006 18:39, paul.moore@hp.com wrote:
> This should make NetLabel more consistent with other kernel
> generated audit messages specifying configuration changes.

OK, this looks better. We may fine tune the messages later after we try it 
out, but all the issues I saw are fixed.    ACK.

-Steve

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
