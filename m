Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2OAQJDo029955
	for <selinux@tycho.nsa.gov>; Thu, 24 Mar 2005 05:26:20 -0500 (EST)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2OANbQL028380
	for <selinux@tycho.nsa.gov>; Thu, 24 Mar 2005 10:23:37 GMT
Date: Thu, 24 Mar 2005 10:35:56 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: David Hampton <hampton-rh@rainbolthampton.net>
Cc: jwcart2@epoch.ncsc.mil, SELinux <selinux@tycho.nsa.gov>,
   fedora-selinux-list@redhat.com
Subject: Re: New policy for pyzor
Message-ID: <20050324103556.GD7999@lkcl.net>
References: <1111454594.18940.54.camel@hampton-pc.rainbolthampton.net> <1111605242.3856.24.camel@moss-lions.epoch.ncsc.mil> <1111610253.26996.16.camel@hampton-pc.rainbolthampton.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1111610253.26996.16.camel@hampton-pc.rainbolthampton.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Mar 23, 2005 at 03:37:33PM -0500, David Hampton wrote:
> On Wed, 2005-03-23 at 14:14 -0500, James Carter wrote:
> > >From pyzor.te:
> 
> > Why home_domain_access()?
> 
> If you don't specify a directory with the --homedir argument, pyzor
> creates a ~/.pyzor directory to store its files.  I've had them created
> as both /root/.pyzor and /home/david/.pyzor depending upon which uid I
> use to run the applications.  

 
 ... btw just as an aside, what the heck is razor doing
 attempting to create /razor.log and /root/razor.log?

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
