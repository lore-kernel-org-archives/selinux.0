Message-ID: <001201c0fe80$2c6aa730$9c34e9c0@sahad1>
From: "Pranav Saha" <psaha@bbn.com>
To: "Stephen Smalley" <sds@tislabs.com>
Cc: <SELinux@tycho.nsa.gov>
References: <Pine.SOL.3.95.1010626154408.20459K-100000@clipper.gw.tislabs.com>
Subject: Re: New to Linux - Need help
Date: Tue, 26 Jun 2001 16:40:01 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The kernel version is 2.2.12-20 and I am using the "Everything in One Large
File" package.  I am attempting to use just the SELinux-modified kernel
without any other patches.  Not sure what you want to know about the kernel
"configuration"...  I have not manually made any configuration changes to
the kernel beyond what is automatically configured.  I may try to step up to
Red Hat 7.1 if that may solve some of these installation issues?

Thanks for the guidance.
Pranav Saha

----- Original Message -----
From: "Stephen Smalley" <sds@tislabs.com>
To: "Pranav Saha" <psaha@bbn.com>
Cc: <SELinux@tycho.nsa.gov>
Sent: Tuesday, June 26, 2001 3:51 PM
Subject: Re: New to Linux - Need help


>
> On Tue, 26 Jun 2001, Pranav Saha wrote:
>
> > Hello -
> >
> > Our company is preparing to begin a project involving SELinux
> > and I have been tasked to build a functioning SELinux box.  However, I
> > am new to Linux (and obviously, SELinux) and am having some trouble with
> > the installation.  I am installing on a RedHat 6.1 implementation, and
> > get the error below while trying to do a 'make' on the modified kernel.
> > Am I missing a required library?  Any suggestions or help that can point
> > me in the right direction would be much appreciated.
> >
> > Apologies for the novice question.
>
> Which kernel version are you using?  2.4.3 or 2.2.19?  Are you using
> the "Everything in One Large File" package or the individual
> packages/patches?  Are you using just the SELinux-modified kernel
> or are you trying to incorporate any other kernel patches?  What
> is your kernel configuration?
>
> By the way, feel free to use a newer distribution of RedHat if you want.
> I'm using RH7.1 now, and several others on the mailing list have done
> likewise.
>
> --
> Stephen D. Smalley, NAI Labs
> ssmalley@nai.com
>
>
>


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
