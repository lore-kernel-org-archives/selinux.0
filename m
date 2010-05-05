Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o45FFgo7029141
	for <selinux@tycho.nsa.gov>; Wed, 5 May 2010 11:15:42 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o45FF4Pi026651
	for <selinux@tycho.nsa.gov>; Wed, 5 May 2010 15:15:05 GMT
Message-ID: <4BE18B94.7000903@redhat.com>
Date: Wed, 05 May 2010 11:15:32 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Alan Rouse <alan.rouse@ericsson.com>
CC: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Re: Life cycle process for building products with selinux
References: <5A5E55DF96F73844AF7DFB0F48721F0F52E5D0EAF4@EUSAACMS0703.eamcs.ericsson.se>
In-Reply-To: <5A5E55DF96F73844AF7DFB0F48721F0F52E5D0EAF4@EUSAACMS0703.eamcs.ericsson.se>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 05/05/2010 10:22 AM, Alan Rouse wrote:
> I'm not sure where to ask a question like this but I bet someone on the list will know...
> 
> Are there any guidelines or "best practices" for building products with selinux?   (Think network appliances for example.)  I have in mind life cycle tasks such as
> 
I would argue as early in the process as possible.  From a security
point of view, I would specify your security goals during your design
phase and then write preliminary policy to implement them.
> - Software development:  Where in the software development cycle do you introduce selinux?  Should application developers have to develop on a system confined by selinux?   Is selinux policy maintenance a software development task, or a separate phase in the development cycle?
>
Yes it should be a development task, BUT some one with knowledge of
security should review the policy.  Most developers are just going to
want to get SELinux out of the way, so they will write as close to
unconfined_t policy as they can get away with.  Developers will get
continually frustrated by mislabeling though.  For example a binary has
a label of myapp_exec_t, every time the developer replaces the app, he
must make sure it has the label on it.  Also SELinux makes debugging
more difficult.  For example if you are writing a daemon application the
policy will probably have something like
unconfined_t -> initrc_exec_t @> initrc_t -> myapp_exec_t @> myapp_t

So an admin executing service myapp start will transition properly,
but

unconfined_t -> myapp_exec_t @> unconfined_t

Which means a admin executing the daemon directly or via gdm will stay
in the same context as the admin.

You can hook up to a running process with gdm or use runcon to make sure
the app runs within the correct context.



> - System integration:  Is this where selinux is first turned on?
> 
It can be, but some major design decisions might have been made that
cause confinement to be more difficult and may cause you to need to
redesign.
> - QA testing:  should QA testing include selinux-specific penetration testing?  Any guidelines or examples of how this is done?  Any tools?
> 
I would argue this should happen with or without SELinux.  Sorry no
guidelines.
> - Who in the development organization needs selinux expertise?
> 
Developers and QA people need to know to look for AVC messages.  But you
probably only need one person to understand how to write policy.
> - Are there services that can certify the MAC rules for the operating system?  For the product application?
> 
> - Any selinux-specific guidance for customers who install the protected appliance?
> 
I think you want to run with permissive domains, for a while to catch
all of the code paths that you did not expect, without the SELinux
causing the application to break.
> - Impact on the process for upgrades and patches because of selinux.  What not to do... for example, turning off selinux to apply a patch.  How to configure a properly confined user for applying patches.
> 
Yes having to turn off SELInux is a mistake, SELinux policy should be
able to be updated without major problems.  Verifying labels can be a
critical part of the update.
> - Organizational policy to complement a properly designed system (separation of duties; physical security; etc).
> 
> - War stories, lessons learned... or anything of the sort
> 
> Thanks
> Alan
> 
> 

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkvhi5QACgkQrlYvE4MpobM14ACghN3TMxeIASK1mxsosYfTPd++
sq0AnRGzsKRgLYytT01EwJSIZvfZbcd0
=33rj
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
