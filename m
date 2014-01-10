Message-ID: <52D00748.9070205@tycho.nsa.gov>
Date: Fri, 10 Jan 2014 09:44:24 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Bryan Harris <bryanlharris@me.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Re: new to selinux
References: <441837E5-55B1-463C-A8E2-7F48F2C847E0@me.com>
In-Reply-To: <441837E5-55B1-463C-A8E2-7F48F2C847E0@me.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 01/10/2014 04:16 AM, Bryan Harris wrote:
> Hello,
> 
> I'm wondering if it is possible to use selinux network & process labeling, iptables, and something like /usr/bin/script to create an environment where we can enforce session recording for ssh sessions.
> 
> We will soon have a requirement to record our actions on customer environments, but at the same time we also need to block users who have not activated the recording.  Is selinux policy an appropriate way to accomplish these requirements?  I'd like to search for the details and learn more, but if I'm taking the wrong approach I'd like to know that before starting out.
> 
> Any guidance is greatly appreciated.  Thanks in advance.

I think linux-audit is where you want to be,
https://www.redhat.com/mailman/listinfo/linux-audit
