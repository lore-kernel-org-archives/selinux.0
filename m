Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j11CI453014681
	for <selinux@tycho.nsa.gov>; Tue, 1 Feb 2005 07:18:04 -0500 (EST)
Subject: Re: File Browsing apps and getattr
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: ivg2@cornell.edu
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1107210369.1928.5.camel@cobra.ivg2.net>
References: <1107210369.1928.5.camel@cobra.ivg2.net>
Content-Type: text/plain
Message-Id: <1107259894.26936.27.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 01 Feb 2005 07:11:35 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-01-31 at 17:26, Ivan Gyurdiev wrote:
> What are your thoughts on this bug?
> It asks whether it would be reasonable to grant full getattr privileges
> to all file browsing applications (like nautilus, mozilla, things with a
> file open dialog..)
> 
> This has bothered me ever since I first tried selinux - I open up 
> nautilus or any other app with a file browser, and soon I get a storm of
> denials. There should be a way to fix this.
> 
> https://bugzilla.redhat.com/beta/show_bug.cgi?id=146557
> 
> The bug says dontaudit, but when dwalsh explained the difference
> I see I mean allow instead.

Allowing access to file_type would obviously be too wide.  Allowing a
user's browser or similar user apps to stat his home directory files
with the corresponding derived types may be reasonable.  The
$1_file_type attribute may help you there.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
