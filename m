Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h97MqxWt015672
	for <selinux@tycho.nsa.gov>; Tue, 7 Oct 2003 18:52:59 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h97Mqw7d028046
	for <selinux@tycho.nsa.gov>; Tue, 7 Oct 2003 22:52:59 GMT
Received: from chris.pebenito.dhs.org (12-251-184-225.client.attbi.com [12.251.184.225])
        by jazzband.ncsc.mil  with ESMTP id h97MqwRn028041 for <selinux@tycho.nsa.gov>; Tue, 7 Oct 2003 22:52:58 GMT
Subject: Re: 2.6.0-test6 boot process failures
From: Chris PeBenito <pebenito@gentoo.org>
To: Tom <tom@lemuria.org>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <20031007230348.E11325@lemuria.org>
References: <20031007230348.E11325@lemuria.org>
Content-Type: multipart/mixed; boundary="=-b2bQ9PxGbqyawp5Y7oTQ"
Message-Id: <1065567176.2083.12.camel@chris.pebenito.net>
Mime-Version: 1.0
Date: Tue, 07 Oct 2003 17:52:56 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-b2bQ9PxGbqyawp5Y7oTQ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2003-10-07 at 16:03, Tom wrote:
> I have a few weird dynamic linker "libselinux.so not found" errors during 
> bootup, even though libselinux.so is on the initrd image, the policy
> loads correctly and everything seems to work fine.
> 
> The only thing I can think about is that libselinux.so is in /usr/lib
> and that is on a seperate partition, (/usr is).
> 
> Is it possible - I'm not familiar with the details of the boot process
> - that somewhere inbetween it loses access to the initrd /usr/lib but
> before it has mounted all the other partitions?

Actually a Gentoo user reported this to me a couple days ago.  Yeah, its
because /usr/ is a separate partition.  I'm not familiar with the debian
initrd-tools, but I would assume that it pivot_root's at the end of the
initrd script, and then it does an exec /sbin/init.  After the
pivot_root, /usr/lib doesnt point to the initrd, since root is not the
real root, not the initrd root.  And since your /usr is a separate
partition, if something thats linked against libselinux.so is used
before /usr is mounted, you get that error.

BTW, You don't need the libraries on the initrd, because load_policy is
a static executable.

For Gentoo, I used the attached patch on libselinux to make it install
to /lib.

On a side note, I noticed that all of the coreutils programs were
mysteriously linked against libselinux for some reason (as reported by
ldd).  I don't know yet why this is happening.  Is this happening to
other people's systems?

-- 
Chris PeBenito
<pebenito@gentoo.org>
Developer, SELinux
Hardened Gentoo Linux
 
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=get&search=0xE6AF9243
Key fingerprint = B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243

--=-b2bQ9PxGbqyawp5Y7oTQ
Content-Disposition: attachment; filename=libselinux-1.2-movelibs.diff
Content-Type: text/x-patch; name=libselinux-1.2-movelibs.diff; charset=iso-8859-1
Content-Transfer-Encoding: base64

ZGlmZiAtdXJOIGxpYnNlbGludXgtMS4yLm9yaWcvc3JjL01ha2VmaWxlIGxpYnNlbGludXgtMS4y
L3NyYy9NYWtlZmlsZQ0KLS0tIGxpYnNlbGludXgtMS4yLm9yaWcvc3JjL01ha2VmaWxlCTIwMDMt
MDgtMjcgMTA6MzY6MTkuMDAwMDAwMDAwIC0wNTAwDQorKysgbGlic2VsaW51eC0xLjIvc3JjL01h
a2VmaWxlCTIwMDMtMTAtMDYgMTE6Mzg6MzguMDAwMDAwMDAwIC0wNTAwDQpAQCAtMSw1ICsxLDUg
QEANCiAjIEluc3RhbGxhdGlvbiBkaXJlY3Rvcmllcy4NCi1QUkVGSVggPz0gJChERVNURElSKS91
c3INCitQUkVGSVggPz0gJChERVNURElSKS8NCiBMSUJESVIgPz0gJChQUkVGSVgpL2xpYg0KIA0K
IExJQlZFUlNJT04gPSAxDQo=

--=-b2bQ9PxGbqyawp5Y7oTQ--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
