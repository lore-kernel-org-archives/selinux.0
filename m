Message-ID: <72222DC86846D411ABD300A0C9EB08A101524435@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: "'Stephen Smalley'" <sds@tislabs.com>,
        "Westerman, Mark"
	 <Mark.Westerman@csoconline.com>
Cc: SELinux@tycho.nsa.gov
Subject: RE: initrd kernel panic
Date: Wed, 16 Oct 2002 10:31:57 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ok I fat fingered the kernel I was booting off of.
One more question.
	Does the initrd need to be labeled ?


> -----Original Message-----
> From: Stephen Smalley [mailto:sds@tislabs.com]
> Sent: Wednesday, October 16, 2002 9:45 AM
> To: Westerman, Mark
> Cc: SELinux@tycho.nsa.gov
> Subject: RE: initrd kernel panic
> 
> 
> 
> On Wed, 16 Oct 2002, Westerman, Mark wrote:
> 
> > That should have been cvs check out on friday.
> 
> I'd suggest double checking your working copy (do a 'cvs 
> update -A') and
> making sure that you are booting the kernel you just built.  
> The behavior
> you describe was specifically fixed by the patch, and the patch was
> committed to the head of the tree.
> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
