Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA12862
	for <selinux@tycho.nsa.gov>; Tue, 23 Jan 2001 12:43:07 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id RAA13154
	for <selinux@tycho.nsa.gov>; Tue, 23 Jan 2001 17:41:31 GMT
Received: from deliverator.sgi.com (deliverator.sgi.com [204.94.214.10])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id RAA13150
	for <selinux@tycho.nsa.gov>; Tue, 23 Jan 2001 17:41:30 GMT
Date: Tue, 23 Jan 2001 09:44:18 -0800 (PST)
From: casey@credo.engr.sgi.com (Casey Schaufler)
Message-Id: <200101231744.JAA46475@credo.engr.sgi.com>
To: linux-privs-discuss@sourceforge.net, selinux@tycho.nsa.gov
Subject: Re: SELinux & Linux-privs projects
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

According to Robert Watson:
>
> I've run into a few limitations in the POSIX.1e MAC interface that I've
> needed to work around and suggest directions for future improvement if
> there's any desire towards moving to a more general MAC framework:
> 
> 1) Dominance operator required -- mac_dominate() must return true, false,
>    or an error (EINVAL), but is unable to return that dominance is
>    undefined.  For un-ordered or partially ordered MAC schemes, this will
>    cause problems for applications that rely on the ordering.  In this
>    case, mac_dominate()  will often (or always) return 0, making it less
>    useful; as it's not clear that mac_dominate() will be meaningful in an
>    environment and if it is, what it means may not be consistent. 

In the Trix MAC implementation almost all (I can't think of any
exceptions, but I don't have time to go look'n) calls to
mac_dominate() could be replaced with mac_access(,, READ).
Similarly, mac_equal() could be replaced by mac_access(,, WRITE).

This brings us back to Olin Sibert's assertion that there really
ought to be a take_everything_into_account_access(,....,<mode>)
function, which is policy independent.

> 2) Limited support for compound labels -- when more than one scheme is in
>    use at a time, a compound mac label is required.  However, the
>    dominance operator may be defined differently for different components
>    of the label (for example, Biba dominate differs from MLS dominate). 
>    When moving to different or more complex schemes, it's easy to imagine
>    situations where mac_dominate() has to combine inconsistent results,
>    and presumably always return 0 as a result. 

I could imagine such a policy, but not without mangling
the capability policy to achieve it. OKay, so the policy
could be B&LaP unless you're a general, in which case it's
based on a crypographic siganture. IT's that pesky "unless"
clause that starts pulling you into the realm of privilege.
 
> 3) mac_dominate() is not meaningful without understanding the policy in
>    question: that is, a userland application cannot use it for policy
>    evaluation to determine whether a given operation on a given object is
>    permitted, because mac_dominate() isn't an "is this allowed" request,
>    it has to do with label relationships. 

Yes, this is the problem in a nutshell. A mac_access() function
would be more policy independent.
 
> This would include functions that
> request an access control determination for a pair of labels and an
> operation identifier,

mac_access() above?

> functions to determine inheritence when a subject
> spawns a new object from an existing object (file from directory, packet
> from interface, MIB hiearchies, etc), and so on.

A good topic for a rousing debate.

> Also, an interface to
> push requests concerning MAC labels based on knowledge of the syntax and
> semantics of a component of the label, but without assumptions in the
> interface about what those might be.

How does this differ from mac_from_text()? I expect
you're looking for something more sophisticated, but
in what way?

> In addition, a way to determine what
> components of the label are available, and properties of the policy
> enforcement environment. 

main()
{
	printf("%s\n", mac_what());
}

% mac_what
Well, you've got a Domian Enforcement scheme emulating
Bell & LaPadula Sensitivity, expect that write-up is
not allowed and sockets require label equality to read
and there's a special case label for /dev/null, and
Clarke-Wilson integrity on sockets and a time-stamp
scheme for executables which is only applied to game
programs and there are four-hundred sixteen administrater
role defined. Hope that helps!
%

 
> This won't allow applications invoking privilege to manage mandatory
> labels to be completely free of knowledge of a policy, but it will allow
> the application that is aware of one component of the policy to override
> the policy via general interfaces, at the same time as not overriding
> policies that it doesn't understand, or isn't intended to manipulate. 
> Similarly, it will allow applications maintaining objects to rely on the
> system policy evaluation when enforcing protections on these internal
> objects.  The SELinux implementation allows some aspects of this (in
> particular, allowing applications to use the standard system policy and
> access control mechanisms), as does the NAI DTE implementation.  POSIX.1e
> begins the process of moving towards a general labeling mechanism, and
> though some changes could better support the kind of environment that I
> envision.

Just to throw gas on the fire, please consider the
implications of supporting such a system in the field.
It's hard enough to teach people simple MAC policies.
A general, configurable MAC policy would be a vendor's
nightmare.


Casey Schaufler				Manager, Trust Technology, SGI
casey@sgi.com				voice: 650.933.1634
casey_p@pager.sgi.com			Pager: 888.220.0607

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
