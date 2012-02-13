Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q1D5dKVB014514
	for <selinux@tycho.nsa.gov>; Mon, 13 Feb 2012 00:39:20 -0500
Received: from mail1.windriver.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id q1D5dIgk019532
	for <selinux@tycho.nsa.gov>; Mon, 13 Feb 2012 05:39:18 GMT
Message-ID: <4F38A1FF.3090105@windriver.com>
Date: Mon, 13 Feb 2012 13:39:11 +0800
From: Harry Ciao <qingtao.cao@windriver.com>
Reply-To: <qingtao.cao@windriver.com>
MIME-Version: 1.0
To: Martin Orr <martin@martinorr.name>
CC: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: role_fix_callback assertion with sysadm in base
References: <20120209225847.969915sba4w431r4@webmail.tuffmail.net> <20120211235215.13243ztx045c14w0@webmail.tuffmail.net>
In-Reply-To: <20120211235215.13243ztx045c14w0@webmail.tuffmail.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This issue was discovered months ago, it seg faults when the "level" of 
a security context is NULL, which explains why it disappears when 
building mcs or mls types of policy. BTW, this problem could be worked 
around by specifying "disable-genhomedircon = true" in your semanage.conf.

Thanks,
Harry

On 02/12/2012 07:52 AM, Martin Orr wrote:
> The seg fault with a non-mcs policy may be an independent problem. 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
