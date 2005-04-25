Subject: Re: Strange audit messages - whitespace
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: dwalsh@redhat.com, selinux@tycho.nsa.gov,
   James Morris <jmorris@redhat.com>, Steve Grubb <sgrubb@redhat.com>
In-Reply-To: <1114306474.11286.1.camel@localhost.localdomain>
References: <1114306474.11286.1.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 25 Apr 2005 08:11:00 -0400
Message-Id: <1114431060.27036.40.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2005-04-23 at 21:34 -0400, Ivan Gyurdiev wrote:
> I get audit messages that look like this (with lots of extra whitespace)
> for my new GConf domain. Any idea what can cause this? 
> 
> audit(1114306264.184:0): avc:  denied  { connectto } for  pid=21975
> exe=/usr/libexec/gconfd-2
> 
> audit(1114306274.010:0): avc:  denied  { write } for  pid=21975
> exe=/usr/libexec/gconfd-2

IIRC, this is believed to be a bug in the handling of the "%*.*s" format
by printk as used by the kernel audit framework.  What's the status on
getting the patch by Peter Martucelli to eliminate that usage
upstreamed?

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
