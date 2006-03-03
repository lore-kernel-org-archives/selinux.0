Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k231K3Qu027450
	for <selinux@tycho.nsa.gov>; Thu, 2 Mar 2006 20:20:07 -0500
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k231K0E8005901
	for <selinux@tycho.nsa.gov>; Fri, 3 Mar 2006 01:20:00 GMT
Message-ID: <440799A1.2090401@tresys.com>
Date: Thu, 02 Mar 2006 20:19:29 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Erich Schubert <erich@debian.org>
CC: Chad Sellers <csellers@tresys.com>, SE Linux <selinux@tycho.nsa.gov>,
        Kevin Carr <kcarr@tresys.com>, selinux-dev@tresys.com
Subject: Re: FYI SELinux/AppArmor press
References: <43FF7418.90205@redhat.com>	 <1141138934.29803.2.camel@wintermute.xmldesign.de>	 <1141183226.8475.22.camel@localhost.localdomain>	 <1141222338.2834.33.camel@wintermute.xmldesign.de>	 <d82d6db50603011259s3fe0e80duca501a9c7925c661@mail.gmail.com>	 <1141250441.2834.62.camel@wintermute.xmldesign.de>	 <44065CB2.5080500@tresys.com> <1141296207.17082.12.camel@wintermute.xmldesign.de>
In-Reply-To: <1141296207.17082.12.camel@wintermute.xmldesign.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Erich Schubert wrote:
> Hello Chad,
> In my opinion, the SELinux security policy should be done using a real
> OOP paradigma, not this "imperative" like set of rules we have right now
> (M4 is imperative...)
> In an ideal case, people could write SELinux policies using UML
> modelers.
> I'm not a big fan of Java and UML, but I think it helps people a lot.
>

I'll start by saying I've been spending alot of time thinking about 
language enhancements lately and will be sending an RFC to the list 
sometime soon. With that in mind I have some comments on these suggestions.

> We had some OOP-like elements alaredy - "sysadmfile" and similar type
> flags we had in the old nsa policy.
> 
> I'd imagine a good policy language to be like this:
> ---
> type system_logfile : public system_file {
> 	public interface read { ... }
> 	public interface write { ... }
> 	public interface append { ... }
> 	public interface manage { ... }
> }

the reference policy is designed so that modules don't know about types 
(or any symbol) from other modules. Instead the reference policy tries 
to abstract them into actions relevant to that module such as 
apache_read_log. The webalizer module knows it needs to read apache 
logs, but doesn't need to know how that is implemented. This kind of 
encapsulation is one of the best benefits of refpolicy IMHO.

> 
> type amavis_logfile : public system_logfile {
> 	match "/var/log/amavis.*"
> 	/* will inherit interfaces by system_logfile */
> }
> 
putting labeling with the policy is bad for a few reasons. First the 
file context files are suppose to be for system initialization only, 
though they aren't necessarily used that way. Further, different distros 
(and even different OS's) are going to have different file paths which 
would require that information to be encoded into the policy instead of 
letting the enforcement policy be separate from labeling.

> type amavisd_exec : public system_executable_file {
> 	match "/usr/sbin/amavisd.*"
> 
> 	interface execTransition { ... }
> }
> 
> type amavisd : public network_daemon {
> 	interface sendTo { ... }
> }
> 
> rules amavisd {
> 	allow appendTo amavis_logfile
> }
>
Not sure things like this fix anything. You would still have to know 
about something called "amavis_logfile", how is that different from 
looking at http://serefpolicy.sourceforge.net/api-docs/ and going to the 
amavis module and seeing the available interfaces (or using SLIDE with 
autocomplete)

> rules initrc {
> 	allow execTransition amavisd_exec
> }

It seems like this would be more verbose, lots of rules are handled by 
way of attributes which this seems to ignore.

> ---
> 
> I'm no language designer, and no usability expert... but I think the
> policy language should avoid unnecessary repetition as far as possible
> and follow modelling paradigmas people already know such as inheritance.
> 

inheritance is great while programming when you can apply repetitive 
procedures to similar classes. Inheritance with security is not good, 
however. In an ideal world children would be reducing policy, not 
applying the same.

Other than those I agree that OOP principles could do wonders for policy 
development and I'm collecting ideas like these for the language 
discussion at the developers summit tomorrow, stay tuned for published 
notes from there.

We also had a couple papers in the symposium proceedings regarding 
language abstractions and I think there are lots of good ideas being 
bounced around and now we need to take those and figure out which ones 
are truly helpful and implement them.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
