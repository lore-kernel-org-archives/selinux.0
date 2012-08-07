Message-ID: <1344350514.31665.9.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: Don't audit debugfs
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Haiqing Jiang <hqjiang1988@gmail.com>
Cc: selinux@tycho.nsa.gov, William Roberts <bill.c.roberts@gmail.com>
Date: Tue, 07 Aug 2012 10:41:54 -0400
In-Reply-To: <CAO-4OdGTUMZxOyjsF3wbtGXwV4W3=j5N3A7MnTWh2jm0te-S8Q@mail.gmail.com>
References: 
	<CAO-4OdGTUMZxOyjsF3wbtGXwV4W3=j5N3A7MnTWh2jm0te-S8Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2012-08-06 at 16:17 -0700, Haiqing Jiang wrote:
> Hi, all
> 
> 
> Could we apply the following policy in android-4.1.1?
> 
> 
> dontaudit domain debugfs:file {write open}
> 
> 
> The reason is that if you want to debug using adb shell dmesg or
> cat /proc/kmsg, you have to open --> write trace_marker to debug frame
> buffers.
> 
> 
> Could you give some options? Thanks.....  

Bob put the following into his sepolicy.te file for the Nexus 7, but I
guess it or something like it belongs in core policy:
# ftrace support
bool ftrace true;
if (ftrace) {
   allow domain debugfs:file {open write};
} else {
   dontaudit domain debugfs:file {open write};
}

I haven't yet set up a grouper project for SE Android.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
