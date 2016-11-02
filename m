MIME-Version: 1.0
In-Reply-To: <f25bd779-ea07-383e-f724-b86e2847edae@tycho.nsa.gov>
References: <CAF_dkJA-3FNQ1m-8AQxrnWXsbiP+P86OUxeXHeRchh3pYZz70g@mail.gmail.com>
 <706f5fa7-f73a-641b-2a50-4e58ede933a4@tycho.nsa.gov>
 <CAF_dkJAW6hyo8r+m=0AuJRkLV4kA_zFM=5tOQd2iWuFHJjb8Pw@mail.gmail.com>
 <3d207136-9e4a-c61d-7939-2b5a3a7f47a2@tycho.nsa.gov>
 <CAF_dkJDA64AaZBzoC3q0q+9=QPMWy6ju_OL7dK6HDmqtJTZf3g@mail.gmail.com>
 <f25bd779-ea07-383e-f724-b86e2847edae@tycho.nsa.gov>
From: Patrick Doyle <wpdster@gmail.com>
Date: Wed, 2 Nov 2016 11:10:45 -0400
Message-ID: <CAF_dkJDFGQHxqPEUZ4gx-_fZaU0e+Kt62vTY7GLVSy3dvDrmuA@mail.gmail.com>
Subject: Re: Is it possible to prevent a binary executable file from being
 read via SELinux?
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Nov 2, 2016 at 10:08 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> No.  For example, if all processes can access all /dev nodes, then they
> can perform raw reads/writes to the block devices and thereby circumvent
> any file-based access controls entirely.  If all processes can write to
> e.g. /lib, then they can replace the dynamic linker and any shared
> libraries used by your application and get it to execute their code in
> order to dump its memory.  If they can all execute your application,
> then they can run its binary in their own memory and then dump its
> contents.
I didn't realize that saying "Allow all access" would circumvent the
normal Linux based file permissions.  I assumed that SELinux was
layered on top of those permissions.  I guess I have more to learn.


>  Please, see my original email and answer the questions there
> (which you mostly ignored) to see whether this is even a worthwhile
> exercise, and then, if so, follow the guidance for using sound DAC
> ownership and modes first, then investigate SELinux to address residual
> gaps.
ok.  That is what I have been attempting to do... one residual gap I
see with that is that a root user can make a copy of my application.
I would like to prevent that.

>> Is anything besides your application even running on the device?
yes

>> Are there other services/applications that run on the device too?
yes

>> When you say "gain access to my device", what kind of access did you have in mind?

I am assuming that somebody has managed to gain root access to my
device, possibly via a serial port, or possibly via a remote exploit
of one of the other services running on the device.  (S)He will
certainly have physical access to the device, and therefore my kernel
& rootfs will be encrypted, (and the key would be protected by the
secure boot facilities of the SoC).  But if (s)he gains root access to
the file system, I don't want him/her to be able to be able to copy my
application code off the device.

>
> If you want a simple, small SELinux policy to start from, I would again
> recommend the Android SELinux policy.
>
Very well.  I will start there and save the rest of my questions until
after I have learned more.

Thanks again for your tips and advice.

--wpd
