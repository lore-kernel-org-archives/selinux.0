Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4F0AhVK023025
 for <selinux@tycho.nsa.gov>; Mon, 14 May 2018 20:10:43 -0400
To: Stephen Smalley <stephen.smalley@gmail.com>
Cc: selinux <selinux@tycho.nsa.gov>
References: <991a548d-1cdc-5e15-89d9-a36a557429d2@schaufler-ca.com>
 <CAB9W1A1=mRMn_HuUu-Qsxy8goWMW1C3U5eCOTWV1JSj2+9F2BA@mail.gmail.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <ae956be3-3fef-3b87-53b3-75779d3f5286@schaufler-ca.com>
Date: Mon, 14 May 2018 17:10:33 -0700
MIME-Version: 1.0
In-Reply-To: <CAB9W1A1=mRMn_HuUu-Qsxy8goWMW1C3U5eCOTWV1JSj2+9F2BA@mail.gmail.com>
Content-Type: multipart/alternative;
 boundary="------------9852E00E3A2A30D1D48AAE61"
Subject: Re: Anyone using the SELinux test suite on Fedora 28?
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a multi-part message in MIME format.
--------------9852E00E3A2A30D1D48AAE61
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 5/14/2018 4:48 PM, Stephen Smalley wrote:
> It's been running fine for me. Maybe you just need to clean your tree and do a fresh make test.

Did that first thing.

Digging down, I find that the "make -C policy load" is failing.

make[1]: Leaving directory '/home/cschaufler/SELinux/selinux-testsuite/policy/test_policy'
# General policy load
/usr/sbin/semodule -i test_policy/test_policy.pp
neverallow check failed at /var/lib/selinux/targeted/tmp/modules/100/base/cil:4703
  (neverallow base_typeattr_6 base_typeattr_7 (process (fork transition sigchld sigkill sigstop signull signal ptrace getsched setsched getsession getpgid setpgid getcap setcap share getattr setexec setfscreate noatsecure siginh setrlimit rlimitinh dyntransition setcurrent execmem execstack execheap setkeycreate setsockcreate getrlimit)))
    <root>
    allow at /var/lib/selinux/targeted/tmp/modules/400/test_policy/cil:2565
      (allow test_create_no_t unconfined_t (process (sigchld)))
    <root>
    allow at /var/lib/selinux/targeted/tmp/modules/400/test_policy/cil:2569
      (allow test_create_no_t self (process (transition sigchld sigkill sigstop signull signal ptrace getsched setsched getsession getpgid setpgid getcap setcap share getattr setexec setfscreate noatsecure siginh setrlimit rlimitinh dyntransition setcurrent execmem execstack execheap setkeycreate setsockcreate getrlimit)))
    <root>
    allow at /var/lib/selinux/targeted/tmp/modules/400/test_policy/cil:2606
      (allow test_create_no_t self (process (setexec)))
    <root>
    allow at /var/lib/selinux/targeted/tmp/modules/400/test_policy/cil:2634
      (allow test_create_d sysadm_t (process (sigchld)))

I bet the reason it's doing this is obvious. Just not to me.

> On Mon, May 14, 2018, 7:37 PM Casey Schaufler <casey@schaufler-ca.com <mailto:casey@schaufler-ca.com>> wrote:
>
>     Has anyone had success with the SELinux test suite on Fedora 28?
>     I find the chcon and newrole are unhappy with the contexts used
>     in the suite.
>
>


--------------9852E00E3A2A30D1D48AAE61
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    On 5/14/2018 4:48 PM, Stephen Smalley wrote:<br>
    <blockquote type="cite"
cite="mid:CAB9W1A1=mRMn_HuUu-Qsxy8goWMW1C3U5eCOTWV1JSj2+9F2BA@mail.gmail.com">
      <div dir="auto">It's been running fine for me. Maybe you just need
        to clean your tree and do a fresh make test.</div>
    </blockquote>
    <pre>
Did that first thing.

Digging down, I find that the "make -C policy load" is failing.

make[1]: Leaving directory '/home/cschaufler/SELinux/selinux-testsuite/policy/test_policy'
# General policy load
/usr/sbin/semodule -i test_policy/test_policy.pp
neverallow check failed at /var/lib/selinux/targeted/tmp/modules/100/base/cil:4703
  (neverallow base_typeattr_6 base_typeattr_7 (process (fork transition sigchld sigkill sigstop signull signal ptrace getsched setsched getsession getpgid setpgid getcap setcap share getattr setexec setfscreate noatsecure siginh setrlimit rlimitinh dyntransition setcurrent execmem execstack execheap setkeycreate setsockcreate getrlimit)))
    &lt;root&gt;
    allow at /var/lib/selinux/targeted/tmp/modules/400/test_policy/cil:2565
      (allow test_create_no_t unconfined_t (process (sigchld)))
    &lt;root&gt;
    allow at /var/lib/selinux/targeted/tmp/modules/400/test_policy/cil:2569
      (allow test_create_no_t self (process (transition sigchld sigkill sigstop signull signal ptrace getsched setsched getsession getpgid setpgid getcap setcap share getattr setexec setfscreate noatsecure siginh setrlimit rlimitinh dyntransition setcurrent execmem execstack execheap setkeycreate setsockcreate getrlimit)))
    &lt;root&gt;
    allow at /var/lib/selinux/targeted/tmp/modules/400/test_policy/cil:2606
      (allow test_create_no_t self (process (setexec)))
    &lt;root&gt;
    allow at /var/lib/selinux/targeted/tmp/modules/400/test_policy/cil:2634
      (allow test_create_d sysadm_t (process (sigchld)))

I bet the reason it's doing this is obvious. Just not to me.

</pre>
    <blockquote type="cite"
cite="mid:CAB9W1A1=mRMn_HuUu-Qsxy8goWMW1C3U5eCOTWV1JSj2+9F2BA@mail.gmail.com">
      <div class="gmail_quote">
        <div dir="ltr">On Mon, May 14, 2018, 7:37 PM Casey Schaufler
          &lt;<a href="mailto:casey@schaufler-ca.com"
            moz-do-not-send="true">casey@schaufler-ca.com</a>&gt; wrote:<br>
        </div>
        <blockquote class="gmail_quote" style="margin:0 0 0
          .8ex;border-left:1px #ccc solid;padding-left:1ex">Has anyone
          had success with the SELinux test suite on Fedora 28?<br>
          I find the chcon and newrole are unhappy with the contexts
          used<br>
          in the suite.<br>
          <br>
          <br>
        </blockquote>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------9852E00E3A2A30D1D48AAE61--
