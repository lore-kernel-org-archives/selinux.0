Date: Mon, 17 Feb 2003 15:20:01 +0000
From: Dale Amon <amon@vnl.com>
To: Joshua Brindle <JBrindle@snu.edu>
Cc: SELinux@tycho.nsa.gov
Subject: Re: user transparent encryption
Message-ID: <20030217152001.GD14914@vnl.com>
References: <se502174.064@atlas.snu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <se502174.064@atlas.snu.edu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Feb 16, 2003 at 11:40:01PM -0600, Joshua Brindle wrote:
> I've pondered this myself, suppose you have a great selinux setup
> very secure, no easy way to compromise it, but the machine itself
> was in a hostile environment (not able to be protected from others
> well). What is to stop someone from booting up a non-selinux kernel
> and having at it with your filesystems? Nothing. I've often wondered
> if there is a way to lock down the drive contents so it is not
> accessible 
> (at least easily) by a non-selinux kernel, or even the encrypted fs
> where the key is compiled securely into a selinux-enabled kernel
> so that with a new (possible non-selinux) kernel the filesystem would
> not be readable. Do you guys think this is possible? granted it would
> make system recovery next to impossible but maybe it would be a 
> good option for folks with malicious or ignorant users/-co admins?
> 
> Joshua Brindle
> UNIX Administrator
> Southern Nazarene University

I don't have a full solution (other than what Russell
discusses later in this thread) but you should certainly
assume a well configured secure systems has:

	* a BIOS password
	* a lilo boot password
	* good root and role passwords

If you have reasonable password security, an attacker
now has no choice other than to disassemble the machine
and put the hard drive(s) in another machine. This is
not a full solution, but it stops the casual attacker
in the machine room cold unless they've got enough 
time to:

	* open up the machine
	* connect the IDE/SCSI cables to a preconfigured
	  attack machine
	* attack the disks
		* online: immediate entry and mod
		* offline: make copies of the disks
		  for study and later attack
	* load a log cleansing script
	* reconnect, close up and reboot
	* have the cleanup script run and remove
	  itself.

The online attack can be stopped cold by encrypted
root and user disks. Then, the attacker must

	* get an image of the disk
	* use social engineering, espionage or 
	  theft to get the password

And even then, to get the disk copy they might as
well not even try to hide their tracks because
without the passwords they can't put it back
as it was. They will have left a clear signature
they were there. Which means a serious attacker
might just torch the computer room to hide their
tracks. (hmmm... Twente???)

So if you go with Russell's approach, the machine
is secure against all but the admin with the key
and. If the admin is bent, or not careful with
the key, or his subverted (Mata Hari or missing 
fingers), then all is lost.

Ultimately comes down to internal security 
procedures and a sufficiently large and highly
trained staff to handle those issues.

That's why real security is *very* expensive.

-- 
------------------------------------------------------
       IN MY NAME:            Dale Amon, CEO/MD
  No Mushrooms clouds over    Islandone Society
    London and New York.      www.islandone.org
------------------------------------------------------

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
