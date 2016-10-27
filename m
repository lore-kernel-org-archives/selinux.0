Subject: Re: selinux: should execmem disable shmat(..., SHM_EXEC)?
To: Topi Miettinen <toiwoton@gmail.com>, Paul Moore <paul@paul-moore.com>,
 Eric Paris <eparis@parisplace.org>, James Morris
 <james.l.morris@oracle.com>, "Serge E. Hallyn" <serge@hallyn.com>,
 "moderated list:SELINUX SECURITY MODULE" <selinux@tycho.nsa.gov>,
 "open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <3f453e5e-e70c-f00d-9b5b-f09addd04ada@gmail.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <732d3c0d-a7d1-22b3-d468-b0d399ba56ff@tycho.nsa.gov>
Date: Thu, 27 Oct 2016 09:01:35 -0400
MIME-Version: 1.0
In-Reply-To: <3f453e5e-e70c-f00d-9b5b-f09addd04ada@gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 10/26/2016 04:31 PM, Topi Miettinen wrote:
> Hi,
> 
> Maybe this is a stupid question and I didn't test this with SELinux, but
> it looks to me that SELinux execmem does not prevent process from
> getting writable and executable memory mappings by using shmat(...,
> SHM_EXEC). Shouldn't this be blocked by execmem, I suppose it is there
> to prevent this kind of memory access?
> 
> Here's a test program:
> #include <sys/ipc.h>
> #include <sys/shm.h>
> 
> int main(void) {
>         int shmid;
>         char *execmem;
>         void (*fn)(void);
> 
>         shmid = shmget(IPC_PRIVATE, 4096, IPC_CREAT | 0777);
>         execmem = shmat(shmid, 0, SHM_EXEC);
>         shmctl(shmid, IPC_RMID, 0);
>         *execmem = 0xc3; // retq
>         fn = (void (*)(void))execmem;
>         fn();
>         shmdt(execmem);
> }
> 
> -Topi
> 

The test program fails with a seg fault and a SELinux avc denial for
execmem permission when run in a domain that lacks execmem permission.
Thanks though for the test; I'll add it to the selinux testsuite to
ensure we don't regress in this area.
