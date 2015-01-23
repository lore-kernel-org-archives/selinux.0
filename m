MIME-Version: 1.0
In-Reply-To: <1421983803.24914.3.camel@stgolabs.net>
References: <1421745518-18790-1-git-send-email-ethan.zhao@oracle.com>
 <54BE61F0.202@tycho.nsa.gov>
 <CABawtvPrhVWV3bC-=wygqfHJzctvrmd1WxDD1ciuLE7F7-_yaQ@mail.gmail.com>
 <54BF3971.2090003@colorfullife.com>
 <CABawtvO3PdKhmeH_H1v_tQxmgOBQrnLGNayTE1=EbcxJbtwAzQ@mail.gmail.com>
 <CAB9W1A3kabX9qMm56k=FJ1jcL8ou4APqt8teT38oFCiu=g1wNg@mail.gmail.com>
 <54C1AFA2.8040900@oracle.com>
 <1421983803.24914.3.camel@stgolabs.net>
Date: Fri, 23 Jan 2015 23:30:47 +0800
Message-ID: <CABawtvMCyWL1DQb4Q4jM_S0mGWO+V5t_qtq94aE78ar75=+ouA@mail.gmail.com>
Subject: Re: [PATCH] Selinux/hooks.c: Fix a NULL pointer dereference caused by
 semop()
From: Ethan Zhao <ethan.kernel@gmail.com>
To: Davidlohr Bueso <dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8
Cc: ethan.kernel@gmail.conm, ethan zhao <ethan.zhao@oracle.com>,
 Manfred Spraul <manfred@colorfullife.com>, LKML <linux-kernel@vger.kernel.org>,
 linux-security-module@vger.kernel.org,
 James Morris <james.l.morris@oracle.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 selinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Davidlohr，

    I read your commit 53dad6d3a8e5ac1af8bacc6ac2134ae1a8b085f1,
    ipc: fix race with LSMs

    The issue we hit without the above patch, the race may happen  when
process call semctl with IPC_RMID just as  Manfred Spraul mentioned:

Thread A:
   IPC_RMID
   -> freeary()
       ->wake_up_sem_queue_do()
                                                                   Thread B:
       ->security_sem_free()                           semtimedop()

->ipcperms()
       ->ipc_rcu_putref()

   If this is the only race, the bug should be fixed with your patch applied
  (not verified yet on my case).


Thanks,
Ethan



On Fri, Jan 23, 2015 at 11:30 AM, Davidlohr Bueso <dave@stgolabs.net> wrote:
> On Fri, 2015-01-23 at 10:19 +0800, ethan zhao wrote:
>> >   If not, what kernel
>> > version were you running when you triggered the bug?
>>   To be honest, a kernel from distro, but not released, but before we
>> get it clear, we wouldn't public more.
>
> Sheesh, could Oracle be any more (ridiculously) secretive about what the
> hell kernel(s) they run... it's like pulling teeth. *sigh*
>
