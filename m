Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0QK7nZH020368
	for <selinux@tycho.nsa.gov>; Fri, 26 Jan 2007 15:07:49 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l0QK8n0N006648
	for <selinux@tycho.nsa.gov>; Fri, 26 Jan 2007 20:08:49 GMT
Subject: Re: [PATCH 5/8] busybox -- libselinux utilities applets
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: KaiGai Kohei <kaigai@kaigai.gr.jp>
Cc: busybox@busybox.net, selinux@tycho.nsa.gov, rob@landley.net,
        dwalsh@redhat.com, russell@coker.com.au, busybox@kaigai.gr.jp
In-Reply-To: <45B8C25C.6090705@kaigai.gr.jp>
References: <45B8C039.10907@kaigai.gr.jp>  <45B8C25C.6090705@kaigai.gr.jp>
Content-Type: text/plain
Date: Fri, 26 Jan 2007 20:10:27 +0000
Message-Id: <1169842227.25290.8.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-01-25 at 23:44 +0900, KaiGai Kohei wrote:
> [5/8] busybox-libselinux-05-avcstat.patch
>   avcstat reports SELinux AVC(Access Vector Cache) statistics.
>   AVC is a in-kernel data structure to accelerate SELinux's
>   decision making.

Are you sure this should be added?  It doesn't seem like it would be
used much.  I don't think most people are even aware that you can get
stats on the AVC, much less know what to do with them.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
