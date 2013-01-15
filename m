Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r0FKiNRl015131
	for <selinux@tycho.nsa.gov>; Tue, 15 Jan 2013 15:44:24 -0500
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r0FKiCYE028636
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Tue, 15 Jan 2013 15:44:12 -0500
Received: from [10.10.52.105] (vpn-52-105.rdu2.redhat.com [10.10.52.105])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id r0FKZ3n1025142
	for <selinux@tycho.nsa.gov>; Tue, 15 Jan 2013 15:35:07 -0500
Message-ID: <1358282103.2081.13.camel@localhost>
Subject: __thread and fork() is a big no-no
From: Eric Paris <eparis@redhat.com>
To: selinux@tycho.nsa.gov
Date: Tue, 15 Jan 2013 15:35:03 -0500
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Looking at the set*createcon cache patch we realized it wasn't working
right.  Quickly putting together a test program we found that:

static __thread pid_t tid = 0;

int main(void)
{
        pid_t child;
 
        tid = syscall(__NR_gettid);
        printf("parent=%d\n", tid);
 
        child = fork();
        if (child == 0)
                printf("child=%d\n", tid);
         return 0;
}

We expected to get results like:
parent=6500
child=0

Instead you find result like:
parent=6500
child=6500

Thread local storage is NOT initialized across fork().  It's always been
known that threads and fork() don't play well together:
http://www.linuxprogrammingblog.com/threads-and-fork-think-twice-before-using-them

But we weren't threading the parent or the child, so we expected it to
work.  Instead we've had to add a call to pthread_atfork() which
explicitly resets tid at fork.  Basically just:

static void clear(void)
{
        tid = 0;
}
 
int main(void)
{
...
        int rc;
        rc = pthread_atfork(NULL, NULL, clear);
        if (rc)
                return rc;
...
}

We actually call this ptherad_atfork() inside the init_procattr()
function which is only called once.  I'm wondering if we suffer from the
same problems with __thread variables and fork() in the library callers
elsewhere in the code.  I'll take a look.

Just letting folks know something interesting we found yesterday, in
case they find it interesting...

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
