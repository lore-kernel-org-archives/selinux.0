Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j11D8N53014914
	for <selinux@tycho.nsa.gov>; Tue, 1 Feb 2005 08:08:23 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j11D6ErX021602
	for <selinux@tycho.nsa.gov>; Tue, 1 Feb 2005 13:06:15 GMT
Subject: Re: File Browsing apps and getattr
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1107259894.26936.27.camel@moss-spartans.epoch.ncsc.mil>
References: <1107210369.1928.5.camel@cobra.ivg2.net>
	 <1107259894.26936.27.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 01 Feb 2005 06:08:28 -0700
Message-Id: <1107263308.6722.5.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-02-01 at 07:11 -0500, Stephen Smalley wrote:
> On Mon, 2005-01-31 at 17:26, Ivan Gyurdiev wrote:
> > What are your thoughts on this bug?
> > It asks whether it would be reasonable to grant full getattr privileges
> > to all file browsing applications (like nautilus, mozilla, things with a
> > file open dialog..)
> > 
> > This has bothered me ever since I first tried selinux - I open up 
> > nautilus or any other app with a file browser, and soon I get a storm of
> > denials. There should be a way to fix this.
> > 
> > https://bugzilla.redhat.com/beta/show_bug.cgi?id=146557
> > 
> > The bug says dontaudit, but when dwalsh explained the difference
> > I see I mean allow instead.
> 
> Allowing access to file_type would obviously be too wide.  

Why? I don't see why it's necessary to get all those denials,
and why ls doesn't show me the file properties for restricted types. 
It seems reasonable to me that if you can search the parent directory
you should be permitted to stat the files in it.

Even the manpage of stat() says so:

"These  functions  return information about the specified file.  You do
not need any access rights to the file to get this information but you
need search rights to all directories named in the path leading to the
file."

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
