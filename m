Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2SBQpDo025611
	for <selinux@tycho.nsa.gov>; Mon, 28 Mar 2005 06:26:51 -0500 (EST)
Received: from mail.lemuria.org (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2SBQ31g018954
	for <selinux@tycho.nsa.gov>; Mon, 28 Mar 2005 11:26:03 GMT
Date: Mon, 28 Mar 2005 13:26:54 +0200
From: Tom <tom@lemuria.org>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: "Fedora SELinux support list for users &amp;  developers." <fedora-selinux-list@redhat.com>,
   selinux@tycho.nsa.gov
Subject: Re: Desktop apps interoperability
Message-ID: <20050328132653.F27857@lemuria.org>
References: <1111985855.1514.70.camel@cobra.ivg2.net> <1111986213.1514.77.camel@cobra.ivg2.net> <1111987652.1514.97.camel@cobra.ivg2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1111987652.1514.97.camel@cobra.ivg2.net>; from ivg2@cornell.edu on Mon, Mar 28, 2005 at 12:27:31AM -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Mar 28, 2005 at 12:27:31AM -0500, Ivan Gyurdiev wrote:
> Part of the problem seems to be the way Linux apps treat /home, as the
> place for everything. 

It doesn't. It treats $HOME as the only place that the user has
permission to store his stuff. On a well-configured system, that
assumption is correct.


> Why are both app. settings and user data stored
> in /home as the default location. 

Because otherwise the user couldn't add or edit them.


> Now Windows' approach of having "My Documents" and the like is starting
> to make a lot of sense (even though I absolutely hate those names).

The Linux approach, however, allows much more flexibility.

If you want applications to share data, there are several ways to
accomplish that goal. Here's just a quick idea:

* add $HOME/Downloads as a directory
* give it its own type, maybe ROLE_downloads_t
* give mozilla permissions to write there, with file_type_auto_trans
* give mplayer permissions to the resulting files

voila, mplayer can now play stuff downloaded from the web, without
opening up the big hole of giving it permissions to all mozilla files.


Another solution, for a more paranoid environment would be adding a
virus/malware scanner domain that can read mozilla's files and write them 
out again (after checking and/or cleaning) as a regular ROLE_home_t
file. This would ensure that any files fully accessible in the home
directory have been scanned.



The point is - I may or may not want mplayer to play random stuff from
the web with potentially dangerous content. If you want to, evaluate
your security requirements and institute the appropriate solution.


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
