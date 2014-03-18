Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s2INx9BB021310
 for <selinux@tycho.nsa.gov>; Tue, 18 Mar 2014 19:59:10 -0400
Received: by mail-lb0-f173.google.com with SMTP id p9so5386568lbv.32
 for <selinux@tycho.nsa.gov>; Tue, 18 Mar 2014 16:59:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.02.1403190843080.18776@tundra.namei.org>
References: <2794067.Wx0yCIiBrQ@sifl> <1685091.iJm6M33sra@sifl>
 <alpine.LRH.2.02.1403181326240.10830@tundra.namei.org>
 <2065464.ftu8fijlua@sifl>
 <alpine.LRH.2.02.1403190843080.18776@tundra.namei.org>
Date: Tue, 18 Mar 2014 19:59:07 -0400
Message-ID: <CACLa4psX4bNAGAGth=tQ7Nyi39A-kdyirBJJgRdM_4i6LYVo8Q@mail.gmail.com>
Subject: Re: [GIT PULL] SELinux patches for 3.15
From: Eric Paris <eparis@parisplace.org>
To: James Morris <jmorris@namei.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: LSM List <linux-security-module@vger.kernel.org>,
 SE-Linux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Paul merged your -next branch into his branch which already included
3.13, and then rebased his new patches on top of that.  So he's still
ahead of you.  I honestly believe pulling what he first requested is
the right thing.  But since James won't pull...

 Paul, I think you need to instead do a

BEFORE_MERGE=8ed814602876bec9bad2649ca17f34b499357a1c
BEFORE_FIRST_COMMIT=2146749d6db31f82691290dcad0827bb6a84d06b~1
LAST_COMMIT=3a501ff06773c33571eac7c6c425c10c99f08401

git rebase --onto $BEFORE_MERGE $BEFORE_FIRST_COMMIT $LAST_COMMIT
git branch -D next-jmorris #delete this last next-jmorris which contains 3.13
git checkout -b next-jmorris #recreate next-jmorris based on the last
SELinux tree
git push -f origin jmorris-next:jmorris-next

-Eric

On Tue, Mar 18, 2014 at 5:50 PM, James Morris <jmorris@namei.org> wrote:
> On Tue, 18 Mar 2014, Paul Moore wrote:
>
>> On Tuesday, March 18, 2014 01:26:40 PM James Morris wrote:
>> > On Mon, 17 Mar 2014, Paul Moore wrote:
>> > > On Monday, March 17, 2014 07:21:59 AM Eric Paris wrote:
>> > > > You think a security tree based on 3.13-rc7 is good and Paul, who
>> > > > tested on the actual release of 3.13 is bad?
>> > > >
>> > > > I know you got yelled at for randomly picking fast forward-ish merge
>> > > > points, but now you've got a crappy merge point.  Apparently, it was
>> > > > needed it for the Xen/TPM work (not sure why YOU merged it instead of
>> > > > the TPM people, but that's beside the point).
>> > > >
>> > > > But the problem stands.  You are based on a crummy location.  When are
>> > > > you going to pick up 3.13?  After 3.14 is out?
>> > > >
>> > > > Seems like Paul's move to include 3.13 made a lot of sense...
>> > >
>> > > This issue with the linux-security tree keeps coming up and I stand by my
>> > > earlier statements that I would much prefer if the linux-security is based
>> > > off the latest kernel release, e.g. 3.13 as of today.  This seems to be
>> > > in keeping with Linus' comments, fits with what Eric was doing back when
>> > > he managed the SELinux tree, and strikes a nice balance between stability
>> > > and "newness".  I plan on continuing with this approach for the SELinux
>> > > tree.
>> > >
>> > > However, I don't want the 3.15 patches to get lost due to these stupid
>> > > differences so I've created a new branch that has the SELinux 3.15 patches
>> > > applied on top of linux-security#next.
>> > >
>> > >  * git://git.infradead.org/users/pcmoore/selinux next
>> >
>> > What's the new branch?  That seems to be the same.
>>
>> My mistake, the new branch is "next-jmorris".
>
> 195 files changed, 1348 insertions(+), 885 deletions(-)
>
> You should be using my next branch as your upstream.
>
>
>
> --
> James Morris
> <jmorris@namei.org>
