Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m9KDaWpm031201
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2008 09:36:32 -0400
Received: from mailhost.cdltd.co.uk (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m9KDaVIT001816
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2008 13:36:32 GMT
Received: from exch.cdltd.co.uk (fw.cdltd.co.uk [193.132.127.247])
	by mailhost.cdltd.co.uk (8.14.1/8.12.11) with ESMTP id m9KDXv9W018291
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2008 14:35:10 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: SELinux blocking disclaimer - help diagnosing
Date: Mon, 20 Oct 2008 14:35:44 +0100
Message-ID: <DAE2574A7F44F44ABE07381C36213DFA05C05B03@exch.cdltd.co.uk>
In-Reply-To: <200810202247.06768.russell@coker.com.au>
References: <DAE2574A7F44F44ABE07381C36213DFA05C05720@exch.cdltd.co.uk> <200810202247.06768.russell@coker.com.au>
From: "Paul Cocker" <paul.cocker@tntpost.co.uk>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Russell Coker [mailto:russell@coker.com.au] 
> Sent: 20 October 2008 12:47
> To: Paul Cocker
> Cc: selinux@tycho.nsa.gov
> Subject: Re: SELinux blocking disclaimer - help diagnosing
> 
> On Monday 20 October 2008 19:56, "Paul Cocker" 
> <paul.cocker@tntpost.co.uk>
> wrote:
> > I'm attaching a footer to e-mail in postfix using 
> altermime. SELinux 
> > is preventing this from happening.
> 
> How do you configure that?  Please give us a simple example 
> of how to make Postfix do that so we can reproduce it.
> 

I followed the instructions here (though I use CentOS 5.2, not Debian):

http://www.howtoforge.com/add-disclaimers-to-outgoing-emails-with-alterm
ime-postfix-debian-etch

Only difference being I didn't use the modifications they list to the
script, except they incorrectly label:

  /usr/bin/altermime --input=in.$$ \
                   --disclaimer=/etc/postfix/disclaimer.txt \
                   --disclaimer-html=/etc/postfix/disclaimer.txt \
                   --xheader="X-Copyrighted-Material: Please visit
http://www.company.com/privacy.htm" || \
                    { echo Message content rejected; exit
$EX_UNAVAILABLE; }

As being a modification when in fact it's part of the original script. I
think this is just so capture their full IF statement though.

Config of the disclaimer has been given the thumbs up by the postfix
mailing list.

> --
> russell@coker.com.au
> http://etbe.coker.com.au/          My Blog
> 
> http://www.coker.com.au/sponsorship.html Sponsoring Free 
> Software development
> 



TNT Post is the trading name for TNT Post UK Ltd (company number: 04417047), TNT Post (Doordrop Media) Ltd (00613278), TNT Post Scotland Ltd (05695897), TNT Post North Ltd (05701709), TNT Post South West Ltd (05983401), TNT Post Midlands Limited (6458167)and TNT Post London Limited (6493826). Emma's Diary and Lifecycle are trading names for Lifecycle Marketing (Mother and Baby) Ltd (02556692). All companies are registered in England and Wales; registered address: 1 Globeside Business Park, Fieldhouse Lane, Marlow, Buckinghamshire, SL7 1HY.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
