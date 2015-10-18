Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t9I9vrj8000791
 for <selinux@tycho.nsa.gov>; Sun, 18 Oct 2015 05:57:53 -0400
Received: by padhk11 with SMTP id hk11so187807pad.1
 for <selinux@tycho.nsa.gov>; Sun, 18 Oct 2015 02:57:51 -0700 (PDT)
Date: Sun, 18 Oct 2015 17:57:48 +0800
From: Jason Zaman <jason@perfinion.com>
To: Bond Masuda <bond.masuda@jlbond.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: how to troubleshoot SELinux when auditd won't start?
Message-ID: <20151018095748.GA18882@meriadoc>
References: <562355F4.2040303@jlbond.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <562355F4.2040303@jlbond.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sun, Oct 18, 2015 at 01:19:00AM -0700, Bond Masuda wrote:
> I'm running into an issue where SELinux is preventing auditd from 
> starting. But I can't figure out exactly what SELinux is not happy about 
> since without auditd, I can't look for AVC messages. I think SELinux is 
> blocking auditd from starting up because auditd starts up once I do 
> 'setenforce 0'.

If auditd is not running the avc's go into dmesg. dmesg | grep avc will
show any.

-- Jason
