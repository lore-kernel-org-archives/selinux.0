Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t68Ij4QM003094
 for <selinux@tycho.nsa.gov>; Wed, 8 Jul 2015 14:45:04 -0400
Message-ID: <559D6FAC.4000606@schaufler-ca.com>
Date: Wed, 08 Jul 2015 11:45:00 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: William Roberts <bill.c.roberts@gmail.com>
Subject: Re: Linux 4.2-rc1
References: <CA+55aFxmm7THBsCK62esr=JCcHpn6nmReGKqPp0inUrhbkveuA@mail.gmail.com>	<CAKocOOM0-uce9kUzprCW9M48_G2OTV-eWgPe4euht2qY8FdA3A@mail.gmail.com>	<CA+55aFy-iZ2g8xKZW---LgUHaVMbqLZ_oadw=Vbg0g78dfH9PA@mail.gmail.com>	<CA+55aFyYFhkupwb0tVLCDWQs9H1DX0kXZZkCwax_xUOUMfDgxA@mail.gmail.com>	<559D623D.405@schaufler-ca.com>
 <CAFftDdr54GLdtZ+biC2hpbyjbHe+SKbLEbz0fbLVrK3sdBD+Vw@mail.gmail.com>
In-Reply-To: <CAFftDdr54GLdtZ+biC2hpbyjbHe+SKbLEbz0fbLVrK3sdBD+Vw@mail.gmail.com>
Content-Type: multipart/alternative;
 boundary="------------000202050205060709080305"
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ming Lei <ming.lei@canonical.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Shuah Khan <shuahkh@osg.samsung.com>, Shuah Khan <shuahkhan@gmail.com>,
 SE Linux <selinux@tycho.nsa.gov>,
 Linus Torvalds <torvalds@linux-foundation.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a multi-part message in MIME format.
--------------000202050205060709080305
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 7/8/2015 11:07 AM, William Roberts wrote:
>
>
> On Wed, Jul 8, 2015 at 10:47 AM, Casey Schaufler
> <casey@schaufler-ca.com <mailto:casey@schaufler-ca.com>> wrote:
>
>     On 7/8/2015 10:29 AM, Linus Torvalds wrote:
>     > On Wed, Jul 8, 2015 at 10:17 AM, Linus Torvalds
>     > <torvalds@linux-foundation.org
>     <mailto:torvalds@linux-foundation.org>> wrote:
>     >> Decoding the "Code:" line shows that this is the "->fw_id"
>     dereference in
>     >>
>     >>         if (add_uevent_var(env, "FIRMWARE=%s",
>     fw_priv->buf->fw_id))
>     >>                 return -ENOMEM;
>     >>
>     >> and that "fw_priv->buf" pointer is NULL.
>     >>
>     >> However, I don't see anything that looks like it should have
>     changed
>     >> any of this since 4.1.
>     > Looking at the otehr uses of "fw_priv->buf", they all check that
>     > pointer for NULL. I see code like
>     >
>     >         fw_buf = fw_priv->buf;
>     >         if (!fw_buf)
>     >                 goto out;
>     >
>     > etc.
>     >
>     > Also, it looks like you need to hold the "fw_lock" to even look at
>     > that pointer, since the buffer can get reallocated etc.
>     >
>     > So that uevent code really looks buggy. It just doesn't look like a
>     > *new* bug to me. That code looks old, going back to 2012 and commit
>     > 1244691c73b2.
>
>     There have been SELinux changes to kernfs for 4.2. William,
>     you might want to have a look here.
>
>
> My changes were never merged AFAIK and can tell. I was still working
> on this
> but we had some changes internally to SELinux that let us handle this,
> although
> we should correct this on kernfs at some point, its low priority for
> me now. Also
> commit fb029 makes kernfs_get_inode() public, so I need to rethink
> some things.

OK, false alarm. Not an SELinux issue. It might be useful
to see if the problem occurs with AppArmor off.

>  
>
>
>     >
>     > Ming Lei?
>     >
>     >                  Linus
>     > --
>     > To unsubscribe from this list: send the line "unsubscribe
>     linux-kernel" in
>     > the body of a message to majordomo@vger.kernel.org
>     <mailto:majordomo@vger.kernel.org>
>     > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>     > Please read the FAQ at  http://www.tux.org/lkml/
>     >
>
>     _______________________________________________
>     Selinux mailing list
>     Selinux@tycho.nsa.gov <mailto:Selinux@tycho.nsa.gov>
>     To unsubscribe, send email to Selinux-leave@tycho.nsa.gov
>     <mailto:Selinux-leave@tycho.nsa.gov>.
>     To get help, send an email containing "help" to
>     Selinux-request@tycho.nsa.gov <mailto:Selinux-request@tycho.nsa.gov>.
>
>
>
>
> -- 
> Respectfully,
>
> William C Roberts
>


--------------000202050205060709080305
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">On 7/8/2015 11:07 AM, William Roberts
      wrote:<br>
    </div>
    <blockquote
cite="mid:CAFftDdr54GLdtZ+biC2hpbyjbHe+SKbLEbz0fbLVrK3sdBD+Vw@mail.gmail.com"
      type="cite">
      <div dir="ltr"><br>
        <div class="gmail_extra"><br>
          <div class="gmail_quote">On Wed, Jul 8, 2015 at 10:47 AM,
            Casey Schaufler <span dir="ltr">&lt;<a
                moz-do-not-send="true"
                href="mailto:casey@schaufler-ca.com" target="_blank">casey@schaufler-ca.com</a>&gt;</span>
            wrote:<br>
            <blockquote class="gmail_quote" style="margin:0px 0px 0px
0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;padding-left:1ex">On
              7/8/2015 10:29 AM, Linus Torvalds wrote:<br>
              &gt; On Wed, Jul 8, 2015 at 10:17 AM, Linus Torvalds<br>
              &gt; &lt;<a moz-do-not-send="true"
                href="mailto:torvalds@linux-foundation.org">torvalds@linux-foundation.org</a>&gt;
              wrote:<br>
              &gt;&gt; Decoding the "Code:" line shows that this is the
              "-&gt;fw_id" dereference in<br>
              &gt;&gt;<br>
              &gt;&gt;         if (add_uevent_var(env, "FIRMWARE=%s",
              fw_priv-&gt;buf-&gt;fw_id))<br>
              &gt;&gt;                 return -ENOMEM;<br>
              &gt;&gt;<br>
              &gt;&gt; and that "fw_priv-&gt;buf" pointer is NULL.<br>
              &gt;&gt;<br>
              &gt;&gt; However, I don't see anything that looks like it
              should have changed<br>
              &gt;&gt; any of this since 4.1.<br>
              &gt; Looking at the otehr uses of "fw_priv-&gt;buf", they
              all check that<br>
              &gt; pointer for NULL. I see code like<br>
              &gt;<br>
              &gt;         fw_buf = fw_priv-&gt;buf;<br>
              &gt;         if (!fw_buf)<br>
              &gt;                 goto out;<br>
              &gt;<br>
              &gt; etc.<br>
              &gt;<br>
              &gt; Also, it looks like you need to hold the "fw_lock" to
              even look at<br>
              &gt; that pointer, since the buffer can get reallocated
              etc.<br>
              &gt;<br>
              &gt; So that uevent code really looks buggy. It just
              doesn't look like a<br>
              &gt; *new* bug to me. That code looks old, going back to
              2012 and commit<br>
              &gt; 1244691c73b2.<br>
              <br>
              There have been SELinux changes to kernfs for 4.2.
              William,<br>
              you might want to have a look here.<br>
            </blockquote>
            <div><br>
            </div>
            <div>My changes were never merged AFAIK and can tell. I was
              still working on this</div>
            <div>but we had some changes internally to SELinux that let
              us handle this, although</div>
            <div>we should correct this on kernfs at some point, its low
              priority for me now. Also</div>
            <div>commit fb029 makes kernfs_get_inode() public, so I need
              to rethink some things.</div>
          </div>
        </div>
      </div>
    </blockquote>
    <pre>
OK, false alarm. Not an SELinux issue. It might be useful
to see if the problem occurs with AppArmor off.

</pre>
    <blockquote
cite="mid:CAFftDdr54GLdtZ+biC2hpbyjbHe+SKbLEbz0fbLVrK3sdBD+Vw@mail.gmail.com"
      type="cite">
      <div dir="ltr">
        <div class="gmail_extra">
          <div class="gmail_quote">
            <div> </div>
            <blockquote class="gmail_quote" style="margin:0px 0px 0px
0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;padding-left:1ex"><br>
              &gt;<br>
              &gt; Ming Lei?<br>
              &gt;<br>
              &gt;                  Linus<br>
              &gt; --<br>
              &gt; To unsubscribe from this list: send the line
              "unsubscribe linux-kernel" in<br>
              &gt; the body of a message to <a moz-do-not-send="true"
                href="mailto:majordomo@vger.kernel.org">majordomo@vger.kernel.org</a><br>
              &gt; More majordomo info at  <a moz-do-not-send="true"
                href="http://vger.kernel.org/majordomo-info.html"
                rel="noreferrer" target="_blank">http://vger.kernel.org/majordomo-info.html</a><br>
              &gt; Please read the FAQ at  <a moz-do-not-send="true"
                href="http://www.tux.org/lkml/" rel="noreferrer"
                target="_blank">http://www.tux.org/lkml/</a><br>
              &gt;<br>
              <br>
              _______________________________________________<br>
              Selinux mailing list<br>
              <a moz-do-not-send="true"
                href="mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a><br>
              To unsubscribe, send email to <a moz-do-not-send="true"
                href="mailto:Selinux-leave@tycho.nsa.gov">Selinux-leave@tycho.nsa.gov</a>.<br>
              To get help, send an email containing "help" to <a
                moz-do-not-send="true"
                href="mailto:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.gov</a>.<br>
            </blockquote>
          </div>
          <br>
          <br clear="all">
          <div><br>
          </div>
          -- <br>
          <div class="gmail_signature">Respectfully,<br>
            <br>
            William C Roberts<br>
            <br>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------000202050205060709080305--
