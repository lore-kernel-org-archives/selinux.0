Date: Thu, 28 Jun 2001 17:30:26 -0400 (EDT)
From: Jose Nazario <jose@biocserver.bioc.cwru.edu>
To: Pranav Saha <psaha@bbn.com>
cc: <SELinux@tycho.nsa.gov>
Subject: Re: More install issues
In-Reply-To: <001801c10010$4cb34ba0$9c34e9c0@sahad1>
Message-ID: <Pine.LNX.4.30.0106281729200.32758-100000@biocserver.BIOC.CWRU.Edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 28 Jun 2001, Pranav Saha wrote:

> I keep getting a "YPBINDPROC_DOMAIN: Domain Not Bound" error and the
> machine fails on boot when "bringing up interface eth0".  Don't know
> if the SELinux install wrote over some of my network drivers or if it
> was a problem with my config??

ypbind is an NIS/yp (yp is the old name for it) service. it shouldn't have
anything to do with SELinux/FLASK i think. are you sure you need it?

does it run when you're running a normal kernel?

____________________________
jose nazario						     jose@cwru.edu
	      	     PGP: 89 B0 81 DA 5B FD 7E 00  99 C3 B2 CD 48 A0 07 80
				       PGP key ID 0xFD37F4E5 (pgp.mit.edu)


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
