To: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>, "Serge E. Hallyn"
 <serge@hallyn.com>,
 "moderated list:SELINUX SECURITY MODULE" <selinux@tycho.nsa.gov>,
 "open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 Stephen Smalley <sds@tycho.nsa.gov>
From: Topi Miettinen <toiwoton@gmail.com>
Subject: selinux: should execmem disable shmat(..., SHM_EXEC)?
Message-ID: <3f453e5e-e70c-f00d-9b5b-f09addd04ada@gmail.com>
Date: Wed, 26 Oct 2016 20:31:36 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi,

Maybe this is a stupid question and I didn't test this with SELinux, but
it looks to me that SELinux execmem does not prevent process from
getting writable and executable memory mappings by using shmat(...,
SHM_EXEC). Shouldn't this be blocked by execmem, I suppose it is there
to prevent this kind of memory access?

Here's a test program:
#include <sys/ipc.h>
#include <sys/shm.h>

int main(void) {
        int shmid;
        char *execmem;
        void (*fn)(void);

        shmid = shmget(IPC_PRIVATE, 4096, IPC_CREAT | 0777);
        execmem = shmat(shmid, 0, SHM_EXEC);
        shmctl(shmid, IPC_RMID, 0);
        *execmem = 0xc3; // retq
        fn = (void (*)(void))execmem;
        fn();
        shmdt(execmem);
}

-Topi
