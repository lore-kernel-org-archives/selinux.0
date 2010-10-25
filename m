Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o9PFEH7h025158
	for <selinux@tycho.nsa.gov>; Mon, 25 Oct 2010 11:14:24 -0400
Received: from mail-pv0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o9P7vKIg008621
	for <selinux@tycho.nsa.gov>; Mon, 25 Oct 2010 07:57:21 GMT
Received: by pvg6 with SMTP id 6so675786pvg.12
        for <selinux@tycho.nsa.gov>; Mon, 25 Oct 2010 00:57:17 -0700 (PDT)
Message-ID: <4CC53877.7040106@gmail.com>
Date: Mon, 25 Oct 2010 00:57:43 -0700
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: imsand@puzzle.ch
CC: Daniel J Walsh <dwalsh@redhat.com>, Chad Sellers <csellers@tresys.com>,
        selinux@tycho.nsa.gov
Subject: Re: Context settings after ssh login
References: <C8D3542D.BAC90%csellers@tresys.com>    <4CADF149.3040301@redhat.com> <4CAE025C.6010005@gmail.com>    <44256.193.5.216.100.1287499358.squirrel@mail.puzzle.ch>    <4CBDB14E.2030207@gmail.com>    <12764.193.5.216.100.1287503226.squirrel@mail.puzzle.ch>    <4CBDC997.6030800@gmail.com>    <10617.193.5.216.100.1287564131.squirrel@mail.puzzle.ch>    <4CBEF2B4.3050408@gmail.com>    <35906.193.5.216.100.1287584724.squirrel@mail.puzzle.ch>    <4CC3400C.8060004@gmail.com> <30707.193.5.216.100.1287990574.squirrel@mail.puzzle.ch>
In-Reply-To: <30707.193.5.216.100.1287990574.squirrel@mail.puzzle.ch>
Content-Type: multipart/alternative;
 boundary="------------030705030103050609090800"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030705030103050609090800
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

  On 10/25/2010 12:09 AM, imsand@puzzle.ch wrote:
> Hi Justin.
>
> First of all, thanks a lot for your efforts.

youre welcome!!
> Unfortunately I'm a little bit confused about what you've done exactly to
> make it run.
> Can you please summarize it and make a little step by step guide for me?

I can try, but maybe later on another post(a bit late over here.)
> Did selinux worked out of the box (on sles11.1)? Didn't had you have to
> fix the bug in /lib/mkinitrd/scripts/boot-boot.sh and rebuild initrd?

long story short, installed sles11.1, changed the repos to download git-core
then changed repos to download the rest of the packages to build the 
latest Mainline kernel
(make, make modules_install)
then after that, installed all the SELinux packages, rebooted realized 
even though this system is
using sysvinit the policy still wont load without an initrd(must be 
because my other systems have
_nothing_ of the sort with initrd in them(*.h)or something, so ended up 
using mkinitrd_setup to make the image
so the policy can load..

Then once loaded made sure the home directory was labelled correctly, as 
well as other
areas that I've seen issues with, then just started the sshd..with the 
other machine with SELinux,
and the iphone(touchterm ssh(free))..

> which package have you build with --with-selinux and the --with-pam?
this was on my cblfs system.. I just built this(all gnome etc..)and 
didnt realize that I had
built this wrong until I looked at config.log of the package and noticed 
I messd up..

after that things went good..(from over here sles11.1 sshd looks built 
fine, maybe this is config issues..,
only issue I noticed is getsebool/setsebool are missing, so just do: mv 
/etc/initscript{,-old}
to avoid problems during boot, or define the init_upstart boolean in 
boolean.conf.)

> which policy did you used? http://oss.tresys.com/git/refpolicy.git?
>

yep... I follow track

> kind regards
> Matthias
>
>

Justin P. Mattock


--------------030705030103050609090800
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    On 10/25/2010 12:09 AM, <a class="moz-txt-link-abbreviated" href="mailto:imsand@puzzle.ch">imsand@puzzle.ch</a> wrote:
    <blockquote
      cite="mid:30707.193.5.216.100.1287990574.squirrel@mail.puzzle.ch"
      type="cite">
      <pre wrap="">Hi Justin.

First of all, thanks a lot for your efforts.
</pre>
    </blockquote>
    <br>
    <small>youre welcome!!</small><br>
    <blockquote
      cite="mid:30707.193.5.216.100.1287990574.squirrel@mail.puzzle.ch"
      type="cite">
      <pre wrap="">
Unfortunately I'm a little bit confused about what you've done exactly to
make it run.
Can you please summarize it and make a little step by step guide for me?
</pre>
    </blockquote>
    <br>
    <small>I can try, but maybe later on another post(a bit late over
      here.)</small><br>
    <blockquote
      cite="mid:30707.193.5.216.100.1287990574.squirrel@mail.puzzle.ch"
      type="cite">
      <pre wrap="">
Did selinux worked out of the box (on sles11.1)? Didn't had you have to
fix the bug in /lib/mkinitrd/scripts/boot-boot.sh and rebuild initrd?
</pre>
    </blockquote>
    <br>
    <small>long story short, installed sles11.1, changed the repos to
      download git-core<br>
      then changed repos to download the rest of the packages to build
      the latest Mainline kernel<br>
      (make, make modules_install) <br>
      then after that, installed all the SELinux packages, rebooted
      realized even though this system is <br>
      using sysvinit the policy still wont load without an initrd(must
      be because my other systems have<br>
      _nothing_ of the sort with initrd in them(*.h)or something, so
      ended up using mkinitrd_setup to make the image<br>
      so the policy can load..<br>
      <br>
      Then once loaded made sure the home directory was labelled
      correctly, as well as other<br>
      areas that I've seen issues with, then just started the sshd..with
      the other machine with SELinux, <br>
      and the iphone(touchterm ssh(free))..</small><br>
    <br>
    <blockquote
      cite="mid:30707.193.5.216.100.1287990574.squirrel@mail.puzzle.ch"
      type="cite">
      <pre wrap="">
which package have you build with --with-selinux and the --with-pam?
</pre>
    </blockquote>
    <small>this was on my cblfs system.. I just built this(all gnome
      etc..)and didnt realize that I had<br>
      built this wrong until I looked at config.log of the package and
      noticed I messd up..<br>
      <br>
      after that things went good..(from over here sles11.1 sshd looks
      built fine, maybe this is config issues..,<br>
      only issue I noticed is getsebool/setsebool are missing, so just
      do: mv /etc/initscript{,-old}<br>
      to avoid problems during boot, or define the init_upstart boolean
      in boolean.conf.)</small><br>
    <br>
    <blockquote
      cite="mid:30707.193.5.216.100.1287990574.squirrel@mail.puzzle.ch"
      type="cite">
      <pre wrap="">
which policy did you used? <a class="moz-txt-link-freetext" href="http://oss.tresys.com/git/refpolicy.git">http://oss.tresys.com/git/refpolicy.git</a>?

</pre>
    </blockquote>
    <br>
    <small>yep... I follow track</small><br>
    <br>
    <blockquote
      cite="mid:30707.193.5.216.100.1287990574.squirrel@mail.puzzle.ch"
      type="cite">
      <pre wrap="">kind regards
Matthias

</pre>
      <br>
    </blockquote>
    <br>
    <small>Justin P. Mattock</small><br>
    <br>
  </body>
</html>

--------------030705030103050609090800--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
