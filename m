Message-Id: <200301202037.h0KKbdf28025@jazzband.ncsc.mil>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Carsten Grohmann <carstengrohmann@gmx.de>
To: Russell Coker <russell@coker.com.au>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: regular expressions
Date: Mon, 20 Jan 2003 21:15:41 +0100
References: <200301191750.h0JHoMf08676@jazzband.ncsc.mil> <200301200128.20028.russell@coker.com.au>
In-Reply-To: <200301200128.20028.russell@coker.com.au>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Am Montag, 20. Januar 2003 01:28 schrieb Russell Coker:
> On Sun, 19 Jan 2003 18:29, Carsten Grohmann wrote:
> > a few fc-files used the regexp [^/]* to label exact one file system
> > entry. I think sometimes it is better to use [^/]+ to mark one entry
> > instead of "zero and more".
>
> You are right.  Those regex's should be made more strict to avoid the
> potential for future conflicts or mis-interpretations.

> Also perhaps every instance of "(/.*)?" should be changed to "(/.+)?"?

If we replace the all regexp in this way, we will need often new entries 
for directories. e.g. "/var/log(/.*)?". I am not sure, if this is a good 
way. 

Carsten

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
