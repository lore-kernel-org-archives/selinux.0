To: james.l.morris@oracle.com
Cc: bot+015afdb01dbf2abb6a6bfdd5430b72e5503fca6d@syzkaller.appspotmail.com,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 syzkaller-bugs@googlegroups.com, danielj@mellanox.com,
 dledford@redhat.com, eparis@parisplace.org, junil0814.lee@lge.com,
 kyeongdon.kim@lge.com, linux-kernel@vger.kernel.org, mka@chromium.org,
 paul@paul-moore.com, sds@tycho.nsa.gov, serge@hallyn.com,
 penguin-kernel@i-love.sakura.ne.jp
From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
References: <089e08259d282c063e055f4bddbd@google.com>
 <97d6bab0-d278-9945-5d82-a0a76b8b78c5@I-love.SAKURA.ne.jp>
 <201712032227.JCH90603.HQOOtVFMJOFLSF@I-love.SAKURA.ne.jp>
 <alpine.LFD.2.20.1712041150270.1348@localhost>
 <201712041944.HAI56745.HOFQFtJSOVMOFL@I-love.SAKURA.ne.jp>
In-Reply-To: <201712041944.HAI56745.HOFQFtJSOVMOFL@I-love.SAKURA.ne.jp>
Message-Id: <201712041949.DEG35990.VFQOSFOtJOHMFL@I-love.SAKURA.ne.jp>
Date: Mon, 4 Dec 2017 19:49:10 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: KASAN: slab-out-of-bounds Read in strcmp
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Tetsuo Handa wrote:
> James Morris wrote:
> > On Sun, 3 Dec 2017, Tetsuo Handa wrote:
> > 
> > > Tetsuo Handa wrote:
> > > > which will allow strcmp() to trigger out of bound read when "size" is
> > > > larger than strlen(initial_sid_to_string[i]).
> > > 
> > > Oops. "smaller" than.
> > > 
> > > > 
> > > > Thus, I guess the simplest fix is to use strncmp() instead of strcmp().
> > > 
> > > Can somebody test below patch? (My CentOS 7 environment does not support
> > > enabling SELinux in linux.git . Userspace tool is too old to support?)
> > 
> > You mean enabling KASAN?  Yep, you need gcc 4.9.2 or better.  Recent 
> > Fedora has it.
> 
> I was not able to find "SELinux:  Initializing." line for some reason, and
> it turned out that I just forgot to run "make install". ;-)
> 
> I tested using debug printk() and init for built-in initramfs shown below.
> It is strange that KASAN does not trigger upon strcmp()ing
> initial_sid_to_string[1]. But anyway, my patch fixes this problem.

Sorry for noise. It was just initial_sid_to_string[10] which compared the second byte.
Thus, nothing is strange.
