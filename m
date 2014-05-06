From: "Kim Lawson-Jenkins" <kim.lawson-jenkins@nrl.navy.mil>
To: "'Stephen Smalley'" <sds@tycho.nsa.gov>, <selinux@tycho.nsa.gov>,
 "'Eric Paris'" <eparis@parisplace.org>
References: <006701cf6934$1d4c4fb0$57e4ef10$@nrl.navy.mil>
 <5368ED86.8010508@tycho.nsa.gov>
In-Reply-To: <5368ED86.8010508@tycho.nsa.gov>
Subject: RE: No AVCs written to /var/log/messages
Date: Tue, 6 May 2014 10:54:16 -0400
Message-ID: <006f01cf693b$0d9c5590$28d500b0$@nrl.navy.mil>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Reply-To: kim.lawson-jenkins@nrl.navy.mil
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I just used the command

dmesg | grep -i avc

There were 2 errors generated when I used the command; these AVC errors were
written to the console and in the dmesg output.  These were the only AVCs
recorded in the dmesg output.  The few errors that I would see during system
initialization are not in the dmesg output.


-----Original Message-----
From: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
Sent: Tuesday, May 06, 2014 10:11 AM
To: kim.lawson-jenkins@nrl.navy.mil; selinux@tycho.nsa.gov
Subject: Re: No AVCs written to /var/log/messages

On 05/06/2014 10:04 AM, Kim Lawson-Jenkins wrote:
> Hi,
> 
>  
> 
> I'm working on an embedded system using SELinux.  The audit daemon is 
> not running so AVC errors should be written to /var/log/messages.
> SELinux is running in permissive mode and during a system reboot I see 
> a few AVC errors written to a console.  However when I look in 
> /var/log/messages there are no AVC errors.  I haven't seen a similar 
> problem reported in the past.  Does anyone have any ideas why AVC 
> errors would not be written to /var/log/messages if the audit daemon 
> is not running?  I've checked syslog.conf and all messages with a 
> priority of warning and above should be written to /var/log/messages.

Do they show up in dmesg output (or if you cat /proc/kmsg)?
