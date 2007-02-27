Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1RKjlqv009117
	for <selinux@tycho.nsa.gov>; Tue, 27 Feb 2007 15:45:47 -0500
Received: from web51510.mail.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l1RKl87G016439
	for <selinux@tycho.nsa.gov>; Tue, 27 Feb 2007 20:47:08 GMT
Date: Tue, 27 Feb 2007 12:47:07 -0800 (PST)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: [PATCH] Lazy config init in libselinux
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SE Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
In-Reply-To: <1172599888.19041.382.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <678979.3102.qm@web51510.mail.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>I'm a bit confused then - why doesn't that introduce a dependency on
>libpthread?

I think I figured it out. First you have this:

# pragma weak __pthread_once

Which will make the linker ignore the function if its not found at runtime. Then
we have this:

/* Call handler iff the first call.  */
#define __libc_once(ONCE_CONTROL, INIT_FUNCTION) \
  do {                                                                        \
    if (__pthread_once != NULL)                                               \
      __pthread_once (&(ONCE_CONTROL), (INIT_FUNCTION));                      \
    else if ((ONCE_CONTROL) == PTHREAD_ONCE_INIT) {                           \
      INIT_FUNCTION ();                                                       \
      (ONCE_CONTROL) = 2;                                                     \
    }                                                                         \
  } while (0)

So, in single thread mode the "else if" is executed. When pthreads exists it
calls the function.

>But I think we need to assess whether that is the case - I don't think
>we know yet what the overall impact is.

In the non-threaded mode, it doesn't look like a big hit. If __pthread_once is
not defined, there's nothing that can race. If it is defined, which is rare, it
will be a call to that function which Uli says is fast.

>> I did the audit yesterday to make sure everything was covered. Please double
>> check me since this is important. 
>
>init_selinux_config() also sets several flags based on /etc/selinux/config
>that are used by other functions, and you don't appear to have explicitly
>added guards for them, 

OK, I see 3 new variables...however, they are not used in any selinux config file
I've ever seen. Are they brand new and never used? Is there a reason they are not
in /etc/selinux/config by default?

>although some end up hitting a guard due to prior call to a path function. The
>one that looks particularly worrisome is the cache_trans flag, used by the
>context translation functions, which in turn are called pervasively to
>translate contexts when they are passed into or out of libselinux.  If
>we add a guard to those functions, we'll essentially hit the guard on
>almost every libselinux function call, just not is_selinux_enabled().

But so far no config file defines it. Is it really used? Right now everyone is
getting the default value.

>I'm not trying to block performance improvement, but we do need to first
>understand the implications of the change, in terms of overall
>performance impact, correctness, and maintainability.

Sure.

What about /etc/security...is that still used? Should that go away?

-Steve


 
____________________________________________________________________________________
Expecting? Get great news right away with email Auto-Check. 
Try the Yahoo! Mail Beta.
http://advision.webevents.yahoo.com/mailbeta/newmail_tools.html 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
