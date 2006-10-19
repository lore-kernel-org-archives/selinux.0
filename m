Subject: Re: Policy tests failed
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel Gil Mayol <Daniel.Gil-Mayol@brunel.de>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200610191700.20138.Daniel.Gil-Mayol@brunel.de>
References: <200610191700.20138.Daniel.Gil-Mayol@brunel.de>
Content-Type: text/plain
Date: Thu, 19 Oct 2006 14:30:00 -0400
Message-Id: <1161282600.14632.199.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-10-19 at 17:00 +0200, Daniel Gil Mayol wrote:
> I am writting a policy over a RHEL4 customized kernel. I want to extend the 
> current targeted policy (there are some new services to define a policy).

Can you identify the particular policy version that you are using as
your baseline?

> I want to test the policy, that is, the services should not have access 
> (read/write/execute) to data that are not allowed. 
> So I have written a script "exectest.py" labelled with a security context 
> "system_u:object_r:XXX_t" where "type XXX_t, file_type;".

>From the above description, I am not clear as to how you are using the
type of the script.  Do you want to transition into a different domain
upon executing the script?  Or not?

> Lets say that we are testing the service "crond", so I execute "exectest.py 
> crond". The first that do this script is execute an "id" and become the next:
> 
> uid=0(root) gid=0(root) groups=0(root),1(bin),2(daemon),3(sys),4(adm),6
> (disk),10(wheel) context=root:system_r:unconfined_t

So the script starts off in the same context as the caller (unconfined
in this instance).  What do you mean by "become the next"?  Does it
execute the real crond?  Or run some test script using runcon -t crond_t
to put it into the crond_t domain?  Can you just post the script itself?

> Then the script try to read, write and execute files out of "crond_t" domain, 
> that is, files labelled with types that I haven't allowed (for example bin_t, 
> httpd_t). And the result is that it can.

Not clear what "out of the "crond_t" domain" means above - how did it
get into the crond_t domain?  How did you check that it actually ran in
that domain?

I'm also not sure how crond_t is defined in your policy; in targeted
policy, crond is unconfined.  In strict policy, it is confined, and
transitions to different domains depending on the job (e.g.
system_crond_t for system jobs, user_crond_t for ordinary user jobs,
sysadm_crond_t for root user crontab).  Naturally, system cron jobs
often require different permissions than user ones.

> I have tried also to write in the policy for example "neverallow crond_t 
> bin_t : file { read write execute };" but still can access to these data.

neverallow statements are assertions on the policy that are checked when
the policy is compiled.  So if you were able to successfully rebuild the
policy after adding such an assertion, then the policy should not
contain any allow rules granting such access.  But it isn't clear to me
that your script is ever executing in crond_t.

> When I execute this script, which domain it has? 

If you haven't defined a domain transition in your policy on the type
assigned to the script, then it stays in the caller's domain (in this
case, unconfined_t).  Unless the caller uses runcon or similar to
specifically run the script in a specified domain.

> Can it be that it works in the unconfined domain and it has access to 
> everything?

>From the output you posted, yes.  The id output showed it being
unconfined_t.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
