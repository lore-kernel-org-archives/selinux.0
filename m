Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Carsten Grohmann <carstengrohmann@gmx.de>
Subject: Re: redhat.te and suse.te (was Re: pppd with ipppd)
Date: Tue, 10 Sep 2002 18:26:30 +0200
Cc: SELinux <SELinux@tycho.nsa.gov>
References: <200209082234.38885.russell@coker.com.au> <200209092236.02733.russell@coker.com.au> <200209101310.NAA02014@jazzswing.ncsc.mil>
In-Reply-To: <200209101310.NAA02014@jazzswing.ncsc.mil>
MIME-Version: 1.0
Message-Id: <200209101826.30237.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 10 Sep 2002 15:11, Carsten Grohmann wrote:
> > Also if we do that then perhaps we should have a redhat.te and move some
> > of the stuff out of rpm.te, and change some of the "ifdef(`rpm.te',"
> > statements to "ifdef(`redhat.te',".
>
> Sound like good. And we should use the m4 macro processor for the fc files
> too.
> In my eyes we needs the m4 conditionals to build simple file contexts
> files.

I suggested this once before, Steve didn't like it so we went to having one 
.fc file per application.

Now that we have shown that the .fc file per application scheme works well I 
doubt that there is a real need to use M4 for the .fc files (it's adding 
extra complexity for little benefit that I can see).

> And it will by possible to remove unused single rules (like dhcpd_t)
> without get an error ( Unkown type ...).

What do you mean?

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
