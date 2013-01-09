Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r09DgU5C001815
	for <selinux@tycho.nsa.gov>; Wed, 9 Jan 2013 08:42:30 -0500
Date: Thu, 10 Jan 2013 00:42:53 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Casey Schaufler <casey@schaufler-ca.com>
cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        LSM <linux-security-module@vger.kernel.org>,
        LKLM <linux-kernel@vger.kernel.org>, SE Linux <selinux@tycho.nsa.gov>,
        John Johansen <john.johansen@canonical.com>,
        Eric Paris <eparis@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v12 0/9] LSM: Multiple concurrent LSMs
In-Reply-To: <50EC53E3.6070606@schaufler-ca.com>
Message-ID: <alpine.LRH.2.02.1301100031590.5423@tundra.namei.org>
References: <50EB7C50.3070605@schaufler-ca.com> <20130108140159.83c07fa6a680e355f024970f@canb.auug.org.au> <50EB9A5E.1080306@schaufler-ca.com> <alpine.LRH.2.02.1301081942030.24212@tundra.namei.org> <50EC53E3.6070606@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 8 Jan 2013, Casey Schaufler wrote:

> What I was hoping to say, and apparently didn't, is that people
> are developing "total" solutions in user space, when some of the
> work ought to be done in an LSM. Work that is appropriate to the
> kernel is being done in user space. Often badly, because the
> kernel provides too many mechanisms to circumvent user space
> based access controls.

People do stupid things all the time.  How is this particular case our 
problem to fix?  Do you have any concrete examples?

> And before we get too far, distros are no longer the driving force
> for Linux development. I suggest that "operating systems", including
> ChromiumOS, Android and Tizen are every bit as important. 

Indeed.  I was including these projects as "distros".

> > What is the UID issue and how does LSM stacking address it?
> 
> Android utilizes UIDs in a way that has often been referred to as
> "hijacking". The UID mechanism supports much of what they want,
> but clearly isn't complete. Now that Android is moving to multi-user
> support they're hitting conflicts with their use of the UID 
> attribute. They really ought to be using an LSM that implements
> the security policy they want rather than hacking around the
> behavior of UID based controls.

Right, so they implement an LSM to do what they need.  What does this have 
to do with stacking?

> > Also, are you saying that security mechanisms are inherently easier to 
> > configure if they're composed from a variety of distinct modules vs. a 
> > monolithic scheme? 
> 
> Nope. I'm saying that for specific use cases including but not limited to
> telephones, TVs and surveillance networks it is simpler and more appropriate
> to create the access control and security schemes that directly address
> the needs than to attempt to squeeze them into corsets designed in the
> 1990's.

That may be true, but we do need at least one significant user to step up 
with concrete plans for deployment.


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
