Subject: Re: debian and initrd with selinux on 2.6.0-test1
From: Colin Walters <walters@verbum.org>
To: max barwell <maxb@paradise.net.nz>
Cc: SElinux list <SELinux@tycho.nsa.gov>, Russell Coker <russell@coker.com.au>
In-Reply-To: <1058642159.776.16.camel@orac.lite.net.nz>
References: <1058642159.776.16.camel@orac.lite.net.nz>
Content-Type: multipart/mixed; boundary="=-9W10KAcB5xzCG8ydnOnJ"
Message-Id: <1058651671.2233.28.camel@columbia>
Mime-Version: 1.0
Date: 19 Jul 2003 17:54:31 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-9W10KAcB5xzCG8ydnOnJ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, 2003-07-19 at 15:15, max barwell wrote:
> I had selinux running well on a 2.4 kernel but decided to be a bit more
> adventurous, so I am trying to get it going on 2.6.0-test1.
> 
> I am using Debian sid and the selinux-2.5-2003071106.tgz set of tools,
> from the NSA website.

You might want to try my experimental packages (just announced a few
minutes ago); otherwise you will likely end up redoing a lot of the work
that I've already done.

> I am assuming this is possible, I am not so hot at coding, so
> writing my own patch could be a big ask for me. Could someone please
> tell/help/point me in the right direction, to get an initrd image for
> selinux and debian.

My selinux-policy-default Debian package contains hooks for the Debian
mkinitrd (in initrd-tools) that work for SELinux 2.5.  I've attached the
scripts for reference.


--=-9W10KAcB5xzCG8ydnOnJ
Content-Disposition: attachment; filename=selinux.initrd-script
Content-Type: text/x-sh; name=selinux.initrd-script; charset=UTF-8
Content-Transfer-Encoding: base64

IyEvYmluL3NoIC1lDQplY2hvIExvYWRpbmcgcG9saWN5DQptb3VudCAtbnQgc2VsaW51eGZzIG5v
bmUgL3NlbGludXgNCi9iaW4vbG9hZF9wb2xpY3kgL2V0Yy9zZWN1cml0eS9zZWxpbnV4L3BvbGlj
eS4xNSB8fCAoZWNobyAiUG9saWN5IGxvYWQgZmFpbGVkISI7IGV4aXQgMSkNCmVjaG8gRG9uZSBs
b2FkaW5nIHBvbGljeQ0KDQo=

--=-9W10KAcB5xzCG8ydnOnJ
Content-Disposition: attachment; filename=selinux.mkinitrd-script
Content-Transfer-Encoding: base64
Content-Type: text/x-sh; name=selinux.mkinitrd-script; charset=UTF-8

IyEvYmluL3NoIC1lDQojIEluc3RhbGwgYmluYXJ5IHBvbGljeSBmaWxlIGFuZCBsb2FkX3BvbGlj
eSB1dGlsaXR5IGZvciBsb2FkaW5nIGl0Lg0KdGVzdCAtbiAiJElOSVRSRERJUiINCm1rZGlyIC1w
ICIkSU5JVFJERElSIi9zZWxpbnV4DQpta2RpciAtcCAiJElOSVRSRERJUiIvZXRjL3NlY3VyaXR5
L3NlbGludXgNCm1rZGlyIC1wICIkSU5JVFJERElSIi9zY3JpcHRzDQpjcCAtYSAvZXRjL3NlY3Vy
aXR5L3NlbGludXgvcG9saWN5LjE1ICIkSU5JVFJERElSL2V0Yy9zZWN1cml0eS9zZWxpbnV4L3Bv
bGljeS4xNSINCmNwIC1hIC91c3Ivc2Jpbi9sb2FkX3BvbGljeSAiJElOSVRSRERJUi9iaW4vbG9h
ZF9wb2xpY3kiDQpjcCAtYSAvdXNyL3NoYXJlL3NlbGludXgvaW5pdHJkLXNjcmlwdCAiJElOSVRS
RERJUi9zY3JpcHRzL3NlbGludXgiDQo=

--=-9W10KAcB5xzCG8ydnOnJ--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
