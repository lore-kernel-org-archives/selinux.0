Subject: Re: concept of a permissive domain
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>, Eric Paris <eparis@redhat.com>,
        selinux@tycho.nsa.gov
In-Reply-To: <1189712298.18713.116.camel@moss-spartans.epoch.ncsc.mil>
References: <1189537981.3407.51.camel@localhost.localdomain>
	 <46E6FB25.5070507@redhat.com>
	 <1189545987.4823.6.camel@localhost.localdomain>
	 <1189692512.18713.61.camel@moss-spartans.epoch.ncsc.mil>
	 <1189694812.3538.20.camel@localhost.localdomain>
	 <1189695443.18713.95.camel@moss-spartans.epoch.ncsc.mil>
	 <46E98E93.40206@redhat.com>
	 <1189712298.18713.116.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 13 Sep 2007 16:25:07 -0400
Message-Id: <1189715107.3093.8.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-09-13 at 15:38 -0400, Stephen Smalley wrote:
> On Thu, 2007-09-13 at 15:25 -0400, Daniel J Walsh wrote:

[...]

> > > 
> > Said large financial institution rols out policy for managing huge money
> > transactions in permissive mode.   Policy build with a pam for verifying
> > users.
> 
> Note that I said it would be better to provide a capability to let
> people develop policy incrementally while in enforcing mode, not
> permissive mode.
> 

That may be a good idea, but it doesn't solve this problem. These
customers are concerned that they can't fully exercise their
applications in a testing environment and are, therefore, hesitant to
deploy these policies in enforcing mode. This, to me, is a reasonable
concern given the importance of these applications.

They would therefore prefer to deploy in permissive mode for some period
of time and see if any other denials pop out. Again - this seems
reasonable.

The only concern here is that permissive is not exactly the same as
enforcing. This problem can't be fixed entirely, but we can at least
chip away at some known problems.

> > Users selected app_uses_pam in policy design tool.
> > 
> > Tool adds
> > 
> > dontaudit financeapp_t shadow_t:file r_file_perms;
> > 
> > App in permissive mode reads shadow perms.  Dontaudit covers it up.
> 
> So don't do that.  Don't include new dontaudit rules while generating
> policy in permissive mode, and let the user decide whether to select the
> dontaudit branch or the allow branch in the final form of the generated
> policy.

That's not a bad idea.

>   For that matter, we should really minimize use of dontaudit
> rules whenever possible - if we can fix the code to _default_ to the
> less privileged code path and only try the more privileged code path if
> it truly needs it, then we should do that.
> 

Also a good idea.

> > App runs for three months.  policy writer sees no avc messages for a
> > long time,  Thinks everything is fine.
> > 
> > Turns on enforcing mode, app tries to authenticate on mysql, gets
> > denials apps blow up, millions lost, people say selinux sucks, policy
> > writer is fired.
> > 
> > If I want the current behavior to see full permissive mode, I can
> > semodule -DB or build my policy without dontaudit.
> > 
> > permissive mode not following code path of dontaudit would causes major
> > problems.
> 
> Let me say it again - dontaudit rules don't affect whether or not
> something is allowed in SELinux today; they are NOT deny rules. 

Agreed.

>  If you
> want deny rules, add those (gasp).

Well - maybe we should explore that concept despite the problems it
raises.

>   Permissive mode is simply following
> the code path of allowing everything, as requested.
> 

Yeah - which is the problem.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
