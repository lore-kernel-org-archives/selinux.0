Date: Fri, 3 Oct 2003 16:28:45 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
To: "Kratzer, James R." <JamesK@xetron.com>
cc: "SELinux (E-mail)" <SELinux@tycho.nsa.gov>,
   "'sds@epoch.ncsc.mil'" <sds@epoch.ncsc.mil>
Subject: Re: Fedora Project and SELinux
In-Reply-To: <69B1CAEF4FC66F4D9A07B903E0265D3F0B4A42@s3cin>
Message-ID: <Pine.LNX.4.44.0310031602210.22164-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 1 Oct 2003, Kratzer, James R. wrote:

> With Red Hat 9 being released to the open source community as the Fedora
> project, will SELinux development continue with the Fedora core only, will
> SELinux development continue with Red Hat Enterprise Linux only, or will
> SELinux development continue with both?.

Current SELinux development by Red Hat uses a Fedora base with SELinux 
specific RPMS maintained by Dan Walsh:
ftp://people.redhat.com/dwalsh/SELinux/packages

> It seems that SELinux changes are being upstreamed to rawhide for
> release with the 2.6 kernel.  Will this kernel, along with upstreamed
> changes to glibc, be included in Fedora's release later this year as
> well as the next release of RH Enterprise?

As far as I know, Fedora will not initially be released with SELinux
enabled, but a future version may.  This is also up to the Fedora
development community, and further discussion on the issue should
probably be directed to fedora-devel-list 
(https://listman.redhat.com/mailman/listinfo/fedora-devel-list).

Also see Michael Johnson's response to a similar question in August:
http://www.redhat.com/archives/fedora-devel-list/2003-August/msg00139.html

> With Fedora being an open source community supported project, will this
> introduce security risks of backdoors being introduced into the core?

Not in my opinion -- the development process is now even more transparent.


- James
-- 
James Morris
<jmorris@redhat.com>





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
