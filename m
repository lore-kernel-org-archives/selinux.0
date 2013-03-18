Message-ID: <51471FDE.1070103@tycho.nsa.gov>
Date: Mon, 18 Mar 2013 10:08:30 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Kernel freak <kernelfreak@gmail.com>
CC: selinux@tycho.nsa.gov
Subject: Re: Compiling Selinux from Source
References: <CAOFt0CRpFTOD8S2iktjUdLDPVOhG9Cvq9j51sqxDsQLVno=irQ@mail.gmail.com>
In-Reply-To: <CAOFt0CRpFTOD8S2iktjUdLDPVOhG9Cvq9j51sqxDsQLVno=irQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 03/16/2013 08:06 AM, Kernel freak wrote:
> Hello,
>           I want to make some modifications to SElinux itself for some
> of my work. I am currently using Fedora v18 with KDE. I downloaded the
> Linux kernel, and also the reference policy source. Both seem to give me
> an error. The errors are
> While compiling the policy '@localhost serefpolicy-3.11.1]$ sudo make conf
> make: *** No rule to make target `policy/modules/contrib/metadata.xml',
> needed by `tmp/admin.xml'.  Stop.'
>
> While compiling Selinux  from Linux kernel 3.7.10
> '@localhost selinux]$ make
> make: *** No rule to make target `/include/classmap.h', needed by
> `/flask.h'.  Stop.'
>
> I fail to understand what am i missing here. I checked the contrib
> directory, it turns out to be empty. Also, i downloaded the serefpolicy
> using yum-utils. Kindly let me know or some links. Thank you for your time.

If you downloaded the selinux-policy source rpm and installed it, then 
you have the spec file, so you can either build it via rpmbuild -bb 
selinux-policy.spec or duplicate the instructions from the spec file to 
build it by hand.  If you checked out the upstream refpolicy sources, 
then you have to run git submodule commands to check out the contrib 
directory, as described in:
http://oss.tresys.com/projects/refpolicy/wiki/RepositoryCheckout

refpolicy-specific questions should go to the refpolicy mailing list 
however.

For the kernel, it looks like you cd'd into security/selinux before 
running make.  That isn't how it is done.  Configure your kernel and run 
make at top-level.  Then it will generate the headers and ultimately 
build the selinux/built-in.o that gets linked into the kernel.  It is 
not a loadable kernel module (LKM).




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
