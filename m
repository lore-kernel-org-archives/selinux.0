Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q61A6Kxc016733
	for <selinux@tycho.nsa.gov>; Sun, 1 Jul 2012 06:06:21 -0400
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: lkcl luke <luke.leighton@gmail.com>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: Is it time to move seandroid policy messages off of the selinux lists and onto there own list?
Date: Sun, 1 Jul 2012 20:06:12 +1000
References: <4FEE0168.70306@redhat.com> <CAPweEDzqzTTRc16bU-GS=f9LutZJTLhi6auGzSU4Xwvup2tnzA@mail.gmail.com>
In-Reply-To: <CAPweEDzqzTTRc16bU-GS=f9LutZJTLhi6auGzSU4Xwvup2tnzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201207012006.13120.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 30 Jun 2012, lkcl luke <luke.leighton@gmail.com> wrote:
> On Fri, Jun 29, 2012 at 8:26 PM, Daniel J Walsh <dwalsh@redhat.com> wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> > 
> > We moved off fedora user questions and reference policy...
> 
>  almost certainly, yes.  the popularity of android and the general...
> how-to-say-politely-i-know-lets-use-implicit-tact... level of
> intelligence of the average android user is quite likely to swamp the
> selinux mailing list and reduce its quality to zero.

For Android development the barriers to entry are a lot higher than for 
general Linux development.  So I would expect Android developers to be more 
dedicated than people who do similar work on an easier platform.

In regard to the issue of a separate mailing list, there have been a lot of 
messages about details of the Android platform that aren't relevant to people 
who are developing for a Debian or RHEL platform.  Having a separate list for 
such messages seems like a good idea.

But messages that concern policy or more mainline SE Linux development should 
still go to the current two lists even if they concern Android.

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
