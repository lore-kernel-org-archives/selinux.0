Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6GMZqcd021681
	for <selinux@tycho.nsa.gov>; Wed, 16 Jul 2008 18:35:52 -0400
Received: from qw-out-1920.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6GMZphv029509
	for <selinux@tycho.nsa.gov>; Wed, 16 Jul 2008 22:35:51 GMT
Received: by qw-out-1920.google.com with SMTP id 5so450769qwc.30
        for <selinux@tycho.nsa.gov>; Wed, 16 Jul 2008 15:35:46 -0700 (PDT)
Message-ID: <7e0fb38c0807161535v42dcc6em34918cadd48e43e6@mail.gmail.com>
Date: Wed, 16 Jul 2008 18:35:45 -0400
From: "Eric Paris" <eparis@parisplace.org>
To: "=?ISO-8859-1?Q?David_H=E4rdeman?=" <david@hardeman.nu>
Subject: Re: Fedora refpolicy patches
Cc: "Daniel J Walsh" <dwalsh@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        selinux@tycho.nsa.gov
In-Reply-To: <20080716201829.GC11166@hardeman.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080716165634.GA8072@hardeman.nu> <487E2C1F.4010308@redhat.com>
	 <20080716174410.GA9226@hardeman.nu> <1216232357.21191.76.camel@gorn>
	 <487E451C.5000603@redhat.com> <20080716192942.GA11166@hardeman.nu>
	 <487E4EAD.5070207@redhat.com> <20080716201829.GC11166@hardeman.nu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Jul 16, 2008 at 4:18 PM, David Härdeman <david@hardeman.nu> wrote:
> On Wed, Jul 16, 2008 at 03:40:29PM -0400, Daniel J Walsh wrote:

>> Patches have been sent up stream in the past that have got lost in the
>> volume of work that Chris has to do.  Not his fault.  But we have a
>> system where we have only one person whose primary job is not to check
>> in policy patches, having to review every patch.
>
> So obviously something is wrong in the refpolicy patch acceptance process?
> As a comparison, every single patch is applied by Linus to the kernel (even
> though they've been filtered by maintainers first) and going from 2.6.25 to
> 2.6.26-rc1 alone was 7555 patches.

The difference being that Linus has trusted subsystem maintainers and
anything from those people are pulled into his tree without any
review.  Linus actually looks at (relatively) few patches these day.
As an example look at how Linus doesn't add his 'Signed-off-by' to
SELinux patches.  He didn't review them or even look at them.  He
trusted James and so in they went.

In the policy world Chris looks at every single patch and we don't
have any 'trust' from other people to commit.  The main reason for
that being that we only really have one other person in the community
who really does a lot of active development (Dan) and he is the first
to tell you that his primary motivation is to fix user problems and
move on rather than try to 'do what is right for the technology."  He
doesn't have time to follow strict (unwritten) style guidelines or
verify that every change is 'the right way' for upstream.  Just not
enough man hours in the day.

As an example if my fedora sendmail program starts needing bogus
permissions Dan is going to allow it in Fedora policy and will push
back on the sendmail people to stop it from needing that bogus access.
 This shouldn't (and doesn't usually) get pushed towards upstream.
What Dan doesn't have time for is to go back this quick fixes make
sure they are clean and documented, and send them along. We have time
constraints on both Dan and Chris.

I'm told the Red Hat is trying to hire a new person to work full time
on nothing but policy.  My guess is that as this person becomes
knowledgeable enough direct commit access to the upstream refpolicy
will be given allowing him to bypass Chris.  Chris will probably still
be the overlord and might kick things out that he doesn't like (much
as Linus does in the kernel) after the fact, but until there are
multiple people who both can and want direct commit access this isn't
going to resolve.  (I don't think Dan even wants upstream direct
commit access but I could be wrong)

I don't think there is a solution with the manpower we have today to
fix the issue of the ever growing backlog.  My guess is that if you
start showing Chris and the community that you can decide what from
the monstrosity that is the Fedora patch set is reasonable and ready
for upstream you can get direct commit access.  Tresys is not trying
to be a bottleneck, stranglehold, dictator, or sole proprietor of the
policy they just happen to have the man who cares about the code above
all else and he is rightfully the maintainer.  If more people come
along and want to do what's right for upstream we can start working on
the web of trust rather than the one man show we have today.  (moving
the actual repository from tresys to sourceforge or to fedoraproject
won't magically solve any of these issues.  I haven't seen tresys
reject developers, I just haven't seen nearly enough developers)

The solution?  Take what you find, clean it, send it, get it in
through Chris.  Hopefully RH will have a person to do the same soon!

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
