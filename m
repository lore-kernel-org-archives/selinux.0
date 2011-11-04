Subject: Re: SELinux on Android
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Bhargava Shastry <bshas3@gmail.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <CAGGozWR6yGyQaxgSED+NdAyLYGzkjDhdWmMxnB=B0qEBAEOtLA@mail.gmail.com>
References: 
	 <CAGGozWSLxn-SNzpc-jW+tZuEHAxOX0-Sn9PxDuyd7rLvvwempw@mail.gmail.com>
	 <1320409924.1015.7.camel@moss-pluto>
	 <CAGGozWR6yGyQaxgSED+NdAyLYGzkjDhdWmMxnB=B0qEBAEOtLA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 04 Nov 2011 12:59:58 -0400
Message-ID: <1320425998.1015.31.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2011-11-04 at 17:25 +0100, Bhargava Shastry wrote:
> Dear Mr. Smalley,
> 
> Thanks for your inputs. I did go through the slides of your recent
> presentation on a case for SELinux enhanced Android phone. You have
> done a great job re-engineering Android to retrofit SELinux.
> 
> I was wondering how much effort it is to actually port a subset of
> SELinux's userspace (e.g., loadpolicy, chcon and a few others) tools
> to Android? Does it entail major changes to Android's existing
> toolchain including modifications to its bionic libc?  Also, I was
> wondering if you also undertook a port of coreutils as well (to enable
> the -Z option for utils like ps and ls)?

I did need to make some changes to bionic, e.g. adding the xattr system
calls to SYSCALLS.TXT and re-generating the syscall wrapper functions
via gensyscalls.py, adding support for the AT_SECURE auxv flag.  Then I
could port a subset of libselinux. To support the SELinux commands and
-Z option, I modified the Android toolbox with support for ps -Z and ls
-Z and added new commands to it for various SELinux tools.  To date, I
have added chcon, [gs]etenforce, [gs]etsebool, load_policy, restorecon,
and runcon.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
