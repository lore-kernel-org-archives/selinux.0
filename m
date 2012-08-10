Message-ID: <1344603615.10631.26.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: SELinux performance depending on type count
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ole Kliemann <ole@plastictree.net>
Cc: selinux@tycho.nsa.gov
Date: Fri, 10 Aug 2012 09:00:15 -0400
In-Reply-To: <20120810121113.GE2296@telvanni>
References: <20120807130244.GE2085@telvanni>
	 <20120810121113.GE2296@telvanni>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2012-08-10 at 14:11 +0200, Ole Kliemann wrote:
> On Tue, Aug 07, 2012 at 03:02:44PM +0200, Ole Kliemann wrote:
> > I read on some locations (Fedora FAQ...) that there is an overall 
> > performance impact of about 7% when running with SELinux.
> > 
> > Does anyone know if this impact is dependent upon the number of 
> > types the policy has? I would assume no: A lot of types only take 
> > up memory and caching should prevent any impact on the runtime 
> > performance.
> > 
> > But if there was a performance problem with a lot of types, at 
> > what number n would it start to hit hard? And how does it 
> > increase (linear, quadratic...)?
> > 
> > And would it be better performance-wise to run a MCS-policy with 
> > say categories c0.cn than to have types c0_t, ... cn_t?
> > 
> > Ole
> 
> I did some runtime test now. I have about 2000 types, 1000 of 
> them (named xIcJ_t, for 0 <= I <= 9, 0 <= J <= 99) each with his 
> own role (xIcJ_r) associated to a user_u. Then there is a user_r 
> and user_t for login. Additionally there is 
> system_u:system_r:root_t with full access to everything.
> 
> I run the attached script. It creates directories for each of the 
> 1000 types, puts something in it, does a find/grep etc.
> 
> As system_u:system_r:root_t the script measures an average of 
> about 6sec walltime over 5 runs. (With very little variance.)
> 
> When I change context to user_u:user_r:user_t even things like 
> 'ls' on home dir or 'id' lag consideribly the first time 
> executed. Just being in this context makes things slow. The 
> script measures an average of about 15sec walltime over 5 runs. 
> 
> That's 2.5 times as much. Who thinks 7% is ridiculously high now? 
> ;-)
> 
> While it's running the whole system sometimes lags even for just 
> writing on the terminal. top shows spikes of 50%+ CPU on kworker 
> threads.
> 
> 
> Good side is: It's a clear result and kind of settles the 
> question. If you want a lot of different types for one user, go 
> for categories.
> 
> 
> But I don't understand this result. Why isn't it slow when root 
> runs the script? He does the same relabeling to all those types. 
> It's not like user_u:user_r:user_t would be running in different 
> type concurrently. Just the fact that user_u is associated with 
> all those types seems to make it slow to run in any context 
> user_u:*

Your result doesn't sound right.  Wondering whether you are triggering
masses of AVC denials (which could then peg syslog or audit) when
running your script?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
