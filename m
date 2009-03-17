Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n2HH698I027092
	for <selinux@tycho.nsa.gov>; Tue, 17 Mar 2009 13:06:09 -0400
Received: from merlin.cdltd.co.uk (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n2HH67Cq019500
	for <selinux@tycho.nsa.gov>; Tue, 17 Mar 2009 17:06:08 GMT
Received: from exch.cdltd.co.uk (fw.cdltd.co.uk [193.132.127.247])
	by merlin.cdltd.co.uk (Postfix) with ESMTP id 702371F8009A
	for <selinux@tycho.nsa.gov>; Tue, 17 Mar 2009 17:06:37 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Unable to disable SELinux
Date: Tue, 17 Mar 2009 17:06:45 -0000
Message-ID: <DAE2574A7F44F44ABE07381C36213DFA06A78C32@exch.cdltd.co.uk>
In-Reply-To: <200903141134.07934.russell@coker.com.au>
References: <DAE2574A7F44F44ABE07381C36213DFA069F7833@exch.cdltd.co.uk> <200903141134.07934.russell@coker.com.au>
From: "Paul Cocker" <paul.cocker@tntpost.co.uk>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Russell Coker [mailto:russell@coker.com.au] 
> Sent: 14 March 2009 00:34
> To: Paul Cocker
> Cc: selinux@tycho.nsa.gov
> Subject: Re: Unable to disable SELinux
> 
> On Fri, 13 Mar 2009, "Paul Cocker" <paul.cocker@tntpost.co.uk> wrote:
> > Running SELinux on a CentOS 5.2 box, Im trying to 
> temporarily disable 
> > SELinux via one of the following methods:
> >
> > 1. sudo echo 0 > /selinux/enforce
> 
> Redirecting standard output is done by your shell.  So "sudo 
> echo > file" will not work unless "echo > file" works.  This 
> is not a SE Linux issue.
> 
> "sudo setenforce 0" will work.
> 

Thanks, this is correct, I used this command and all was well.

> > 2. sudo vim /selinux/enforce
> >
> > The first comes back with
> >
> > -bash: /selinux/enforce: Permission denied
> 
> Note that the error is from "bash".
> 
> > The second comes back with
> >
> > Could not set security context for /home/paulc/enforcz~
> 
> Editors such as "vim" are not designed to just write data to 
> a file.  In the /root directory of my SE Linux Play Machine I 
> have a file named thanks.txt_append_only_dont_edit_with_vi - 
> many people try editing it with vi and find that it doesn't work.
> 
> Generally don't even try using vi to edit "files" under 
> /proc, /sys, or any other filesystem that is used for kernel 
> communications.
> 
> --
> russell@coker.com.au
> http://etbe.coker.com.au/          My Main Blog
> http://doc.coker.com.au/           My Documents Blog
> 


TNT Post is the trading name for TNT Post UK Ltd (company number: 04417047), TNT Post (Doordrop Media) Ltd (00613278), TNT Post Scotland Ltd (05695897), TNT Post North Ltd (05701709), TNT Post South West Ltd (05983401), TNT Post Midlands Limited (6458167)and TNT Post London Limited (6493826). Emma's Diary and Lifecycle are trading names for Lifecycle Marketing (Mother and Baby) Ltd (02556692). All companies are registered in England and Wales; registered address: 1 Globeside Business Park, Fieldhouse Lane, Marlow, Buckinghamshire, SL7 1HY.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
