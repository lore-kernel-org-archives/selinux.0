Subject: Re: checkpolicy is broken (which is not)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: qingtao.cao@windriver.com
Cc: Eric Paris <eparis@redhat.com>,
        "Christopher J. PeBenito"
 <cpebenito@tresys.com>,
        Daniel J Walsh <dwalsh@redhat.com>, SELinux
 <selinux@tycho.nsa.gov>
In-Reply-To: <4E3B6F5B.40904@windriver.com>
References: <4E3AEA75.3090602@redhat.com> <4E3B3D39.4020700@windriver.com>
	 <4E3B441A.1090900@windriver.com> <4E3B5593.7000502@redhat.com>
	 <4E3B6F5B.40904@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 05 Aug 2011 08:56:22 -0400
Message-ID: <1312548982.19283.14.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2011-08-05 at 12:19 +0800, Harry Ciao wrote:
> Hi Eric,
> 
> Let me explain more about the background story.
> 
> The existing type rule could declare a type, and optionally associate it
> with a list of type attributes. So I invented this "role <regular role>
> attribute <a list of role attributes>" rule in the same manner to do the
> similar things for roles, since I figure this would make refpolicy rules
> similar and easy to remember and use.
> 
> Now that the above new role-attr rule takes care of declaring roles,
> this duty has to be removed from role-type rule in order to avoid
> ambiguity, and the role-type rule would be used to only associate types
> with roles, which only requires TWO lines of code as in 3cbc9727, since
> mostly used roles such as system_r have been declared in kernel.te(in
> order to avoid some build failure).
> 
> In a word, we could preserve the behavior of role-type rule, but this
> would introduce discrepancy between that of role-attr rule and type-attr
> rule, considering that getting used to the new toolchain only requires
> an easy cherry-pick of only 2 lines of change, would it be that
> desirable for us to do so?

I don't think we should introduce an incompatible policy language change
without very strong reasons.  It is fine to introduce new constructs
like your role...attribute construct, but we shouldn't change the
meaning of role...type statements and thereby render invalid policies
that used to be valid.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
