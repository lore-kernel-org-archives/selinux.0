Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1ECq5rY017845
	for <selinux@tycho.nsa.gov>; Thu, 14 Feb 2008 07:52:05 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1ECq4LX012979
	for <selinux@tycho.nsa.gov>; Thu, 14 Feb 2008 12:52:04 GMT
Message-ID: <47B4395E.4010206@redhat.com>
Date: Thu, 14 Feb 2008 07:51:42 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: James Morris <jmorris@namei.org>
CC: Justin Mattock <justinmattock@gmail.com>, selinux@tycho.nsa.gov,
        Arjan van de Ven <arjan@infradead.org>,
        John Dennis <jdennis@redhat.com>
Subject: Re: SELinux power consumption (was Re: s.m.a.c.k)
References: <dd18b0c30802131822v3a7dd93bkba75363d65c262df@mail.gmail.com> <Xine.LNX.4.64.0802141523010.10898@us.intercode.com.au>
In-Reply-To: <Xine.LNX.4.64.0802141523010.10898@us.intercode.com.au>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

James Morris wrote:
> On Thu, 14 Feb 2008, Justin Mattock wrote:
> 
>> I had a quick question about power consumption, I've been doing a lot of
>> testing and seem to find no signs of SELinux or audit causing any wakeups at
>> all to the processor, but then googling some web site I came acrossed  said
>> there was a 7% overhead of energy or something in this area. What info do
>> you have in the area of power consumption, wakeups to the processor or load
>> on the processor with SELinux or audit that I should be aware of while Im
>> doing some testing?
> 
> IIRC, this was something like the setroubleshoot desktop applet, and I'm 
> not sure if it was fixed or not.  If not, it needs to be.
> 
> (cc'd Arjan, who I think discovered the issue).
> 
> 
> - James
sealert, the applet for setroubleshoot was a threaded python app.  The
python library that sealert uses wakes up every .1 seconds to see if the
parent received a signal.  This was causing the problem.   This has been
fixed in all versions of setroubleshoot, I believe.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAke0OV0ACgkQrlYvE4MpobOo0wCfRoyXVZcYkodfUGlL4qQ62JeF
V9oAoNmeRQuQOMZWpaAmJcoliaguUm9X
=F/p4
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
