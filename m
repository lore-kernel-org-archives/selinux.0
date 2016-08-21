Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7LAGlB4011055
 for <selinux@tycho.nsa.gov>; Sun, 21 Aug 2016 06:16:47 -0400
Subject: Re: (How to ) Change the context of user
To: Kashif ali <kashif.ali.9498@gmail.com>, Jason Zaman <jason@perfinion.com>
References: <CAFC8oadn76ZLU2T0BAJyrceAzuVAtB+Yincvt7m7=29kbOrFNg@mail.gmail.com>
 <CAPuKSJZcvoALJ+tb3258mAORTnTu162zPs5h6YHX_mpqJFdZZw@mail.gmail.com>
 <CAFC8oadF+8bsRxvibsiTO_ekjC6xDGK2hm6M7w6J8xT6+tLUDw@mail.gmail.com>
Cc: SELinux <selinux@tycho.nsa.gov>
From: Daniel J Walsh <dwalsh@redhat.com>
Message-ID: <9849e7e4-60b8-f201-6fe5-ec6b7b99d509@redhat.com>
Date: Sun, 21 Aug 2016 06:16:26 -0400
MIME-Version: 1.0
In-Reply-To: <CAFC8oadF+8bsRxvibsiTO_ekjC6xDGK2hm6M7w6J8xT6+tLUDw@mail.gmail.com>
Content-Type: multipart/alternative;
 boundary="------------5645678EFD3816CDAACDB44D"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a multi-part message in MIME format.
--------------5645678EFD3816CDAACDB44D
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit

You could add a policy module with transition rule that states

=================================

policy_module(mydocker,1.0)

gen_require(`

type unconfined_t;
role unconfined_r, system_r;
type docker_exec_t;
')

docker_domtrans(unconfined_t)
role_transition unconfined_r docker_exec_t system_r;

=================================

This will get you running docker as


unconfined_u:system_r:docker_t:s0-s0:c0.c1023

Which should get you most of the way there.



On 08/20/2016 10:43 AM, Kashif ali wrote:
> i want to change it because of docker_t label of docker daemon when
> root user run in the following context 
> "unconfined_u:unconfined_r:unconfined_t:", when i run docker daemon on
> network with the following command 
> => docker daemon -H localhost:2376 --selinux-enabled & 
> then docker daemon have unconfined_t label on it and as it is
> described unconfined domain have access to all process in the system
> and i have read unconfined_t have no domain transition in selinux so 
>
> * but when i run root user in the following context
> "system_u:system_r:initrc_t:", and when i run docker daemon in this
> context then docker daemon have docker_t label on it
>
> so is there anyway to solve this problem or anyway that should assign
> correct docker_t label on docker daemon
>  
>
>
> On Sat, Aug 20, 2016 at 10:12 AM, Jason Zaman <jason@perfinion.com
> <mailto:jason@perfinion.com>> wrote:
>
>     On 20 Aug 2016 08:56, "Kashif ali" <kashif.ali.9498@gmail.com
>     <mailto:kashif.ali.9498@gmail.com>> wrote:
>     >
>     > Hi
>     >   * I'm facing a problem while changing the context of root user
>     in selinux, Selinux is in enforced and targeted policy. By default
>     Selinux assign user =>"unconfined_u:unconfiend_r:unconfined_t:" 
>     > context for the user i have changed the selinux mapped root user
>     "unconifined_u" into "system_u" for root user with the help of
>     command 
>     > =>"semanage login -a -s system_u root" 
>     > after executing this command the root user context is changed
>     into "system_u:unconfined_r:unconfined_t:".
>
>     Don't do this. System_u is not able to login. System_u is for
>     daemon's. Root is in sysadm_r or unconfined_r usually.
>
>     > * Now i have changed the root user role and domain type so i execute this command 
>     > =>"newrole -r system_r -t initrc_t:" 
>     > and change the root user context into
>     "system_u:system_r:initrc_t:" but this change is temporary after
>     rebooting the system the context of root user is changed back to
>     "system_u:unconfined_r:unconfined_t:"
>     >
>     > * what i need is to change the root user context permanently
>     into "system_u:system_r:initrc_t:".
>
>     Why permanently? This will probably break a lot of things. What
>     are you trying to accomplish with making it permanent?
>     If you need to run a command as initrc_t, use run_init in front. Eg:
>
>     # run_init /etc/init.d/sshd restart
>
>     This will first switch to system_u:system_r:initrc_t and then run
>     ssh which will automatically transition to sshd_t
>
>     -- Jason
>
>
>
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.


--------------5645678EFD3816CDAACDB44D
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=windows-1252"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <p>You could add a policy module with transition rule that states</p>
    <p>=================================<br>
    </p>
    <p>policy_module(mydocker,1.0)<br>
      <br>
      gen_require(`<br>
      <br>
      type unconfined_t;<br>
      role unconfined_r, system_r;<br>
      type docker_exec_t;<br>
      ')<br>
      <br>
      docker_domtrans(unconfined_t)<br>
      role_transition unconfined_r docker_exec_t system_r;</p>
    <p>=================================</p>
    <p>This will get you running docker as <br>
    </p>
    <p><br>
    </p>
    <p>unconfined_u:system_r:docker_t:s0-s0:c0.c1023<br>
    </p>
    <p>Which should get you most of the way there.</p>
    <p><br>
    </p>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 08/20/2016 10:43 AM, Kashif ali
      wrote:<br>
    </div>
    <blockquote
cite="mid:CAFC8oadF+8bsRxvibsiTO_ekjC6xDGK2hm6M7w6J8xT6+tLUDw@mail.gmail.com"
      type="cite">
      <div dir="ltr">i want to change it because of docker_t label of
        docker daemon when root user run in the following context 
        <div>"unconfined_u:unconfined_r:unconfined_t:", when i run
          docker daemon on network with the following command <br>
          =&gt; docker daemon -H localhost:2376 --selinux-enabled &amp; <br>
          then docker daemon have unconfined_t label on it and as it is
          described unconfined domain have access to all process in the
          system and i have read unconfined_t have no domain transition
          in selinux so <br>
          <br>
          * but when i run root user in the following context
          "system_u:system_r:initrc_t:", and when i run docker daemon in
          this context then docker daemon have docker_t label on it<br>
          <br>
          so is there anyway to solve this problem or anyway that should
          assign correct docker_t label on docker daemon <br>
           <br>
          <div>
            <div><br>
            </div>
          </div>
        </div>
      </div>
      <div class="gmail_extra"><br>
        <div class="gmail_quote">On Sat, Aug 20, 2016 at 10:12 AM, Jason
          Zaman <span dir="ltr">&lt;<a moz-do-not-send="true"
              href="mailto:jason@perfinion.com" target="_blank">jason@perfinion.com</a>&gt;</span>
          wrote:<br>
          <blockquote class="gmail_quote" style="margin:0 0 0
            .8ex;border-left:1px #ccc solid;padding-left:1ex"><span
              class="">
              <p dir="ltr">On 20 Aug 2016 08:56, "Kashif ali" &lt;<a
                  moz-do-not-send="true"
                  href="mailto:kashif.ali.9498@gmail.com"
                  target="_blank">kashif.ali.9498@gmail.com</a>&gt;
                wrote:<br>
                &gt;<br>
                &gt; Hi<br>
                &gt;   * I'm facing a problem while changing the context
                of root user in selinux, Selinux is in enforced and
                targeted policy. By default Selinux assign user
                =&gt;"unconfined_u:unconfiend_r:<wbr>unconfined_t:" <br>
                &gt; context for the user i have changed the selinux
                mapped root user "unconifined_u" into "system_u" for
                root user with the help of command <br>
                &gt; =&gt;"semanage login -a -s system_u root" <br>
                &gt; after executing this command the root user context
                is changed into "system_u:unconfined_r:<wbr>unconfined_t:".</p>
            </span>
            <p dir="ltr">Don't do this. System_u is not able to login.
              System_u is for daemon's. Root is in sysadm_r or
              unconfined_r usually. </p>
            <span class="">
              <p dir="ltr">&gt; * Now i have changed the root user role
                and domain type so i execute this command <br>
                &gt; =&gt;"newrole -r system_r -t initrc_t:" <br>
                &gt; and change the root user context into
                "system_u:system_r:initrc_t:" but this change is
                temporary after rebooting the system the context of root
                user is changed back to "system_u:unconfined_r:<wbr>unconfined_t:"<br>
                &gt;<br>
                &gt; * what i need is to change the root user context
                permanently into "system_u:system_r:initrc_t:".</p>
            </span>
            <p dir="ltr">Why permanently? This will probably break a lot
              of things. What are you trying to accomplish with making
              it permanent?<br>
              If you need to run a command as initrc_t, use run_init in
              front. Eg:</p>
            <p dir="ltr"># run_init /etc/init.d/sshd restart</p>
            <p dir="ltr">This will first switch to
              system_u:system_r:initrc_t and then run ssh which will
              automatically transition to sshd_t</p>
            <span class="HOEnZb"><font color="#888888">
                <p dir="ltr">-- Jason<br>
                </p>
              </font></span></blockquote>
        </div>
        <br>
      </div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
Selinux mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a>
To unsubscribe, send email to <a class="moz-txt-link-abbreviated" href="mailto:Selinux-leave@tycho.nsa.gov">Selinux-leave@tycho.nsa.gov</a>.
To get help, send an email containing "help" to <a class="moz-txt-link-abbreviated" href="mailto:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.gov</a>.</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------5645678EFD3816CDAACDB44D--
