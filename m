Message-ID: <36282A1733C57546BE392885C0618592D96BAF@chaos.tcs.tcs-sec.com>
From: Chad Hanson <chanson@TrustedCS.com>
To: Daniel J Walsh <dwalsh@redhat.com>, Chad Hanson
	 <chanson@TrustedCS.com>
Cc: "SE Linux (E-mail)" <SELinux@tycho.nsa.gov>,
   "Stephen Smalley (E-mail)" <sds@epoch.ncsc.mil>,
   Darrel Goeddel
	 <DGoeddel@TrustedCS.com>
Subject: RE: [PATCH] libsetrans
Date: Tue, 25 Oct 2005 19:12:24 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> How about instead of adding another config file, we default the file to 
> the current policy that is installed.
> 
> /etc/selinux/setrans_mls.conf and /etc/selinux/setrans_targeted.conf
> 
> libselinux already reads config file so this will require no additional 
> perms, or we just put them into the policy file.
> 
> /etc/selinux/TYPE/setrans.conf
> 

Either way seems fine. Initially, I was for the last, but I'm not sure we
want the translation configs in the policy rpm. So if we want to keep this
out of the policy, probably the first even though the second is more
elegant.

-Chad 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
