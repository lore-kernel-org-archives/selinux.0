Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p2I0YAtg010209
	for <selinux@tycho.nsa.gov>; Thu, 17 Mar 2011 20:34:10 -0400
Received: from cp-out7.libero.it (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p2I0Y8WH009768
	for <selinux@tycho.nsa.gov>; Fri, 18 Mar 2011 00:34:09 GMT
Subject: Re: SE Linux use - was: Question: and the policy grows...
From: Guido Trentalancia <guido@trentalancia.com>
To: russell@coker.com.au
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <201103181024.18303.russell@coker.com.au>
References: <1300369855.30425.14.camel@tesla.lan>
	 <4D823A60.9020107@redhat.com> <1300390804.31755.6.camel@tesla.lan>
	 <201103181024.18303.russell@coker.com.au>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 18 Mar 2011 01:33:36 +0100
Message-ID: <1300408416.3050.5.camel@tesla.lan>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Russel !

On Fri, 18/03/2011 at 10.24 +1100, Russell Coker wrote:
> On Fri, 18 Mar 2011, Guido Trentalancia <guido@trentalancia.com> wrote:
> > There is at least the limit of not having many people on this list
> > compared to most other Linux projects. Perhaps security is considered
> > something boring to the average user/developer. Or even more likely
> > SELinux is still perceived as "difficult to get into" (a documentation
> > issue).
> 
> NSA people:  How many subscribers are there to this list outside .gov?
> 
> Tresys people:  How many subscribers to the refpolicy list are outside .gov?
> 
> Does anyone know of a good study about the size of typical Linux projects?  
> I'm willing to bet that SE Linux has more active developers and more members 
> on the main mailing list than most Linux projects.

In that context I meant active subscribers.

I found an estimate for Gnome (gnome.org):

around 700 active committers in the last two years

cfr.
http://www.osor.eu/idabc-studies/expert-docs/encouraging-good-practice

Just showed up as the very first results on Google.

> On Fri, 18 Mar 2011, Sven Vermeulen <sven.vermeulen@siphos.be> wrote:
> > It is a good thing that RedHat and other (commercial) distributions are
> > (starting to) offer SELinux-enabled systems by default. By integrating it
> > immediately (and not offering it as an "additional" option) they somewhat
> > force organizations to at least understand what it does or is supposed to
> > do. By having the non-commercial distributions focus on SELinux more and
> > more, this will also create awareness in the community.
> 
> Red Hat has been doing it for a long time, since RHEL4 (they are at RHEL6 
> now).
> 
> Making it a default feature means that if a server is cracked and it turns out 
> to have had SE Linux disabled then the sysadmin will have to explain why they 
> turned off default security features thus making it easier for the attacker.  
> That wouldn't be a desirable situation for a sysadmin to be in.
> 
> http://oss.tresys.com/pipermail/refpolicy/2011-March/004129.html
> 
> Mark Montague's message archived at the above URL is worth bookmarking as a 
> list of issues to work on.
> 
> On Fri, 18 Mar 2011, Mark Montague <mark@catseye.org> wrote:
> > research University), all of the system administrators I have met 
> > disable SELinux as the very first thing they do after installing the 
> > OS.  Most of them disable SELinux without having any real understanding 
> > of what it does, and the reason they give, when asked, is because they 
> > want everything to "just work".  When an AVC denial occurs, they don't 
> > even want to know what it means or why it occurs, the just know that 
> > "the AVC denial breaks their service" and disabling SELinux "fixes their 
> > service".
> 
> There are a lot of people who do the same with UID and GID, they just run 
> everything as root.  Nearly as bad are the people who run everything as user 
> "nobody", so "nobody" becomes everybody which dramatically weakens security.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
