Message-ID: <72222DC86846D411ABD300A0C9EB08A10152435E@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: "'Russell Coker'" <russell@coker.com.au>,
        "Westerman, Mark"
	 <Mark.Westerman@csoconline.com>,
        "'Reino Wallin'" <reino@oribium.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
Subject: RE: SELinux RPM Version
Date: Wed, 24 Apr 2002 07:31:27 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday, April 24, 2002 7:18 AM, Russell Coker wrote

> On Tue, 23 Apr 2002 19:44, Westerman, Mark wrote:
> > > According to the recent discussions, isn't
> > > /usr/share/selinux/policy/default
> > > the correct install path for the example policy?
> 
> That is the path used by my Debian packages.
> 
> > After much discussion on this subject it was decided
> > that the example policy resideds in
> >
> > /usr/share/doc/selinux/examples/policy
> 
> On the 12th of April Howard Holm convinced me to use 
> /usr/share/selinux/policy as the old 
> /usr/share/doc/selinux/examples/policy 
> directory that I (and only I) had been using was inconveniantly long.
> 
> I changed my packages that day and don't plan to change them back.
> 
Your orginal was corecct the /usr/share/doc/<package> is
90% of the packages put there examples. The /usr/share/<package>
is where most packages put information for packages to run.

I will keep  /usr/share/doc/selinux/examples/policy 
for the examples policies

I have also added /usr/share/selinux
for extra program such as the newrules.pl
that was posted to the list awhile back. 

By move the examples it confuses the extra programs
I might give out with the package.


Mark

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
