Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q83NnMwd028902
	for <selinux@tycho.nsa.gov>; Mon, 3 Sep 2012 19:49:22 -0400
Message-ID: <504541FE.2010406@schaufler-ca.com>
Date: Mon, 03 Sep 2012 16:49:18 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Marcel Butucea <marcelbutucea@gmail.com>
CC: selinux@tycho.nsa.gov, Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: RBAC to SELinux policy migration
References: <CADxHy9eYOVaVK22ZCi_UregXFwsOwtb1B=Tyygh=87tECsYwhg@mail.gmail.com>
In-Reply-To: <CADxHy9eYOVaVK22ZCi_UregXFwsOwtb1B=Tyygh=87tECsYwhg@mail.gmail.com>
Content-Type: multipart/alternative;
 boundary="------------020106010803010304060608"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020106010803010304060608
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 9/3/2012 3:41 PM, Marcel Butucea wrote:
>
> Hello SELinux Team,
>
> As I am a beginner in deciphering the depths of SELinux I come to you
> with the following predicament in hope of guidance and help:
>
> We are migrating an application from Solaris to Linux and the main
> user is allowed, through the use of RBAC roles, to run a few system
> commands like svccfg/svcadm (chkconfig on redhat).
>
> Is it possible, using only SElinux (no sudo), to allow a normal user
> to run chkconfig off/on <service> (basically giving it the ability to
> add/remove services) ?(my ultimate goal would be to allow this user to
> run other "root-only" utilities as well). One of my concerns is that
> chkconfig might have some internal check for the uid of the calling
> user, ergo blocking this account from running the utility irrespective
> of my selinux policy, is my worry legitimate or am I imagining things ?
>

You should look into capabilities, which do exactly what you want.

> My approach was to try to create an SElinux user with a corresponding
> SElinux role that manages the app's domain/type and is allowed to
> transition to all other domains required to run chkconfig, tcpdump or
> any other system utility usually restricted to root access only. All
> my attempts so far have failed, so my second question would be where
> could I find good documentation that applies to this specific problem ?
>
> Thank you for your support!
>
> Best Regards,
>
> Marcel
>


--------------020106010803010304060608
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">On 9/3/2012 3:41 PM, Marcel Butucea
      wrote:<br>
    </div>
    <blockquote
cite="mid:CADxHy9eYOVaVK22ZCi_UregXFwsOwtb1B=Tyygh=87tECsYwhg@mail.gmail.com"
      type="cite">
      <p style="margin:0px 0px
1em;padding:0px;border:0px;vertical-align:baseline;clear:both;word-wrap:break-word"></p>
      <p style="margin:0px 0px
1em;padding:0px;border:0px;vertical-align:baseline;clear:both;word-wrap:break-word"></p>
      <p style="margin:0px 0px
1em;padding:0px;border:0px;vertical-align:baseline;clear:both;word-wrap:break-word"><font
          face="Arial, Liberation Sans, DejaVu Sans, sans-serif"><span
            style="font-size:14px;line-height:18px">Hello SELinux Team,</span></font></p>
      <p style="margin:0px 0px
1em;padding:0px;border:0px;vertical-align:baseline;clear:both;word-wrap:break-word"><font
          face="Arial, Liberation Sans, DejaVu Sans, sans-serif"><span
            style="font-size:14px;line-height:18px">As I am a beginner
            in deciphering the depths of SELinux I come to you with the
            following predicament in hope of guidance and help:</span></font></p>
      <p style="margin:0px 0px
1em;padding:0px;border:0px;vertical-align:baseline;clear:both;word-wrap:break-word"><font
          face="Arial, Liberation Sans, DejaVu Sans, sans-serif"><span
            style="font-size:14px;line-height:18px">We are migrating an
            application from Solaris to Linux and the main user is
            allowed, through the use of RBAC roles, to run a few system
            commands like svccfg/svcadm (chkconfig on redhat).</span></font></p>
      <p style="margin:0px 0px
1em;padding:0px;border:0px;vertical-align:baseline;clear:both;word-wrap:break-word"><font
          face="Arial, Liberation Sans, DejaVu Sans, sans-serif"><span
            style="font-size:14px;line-height:18px">Is it possible,
            using only SElinux (no sudo), to allow a normal user to run
            chkconfig off/on &lt;service&gt; (basically giving it the
            ability to add/remove services) ?(my ultimate goal would be
            to allow this user to run other "root-only"&nbsp;utilities&nbsp;as
            well).&nbsp;</span></font><span
          style="font-size:14px;line-height:18px;font-family:Arial,'Liberation
          Sans','DejaVu Sans',sans-serif">One of my concerns is that
          chkconfig might have some internal check for the uid of the
          calling user, ergo blocking this account from running the
          utility irrespective of my selinux policy, is my worry
          legitimate or am I&nbsp;</span><span
          style="font-size:14px;line-height:18px;font-family:Arial,'Liberation
          Sans','DejaVu Sans',sans-serif">imagining</span><span
          style="font-size:14px;line-height:18px;font-family:Arial,'Liberation
          Sans','DejaVu Sans',sans-serif">&nbsp;things ?</span></p>
    </blockquote>
    <br>
    You should look into capabilities, which do exactly what you want.<br>
    <br>
    <blockquote
cite="mid:CADxHy9eYOVaVK22ZCi_UregXFwsOwtb1B=Tyygh=87tECsYwhg@mail.gmail.com"
      type="cite">
      <p style="margin:0px 0px
1em;padding:0px;border:0px;vertical-align:baseline;clear:both;word-wrap:break-word"><font
          face="Arial, Liberation Sans, DejaVu Sans, sans-serif"><span
            style="font-size:14px;line-height:18px">My approach was to
            try to create an SElinux user with a corresponding SElinux
            role that manages the app's domain/type and is allowed to
            transition to all other domains required to run chkconfig,
            tcpdump or any other system utility usually restricted to
            root access only. All my attempts so far have failed, so my
            second question would be where could I find good
            documentation that applies to this specific problem ?</span></font></p>
      <p style="margin:0px 0px
1em;padding:0px;border:0px;vertical-align:baseline;clear:both;word-wrap:break-word"><font
          face="Arial, Liberation Sans, DejaVu Sans, sans-serif"><span
            style="font-size:14px;line-height:18px">Thank you for your
            support!</span></font></p>
      <p style="margin:0px 0px
1em;padding:0px;border:0px;vertical-align:baseline;clear:both;word-wrap:break-word"><span
          style="font-size:14px;line-height:18px;font-family:Arial,'Liberation
          Sans','DejaVu Sans',sans-serif">Best Regards,</span></p>
      <p style="margin:0px 0px
1em;padding:0px;border:0px;vertical-align:baseline;clear:both;word-wrap:break-word"><font
          face="Arial, Liberation Sans, DejaVu Sans, sans-serif"><span
            style="font-size:14px;line-height:18px">Marcel</span></font></p>
    </blockquote>
    <br>
  </body>
</html>

--------------020106010803010304060608--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
