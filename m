Message-ID: <50F5C5F0.7050309@tycho.nsa.gov>
Date: Tue, 15 Jan 2013 16:11:12 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Eric Paris <eparis@redhat.com>
CC: selinux@tycho.nsa.gov
Subject: Re: __thread and fork() is a big no-no
References: <1358282103.2081.13.camel@localhost> <50F5C3B5.9020104@tycho.nsa.gov>
In-Reply-To: <50F5C3B5.9020104@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 01/15/2013 04:01 PM, Stephen Smalley wrote:
> On 01/15/2013 03:35 PM, Eric Paris wrote:
>> Looking at the set*createcon cache patch we realized it wasn't working
>> right.  Quickly putting together a test program we found that:
>>
>> static __thread pid_t tid = 0;
>>
>> int main(void)
>> {
>>          pid_t child;
>>
>>          tid = syscall(__NR_gettid);
>>          printf("parent=%d\n", tid);
>>
>>          child = fork();
>>          if (child == 0)
>>                  printf("child=%d\n", tid);
>>           return 0;
>> }
>>
>> We expected to get results like:
>> parent=6500
>> child=0
>>
>> Instead you find result like:
>> parent=6500
>> child=6500
>>
>> Thread local storage is NOT initialized across fork().  It's always been
>> known that threads and fork() don't play well together:
>> http://www.linuxprogrammingblog.com/threads-and-fork-think-twice-before-using-them
>>
>>
>> But we weren't threading the parent or the child, so we expected it to
>> work.  Instead we've had to add a call to pthread_atfork() which
>> explicitly resets tid at fork.  Basically just:
>>
>> static void clear(void)
>> {
>>          tid = 0;
>> }
>>
>> int main(void)
>> {
>> ...
>>          int rc;
>>          rc = pthread_atfork(NULL, NULL, clear);
>>          if (rc)
>>                  return rc;
>> ...
>> }
>>
>> We actually call this ptherad_atfork() inside the init_procattr()
>> function which is only called once.  I'm wondering if we suffer from the
>> same problems with __thread variables and fork() in the library callers
>> elsewhere in the code.  I'll take a look.
>>
>> Just letting folks know something interesting we found yesterday, in
>> case they find it interesting...
>
> Hmm...seems like caching things like gettid() might be frowned upon, if
> this is any guide,
> http://marc.info/?t=108644931500001&r=1&w=2

BTW, we used to just use /proc/self/attr there, and could conceivably go 
back to using that.  Then you don't need the tid.  The tradeoff is 
whether you care to support set*con for threads other than the thread 
group leader in multi-threaded applications.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
