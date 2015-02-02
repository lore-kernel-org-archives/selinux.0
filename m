Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t12B9GDq000785
 for <selinux@tycho.nsa.gov>; Mon, 2 Feb 2015 06:09:17 -0500
Received: from gator3165.hostgator.com (gator3165.hostgator.com
 [198.57.247.129])
 by gateway09.websitewelcome.com (Postfix) with ESMTP id 1A563CA173BAC
 for <selinux@tycho.nsa.gov>; Mon,  2 Feb 2015 05:09:15 -0600 (CST)
Received: from [89.233.1.134] (port=53475 helo=[10.103.1.74])
 by gator3165.hostgator.com with esmtpsa (UNKNOWN:DHE-RSA-AES128-SHA:128)
 (Exim 4.82) (envelope-from <stefano.borini@quantumwise.com>)
 id 1YIEsU-0002uq-Hj
 for selinux@tycho.nsa.gov; Mon, 02 Feb 2015 05:09:14 -0600
Message-ID: <54CF5AD8.6050800@quantumwise.com>
Date: Mon, 02 Feb 2015 12:09:12 +0100
From: Stefano Borini <stefano.borini@quantumwise.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: spinlock in centos 6.4 and redhat enterprise 6 using chcon
References: <54CA07EC.5090403@quantumwise.com>
 <54CBAE30.5060402@tycho.nsa.gov> <54CBF6B6.9040002@quantumwise.com>
 <54CBF95E.3060109@tycho.nsa.gov> <54CE0B5C.6030509@quantumwise.com>
In-Reply-To: <54CE0B5C.6030509@quantumwise.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 02/01/2015 12:17 PM, Stefano Borini wrote:
>
>> I'm wondering if it might be a bug in glibc in that centos release
>> rather than in libselinux.  I don't see any relevant difference in
>> libselinux/src/setrans_client.c between the .src.rpm for centos 6.4 and
>> current master to explain it, so if it is truly a bug in libselinux, it
>> would seem to still be present.

I found the source of the problem.

Due to other constraints, we are forced to LD_PRELOAD libGL. This in 
turn preloads libnvidia-tls, which apparently messes up something with 
the glibc tls support.

Removing the libGL preloading fixes the issue, although it introduces 
another, but I'll figure something out.

Thanks for the help!


-- 
Stefano Borini
QuantumWise A/S
