Message-Id: <200209291613.QAA24352@jazzswing.ncsc.mil>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Carsten Grohmann <carstengrohmann@gmx.de>
To: Russell Coker <russell@coker.com.au>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: $1_cupsd_spool_t in lpr_macros.te
Date: Sun, 29 Sep 2002 18:07:01 +0200
References: <200209291121.LAA25284@jazzband.ncsc.mil> <200209291343.46606.russell@coker.com.au>
In-Reply-To: <200209291343.46606.russell@coker.com.au>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Am Sonntag, 29. September 2002 13:43 schrieb Russell Coker:
> On Sun, 29 Sep 2002 12:29, Carsten Grohmann wrote:
> > the attached patch add cups support in lpr_domain. You can pipe some
> > data to lpr with this additional rules.
>
> Won't you also need something like the following?
> allow cupsd_t $1_cupsd_spool_t:file { r_file_perms unlink };

No. I try the new rules and it runs fine.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
