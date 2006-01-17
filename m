Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0HGudXf005395
	for <selinux@tycho.nsa.gov>; Tue, 17 Jan 2006 11:56:40 -0500 (EST)
Received: from luminouswebdesign.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0HGtVP2025370
	for <selinux@tycho.nsa.gov>; Tue, 17 Jan 2006 16:55:31 GMT
Received: from schaufler-ca.com (luminouswebdesign.com. [216.117.155.141])
	by luminouswebdesign.com (8.12.10/8.12.10) with SMTP id k0HGubQp006859
	for selinux@tycho.nsa.gov; Tue, 17 Jan 2006 11:56:37 -0500
Date: Tue, 17 Jan 2006 11:56:37 -0500
From: "schaufler-ca.com - Casey Schaufler" <casey@schaufler-ca.com>
Message-Id: <200601171656.k0HGubQp006859@luminouswebdesign.com>
To: selinux@tycho.nsa.gov
Subject: Re: Why are we managing seusers file via libsemanage?
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



Ivan Gyurdiev wrote:

> I don't understand the way Unix updates
> the password for example - it  doesn't make
> sense to me, I would appreciate an explanation
> from  someone who knows better.


Image a universe with no Internet. A universe
in which DES is sufficiently strong encryption for
any purpose, including DoD classified material.
A universe in which 16bit computing is hot stuff,
where computers store passwords in clear text,
and Gigabyte describes the storage capacity of
the United States.

In that universe storing user ID and password
information in an unstructured flat file, with the
password stored as a one-way DES hash not
only makes sense, it's Brilliant! (Wow, I want a
Guiness now!) The administrator can update
the user information using normal tools like ed,
or even exotic ones like sed, grep, and ex.
Heck, there's even an API for reading the file
(getpwent()) that parses the file for you if you
need to translate uid numbers to user names.
What's more, there's a program (passwd(1))
that carefully allows a user to change her
password -get this- without bothering the
administrator. Incredible.

Unix password management was magical in
its day. It's still good enough to fight off the
dozens of attempts that have been made to
replace it with something "better".

Sigh. You just made me feel old. I'll go back
to my corner now.


------------------------
Casey Schaufler
casey@schaufler-ca.com
650.906.1780








--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
