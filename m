Subject: RE: dynamic context transitions
From: Karl MacMillan <kmacmillan@tresys.com>
To: Chad Hanson <chanson@TrustedCS.com>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, Frank Mayer <mayerf@tresys.com>,
   Darrel Goeddel <DGoeddel@TrustedCS.com>,
   SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <36282A1733C57546BE392885C06185924D92D7@chaos.tcs.tcs-sec.com>
References: <36282A1733C57546BE392885C06185924D92D7@chaos.tcs.tcs-sec.com>
Content-Type: text/plain
Date: Tue, 02 Nov 2004 17:06:27 -0500
Message-Id: <1099433187.23756.152.camel@pham.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-11-02 at 13:49 -0500, Chad Hanson wrote:
> Karl MacMillan wrote: 
> > I admit that I was really trying to make it clear that this isn't a
> > transition mechanism, but something that would stay if introduced. Also,
> > where would you put the trust boundaries if not at process boundries? Is
> > it possible to truly reduce the trust between two sections of code in
> > the same process image? [these are not rhetorical questions - I'm really
> > asking for some clarification]
> 
> You put the trust at the process boundary. This does not preclude you from
> trying increase the trust in the code. You clearly could reduce the trust
> within an application.

These statements seem contradictory to me. If the trust is at the
process boundary, then it is not possible to further reduce the trust
within the same process image. Can you clarify?

> The privilege bracketing approach goes hand in hand
> with secure programming techniques. An example would be that your program
> needs to open the kernel memory device. If your application does this action
> and has the needed information you should close the device. If you have
> incorrect source and forget to close this device, there are two methods of
> protection. One approach is the exec-based methodology and exec other
> programs to perform additional operations, thus reducing the footprint of
> the trusted code. The second approach would be using privilege bracketing to
> remove the ability to handle this resource. If you permanently remove your
> access to this device, even if the file descriptor is still open you will
> not be able to access this information.  Both of these approaches achieve
> the exact same goal, the implementations are just a bit different. 
> 

Dropping privileges permanently is obviously preferable. The problem is
that the current language has no concept of hierarchical domains and it
will take very careful policy development to ensure that a context
change is really dropping privileges instead of trading one set of
privileges for another. Fundamentally, the problem seems to be the
ability of code in one domain to execute arbitrary code in another
domain. In certain circumstances you can try to make certain that the
new domain only has less access, but there is no strong guarantee. This
seems like a good argument for the language changes that Frank discussed
with you in other emails, even though that is not likely to provide any
stronger guarantees.

> > It is not a straightforward answer I don't think. One reason I am able
> > to work on SELinux is because of the compromises made to make this a
> > workable system for general purpose. My concern is that dynamic context
> > transitions will give people a false sense of security. I don't think
> > that it is necessarily the case that it is worse to run in a domain with
> > the maximal set of permissions. 
> 
> I would disagree, running with the maximal set of permissions is exactly
> what we are trying to prevent by providing fine-grained privileges.  This
> shouldn't provide  a false sense of security, from a vulnerability point of
> view, because the process is capable of using all current privileges and
> misuse of what it can execute. The minimal use of permission can be used to
> verify that the application is behaving as intended without using unneeded
> permissions for an operation.
> 

Ultimately, I am trying to make it clear that there is a difference
between reducing the amount of trust given to an application and
applying practical discretionary security measures. I haven't seen any
arguments to lead me to conclude that dynamic context transitions are
anything but the latter. If my assessment is correct, the union of the
set of privileges given to the domains (which is what I meant by maximal
permissions) defines the trust given to that application. In that case
there is no reason, from a trust standpoint, to not give the application
all of those privileges. There may be other practical reasons, of
course.

Karl

> -Chad
-- 
Karl MacMillan
Tresys Technology
kmacmillan@tresys.com
http://www.tresys.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
