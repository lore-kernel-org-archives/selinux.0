Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: jw@centraltexasit.com, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Trivial question bout EXTRAVERSION and install destination
Date: Tue, 9 Jul 2002 16:56:37 -0400
References: <200207081915.25388.jw@centraltexasit.com>
In-Reply-To: <200207081915.25388.jw@centraltexasit.com>
MIME-Version: 1.0
Message-Id: <20020709205637.692F51A7@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 8 Jul 2002 20:15, JW wrote:
>  You can determine the name of the new kernel by
> looking in /boot.  The new kernel's name will end in "-selinux"
> (example: "vmlinuz-2.4.18-selinux").
>
> SuSE kernels always install into /boot, but all othe end up in /, with
> generic names, including selinux's:
>
> 1. What is wrong that's causing EXTRAVERSION to be ignored
> 2 Why are System.map and vmlinuz edning up in / instead of /boot ?

Debian kernels end up in /boot with extraversion included in the names.

Also I have been convinced to remove the EXTRAVERSION from the patches I 
package for Debian to avoid conflicts, but the Debian package build system 
allows specifying it at compile time.

> It's not a huge problem, but it's rather perplexing, especially since I had
> the exact same issue with a grsecurity-patched kernel

Not a problem for Debian...

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
