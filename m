Message-ID: <5368ED86.8010508@tycho.nsa.gov>
Date: Tue, 06 May 2014 10:11:18 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: kim.lawson-jenkins@nrl.navy.mil, selinux@tycho.nsa.gov
Subject: Re: No AVCs written to /var/log/messages
References: <006701cf6934$1d4c4fb0$57e4ef10$@nrl.navy.mil>
In-Reply-To: <006701cf6934$1d4c4fb0$57e4ef10$@nrl.navy.mil>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/06/2014 10:04 AM, Kim Lawson-Jenkins wrote:
> Hi,
> 
>  
> 
> I’m working on an embedded system using SELinux.  The audit daemon is
> not running so AVC errors should be written to /var/log/messages. 
> SELinux is running in permissive mode and during a system reboot I see a
> few AVC errors written to a console.  However when I look in
> /var/log/messages there are no AVC errors.  I haven’t seen a similar
> problem reported in the past.  Does anyone have any ideas why AVC errors
> would not be written to /var/log/messages if the audit daemon is not
> running?  I’ve checked syslog.conf and all messages with a priority of
> warning and above should be written to /var/log/messages.

Do they show up in dmesg output (or if you cat /proc/kmsg)?
