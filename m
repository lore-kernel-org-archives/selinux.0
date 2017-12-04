To: sds@tycho.nsa.gov,
 bot+015afdb01dbf2abb6a6bfdd5430b72e5503fca6d@syzkaller.appspotmail.com,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 syzkaller-bugs@googlegroups.com
Cc: linux-kernel@vger.kernel.org, dledford@redhat.com, mka@chromium.org,
 junil0814.lee@lge.com, kyeongdon.kim@lge.com
From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
References: <001a113f711a721c58055f052200@google.com>
 <089e08259d282c063e055f4bddbd@google.com>
 <97d6bab0-d278-9945-5d82-a0a76b8b78c5@I-love.SAKURA.ne.jp>
 <1512395025.20988.3.camel@tycho.nsa.gov>
In-Reply-To: <1512395025.20988.3.camel@tycho.nsa.gov>
Message-Id: <201712042307.ACI78163.JOVFOLOtHFMFSQ@I-love.SAKURA.ne.jp>
Date: Mon, 4 Dec 2017 23:07:56 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: KASAN: slab-out-of-bounds Read in strcmp
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Stephen Smalley wrote:
> > Thus, I guess the simplest fix is to use strncmp() instead of
> > strcmp().
> 
> Already fixed by
> https://www.spinics.net/lists/selinux/msg23589.html
> 

OK, I thought everyone was too busy.
I would appreciate if you responded to all.
