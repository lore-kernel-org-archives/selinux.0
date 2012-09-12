Message-ID: <5050AC29.30400@tycho.ncsc.mil>
Date: Wed, 12 Sep 2012 11:37:13 -0400
From: Joman Chu <jcchu@tycho.ncsc.mil>
MIME-Version: 1.0
To: Cesar Maiorino <cesar.maiorino@gmail.com>
CC: William Roberts <bill.c.roberts@gmail.com>, selinux@tycho.nsa.gov
Subject: Re: Problem with SEManager app on Seandroid 4.0.4
References: <CAN93RkJ63JnR-ajfVtKx772+NsFT=-P2_L7Cv3cr4rEAJxMYDg@mail.gmail.com> <CAN93Rk+Q1QSftoKtV=kiJ7gUqq8V-C6uJJmibeUQhjR5-AgiAw@mail.gmail.com> <CAFftDdqD-VRvrFjbvg=jxsFyo8Ucp50bOwS1Cs+0GLAe9vNMFg@mail.gmail.com> <CAN93RkJ24TMdj7J-yWRE14HhPaGdAYoOMcvLyyA_r0D_eGXzzA@mail.gmail.com>
In-Reply-To: <CAN93RkJ24TMdj7J-yWRE14HhPaGdAYoOMcvLyyA_r0D_eGXzzA@mail.gmail.com>
Content-Type: multipart/alternative;
 boundary="------------050801000406050308050205"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050801000406050308050205
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 09/12/2012 11:01 AM, Cesar Maiorino wrote:
> I did have these in my init.rc, but my build was not copying init.rc 
> to  to the out directory.
> I copied it over manually and rebuilt the boot.img and it now I can 
> change the values.
> So that is progress.
> Now, however, when I toggle on SELinux, my device locks up. On reboot 
> it is stuck at the
> lock screen.
> Thanks for the help.
>
> On Tue, Sep 11, 2012 at 4:37 PM, William Roberts 
> <bill.c.roberts@gmail.com <mailto:bill.c.roberts@gmail.com>> wrote:
>
>     My guess is you need to change the permissions of /selinux/*
>     (/selinux/booleans for the booleans) to system system.
>
>     the init.rc needs to have chown system system for all of the booleans,
>     setenforce etc
>
>         chown system system /selinux/enforce
>         chown -R system system /selinux/booleans
>         chown system system /selinux/commit_pending_bools
>
>     You'll need to patch in the recursive support or enumerate all the
>     bools. The patch for recursive support can be found:
>     https://android-review.googlesource.com/#/c/32220/
>
>     Hope this helps.
>
>
>     On Tue, Sep 11, 2012 at 1:23 PM, Cesar Maiorino
>     <cesar.maiorino@gmail.com <mailto:cesar.maiorino@gmail.com>> wrote:
>     > I finally got a version of seandroid (4.0.4) running on my
>     Qualcomm MSM8960
>     > Mobile Development Platform. This required some manual
>     intervention as the
>     > patch files did not all apply cleanly, so it's possible that
>     I've messed
>     > something up in the process.
>     >
>     > That being said, the SEManager app does not let me change any
>     settings aside
>     > from toggling "MAC Mode" on and off. So I can't change '"SELinux
>     Mode"
>     > (stuck in permissive), and I can't change any of the Booleans.
>     >
>     > AVC and MAC logging seem to be working.
>     >
>     > Any ideas?
>     >
>
>
>
>     --
>     Respectfully,
>
>     William C Roberts
>
>
Perhaps you're running into AVC denials. Can you post the kernel logs 
from /proc/kmsg?

--------------050801000406050308050205
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">On 09/12/2012 11:01 AM, Cesar Maiorino
      wrote:<br>
    </div>
    <blockquote
cite="mid:CAN93RkJ24TMdj7J-yWRE14HhPaGdAYoOMcvLyyA_r0D_eGXzzA@mail.gmail.com"
      type="cite">I did have these in my init.rc, but my build was not
      copying init.rc to&nbsp; to the out directory. <br>
      I copied it over manually and rebuilt the boot.img and it now I
      can change the values.<br>
      So that is progress.<br>
      Now, however, when I toggle on SELinux, my device locks up. On
      reboot it is stuck at the<br>
      lock screen. <br>
      Thanks for the help.<br>
      <br>
      <div class="gmail_quote">On Tue, Sep 11, 2012 at 4:37 PM, William
        Roberts <span dir="ltr">&lt;<a moz-do-not-send="true"
            href="mailto:bill.c.roberts@gmail.com" target="_blank">bill.c.roberts@gmail.com</a>&gt;</span>
        wrote:<br>
        <blockquote class="gmail_quote" style="margin:0 0 0
          .8ex;border-left:1px #ccc solid;padding-left:1ex">My guess is
          you need to change the permissions of /selinux/*<br>
          (/selinux/booleans for the booleans) to system system.<br>
          <br>
          the init.rc needs to have chown system system for all of the
          booleans,<br>
          setenforce etc<br>
          <br>
          &nbsp; &nbsp; chown system system /selinux/enforce<br>
          &nbsp; &nbsp; chown -R system system /selinux/booleans<br>
          &nbsp; &nbsp; chown system system /selinux/commit_pending_bools<br>
          <br>
          You'll need to patch in the recursive support or enumerate all
          the<br>
          bools. The patch for recursive support can be found:<br>
          <a moz-do-not-send="true"
            href="https://android-review.googlesource.com/#/c/32220/"
            target="_blank">https://android-review.googlesource.com/#/c/32220/</a><br>
          <br>
          Hope this helps.<br>
          <div class="HOEnZb">
            <div class="h5"><br>
              <br>
              On Tue, Sep 11, 2012 at 1:23 PM, Cesar Maiorino<br>
              &lt;<a moz-do-not-send="true"
                href="mailto:cesar.maiorino@gmail.com">cesar.maiorino@gmail.com</a>&gt;
              wrote:<br>
              &gt; I finally got a version of seandroid (4.0.4) running
              on my Qualcomm MSM8960<br>
              &gt; Mobile Development Platform. This required some
              manual intervention as the<br>
              &gt; patch files did not all apply cleanly, so it's
              possible that I've messed<br>
              &gt; something up in the process.<br>
              &gt;<br>
              &gt; That being said, the SEManager app does not let me
              change any settings aside<br>
              &gt; from toggling "MAC Mode" on and off. So I can't
              change '"SELinux Mode"<br>
              &gt; (stuck in permissive), and I can't change any of the
              Booleans.<br>
              &gt;<br>
              &gt; AVC and MAC logging seem to be working.<br>
              &gt;<br>
              &gt; Any ideas?<br>
              &gt;<br>
              <br>
              <br>
              <br>
            </div>
          </div>
          <span class="HOEnZb"><font color="#888888">--<br>
              Respectfully,<br>
              <br>
              William C Roberts<br>
            </font></span></blockquote>
      </div>
      <br>
    </blockquote>
    Perhaps you're running into AVC denials. Can you post the kernel
    logs from /proc/kmsg?<br>
  </body>
</html>

--------------050801000406050308050205--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
