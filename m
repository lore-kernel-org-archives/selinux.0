Message-ID: <36282A1733C57546BE392885C06185924D92D7@chaos.tcs.tcs-sec.com>
From: Chad Hanson <chanson@TrustedCS.com>
To: Karl MacMillan <kmacmillan@tresys.com>,
   Stephen Smalley
	 <sds@epoch.ncsc.mil>
Cc: Frank Mayer <mayerf@tresys.com>, Darrel Goeddel
	 <DGoeddel@TrustedCS.com>,
   SELinux List <SELinux@tycho.nsa.gov>, Chad Hanson <chanson@TrustedCS.com>
Subject: RE: dynamic context transitions
Date: Tue, 2 Nov 2004 13:49:07 -0500 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Karl MacMillan wrote: 
> I admit that I was really trying to make it clear that this isn't a
> transition mechanism, but something that would stay if introduced. Also,
> where would you put the trust boundaries if not at process boundries? Is
> it possible to truly reduce the trust between two sections of code in
> the same process image? [these are not rhetorical questions - I'm really
> asking for some clarification]

You put the trust at the process boundary. This does not preclude you from
trying increase the trust in the code. You clearly could reduce the trust
within an application. The privilege bracketing approach goes hand in hand
with secure programming techniques. An example would be that your program
needs to open the kernel memory device. If your application does this action
and has the needed information you should close the device. If you have
incorrect source and forget to close this device, there are two methods of
protection. One approach is the exec-based methodology and exec other
programs to perform additional operations, thus reducing the footprint of
the trusted code. The second approach would be using privilege bracketing to
remove the ability to handle this resource. If you permanently remove your
access to this device, even if the file descriptor is still open you will
not be able to access this information.  Both of these approaches achieve
the exact same goal, the implementations are just a bit different. 

> 
> > On the other hand, what happens if we simply
> > reject this functionality?  Will the developers of all of these "legacy"
> > applications rush to restructure their applications to better support
> > least privilege and isolation for SELinux?  Or will they just leave them
> > as they are, either not running on SELinux at all or running in a single
> > domain with the maximal set of permissions required for operation all
> > the time?  Is that truly preferable?
> > 
> 
> It is not a straightforward answer I don't think. One reason I am able
> to work on SELinux is because of the compromises made to make this a
> workable system for general purpose. My concern is that dynamic context
> transitions will give people a false sense of security. I don't think
> that it is necessarily the case that it is worse to run in a domain with
> the maximal set of permissions. 

I would disagree, running with the maximal set of permissions is exactly
what we are trying to prevent by providing fine-grained privileges.  This
shouldn't provide  a false sense of security, from a vulnerability point of
view, because the process is capable of using all current privileges and
misuse of what it can execute. The minimal use of permission can be used to
verify that the application is behaving as intended without using unneeded
permissions for an operation.

-Chad

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
