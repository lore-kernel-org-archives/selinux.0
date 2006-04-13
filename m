Subject: Re: Untrusted applications under SELinux
From: Erich Schubert <erich@debian.org>
To: Valdis.Kletnieks@vt.edu
Cc: Gaurav Poothia <gpoothia@cs.sunysb.edu>, SELinux@tycho.nsa.gov
In-Reply-To: <200604122022.k3CKMJ6w013405@turing-police.cc.vt.edu>
References: <Pine.GSO.4.53.0604121556280.20146@compserv4>
	 <200604122022.k3CKMJ6w013405@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=ISO-8859-15
Date: Thu, 13 Apr 2006 13:24:33 +0200
Message-Id: <1144927474.30812.36.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
> There is no reasonable way to keep a user from shooting themselves in the foot.

I mostly agree here. There are some exceptions, though. But it all
depends on how much the user is willing to give up in convenience stuff.

For example, you might not want to allow "untrusted" apps (e.g.
webbrowsers) to read personal data files. However, this basically breaks
all webmail applications, flickr and so on. People will often want their
webbrowser to be able to read their photo collection, for example.
This also applies to untrusted applications downloaded from the
internet, let's say a photo manager. That application is untrusted, yet
it needs to be able to write to your photo collection to be of use.

So it boils down to:
If the user wants a high security system, he needs to accept that:
- He sometimes needs to manually "transition" files from a "secured"
part to an "unsecured" part (e.g. by copying files to a directory the
browser can access before uploading them)
- He sometimes needs to manually transition files from a "unsecured"
part to a secure part (e.g. moving downloaded files from the download
folder to his photo collection)
- He can not just download and run applications that access his secured
data.

You can do some high-effort security measures. For example, you might
not allow the user to execute any of his downloaded files, or write his
own applications.
But you can write an application that takes a downloaded file,
virus-checks it and then puts it into a directory (read: relabel it)
where he can execute it.
But that is a) inconvenient for the user b) still not too secure due to
VMs and scripting languages and other means to dynamically load code
that the virus scanner can't check.

> SELinux is designed to contain the damage and protect the *other* user's feet.

Well, DAC does try to do that already. SELinux tries to do so for *one*
user, mostly for root. It prevents bugs in e.g. bind to be able to
damage your other processes, despite running as root.

But deny-by-default (a key security concept) and unknown apps (security
hell) basically boils down to "deny everything". (because "true" doesn't
need any rights)
This security concept just doesn't mix with completely unknown apps!

You can however define a "confined_user_t" role that has only these
access rights that you are willing to give to, well, applications you
want to confine.
But this "you are willing" is very unspecific. You need to find out what
you are willing to allow. I wouldn't include read access to the users
home directory. Nor to his mail. Just to maybe /tmp (rwc), ~/download
(rwc) and ~/upload (r), maybe ro access to some config files (for visual
integration, e.g. .gtkrc)
and read access to common system libraries, but thats it.
I don't think this will be very useful, though. I don't know any
applications I would use this with.

best regards,
Erich Schubert
-- 
    erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
  A polar bear is a rectangular bear after a coordinate transform.   //\
     Zwei Freunde müssen sich im Herzen ähneln, in allem anderen     V_/_
        können sie grundverschieden sein. --- Sully Prudhomme



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
