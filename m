Subject: Re: labeling of compilers etc
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: SELinux-dev@tresys.com, SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <200601311847.56015.russell@coker.com.au>
References: <200601291156.13076.russell@coker.com.au>
	 <1138631347.7076.32.camel@moss-spartans.epoch.ncsc.mil>
	 <200601311847.56015.russell@coker.com.au>
Content-Type: text/plain
Date: Wed, 01 Feb 2006 08:45:45 -0500
Message-Id: <1138801545.18268.32.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-01-31 at 18:47 +1100, Russell Coker wrote:
> If the shell can read two files but should only "execute" one of them then 
> it's something that can only be enforced by the shell itself.

Except that domain transitions don't occur when you run the shell
directly, so we are only talking about an execve on a script, where the
kernel can adjudicate whether the script file is a valid entrypoint for
the domain.  Running bash on the same script won't yield the domain
transition.

> Naturally we would not break them.  My proposal would still support such 
> things with a little extra policy.
> 
> Below the line "domain_auto_trans(init_t,initrc_exec_t,initrc_t)" we would 
> merely have to add "domain_trans(init_t, shell_exec_t, initrc_t)".  The 
> policy changes would be introduced before the changes to shells so no 
> breakage would occur.

This is not exactly equivalent, see above.  Also, it should be possible
to eliminate the kernel race condition on interpreted scripts; Solaris
does this by pre-opening the script file and passing /dev/fd/<n> to the
interpreter so that there is second lookup of the script file.  This
still wouldn't make setuid/setgid bash scripts a good idea, but other
scripting languages may be more resilient to caller influence.

> open_exec() is not used when bash decides to execute a script:
> # cat > /dev/sda1
> echo test
> exit 1
> ^D
> # chmod 644 /dev/sda1
> #
> 
> $ bash /dev/sda1
> test
> $
> 
> I executed code on a block device.

Yes, but such execution will never cause a domain transition; you have
to do that via an execve of the script file, which has to be a regular
file.

>   Incidentally the device I used for testing 
> was a USB flash device.  It seems to me that we want such devices to be 
> removable_device_t not fixed_disk_device_t (as is currently the case).  Using 
> removable_device_t will fix some usability cases but also make it more of an 
> issue to control executing code from it.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
