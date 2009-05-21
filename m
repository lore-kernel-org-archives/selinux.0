Subject: Re: avc: denied null
From: Dominick Grift <domg472@gmail.com>
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, SELinux@tycho.nsa.gov,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <4A14BE43.7070505@tycho.nsa.gov>
References: <1242641994.470.5.camel@notebook2.grift.internal>
	 <1242651013.29973.197.camel@localhost.localdomain>
	 <1242651553.1057.0.camel@notebook2.grift.internal>
	 <4A1374D5.6080504@tycho.nsa.gov>
	 <1242817716.14664.3.camel@notebook2.grift.internal>
	 <4A14BE43.7070505@tycho.nsa.gov>
Content-Type: text/plain
Date: Thu, 21 May 2009 14:19:52 +0200
Message-Id: <1242908392.3001.8.camel@notebook2.grift.internal>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-05-20 at 22:36 -0400, Eamon Walsh wrote:

> If you're willing to compile the X server from source, you could apply
> the attached patch and use gdb to attach to the running X server (this
> has to be done over an ssh connection). 
> 
> Break on the SELinuxNullPermissionHappened function and reproduce the
> GLXMakeCurrent avc, hopefully the breakpoint will fire and you can get a
> backtrace.
> 
> Also there is another patch that will fix the x_device null avc's
> (attached).
> 
I tried this. The null avc denials occur on login. 

However, as soon as i "break SELinuxNullPermissionHappened", my login screen becomes unresponsive.

When i cancel the "break" it becomes responsive again.

As you can imagine it is difficult to reproduce the issue if this
happens, as i cannot log in (this is where the null avc occurs) with the
"breakpoint" set.

Any suggestions?

this is what i did:
- rebuild/reinstall xorg rpms with your patches included (seems to work
fine and the other null avcs are gone)
- installed xorg debuginfo rpm
- login using ssh and as root: gdb /usr/bin/Xorg <pid>
- break SELinuxNullPermissionHappened



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
