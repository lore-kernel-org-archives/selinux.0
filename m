Message-ID: <72222DC86846D411ABD300A0C9EB08A101524434@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: "'hariharanjayaraman'" <hariharanjayaraman@indiatimes.com>,
        SELinux Mailing list E-mail <SELinux@tycho.nsa.gov>
Subject: RE: where to find archieves
Date: Wed, 16 Oct 2002 10:03:03 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


on Wednesday, October 16, 2002 9:46 AM hariharanjayaraman wrote:
> hi,
>   I want to know where can i find archieves of all the 
> patched kernel so far..
>

The best was is to use the CVS tree at sourceforge

cvs -d:pserver:anonymous@cvs.selinux.sourceforge.net:/cvsroot/selinux login

hit return at the password prompt

cvs -z3 -d:pserver:anonymous@cvs.selinux.sourceforge.net:/cvsroot/selinux co
nsa

Mark  

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
