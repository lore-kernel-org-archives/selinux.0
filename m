Subject: Re: writing zero bytes in bash
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1109686814.10589.0.camel@moss-spartans.epoch.ncsc.mil>
References: <200502261832.16337.russell@coker.com.au>
	 <1109616468.28470.20.camel@moss-spartans.epoch.ncsc.mil>
	 <200503010721.59865.russell@coker.com.au>
	 <1109686814.10589.0.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 01 Mar 2005 09:38:05 -0500
Message-Id: <1109687885.10589.5.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-03-01 at 09:20 -0500, Stephen Smalley wrote:
> On Tue, 2005-03-01 at 07:21 +1100, Russell Coker wrote:
> > /proc/self/attr/exec will give the same result as 
> > runcon.  /proc/self/attr/fscreate works for operations such as
> > "program > file".
> > 
> > We need to have a way to test these things.  If we can't make it possible to 
> > do these things through the shell then someone (maybe me) has to write an 
> > interactive program to exercise the SE Linux API.
> 
> You can already test them via runcon, mkdir -Z, etc.

BTW, we _could_ modify the kernel code to also accept a string
containing only a newline as a variant way of expressing "clear
attribute" for writes to /proc/pid/attr.  But such a change will
obviously take time to get into an upstream kernel, and I don't even
want to think about changing libselinux to start doing that (with the
attendant dependency on the new kernel).

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
