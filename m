Subject: Re: "Error! Unable to set executable context."
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Larry Ross <selinux.larry@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <81092d890907251241k5ef56a87p2f6d6f763b25b70@mail.gmail.com>
References: <81092d890907251241k5ef56a87p2f6d6f763b25b70@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 27 Jul 2009 09:45:34 -0400
Message-Id: <1248702334.3465.45.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2009-07-25 at 12:41 -0700, Larry Ross wrote:
> I am trying to create a custom selinux user for the strict policy on
> RHEL5.3
> I want logins that are mapped to this user to be able to login via
> gdm, but when they do I get an error "Error! Unable to set executable
> context."
>  
> What does this error message mean?
>  
> I am able to login via gdm with logins that are mapped to user_u.  I
> have run the AVCs generated when I login in permissive mode (which
> succeeds) through audit2allow and gotten to the point where it doesn't
> seem that I am getting any killer AVCs.  What am I missing that is
> needed for a custom user to use X-Windows?  Is there some place I can
> look to determine what is causing the error?

I see that you've resolved the problem now, but could you describe what
you had to do to get it to work for future reference?  That way the next
time someone comes along with the same issue, they can find the answer
in the mailing list archives.

BTW, "executable context" in the error message means that the attempts
by gdm to invoke setexeccon(3) failed.  setexecon(3) is the libselinux
interface to set the security context to which the process will
transition upon the next execve(2) call.  Usually a setexeccon(3) error
means that the security context was invalid under the current policy.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
