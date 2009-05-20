Subject: Re: Policy loading problem
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Dennis Wronka <linuxweb@gmx.net>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <200905202242.37606.linuxweb@gmx.net>
References: <1242641994.470.5.camel@notebook2.grift.internal>
	 <1242828596.20082.395.camel@localhost.localdomain>
	 <1242829261.20082.399.camel@localhost.localdomain>
	 <200905202242.37606.linuxweb@gmx.net>
Content-Type: text/plain
Date: Wed, 20 May 2009 10:40:33 -0400
Message-Id: <1242830433.20082.402.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-05-20 at 22:42 +0800, Dennis Wronka wrote:
> Thanks for this, I think we're going somewhere.
> 
> Booting into single-user and running load_policy -i I get this:
> Mount failed for selinuxfs on /selinux: Device or resource busy
> load_policy: Can't load policy: Device or resource busy

Ok, this error just means that something (presumably /sbin/init) has
already mounted selinuxfs on /selinux, so it doesn't really help in
diagnosing the problem.  umount /selinux and try again.

BTW, can we see your kernel .config, particularly the SELINUX options?

> I've seen this before when I was testing around, but didn't find much about 
> this.
> 
> I'll see that I install strace in order to provide a trace.
> 
> libselinux is 2.0.79

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
