Reply-To: <blacknet@simplyaquatics.com>
From: "Ed Street" <blacknet@simplyaquatics.com>
To: "'Russell Coker'" <russell@coker.com.au>, <jw@centraltexasit.com>,
        "'SELinux'" <SELinux@tycho.nsa.gov>
Subject: RE: Trivial question bout EXTRAVERSION and install destination
Date: Tue, 9 Jul 2002 18:51:43 -0400
Message-ID: <005f01c2279b$32609600$0a01a8c0@ed>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20020709205637.692F51A7@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

One issue does arise with the EXTRAVERSION, some future patches will not
install correctly.

Ed

=> -----Original Message-----
=> From: owner-selinux@tycho.nsa.gov
[mailto:owner-selinux@tycho.nsa.gov] On
=> Behalf Of Russell Coker
=> Sent: Tuesday, July 09, 2002 4:57 PM
=> To: jw@centraltexasit.com; SELinux
=> Subject: Re: Trivial question bout EXTRAVERSION and install
destination
=> 
=> On Mon, 8 Jul 2002 20:15, JW wrote:
=> >  You can determine the name of the new kernel by
=> > looking in /boot.  The new kernel's name will end in "-selinux"
=> > (example: "vmlinuz-2.4.18-selinux").
=> >
=> > SuSE kernels always install into /boot, but all othe end up in /,
with
=> > generic names, including selinux's:
=> >
=> > 1. What is wrong that's causing EXTRAVERSION to be ignored
=> > 2 Why are System.map and vmlinuz edning up in / instead of /boot ?
=> 
=> Debian kernels end up in /boot with extraversion included in the
names.
=> 
=> Also I have been convinced to remove the EXTRAVERSION from the
patches I
=> package for Debian to avoid conflicts, but the Debian package build
=> system
=> allows specifying it at compile time.
=> 
=> > It's not a huge problem, but it's rather perplexing, especially
since I
=> had
=> > the exact same issue with a grsecurity-patched kernel
=> 
=> Not a problem for Debian...
=> 
=> --
=> I do not get viruses because I do not use MS software.
=> If you use Outlook then please do not put my email address in your
=> address-book so that WHEN you get a virus it won't use my address in
the
=> >From field.
=> 
=> --
=> You have received this message because you are subscribed to the
selinux
=> list.
=> If you no longer wish to subscribe, send mail to
majordomo@tycho.nsa.gov
=> with
=> the words "unsubscribe selinux" without quotes as the message.


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
