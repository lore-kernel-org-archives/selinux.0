Message-ID: <1344611147.10631.65.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: SELinux performance depending on type count
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ole Kliemann <ole@plastictree.net>
Cc: selinux@tycho.nsa.gov, Eric Paris <eparis@redhat.com>
Date: Fri, 10 Aug 2012 11:05:47 -0400
In-Reply-To: <20120810143656.GF2296@telvanni>
References: <20120807130244.GE2085@telvanni>
	 <20120810121113.GE2296@telvanni>
	 <1344603615.10631.26.camel@moss-pluto.epoch.ncsc.mil>
	 <20120810143656.GF2296@telvanni>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2012-08-10 at 16:36 +0200, Ole Kliemann wrote:
> On Fri, Aug 10, 2012 at 09:00:15AM -0400, Stephen Smalley wrote:
> > On Fri, 2012-08-10 at 14:11 +0200, Ole Kliemann wrote:
> > > I did some runtime test now. I have about 2000 types, 1000 of 
> > > them (named xIcJ_t, for 0 <= I <= 9, 0 <= J <= 99) each with his 
> > > own role (xIcJ_r) associated to a user_u. Then there is a user_r 
> > > and user_t for login. Additionally there is 
> > > system_u:system_r:root_t with full access to everything.
> > > 
> > > I run the attached script. It creates directories for each of the 
> > > 1000 types, puts something in it, does a find/grep etc.
> > > 
> > > As system_u:system_r:root_t the script measures an average of 
> > > about 6sec walltime over 5 runs. (With very little variance.)
> > > 
> > > When I change context to user_u:user_r:user_t even things like 
> > > 'ls' on home dir or 'id' lag consideribly the first time 
> > > executed. Just being in this context makes things slow. The 
> > > script measures an average of about 15sec walltime over 5 runs. 
> > > 
> > > That's 2.5 times as much. Who thinks 7% is ridiculously high now? 
> > > ;-)
> > > 
> > > While it's running the whole system sometimes lags even for just 
> > > writing on the terminal. top shows spikes of 50%+ CPU on kworker 
> > > threads.
> > > 
> > > 
> > > Good side is: It's a clear result and kind of settles the 
> > > question. If you want a lot of different types for one user, go 
> > > for categories.
> > > 
> > > 
> > > But I don't understand this result. Why isn't it slow when root 
> > > runs the script? He does the same relabeling to all those types. 
> > > It's not like user_u:user_r:user_t would be running in different 
> > > type concurrently. Just the fact that user_u is associated with 
> > > all those types seems to make it slow to run in any context 
> > > user_u:*
> > 
> > Your result doesn't sound right.  Wondering whether you are triggering
> > masses of AVC denials (which could then peg syslog or audit) when
> > running your script?
> 
> Checked that of course. dmesg showed nothing or just occasional 
> denials. Just tryed again giving user_t full access to 
> everything. Changes nothing and dmesg is clear. 
> 
> Anyway turns out above I forgot to mention something that 
> actually is the core of the problem:
> 
> I build a minimal example which is attached. Of course you have 
> at modify it to your policy. 
> 
> Basicly there is one role choke_r with one type choke_t und a 
> user choke_u with role choke_r. Then are 1000 other types in the 
> choke role each with a corresponding attribute.
> 
> This alone isn't a problem. But if each of these attributes get 
> attributed to choke_t, the slowdown starts. Not as bad as 
> mentioned above but still significantly. (10sec in the test 
> above.)
> 
> So we have choke_u:choke_r:choke_t. Although all other types are 
> in choke_r, that alone causes nothing. But as soon as there are
> these 1000 attributes on choke_t the fun starts. Actually you 
> don't even need the 1000 types. Just 1000 attributes on one type 
> produces a measurable slowdown (7sec) and lags. Having 1000 types 
> beside just makes it a lot worse. But there absolutely no 
> slowdown with just 1000 types and no attributes.

Interesting.  We would expect some slowdown on an AVC cache miss in that
situation, although the amount seems troubling.  Things to consider:
- Does the AVC cache need to be increased or otherwise tuned?  You can
see some information via the avcstat utility or by directly looking
at /sys/fs/selinux/avc.

- Does security_compute_av(), which is called on a cache miss, need some
profiling and tuning?  Particularly the logic within
context_struct_compute_av(), where we are iterating through the type
attribute ebitmaps.

In Fedora 17, most types only have a few attributes (as shown by seinfo
-t -x).  unconfined_t has a larger number of attributes than most, but
even it only has 46 attributes.  So we likely don't see this behavior
there.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
